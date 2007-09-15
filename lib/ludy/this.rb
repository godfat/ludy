#!/usr/bin/env ruby

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

begin
  require_ludy 'callstack'
rescue NameError
  require(File.join(File.dirname(__FILE__), '../', 'ludy'))
  require_ludy 'callstack'
end

module Ludy
  def this
    info = callstack(-2)
    # lambda{ |*args|
      # Thread.current[:temp_args] = args
      # eval("send :#{info[3]}, *Thread.current[:temp_args]", info[4])
    # }
    eval('self', info[TRACE_BINDING]).method(info[TRACE_MSG])
  end
  module_function :this
end # of Ludy
