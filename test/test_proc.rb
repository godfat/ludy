
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/proc'

class TestProc < Test::Unit::TestCase
  def test_bind
    assert_equal [9,8,7], ([1,2,3].map(&lambda{|lhs, rhs| lhs-rhs}.bind(10, :_1)))
    assert_equal [3,2,1], (lambda{|a,b,c| [a,b,c]}.bind :_3, :_2, :_1)[1,2,3]
    assert_equal [1,9,3], (lambda{|a,b,c| [a,b,c]}.bind :_1, 9, :_3)[1,2,3]
    assert_equal [9,2,3], (lambda{|a,b,c| [a,b,c]}.bind 9)[2,3]
    assert_equal [9,4,2], (lambda{|a,b,c| [a,b,c]}.bind 9, :_3)[2,3,4]
  end
  def test_curry
    multiply = lambda{|l,r| l*r}

    double = multiply.curry[2]
    assert_equal 8, double[4]
    assert_equal 6, double[3]

    xd = multiply['XD', 5]
    assert_equal 'XDXDXDXDXD', xd

    assert_equal 29, :+.to_proc.curry[18][11]
    assert_equal((0..4).to_a, lambda{|a,b,c,d,e|[a,b,c,d,e]}.curry[0][1][2][3][4])
  end
  def test_compose
    f1 = lambda{|v| v+1}
    f2 = lambda{|v| v*2}
    f3 = f1.compose f2
    assert_equal 21, f3[10]

    f4 = lambda{|a,b| a*b}
    f5 = lambda{|a,b| [a*b, a-b]}
    f6 = f4.compose f5
    assert_equal(-30, f6[3,5])

    f7 = lambda{|a| a*2}.compose f6.compose{|a,b| [b,a]}
    assert_equal 60, f7[3,5]
  end
  def test_chain
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
end

