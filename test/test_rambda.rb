
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/deprecated/rambda'

class TestRambda < Test::Unit::TestCase
  include Ludy
  def test_rambda
    assert_equal(3628800, rambda{|n| n==1 ? 1 : n*this[n-1]}[10])
    assert_equal([1,1,2,3,5,8,13,21,34,55],
      (0...10).map(&rambda{|n| n<=1 ? 1 : this[n-2]+this[n-1]}))

    v = "can't refer v"
    assert_raise(NameError){ rambda{v}.call }
  end
end
