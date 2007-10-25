
# alpha at 2007.10.14

require 'puzzle_generator/puzzle'

require 'rubygems'
require 'facets'   # for Hash#reverse_merge
require 'facets/timer'

# level => 7
# 0  0  0  0  0  0
# 0  0  0  0  0  0
# 0  0  3  0  0  0
# 0  0  1  0  0  0
# 1  3  4  0  0  0
# 2  1  1  0  0  0
# 2  3  2  0  0  0
# 3  4  3  0  0  0
# 3  1  2  4  0  0
# 2  4  2  1  0  0

# level => 15
# 0  0  1  0  0  0
# 2  0  2  1  0  0
# 1  0  4  1  0  0
# 2  0  3  3  1  0
# 2  4  1  4  4  0
# 3  2  4  2  2  1
# 4  1  1  3  3  2
# 3  3  2  3  4  3
# 3  1  3  4  1  2
# 2  3  4  1  4  2

# level => 15 why?
# 0  0  0  1  0  0
# 4  3  0  2  0  0
# 2  1  1  3  1  0
# 3  4  3  3  2  0
# 3  2  4  4  2  0
# 4  2  1  4  3  0
# 4  2  1  1  4  0
# 1  1  1  4  3  0
# 4  3  3  2  3  2
# 3  2  2  1  1  2

module PuzzleGenerator

  def self.generate_chained_map option = {}; generate_klass ChainedMap, option; end
  def self.generate_klass klass, option = {}
    option.reverse_merge! :timeout => 5
    generate(option[:timeout]){ klass.new option }
  end

  def generate timeout = 5, &generator
    timer = Timer.new(timeout).start
    tried_times = 1
    begin
      result = generator.call
      until result.result_map.kind_of? Array
        tried_times += 1
        begin; result = generator.call
        rescue; timer.stop; raise
        end
      end
    rescue; timer.stop; raise
    end
    timer.stop
    [result, {:tried_times => tried_times, :tried_duration => timer.total_time}]
  end
  module_function :generate

end

p = PuzzleGenerator::Puzzle.new :level => 15, :timeout => 20, :invoke_max => 3
p.display_map
p p.tried_times
p p.tried_duration
