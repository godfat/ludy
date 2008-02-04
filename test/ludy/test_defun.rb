
require File.join(File.dirname(__FILE__), '..', 'helper')
require 'ludy/kernel/defun'

class TestDefun < Test::Unit::TestCase
  def test_fact
    defun :fact, 0 do |n|
      1
    end

    defun :fact, Integer do |n|
      n * fact(n-1)
    end

    assert_equal 3628800, fact(10)
  end

  def test_overloading
    defun :f, Integer do |n| 1; end
    defun :f, String do |n| '2'; end
    defun(:f, Integer, Integer) do |n,g| 3; end

    assert_equal 1, f(10)
    assert_equal '2', f('')
    assert_equal 3, f(1,1)
    assert_raise NoMethodError do f('1', 2); end
  end

  def test_more
    defun(:more, 3, Object){3}
    defun(:more, Object, String){|o,s|s}
    assert_equal 'a', more(1,'a')
    # because [3, '2'] matches [3, Object]
    assert_equal 3, more(3,'2')
    assert_equal 3, more(3,nil)
  end
end
