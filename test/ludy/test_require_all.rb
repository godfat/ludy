
require './test/helper'
require 'ludy/all'

class TestAll < Test::Unit::TestCase
  def test_all
    assert [].respond_to?(:combine)
    assert :x.respond_to?(:to_proc)
    assert :x.respond_to?(:to_msg)
    assert Object.const_defined?(:Ludy)
    assert Ludy.const_defined?(:Variable)
    assert Ludy.const_defined?(:Blackhole)
    assert nil.respond_to?(:ergo)
    assert 123.respond_to?(:ergo)
    assert 'a'.respond_to?(:tap)
    assert lambda{}.respond_to?(:chain)
    assert lambda{}.respond_to?(:compose)
    assert lambda{}.respond_to?(:bind)
    assert lambda{}.respond_to?(:curry)
  end
end
