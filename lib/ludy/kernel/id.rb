
module Kernel
  undef_method :id if RUBY_VERSION < '1.9.0'
  def id a = nil; a.nil? ? self : a; end
end
