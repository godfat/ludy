
require 'ludy/kernel/public_send'
require 'ludy/class/undef_all_methods'

module Ludy

  class Variable
    undef_all_methods

    def initialize obj
      @__obj__ = obj
    end

    def method_missing msg, *arg, &block
      @__obj__.public_send msg, *arg, &block
    end

    attr_accessor :__obj__
  end

  def var arg
    Variable.new arg
  end

end # of Ludy
