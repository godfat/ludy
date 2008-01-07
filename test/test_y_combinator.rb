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
require_ludy 'y_combinator'

include Ludy # why should this be here?

class TestYCombinator < Test::Unit::TestCase
  def test_y_combinator
    fact_ = lambda{|this|
      lambda{|n| n==1 ? 1 : n*this[n-1]}
    }
    fact = Y[fact_]
    assert_equal(3628800, fact[10])

    fib_ = lambda{|this|
      lambda{|n| n<=1 ? 1 : this[n-2]+this[n-1]}
    }
    fib = Y[fib_]
    assert_equal([1,1,2,3,5,8,13,21,34,55], (0...10).map(&fib))
  end
end
