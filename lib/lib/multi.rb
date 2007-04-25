# = multi.rb - Multiple Dispatch and Pattern Matching for Ruby
#
#  Copyright 2005, Christopher Cyll
#  mailto: christopher at gmail dot com
#
# == Example
#
# === Factorial Function
# 
#  require 'multi'
#  multi(:fac, 0)       { 1 }
#  multi(:fac, Integer) {|x| x * fac(x-1)}
#  fac(5) ==> 120
#
# === List Reversal Function
#
#  require 'multi'
#  multi(:reverse, []) { [] }
#  multi(:reverse, Array) {|list| [list.pop] + reverse(list) }
#  reverse([1,2,3]) ==> [3,2,1]
#
# === Method Dispatch
#
#  require 'multi'
#  class Foo
#    multi(:hiya, 0)       {|x| "Zero: #{x}" }
#    multi(:hiya, Integer) {|x| "Int: #{x}" }
#    multi(:hiya, String)  {|x| "Str: #{x}" }
#  end
#
#  f = Foo.new()
#  f.hiya(0)         ==> "Zero: 0"
#  f.hiya(5)         ==> "Int: 5"
#  f.hiya("hello")   ==> "Str: hello"
#
# === Match Any ( _ in Haskell/ML) using Object
#
#  require 'multi'
#  multi(:baz, 3, Object) { 3 }
#  multi(:baz, Object, String) {|o, str| str }
#  baz(3, "three") ==> 3
#  baz(2, "two")   ==> "two"
#
# === Guards Using lambda/Proc
#
#  multi(:gt2, lambda {|x| x > 2 }) {|x| x }
#  multi(:gt2, Object)              {    0 }
#  gt2(1) ==> 0
#  gt2(4) ==> 4
#
# === Returning Values From Multimethods
#
#  multi(:evenify, Integer) do |x|
#    next x if x % 2 == 0 # Return x using 'next'
#    x += 1
#    next x
#  end
#  evenify(4) ==> 4
#  evenify(5) ==> 6
#
# === Declare a clause of a multimethod
#
#  multi(:method_name, types_literals_or_guards) do |parameter1, parameter2|
#    # code here!
#  end

def multi(method_name, *patterns, &body)
  Multi::DISPATCHER.add(Multi::Dispatch, self, method_name, patterns, body)
end

module Multi
  class Dispatch
    def initialize(patterns, body)
      @patterns = patterns
      @body = body
    end
    
    def match?(params)
      pairs = params.zip(@patterns)
      return pairs.all? do |param, pattern|
        if pattern.kind_of?(Class)
          param.kind_of?(pattern)
        elsif pattern.instance_of?(Proc)
          begin
            pattern.call(param)
          rescue
            false
          end
        elsif pattern.instance_of?(Regexp)
          pattern.match(param)
        else
          param == pattern
        end
      end
    end
    
    def call(params, block)
      @body.call(*params, &block)
    end
  end

  class Dispatcher
    def initialize
      @map = {}
    end

    def add(type, obj, method_name, patterns, body)
      method_name = method_name.id2name if method_name.kind_of?(Symbol)
      body = patterns.pop if body.nil?

      # Using the object_id() is pretty sleazy, but it gives us faster
      # lookup than object.equal? and searching
      key = [obj.object_id(), method_name]
      @map[key] ||= []
      @map[key].push(type.new(patterns, body))

      # Tried to use send(:define, ...) but Procs can't have &blocks
      if ! obj.methods.include?(method_name)
        obj.instance_eval <<-"DONE"
          def #{method_name}(*params, &block)
            Multi::DISPATCHER.call(self, \"#{method_name}\", params, block)
          end
        DONE
      end
    end

    def call(obj, method_name, params, block)
      dispatches = @map[[obj.object_id, method_name]]
      dispatch = dispatches.find{|dispatch| dispatch.match?(params) }
      if dispatch.nil?
        printed_params = params.map{|param| param.inspect}.join(', ')
        raise "No match for #{obj}.#{method_name}(#{printed_params})"
      end
      dispatch.call(params, block)
    end
  end

  DISPATCHER = Dispatcher.new()
end
