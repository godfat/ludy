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

require 'singleton'

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
  def to_proc; lambda{|*args| args.shift.__send__ self, *args }; end
end

class Array
  alias_method :filter, :select
  def foldl func, init; self.inject init, &func; end
end
