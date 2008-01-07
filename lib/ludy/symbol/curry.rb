
require 'ludy/symbol/to_proc'

class Symbol
  def curry
    to_proc.curry
  end
end
