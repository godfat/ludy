
require 'ludy/class/undef_all_methods'
require 'singleton'

module Ludy
  # a blackhole would eat any message it received.
  class Blackhole
    undef_all_methods
    include Singleton
    def method_missing msg, *args, &block
      self
    end
    def nil?
      true
    end
  end
end
