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

require 'test/unit'
require(File.join(File.dirname(__FILE__), '..', 'lib', 'ludy'))
require_ludy 'ludy_ext'
class TestLudyExt < Test::Unit::TestCase
  def test_object_tap
    assert_equal '11', 10.tap{|i| assert_equal '10', i.to_s}.succ.to_s
  end
  def test_blackhole
    assert_equal nil, nil.XD.Orz.zzz
  end
  def test_fixnum_collect
    # a, b, c = 3.collect{|i| i}
    a, b, c = (0..2).to_a
    assert_equal 0, a
    assert_equal 1, b
    assert_equal 2, c

    # array = 5.collect{Array.new}
    array = Array.new(5).map{[]}
    assert_equal 5, array.size
    5.times{|y|
      5.times{|x|
        break if x == y
        assert_not_equal array[x].object_id, array[y].object_id
      }
      assert_equal Array, array[y].class
    }
  end
  def test_if
    assert_equal  "XD", (true ).if{"XD"}
    assert (false).if{"XD"}.nil?
    assert_equal "Orz", (false).if{"XD"}.else{"Orz"}
    assert_equal  "XD", (true ).if{"XD"}.else{"Orz"}
    assert_equal  "XD", (true ).if{"xd"}.upcase
    assert (false).if{"xd"}.upcase.nil?
    assert_equal "OTL", (false).if{"xd"}.else{"otl"}.upcase
    assert_equal  "XD", (true ).if{"xd"}.else{"otl"}.upcase
  end
  def test_filter
    assert_equal [1,2,3], [1,18,29,9,4,3,2,1,3,7].filter{|i| i<=3}.sort.uniq
  end
  def test_folds
    assert_equal  6, [1,2,3].foldl(:+.to_proc, 0)
    assert_equal -6, [1,2,3].foldl(:-.to_proc, 0)
    assert_equal  6, [1,2,3].foldr(:+.to_proc, 0)
    assert_equal  2, [1,2,3].foldr(:-.to_proc, 0)
  end
  def test_proc_curry
    multiply = lambda{|l,r| l*r}

    double = multiply.curry 2
    assert_equal 8, double[4]
    assert_equal 6, double[3]

    xd = multiply.curry 'XD', 5
    assert_equal 'XDXDXDXDXD', xd.call
  end

  def test_proc_chain
    f1 = lambda{|v| v+1}
    assert_equal 5, f1[4]

    f2 = lambda{|v| v+2}
    assert_equal 6, f2[4]

    f3 = f1.chain f2
    assert_equal [6,7], f3[5]

    f4 = f3.chain f1
    assert_equal [2,3,2], f4[1]

    f5 = f4.chain{|v|[10,11,v]}
    assert_equal [1,2,1,10,11,0], f5[0]
  end

  def test_proc_compose
    f1 = lambda{|v| v+1}
    f2 = lambda{|v| v*2}
    f3 = f1.compose f2
    assert_equal 21, f3[10]

    f4 = lambda{|a,b| a*b}
    f5 = lambda{|a,b| [a*b, a-b]}
    f6 = f4.compose f5
    assert_equal -30, f6[3,5]

    f7 = lambda{|a| a*2}.compose f6.compose{|a,b| [b,a]}
    assert_equal 60, f7[3,5]
  end
end
