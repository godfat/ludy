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
require_ludy 'dice'
include Ludy
class TestDice < Test::Unit::TestCase
  def test_dice
    50.times{ assert((1..20).include?(1.roll)) }
    50.times{ assert((2..40).include?(2.roll)) }
    50.times{ assert((3..18).include?(3.roll(6))) }

    _4d20 = 4.dice
    assert_equal 4, _4d20.min
    assert_equal 4*20, _4d20.max
    50.times{ assert((4..80).include?(_4d20.roll)) }

    _5d12 = 5.dice 12
    assert_equal 5, _5d12.min
    assert_equal 5*12, _5d12.max
    50.times{ assert((5..60).include?(_5d12.roll)) }

    ds = DiceSet.new _4d20, _5d12
    assert_equal _4d20.min+_5d12.min, ds.min
    assert_equal _4d20.max+_5d12.max, ds.max
    50.times{ assert((ds.min..ds.max).include?(ds.roll)) }

    du = DiceSet.new ds, 6.dice(6)
    assert_equal ds.min+6, du.min
    assert_equal ds.max+36, du.max
    50.times{ assert((du.min..du.max).include?(du.roll)) }
  end
end
