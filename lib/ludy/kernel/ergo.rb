
require 'ludy/blackhole'

module Kernel
  # it simply return self, see NilClass#ergo
  def ergo
    self
  end
end

class NilClass
  # return blackhole to eat any message, see Kernel#ergo
  def ergo
    Ludy::Blackhole.instance
  end
end
