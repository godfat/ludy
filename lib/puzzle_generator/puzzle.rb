
require 'puzzle_generator/misc'
require 'puzzle_generator/chained_map'
require 'puzzle_generator/colored_map'
# require '../puzzle_generator'

require 'rubygems'
require 'facets'       # for Array#rotate
require 'facets/timer'

module PuzzleGenerator

  class Puzzle
    include DisplayMap, PuzzleGenerator
    attr_reader :tried_times, :tried_duration
    def initialize option = {}
      @option = DefaultOption.merge option
      @tried_times, @tried_duration = [0, 0], [0, 0]
      raw_colors = (1..@option[:colors]).to_a
      step_colors = raw_colors.rotate
      timer = Timer.new(@option[:timeout]).start

      make_chain
      make_color raw_colors
      until @result_color.result_map.kind_of? Array
        if step_colors == raw_colors
          make_chain
          make_color raw_colors
          step_colors = raw_colors.rotate
        else
          make_color step_colors
          step_colors.rotate!
        end
      end

      timer.stop
      @result_map = @result_color.result_map
    end

    private
    Chain, Color = 0, 1
    def make_chain
      @result_chain, info = generate(@option[:timeout] - @tried_duration[Chain]){
                                     ChainedMap.new @option }
      update_info Chain, info
    end
    def make_color colors
      # @result_color, info = generate(@option[:timeout] - @tried_duration[Color]){
      #                                ColoredMap.new @result_chain, colors }
      start = Time.now
      @result_color = ColoredMap.new @result_chain, colors
      update_info Color, {:tried_times => 1, :tried_duration => Time.now - start}
    end
    def update_info index, info
      @tried_times[index]    += info[:tried_times]
      @tried_duration[index] += info[:tried_duration]
    end
  end

end
