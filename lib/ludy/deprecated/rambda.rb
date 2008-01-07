
require 'rubygems'
raise LoadError.new('you need ruby2ruby gem to use this tool') unless require 'ruby2ruby'

require 'ludy/symbol/to_proc'

module Ludy

  class Rambda
    def initialize &block
      @this = eval block.to_ruby
      define_instance_method :call, &@this
      alias_instance_method :[], :call
    end
    attr_reader :this
    alias_method :to_proc, :this
  end

  def rambda &block
    Rambda.new &block
  end

end # of Ludy
