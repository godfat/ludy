
require 'ludy/kernel/public_send'

class Proc
  # :nodoc:
  def __curry__ *pre
    lambda{ |*post| self[*(pre + post)] }
  end

  # make the caller be a curried function
  # lambda{|a,b,c| [a,b,c]}.curry[1][2][3]
  # -> [1,2,3]
  def curry
    class << self
      alias_method :__call__, :call
      def call *args, &block
        if self.arity == -1
          begin # let's try if arguments are ready
            # is there any better way to determine this?
            # it's hard to detect correct arity value when
            # Symbol#to_proc happened
            # e.g., :message_that_you_never_know.to_proc.arity => ?
            # i'd tried put hacks in Symbol#to_proc, but it's
            # difficult to implement in correct way
            # i would try it again in other day
            self.public_send :__call__, *args, &block
          rescue ArgumentError # oops, let's curry it
            method(:call).to_proc.public_send :__curry__, *args
          end
        elsif args.size == self.arity
          self.public_send :__call__, *args, &block
        else
          method(:call).to_proc.public_send :__curry__, *args
        end
      end
      alias_method :[], :call
    end
    self
  end
end
