
require File.join(File.dirname(__FILE__), '..', 'helper')
require 'ludy/z_combinator'

class TestZCombinator < Test::Unit::TestCase
  include Ludy
  def test_z_combinator
    fact_ = lambda{|this|
      lambda{|n| n==1 ? 1 : n*this[n-1]}
    }
    fact = Z[fact_]
    assert_equal(3628800, fact[10])

    fib_ = lambda{|this|
      lambda{|n| n<=1 ? 1 : this[n-2]+this[n-1]}
    }
    fib = Z[fib_]
    assert_equal([1,1,2,3,5,8,13,21,34,55], (0...10).map(&fib))
  end
end
