
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/proc/bind'

class TestCppBind < Test::Unit::TestCase
  def test_basic
    assert_equal [9,8,7], ([1,2,3].map &(lambda{|lhs, rhs| lhs-rhs}.bind 10, :_1))
    assert_equal [3,2,1], (lambda{|a,b,c| [a,b,c]}.bind :_3, :_2, :_1)[1,2,3]
    assert_equal [1,9,3], (lambda{|a,b,c| [a,b,c]}.bind :_1, 9, :_3)[1,2,3]
    assert_equal [9,2,3], (lambda{|a,b,c| [a,b,c]}.bind 9)[2,3]
    assert_equal [9,4,2], (lambda{|a,b,c| [a,b,c]}.bind 9, :_3)[2,3,4]
  end
end
