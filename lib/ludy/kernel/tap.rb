
module Kernel
  if RUBY_VERSION < '1.9.0'
    def tap
      yield self
      self
    end
  end
end
