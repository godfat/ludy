
module Kernel
  if RUBY_VERSION < '1.9.0'
    def define_singleton_method msg, &block
      self.class.__send__ :define_method, msg, &block
    end
  end
  def alias_singleton_method new_msg, old_msg
    self.class.__send__ :alias_method, new_msg, old_msg
  end
end
