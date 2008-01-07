
module Ludy
  class Blackhole
    def method_missing msg, *args, &block
      self
    end
    def nil?
      true
    end
  end
end
