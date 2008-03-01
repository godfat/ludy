
require 'ludy/version'

module Kernel
  if Ludy::ruby_before '1.9.0'
    # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
    def define_singleton_method msg, &block
      self.class.__send__ :define_method, msg, &block
    end
  end
  # it simply alias singleton(instance) method
  def alias_singleton_method new_msg, old_msg
    self.class.__send__ :alias_method, new_msg, old_msg
  end
end
