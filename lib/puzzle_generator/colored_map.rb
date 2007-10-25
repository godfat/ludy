
require 'puzzle_generator/misc'

module PuzzleGenerator

  class ColoredMap
    include DisplayMap, MapUtils
    def initialize chain_generator, colors = (1..chain_generator.option[:colors]).to_a
      @result_map = []
      @maps = []
      @option = chain_generator.option
      chain_generator.maps.each_with_index{ |map, index|
        @maps << map.clone_with_map{ |color|
          color == 0 ? 0 : colors[index % @option[:colors]]
        }
      }
      resolve_map
      @result_map = GenerationFailed.new("ColoredMap: last result_map: #{@result_map.inspect}") unless check_answer_correctness
    end
  end

end
