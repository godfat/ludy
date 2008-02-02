
require File.join(File.dirname(__FILE__), '..', 'test_helper')
require 'ludy/class/undef_all_methods'

class TestClass < Test::Unit::TestCase
  class C; end
  def test_undef_all_methods
    c = C.new
    assert c.respond_to?(:to_s)
    C.undef_all_methods
    # then? how to test?
  end
end
