
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

module PuzzleGenerator

  def self.generate_puzzle option = {}
    option.reverse_merge! :timeout => 5
    generate lambda{Puzzle.new option}
  end

  def generate generator, timeout = 5
    timer = Timer.new(timeout).start
    tried_times = 1
    result = generator.call
    until result.result_map.kind_of? Array
      tried_times += 1
      begin; result = generator.call
      rescue; timer.stop; raise
      end
    end
    timer.stop
    [result, {:tried_times => tried_times, :tried_duration => timer.total_time}]
  end
  module_function :generate

end
