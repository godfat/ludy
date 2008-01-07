
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/callstack'

class TestCallstack < Test::Unit::TestCase
  include Ludy
  def setup; @binding = 'XD' end
  def test_callstack
    called_line = __LINE__-1
    top = callstack
    assert_equal 'call', top[TRACE_EVENT]
    assert_equal __FILE__, top[TRACE_FILE]
    assert_equal called_line, top[TRACE_LINE]
    assert_equal :test_callstack, top[TRACE_MSG]
    assert_equal 'XD', eval('@binding', top[TRACE_BINDING])
    assert_equal self.class, top[TRACE_CLASS]
  end
end
