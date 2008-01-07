
module Ludy

  class Lazy
    instance_methods.each{|m| undef_method m unless m =~ /^__/}

    def initialize func = nil, &block
      if block_given? then @func = block
      else
        raise TypeError, "#{func} don't respond to :call" unless func.respond_to? :call
        @func = func
      end
    end

    def method_missing msg, *arg, &block
      (@obj ||= @func.call).__send__ msg, *arg, &block
    end
  end

  def lazy arg = nil, &block
    Lazy.new arg, &block
  end

end # of Ludy
