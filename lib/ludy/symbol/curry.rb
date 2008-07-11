
require 'ludy/symbol/to_proc'
require 'ludy/proc/curry'

class Symbol
  # synonymy for to_proc.curry
  def curry args = nil
    if args
      to_proc.curry args
    else
      to_proc.curry
    end
  end
end
