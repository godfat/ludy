
module PuzzleGenerator
  Up, Right, Left = (0..2).to_a
  DefaultOption = {:width => 6, :height => 10, :invoke => 3, :level => 4, :colors => 4,
                   :timeout => 5}
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
  end

end
