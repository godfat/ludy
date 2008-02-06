
require 'puzzle_generator/misc'
require 'puzzle_generator/chain'
require 'puzzle_generator/map'

require 'ludy/kernel/deep_copy'
require 'ludy/array/combine'
require 'ludy/array/rotate'
require 'ludy/array/choice' # for Array#choice!
require 'ludy/array/product' if RUBY_VERSION < '1.9.0'

module PuzzleGenerator

  # 1. put a chain
  # 2. destroy a chain by chain
  # 2. a. choose a position by last map
  # 2. b. choose a direct from 3 direct (memo p+d)
  # 2. c. check if the position + direct is ok? ok pass, failed choose again
  # 2. d. goto 2

  class ChainedMap # :nodoc:
    include DisplayMap, MapUtils
    attr_reader :maps, :option
    def initialize option = {}
      @option = DefaultOption.merge option
      raise_if_bad_argument
      init_map
      @result_map = begin  next_level until @maps.size >= @option[:level]; put_fire_point
                    rescue GenerationFailed; $! end
    end

    private
    def raise_if_bad_argument
      msg = []
      @option.each{ |name, value| msg << "#{name} should be greater than 1." if value <= 1 }
      raise ArgumentError.new(msg.join("\n")) unless msg.empty?
    end
    def make_map; Map.new @option; end
    def init_map
      @maps = [make_map]
      @result_map = make_map_array
      # @picked_chain = make_init_chains([(0..@option[:width]-@option[:invoke]), [0]].combos).pick
      @picked_chain = make_init_chains((0..@option[:width]-@option[:invoke]).to_a.product([0])).choice
      put_picked_chain_on @maps
      resolve_map
    end
    # please make this init chain to variable length chain
    def make_init_chains positions
      positions.inject([]){ |result, pos| result << Chain.new(pos, Right, @option[:invoke]) }
    end

    def chain_ok?
      raise GenerationFailed.new("ChainedMap: last result_map: #{@result_map.inspect}") if @picked_chain.nil?
      @maps_preview = @maps.deep_copy
      put_picked_chain_on @maps_preview

      result = check_overlap_and_resolve_it &&
               check_broken_except_last     &&
               check_answer_correctness(@result_map_preview) # need this if you gen variable length chain

      @maps_preview = nil
      @result_map_preview = nil
      result
    end
    def next_level new_map = nil
      @maps << (new_map || make_map)
      chains = @maps[-1].break_chains @maps[-2], @result_map

      @picked_chain = chains.choice!
      @picked_chain = chains.choice! until chain_ok?

      put_picked_chain_on @maps
      @picked_chain = nil
      resolve_map
    end
    def put_fire_point; next_level Map.new(@option.merge(:invoke => 1, :invoke_max => 1)); end
    def put_picked_chain_on maps
      maps.last.chains << @picked_chain
      @picked_chain.each{ |pos|
        x, y = pos
        maps.each{ |map|
          column = map[x]
          column.replace(column[0...y] + column[y..-1].rotate)
        }
        maps.last[x, y] = maps.size
      }
    end
    def check_overlap_and_resolve_it
      @result_map_preview = @maps_preview[0...-1].inject(make_map_array){ |result, map|
        result.each_with_index{ |column, x|
          column.each_with_index{ |value, y|
            # assert one of them is zero or they are all zero
            return false unless value * map[x, y] == 0
          }
        }
        combine_map result, map
      }
    end
    def check_broken_except_last
      @maps_preview[0...-1].all?{ |map|
        result = true
        map.each_with_index_2d{ |i, x, y|
          result &&= !check_left_chain( map, x, y) &&
                     !check_right_chain(map, x, y) &&
                     !check_up_chain(   map, x, y) &&
                     !check_down_chain( map, x, y)
        }
        result
      }
    end
  end

end
