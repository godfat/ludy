
require 'puzzle_generator/misc'
require 'puzzle_generator/chain'

require 'ludy/kernel/maybe'
require 'ludy/array/count' if RUBY_VERSION < '1.9.0'
require 'ludy/array/product' if RUBY_VERSION < '1.9.0'

module PuzzleGenerator

  class Map # :nodoc:
    include DisplayMap, Enumerable
    attr_reader :chains
    def result_map; @data; end
    def initialize option = {}
      @option = DefaultOption.merge option
      @data = @option[:data] || (Array.new(@option[:width])).map{ [0]*@option[:height] }
      @chains = @option[:chains] || []
    end
    # TRAP!! view is not view, it's clone!!
    # def [] x, y = (0..-1); @data[x][y]; end

    # NOTICE!! this is not view (reference)
    def [] x, y = nil
      if y.nil?
        @data[x]
      else
        if x.kind_of? Range
          @data[x].transpose[y]
        else
          @data[x][y]
        end
      end
    end
    def []= x, y, v; @data[x][y] = v; end
    def each_column_with_index; @data.each_with_index{ |column, index| yield column, index }; end
    def each_column; @data.each{ |column| yield column }; end
    def clone_with_map
      Map.new @option.merge(
        :data => @data.transpose.map{ |row| row.map{ |i| yield i } }.transpose,
        :chains => chains
      )
    end
    def to_a; @data.clone; end
    def each; @data.flatten.each{ |i| yield i }; end
    def each_with_index_2d
      @data.transpose.each_with_index{ |row, y| row.each_with_index{ |i, x| yield i, x, y } }
    end
    def break_chains map, result_map
      @temp_map = map
      @temp_result_map = result_map
      result = []
      map.each_column_with_index{ |column, ix|
        column.each_with_index{ |y, iy| result << [ix, iy] if y != 0 }
      } # e.g., [[0, 0], [1, 1]]
      result = transform result,
        :with_belows,
        :with_directs,
        :to_chains,
        :strip_duplicated_chain,
        :strip_out_bounded_chain,
        :strip_overflow_chain,
        :strip_floating_chain

      @temp_result_map = nil
      @temp_map = nil
      result
    end

    private
    def transform target, *funs; target = method(funs.shift)[target] until funs.empty?; target; end
    def with_belows target
      result = []
      up_hack = 0 # @temp_map.chains.last.up? ? 1 : 0
      target.each{ |pos|
        x, y = pos
        result.concat( ([x]*(y+1)).zip((up_hack..y).to_a) )
      }
      result.uniq
      # e.g., [[0, 0], [[1, 0], [1, 1]]] =>
      #       [[0, 0], [1, 0], [1, 1]]
    end
    def with_directs target
      # [target, [Up] + [Right, Left]*10].combos
      # [target, [Up, Right, Left]].combos
      target.product [Up, Right, Left]
      # e.g., [[[0, 0], Up], [[0, 0], Right], [[0, 0], Left], [[1, 0], Up], ...]
    end
    def to_chains target
      target.map{ |pos| Chain.new pos.first, pos.last, gen_chain_length }
      # e.g., [Chain#0x000, Chain#0x001, ...]
    end
    def gen_chain_length
      @option[:invoke] + (maybe ? 0 : rand(@option[:invoke_max] - @option[:invoke] + 1))
    end
    def strip_duplicated_chain target
      # target.uniq never works for non-num nor non-string :(
      # target.sort.inject([]){ |r, i| r.last == i ? r : r<<i }
      # target.uniq_by{|i|i}
      target.uniq # it works when hash and eql? take effect...
    end
    def strip_out_bounded_chain target
      target.select{ |chain| chain.bound_ok? @option[:width], @option[:height] }
    end
    def strip_overflow_chain target
      target.select{ |chain|
        xs = Hash.new 0
        chain.to_a.transpose.first.each{ |x| xs[x] += 1 }
        xs.all?{ |pair|
          x, count = pair
          height(@temp_result_map[x]) + count <= @option[:height]
        }
      }
    end
    def strip_floating_chain target
      target.select{ |chain|
        chain.all?{ |pos|
          x, y = pos # if the direct is up, then it's impossible floating.
          chain.up? || !@temp_result_map[x][0...y].include?(0)
        }
      }
    end
    def height column; @option[:height] - column.count(0); end
  end

end
