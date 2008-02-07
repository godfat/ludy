
module Kernel
  # common idiom for:
  #  Marshal::load(Marshal::dump(self))
  def deep_copy
    Marshal::load(Marshal::dump(self))
  end
end
