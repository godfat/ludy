
module Ludy
  TRACE_EVENT   = 0
  TRACE_FILE    = 1
  TRACE_LINE    = 2
  TRACE_MSG     = 3
  TRACE_BINDING = 4
  TRACE_CLASS   = 5

  def callstack levels = -1
    st = Thread.current[:callstack]
    if levels then st && st[levels - 2] else st end
  end
  module_function :callstack
end # of Ludy

set_trace_func lambda{ |*args|
  case args[Ludy::TRACE_EVENT]
    when /call$/
      (Thread.current[:callstack] ||= []).push args
    when /return$/
      (Thread.current[:callstack] ||= []).pop
  end
}
