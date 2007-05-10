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

require 'test/unit'
require(File.join(File.dirname(__FILE__), '..', 'lib', 'ludy'))
require_ludy 'ludy_ext'
class TestLudyExt < Test::Unit::TestCase
  def test_object_tap
    assert_equal '11', 10.tap{|i| assert_equal '10', i.to_s}.succ.to_s
  end
  def test_nil
    assert_nil nil.XD.Orz.zzz
  end
  def test_fixnum_collect
    a, b, c = 3.collect{|i| i}
    assert_equal 0, a
    assert_equal 1, b
    assert_equal 2, c

    array = 5.collect{Array.new}
    assert_equal 5, array.size
    5.times{|y|
      5.times{|x|
        break if x == y
        assert_not_equal array[x].object_id, array[y].object_id
      }
      assert Array, array[y].class
    }
    
  end
end
