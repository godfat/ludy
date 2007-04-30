#!/usr/bin/ruby

#    Copyright (c) 2007, Lin Jen-Shin（a.k.a. godfat 真常）
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

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
