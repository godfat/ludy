
require 'ludy/message_dispatcher'

module Kernel
  # you can use defun for overloading(ad-hoc polymorphism),
  # multi-method, pattern matching, and perhaps others?
  def defun name, *args, &fun
    Ludy::MessageDispatcher.create self, name, args, &fun
  end
end
