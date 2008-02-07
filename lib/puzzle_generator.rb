
# alpha at 2007.10.14

require 'puzzle_generator/puzzle'

require 'ludy/hash/reverse_merge'

# require 'rubygems' if RUBY_VERSION < '1.9.0'
# require 'facets/timer'
require 'ludy/timer' # simple and stupid timer....

# puzzle generator for shooting-cubes[http://shooting-cubes.googlecodes.com],
# example usage:
#  PuzzleGenerator.debug = true
#  pg = PuzzleGenerator::Puzzle.new :level => 4, :timeout => 2, :invoke_max => 5
#  begin
#    pg.generate
#    pg.display_map
#  rescue Ludy::Timeout => e
#    puts e
#  ensure
#    p pg.tried_times
#    p pg.tried_duration
#  end
module PuzzleGenerator

  def self.generate_chained_map option = {} #:nodoc:
    generate_klass ChainedMap, option
  end
  def self.generate_klass klass, option = {} #:nodoc:
    option.reverse_merge! :timeout => 5
    generate(option[:timeout]){ klass.new option }
  end

  LastTriedInfo = {} # :nodoc:
  # generate someing with generator with timeout, used in Puzzle#generate
  def self.generate timeout = 5, &generator
    timer = Ludy::Timer.new(timeout).start
    tried_times = 1
    begin
      result = generator.call
      until result.result_map.kind_of? Array
        tried_times += 1
        result = generator.call
      end
    ensure
      # timer.stop
      LastTriedInfo.merge! :tried_times => tried_times, :tried_duration => timer.total_time
    end
    result
  end

end
