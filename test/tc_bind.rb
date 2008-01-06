#!/usr/bin/env ruby

#    Copyright (c) 2008, Lin Jen-Shin（a.k.a. godfat 真常）
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

require 'test/unit'
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy')
require_ludy 'bind'

class TestCppBind < Test::Unit::TestCase
  def test_basic
    assert_equal [9,8,7], ([1,2,3].map &(lambda{|lhs, rhs| lhs-rhs}.bind 10, :_1))
    assert_equal [3,2,1], (lambda{|a,b,c| [a,b,c]}.bind :_3, :_2, :_1)[1,2,3]
    assert_equal [1,9,3], (lambda{|a,b,c| [a,b,c]}.bind :_1, 9, :_3)[1,2,3]
    assert_equal [9,2,3], (lambda{|a,b,c| [a,b,c]}.bind 9)[2,3]
    assert_equal [9,4,2], (lambda{|a,b,c| [a,b,c]}.bind 9, :_3)[2,3,4]
  end
end
