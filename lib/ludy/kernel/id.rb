
require 'ludy/version'

module Kernel
  undef_method :id if Ludy::ruby_before '1.9.0'
  # id returns self
  def id a = nil; a.nil? ? self : a; end
end
