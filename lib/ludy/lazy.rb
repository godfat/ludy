
require 'ludy/kernel/public_send'
require 'ludy/class/undef_all_methods'

module Ludy

  class Lazy
    undef_all_methods

    def initialize func = nil, &block
      if block_given? then @func = block
      else
        raise TypeError, "#{func} don't respond to :call" unless func.respond_to? :call
        @func = func
      end
    end

    def method_missing msg, *arg, &block
      (@obj ||= @func.call).public_send msg, *arg, &block
    end
  end

  def lazy arg = nil, &block
    Lazy.new arg, &block
  end

end # of Ludy
