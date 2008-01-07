
class Proc
  def __curry__ *pre
    lambda{ |*post| self[*(pre + post)] }
  end

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
            self.__send__ :__call__, *args, &block
          rescue ArgumentError # oops, let's curry it
            method(:call).to_proc.__send__ :__curry__, *args
          end
        elsif args.size == self.arity
          self.__send__ :__call__, *args, &block
        else
          method(:call).to_proc.__send__ :__curry__, *args
        end
      end
      alias_method :[], :call
    end
    self
  end
end
