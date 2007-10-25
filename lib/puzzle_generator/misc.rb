
require 'rubygems'
require 'facets'   # for Array#deep_clone

module PuzzleGenerator
  Up, Right, Left = (0..2).to_a
  DefaultOption = {:width => 6, :height => 10, :level => 4, :colors => 4,
                   :invoke => 3, :invoke_max => 5, :timeout => 5}
  class GenerationFailed < RuntimeError; end

  module DisplayMap
    attr_reader :result_map
    def display_map
      @result_map.transpose.reverse_each{ |row| puts row.map{ |color| '%2d' % color }.join(' ') }
    end
  end

  module MapUtils
    def make_map_array; (Array.new(@option[:width])).map{ [0]*@option[:height] }; end
    def resolve_map result_map = @result_map, maps = @maps
      result_map.replace maps.inject(make_map_array){ |result, map|
        combine_map result, map
      }
    end
    def combine_map result, map
      result.zip(map.to_a).map{ |columns|
        orig, last = columns
        orig.combine last
      }
    end
    def check_answer_correctness
      map = @result_map.deep_clone

      @chained = true
      while @chained
        @chained = false
        destory_chains map
        drop_blocks    map
      end
      @chained = nil

      map.flatten.all?{ |i| i == 0 }
    end
    def destory_chains map
      map.each_with_index{ |column, x|
        column.each_with_index{ |value, y|
          next if value == 0

          left  = check_left_chain  map, x, y
          right = check_right_chain map, x, y
          up    = check_up_chain    map, x, y
          down  = check_down_chain  map, x, y

          left.fill  0 unless left.nil?
          right.fill 0 unless right.nil?
          up.fill    0 unless up.nil?
          down.fill  0 unless down.nil?

          @chained ||= left || right || up || down
        }
      }
    end
    def drop_blocks map
      map.each{ |column|
        column[]
      }
    end
    def check_left_chain map, x, y
      left = x - @option[:invoke] + 1
      return nil if left < 0
      chain = map[left..x][y]
      chain if chain.all?{ |i| i == map[x][y] }
    end
    def check_right_chain map, x, y
      right = x + @option[:invoke] - 1
      return nil if right >= @option[:width]
      chain = map[x..right][y]
      chain if chain.all?{ |i| i == map[x][y] }
    end
    def check_up_chain map, x, y
      up = y + @option[:invoke] - 1
      return nil if up >= @option[:height]
      chain = map[x][y..up]
      chain if chain.all?{ |i| i == map[x][y] }
    end
    def check_down_chain map, x, y
      down = y - @option[:invoke] - 1
      return nil if down < 0
      chain = map[x][down..y]
      chain if chain.all?{ |i| i == map[x][y] }
    end
  end

end
