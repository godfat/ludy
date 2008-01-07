
require 'ludy/blackhole'

module Kernel
  def ergo
    self
  end
end

class NilClass
  def ergo
    @ergo ||= Ludy::Blackhole.new
  end
end
