
require './test/helper'
require 'ludy/hash'

class TestClass < Test::Unit::TestCase
  def test_reverse_merge
    opt = {:a => 1, :b => 2}
    assert_equal opt, opt.reverse_merge({:a => 3})
    assert_equal opt, opt.reverse_merge!({:a => 3})
    assert_equal opt.merge({:c => 3}), opt.reverse_merge({:c => 3})
  end
end

