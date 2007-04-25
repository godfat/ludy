# = smulti.rb - String destructuring multiple dispatch for Ruby
#
#  Copyright 2005, Christopher Cyll
#  mailto: christopher at gmail dot com
#
# == Example
#
# === String Dispatch (using 'smulti') ===
# 
# smulti(:foo, 'a') { puts "a FOUND"     }
# smulti(:foo, /./) {|s, rest| foo(rest) }
# smulti(:foo, // ) { puts "a NOT FOUND" }
# foo('a')  ==> "a FOUND"
# foo('')   ==> "a NOT FOUND"
# foo('ab') ==> "a FOUND"
# foo('ba') ==> "a FOUND"
# foo('bb') ==> "a NOT FOUND"

require 'multi'

def smulti(method_name, *patterns, &body)
  Multi::DISPATCHER.add(Multi::StringDispatch, self, method_name, patterns, body)
end

module Multi
  class StringDispatch
    def initialize(patterns, body)
      @body = body

      pattern = patterns.first
      if pattern.kind_of?(String)
        source = "\\A" + Regexp.escape(pattern)
        @re = Regexp.new(source)
      elsif pattern.kind_of?(Regexp)
        opts   = pattern.options
        source = "\\A" + pattern.source
        @re = Regexp.new(source, opts)
      else
        throw "Bad pattern #{pattern} for StringDispatch. Use a string or a regexp"
      end
    end
    
    def match?(params)
      return false if params.size != 1
      @re.match(params.first)
    end
    
    def call(params, block)
      match = @re.match(params.first)
      results = match.captures
      results.push(match[0]) if results.empty?
      results.push(match.post_match)
      @body.call(*results, &block)
    end
  end
end
