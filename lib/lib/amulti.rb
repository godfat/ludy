# = amulti.rb - Array destructuring multiple dispatch for Ruby
#
#  Copyright 2005, Christopher Cyll
#  mailto: christopher at gmail dot com
#
# == Example
#
# === Array Dispatch (using 'amulti') ===
# 

require 'multi'

def amulti(method_name, *patterns, &body)
  Multi::DISPATCHER.add(Multi::ArrayDispatch, self, method_name, patterns, body)
end

module Multi
  class ArrayDispatch < Dispatch
    def initialize(patterns, body)
      @count = patterns.size
      super(patterns, body)
    end

    def match?(params)
      return false if params.size != 1
      # Call .to_a here?
      array = params.first
      return false if ! array.kind_of?(Array)
      return false if array.size < @count
      return super(array[0, @count])
    end
    
    def call(params, block)
      array = params.first
      use = array[0, @count]
      use.push(array[@count..-1])
      super(use, block)
    end
  end
end
