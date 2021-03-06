
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/deprecated/this'

class TestThis < Test::Unit::TestCase
  include Ludy
  def test_fact
    assert_equal(120, fact(5))
    assert_equal(3628800, fact(10))
    assert_equal(5040, lambda{|n| n==1 ? 1 : n*this[n-1]}[7])

    # can't play with yielded method! that's a problem
    assert_raise(ArgumentError){
      (0...10).map(&lambda{|n| n<=1 ? 1 : this[n-2]+this[n-1]})
    }
  end
  def fact n
    return n*this[n-1] if n > 0
    1
  end
##
  def test_pass_around
    assert_equal(method(:pass_around_forward), pass_around.call(lambda{|v| v}))
  end
  def pass_around mode = 'pass'
    case mode
      when 'pass'
        pass_around_forward this
      else
        'value'
    end
  end
  def pass_around_forward func
    assert_equal('value', func['value'])
    this
  end
##
  def test_with_block
    with_block{|b| assert_equal('value', b['value'])}
  end
  def with_block mode = 'pass', &block
    case mode
      when 'pass'
        block[this]
      else
        'value'
    end
  end
##
  def test_more_args
    more_args('get_this'){}.call('call', 1, 2, 3, 4, 5, &lambda{6})
    more_args('get_this'){}.call('call', 1, 2, 3, 4, 5){6}
  end
  def more_args mode, a1=nil, a2=nil, a3=nil, *as, &block
    case mode
      when 'get_this'
        this
      else
        assert_equal(1, a1)
        assert_equal(2, a2)
        assert_equal(3, a3)
        assert_equal(4, as[0])
        assert_equal(5, as[1])
        assert_equal(nil, as[2])
        assert_equal(6, yield)
        assert_equal(6, block.call)
    end
  end
end
