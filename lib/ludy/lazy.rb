
require 'ludy/kernel/public_send'
require 'ludy/class/undef_all_methods'

module Ludy

  # a lazy object would be evaluated until the time it called,
  # and save the result for futher use.
  class Lazy
    undef_all_methods

    # supply the evaluation function through first argument or block
    def initialize func = nil, &block
      if block_given? then @func = block
      else
        raise TypeError, "#{func} don't respond to :call" unless func.respond_to? :call
        @func = func
      end
    end

    # :nodoc:
    def method_missing msg, *arg, &block
      (@obj ||= @func.call).public_send msg, *arg, &block
    end
  end

  # provided for creating lazy object more convient
  def lazy arg = nil, &block
    Lazy.new arg, &block
  end

end # of Ludy
