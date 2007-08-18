#!/usr/bin/env ruby

#    Copyright (c) 2007, Lin Jen-Shin（a.k.a. godfat 真常）
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

# require 'singleton'

class Object
  def tap
    yield self
    self
  end
  def define_instance_method msg, &block
    self.class.send :define_method, msg, &block
  end
  def alias_instance_method new_msg, old_msg
    self.class.send :alias_method, new_msg, old_msg
  end
  def if
    yield if self
  end
  def else
    if self then self
    else yield end
  end
end

=begin
class Blackhole # < NilClass
  include Singleton
  def method_missing msg, *arg, &block; self; end
  def nil?; true; end
  def null?; true; end
  def blackhole?; true; end
  def to_bool; false; end
end
=end

# module Kernel; def blackhole; Blackhole.instance; end; end
class NilClass
  def method_missing msg, *arg, &block; self; end
end

=begin
class Fixnum
  def collect
    result = []
    self.times{|i| result.push(yield(i))}
    result
  end
end
=end

class Symbol
  # def to_proc; lambda{|*args| args.shift.__send__ self, *args}; end
  def to_proc
    lambda{|*args| eval "args[0].#{self.to_s} #{args[1..-1].join ', '}" }
  end
  alias_method :to_msg, :to_proc
end

class Array
  alias_method :filter, :select
  def foldl func, init; self.inject init, &func; end
  def foldr func, init
    self.reverse_each{ |i|
      init = func[i, init]
    }
    init
  end
end

class Proc
  def __curry__ *pre
    lambda{ |*post| self[*(pre + post)] }
  end

  # missing traversal of chain
  def chain *procs, &block
    procs << block if block
    lambda{ |*args|
      result = []
      ([self] + procs).each{ |i|
        result += [i[*args]].flatten
      }
      result
    }
  end
  def compose *procs, &block
    procs << block if block
    lambda{ |*args|
      ([self] + procs).reverse.inject(args){ |val, fun|
        fun[*val]
      }
    }
  end
end

module Kernel
  def curry
    class << self
      alias_method :orig_call, :call
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
            self.__send__ :orig_call, *args, &block
          rescue ArgumentError # oops, let's curry it
            method(:call).to_proc.__send__ :__curry__, *args
          end
        elsif args.size == self.arity
          self.__send__ :orig_call, *args, &block
        else
          method(:call).to_proc.__send__ :__curry__, *args
        end
      end
      alias_method :[], :call
    end
    self
  end
end
