
require './test/helper'
require 'ludy/y_combinator'

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
