
require 'ludy/callstack'

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
