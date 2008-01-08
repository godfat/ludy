
module Ludy
  def defun name, *args, &imp
  end
  class Dispatcher
    def self.dispatchers; @dispatchers ||= []; end
    def initialize
      
    end
  end
end

# defun :fact, 0 do |n|
#   1
# end
# 
# defun :fact, Integer do |n|
#   n * fact(n-1)
# end
