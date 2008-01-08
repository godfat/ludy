
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/dices'

class TestDices < Test::Unit::TestCase
  include Ludy
  def test_dices
    50.times{ assert((1..20).include?(1.roll)) }
    50.times{ assert((2..40).include?(2.roll)) }
    50.times{ assert((3..18).include?(3.roll(6))) }

    _4d20 = 4.dices
    assert_equal 4, _4d20.min
    assert_equal 4*20, _4d20.max
    50.times{ assert((4..80).include?(_4d20.roll)) }

    _5d12 = 5.dices 12
    assert_equal 5, _5d12.min
    assert_equal 5*12, _5d12.max
    50.times{ assert((5..60).include?(_5d12.roll)) }

    ds = DiceSet.new _4d20, _5d12
    assert_equal _4d20.min+_5d12.min, ds.min
    assert_equal _4d20.max+_5d12.max, ds.max
    50.times{ assert((ds.min..ds.max).include?(ds.roll)) }

    du = DiceSet.new ds, 6.dices(6)
    assert_equal ds.min+6, du.min
    assert_equal ds.max+36, du.max
    50.times{ assert((du.min..du.max).include?(du.roll)) }
  end
end
