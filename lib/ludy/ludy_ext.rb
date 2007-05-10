#!/usr/bin/ruby

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
end

class NilClass
  def method_missing msg, *arg, &block
    self
  end
end

class Fixnum
  def collect
    result = []
    self.times{|i| result.push(yield(i))}
    result
  end
end
