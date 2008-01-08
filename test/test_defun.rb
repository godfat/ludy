
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/kernel/defun'

class TestDefun < Test::Unit::TestCase
  def test_basic
    defun :fact, 0 do |n|
      1
    end

    defun :fact, Integer do |n|
      n * fact(n-1)
    end

    assert_equal 3628800, fact(10)
  end
end
