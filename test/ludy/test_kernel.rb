
require File.join(File.dirname(__FILE__), '..', 'test_helper')
require 'ludy/kernel'

class TestKernel < Test::Unit::TestCase
  class C
    def pub; 'pub'; end
    def method_missing msg, *args, &block; args.unshift(msg.to_s.upcase).join(' '); end
    private; def pri; 'pri'; end
  end
  def test_public_send
    c = C.new
    assert_equal 'pub', c.public_send(:pub)
    assert_equal 'PRI', c.public_send(:pri)
    assert_equal 'XD', c.public_send(:xd)
  end
  def test_tap
    assert_equal '11', 10.tap{|i| assert_equal '10', i.to_s}.succ.to_s
  end
  def test_if
    assert_equal  "XD", (true ).if{"XD"}
    assert false.if{"XD"}.nil?
    assert_equal "Orz", (false).if{"XD"}.else{"Orz"}
    assert_equal  "XD", (true ).if{"XD"}.else{"Orz"}
    assert_equal  "XD", (true ).if{"xd"}.upcase
    assert false.if{"xd"}.upcase.nil?
    assert_equal "OTL", (false).if{"xd"}.else{"otl"}.upcase
    assert_equal  "XD", (true ).if{"xd"}.else{"otl"}.upcase
  end
  def test_id_and_m
    assert_equal 'XD', id('XD')
    assert_equal 'Orz', 'Orz'.id
    assert_equal [1,3], [1,3].map(&m(:id))
    assert_equal [2,4], [2,4].map(&:id)
  end
end
