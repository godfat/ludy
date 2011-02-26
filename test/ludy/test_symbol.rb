
require './test/helper'
require 'ludy/symbol'

class TestSymbol < Test::Unit::TestCase
  def test_curry
    a = [1,2,3]
    if Ludy.ruby_before '1.9.0'
      assert_equal nil, a.find(&:==.curry[0])
      assert_equal 2, a.find(&:==.curry[2])
    else
      assert_equal nil, a.find(&:==.curry(2)[0])
      assert_equal 2, a.find(&:==.curry(2)[2])
    end
  end
  def test_to_msg
    assert_equal [3, 7], [[1,2],[3,4]].map(&:'inject(&:+)'.to_msg)
    assert_equal 29, :'to_i*2+9'.to_msg['10']
  end
end
