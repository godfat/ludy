
require 'ludy/kernel/public_send'

module Ludy
  # you can use defun for overloading(ad-hoc polymorphism),
  # multi-method, pattern matching, and perhaps others?
  def defun name, *args, &fun
    MessageDispatcher.create self, name, *args, &fun
  end
  # someone who does the pattern matching thing
  class PatternMatcher
    # init for the first arg_list
    def initialize *args; @arg_list = [args]; end
    # find the first match of this arg_list. notice,
    # this is not the best match. maybe someday i could
    # implement the match policy accordingly or selectable.
    def first_match *args
      @arg_list.find{ |arg_list, fun|
        true
      }.last
    end
    # delegate all the rest message to @arg_list array
    def method_missing msg, *args, &block
      if @arg_list.respond_to? msg
        @arg_list.public_send msg, *args, &block
      else
        raise NoMethodError.new("PatternMatcher doesn't respond to #{msg}")
      end
    end
  end
  class MessageDispatcher
    # create a dispatcher or append arg_list to the existed dispatcher
    def self.create actor, msg, *args, &fun
      if (@patchers ||= {})[[actor, msg]].nil?
        @patchers[[actor, msg]] = MessageDispatcher.new actor, msg, *args, &fun
      else
        @patchers[[actor, msg]].listen *args, &fun
      end
    end
    # actor is the listener who listen to the message
    def initialize actor, msg, *args, &fun
      @actor = actor
      @msg = msg
      @matcher = PatternMatcher.new *args, &fun
      define_method_in_actor
    end
    # open your ear and listen, and call me when you hear
    def listen arg_list, &fun
      @matcher << [arg_list, fun]
    end
    def define_method_in_actor
      # if @actor.respond_to? @msg
        # raise RuntimeError.new("#{@actor.inspect}'s method \"#{@msg}\" already defined.")
      # else
        matcher = @matcher
        msg = @msg # make them close in the closure

        @actor.define_singleton_method msg do |*args, &block|
          fun = matcher.first_match *args
          if fun.nil?
            if self.respond_to? :method_missing
              self.method_missing msg, *args, &block
            else
              raise NoMethodError.new("#{@actor.inspect} doesn't respond to \"#{msg}\"")
            end
          else
            fun.call(*args, &block)
          end
        end
      # end
    end
  end
end

# defun :fact, 0 do |n|
#   1
# end
# 
# defun :fact, Integer do |n|
#   n * fact(n-1)
# end
