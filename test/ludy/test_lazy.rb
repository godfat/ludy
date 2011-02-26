
require './test/helper'
require 'ludy/lazy'

class TestLazy < Test::Unit::TestCase
  include Ludy
  def setup; @data = 0; end
  def get; @data += 1; end
  def test_lazy
    assert_equal 0, @data
    v = lazy{get}
    assert_equal 0, @data
    assert_equal 1, v
    assert_equal '1', v.to_s
    assert_equal 1, v
    assert_equal '1', v.to_s
  end
end
