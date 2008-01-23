
module Ludy
  # append erb output...
  def self.eout string, binding
    eval('_erbout', binding) << string
  end
end
