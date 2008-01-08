
require 'ludy/kernel/public_send'

module Ludy
  # someone who does the pattern matching thing
  class PatternMatcher
    # init for the first parameter
    def initialize args, &fun; @params = [[args, fun]]; end
    # find the first match of this arguments. notice,
    # this is not the best match. maybe someday i could
    # implement the match policy accordingly or selectable policy.
    def first_match args
      puts 'tsetsetset'
      p @params
      @params.find{ |parameters, fun|
        match? parameters, args
      }.last
    end
    # delegate all the rest message to @params array
    def method_missing msg, *args, &block
      if @params.respond_to? msg
        @params.public_send msg, *args, &block
      else
        raise NoMethodError.new("PatternMatcher doesn't respond to #{msg}")
      end
    end
    private
    def match? parameters, arguments
      parameters.zip(arguments).each{ |param, arg|
        if param.kind_of? Class
          return false unless arg.kind_of?(param)
        else
          return false unless arg == param
        end
      }
      return true
    end
  end
end
