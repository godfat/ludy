
module Ludy
  # whenever a Timer was timeout, it was thrown
  class Timeout < Exception; end
  # simple and stupid timer for puzzle_generator...
  class Timer
    def initialize timeout
      @timeout = timeout
    end
    # start ticking
    def start
      @now = Time.now
      @parent = Thread.current
      @thread = Thread.new{
        sleep @timeout
        @parent.raise Timeout.new("timeout for #{@timeout} seconds.")
      }
      self
    end
    # total time until start ticking
    def total_time
      Time.now - @now
    end
    # stop ticking
    def stop
      @thread.kill
    end
  end
end
