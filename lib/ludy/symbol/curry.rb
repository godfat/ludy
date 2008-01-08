
require 'ludy/symbol/to_proc'
require 'ludy/proc/curry'

class Symbol
  # synonymy for to_proc.curry
  def curry
    to_proc.curry
  end
end
