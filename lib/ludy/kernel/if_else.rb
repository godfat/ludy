
require 'ludy/blackhole'

module Kernel
  def if
    (yield if self).ergo
  end
  def else
    if self && !self.kind_of?(Blackhole) then self
    else yield end
  end
end
