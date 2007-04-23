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

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')
require 'test/unit'
require 'callstack'
include Ludy
class TestCallstack < Test::Unit::TestCase
  def setup; @binding = 'XD' end
  def test_callstack
    called_line = __LINE__-1
    top = callstack
    assert_equal 'call', top[TRACE_EVENT]
    assert_equal __FILE__, top[TRACE_FILE]
    assert_equal called_line, top[TRACE_LINE]
    assert_equal :test_callstack, top[TRACE_MSG]
    assert_equal 'XD', eval('@binding', top[TRACE_BINDING])
    assert_equal self.class, top[TRACE_CLASS]
  end
end
