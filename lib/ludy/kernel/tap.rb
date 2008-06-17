
require 'ludy/version'

module Kernel
  if Ludy::ruby_before '1.8.7'
    # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
    def tap
      yield self
      self
    end
  end
end
