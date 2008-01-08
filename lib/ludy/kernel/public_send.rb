
module Kernel
  if RUBY_VERSION < '1.9.0'
    # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
    def public_send msg, *args, &block
      if self.respond_to? msg
        self.__send__ msg, *args, &block
      else
        self.method_missing msg, *args, &block
      end
    end
  end
end
