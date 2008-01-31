
module Ludy
  # append erb output...
  def self.erbout string, binding
    eval('_erbout', binding) << string
  end
end
