
require 'rubygems'
module Ludy
  GEM_RUBY_VERSION = Gem::Version.new(::RUBY_VERSION)
  module_function
  def ruby_before ver
    GEM_RUBY_VERSION < Gem::Version.new(ver)
  end
end
