
require 'ludy/kernel/public_send' unless RUBY_VERSION < '1.9.0'
require 'ludy/class/undef_all_methods'

module Ludy

  # a variable reference, used for side effect...
  class Variable
    undef_all_methods

    # init the refered instance
    def initialize obj
      @__obj__ = obj
    end

    # delegator
    def method_missing msg, *arg, &block
      @__obj__.public_send msg, *arg, &block
    end

    attr_accessor :__obj__
  end

  # provided for creating lazy object more convient
  def var arg
    Variable.new arg
  end

end # of Ludy
