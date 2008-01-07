
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/variable'

class TestVariable < Test::Unit::TestCase
  include Ludy
  class Qoo
    def cool
      'cool ~~~~'
    end
  end

  def test_variable
    x = var Qoo.new
    y = x

    assert_equal x.__obj__, y.__obj__
    assert_equal Qoo, x.__obj__.class
    assert_equal Qoo, x.class

    assert_equal 'cool ~~~~', x.cool
    assert_equal 'cool ~~~~', y.cool

    x.__obj__ = nil

    assert x.nil?
    assert y.nil?
  end
end
