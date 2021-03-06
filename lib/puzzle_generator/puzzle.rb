
require 'puzzle_generator/misc'
require 'puzzle_generator/chained_map'
require 'puzzle_generator/colored_map'

require 'ludy/array/rotate'

module PuzzleGenerator

  class Puzzle
    include DisplayMap
    attr_reader :tried_times, :tried_duration
    # create a puzzle with option. this won't start generating,
    # call Puzzle::generate to start generating.
    def initialize option = {}
      @option = DefaultOption.merge option
      @tried_times, @tried_duration = [0, 0], [0, 0]
    end
    # start generate a puzzle with options that created this puzzle instance.
    def generate
      raw_colors = (1..@option[:colors]).to_a
      step_colors = raw_colors.rotate(-1)

      make_chain
      make_color raw_colors
      until @result_color.result_map.kind_of? Array
        if step_colors == raw_colors
          make_chain
          make_color raw_colors
          step_colors = raw_colors.rotate(-1)
        else
          make_color step_colors
          step_colors.rotate!(-1)
        end
      end

      @result_map = @result_color.result_map
    end

    private
    Chain, Color = 0, 1 # :nodoc:
    def make_chain
      begin
        @result_chain =
          PuzzleGenerator::generate(
            @option[:timeout] - @tried_duration[Chain]){ ChainedMap.new @option }
      ensure
        update_info Chain, LastTriedInfo
      end
    end
    def make_color colors
      start = Time.now
      begin
        @result_color = ColoredMap.new @result_chain, colors
      ensure
        update_info Color, {:tried_times => 1, :tried_duration => Time.now - start}
      end
    end
    def update_info index, info
      @tried_times[index]    += info[:tried_times]
      @tried_duration[index] += info[:tried_duration]
    end
  end

end
