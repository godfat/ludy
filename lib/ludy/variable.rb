
module Ludy

  class Variable
    instance_methods.each{|m| undef_method m unless m =~ /^__/}

    def initialize obj
      @__obj__ = obj
    end

    def method_missing msg, *arg, &block
      @__obj__.__send__ msg, *arg, &block
    end

    attr_accessor :__obj__
  end

  def var arg
    Variable.new arg
  end

end # of Ludy
