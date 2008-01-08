
require 'ludy/blackhole'

module Kernel
  # another if variant...
  def if
    (yield if self).ergo
  end
  # another else variant...
  def else
    if self && !self.kind_of?(Blackhole) then self
    else yield end
  end
end
