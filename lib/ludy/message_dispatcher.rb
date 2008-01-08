
require 'ludy/pattern_matcher'

module Ludy
  class MessageDispatcher
    # create a dispatcher or append arg_list to the existed dispatcher
    def self.create actor, msg, args, &fun
      if (@patchers ||= {})[[actor, msg]].nil?
        @patchers[[actor, msg]] = MessageDispatcher.new actor, msg, args, &fun
      else
        @patchers[[actor, msg]].listen args, &fun
      end
    end
    # actor is the listener who listen to the message
    def initialize actor, msg, args, &fun
      @actor = actor
      @msg = msg
      @matcher = PatternMatcher.new args, &fun
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
        define_method = @actor.kind_of?(Class) ? :define_method : :define_singleton_method

        # comment off &block in lambda for ruby 1.8 compatibility
        @actor.public_send define_method, msg do |*args|#, &block|
          fun = matcher.first_match args
          if fun.nil?
            if self.respond_to? :method_missing
              self.method_missing msg, *args#, &block
            else
              raise NoMethodError.new("#{@actor.inspect} doesn't respond to \"#{msg}\"")
            end
          else
            fun.call *args#, &block
          end
        end
      # end
    end
  end
end

