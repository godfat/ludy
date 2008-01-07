
module Kernel
  def define_instance_method msg, &block
    self.class.send :define_method, msg, &block
  end
  def alias_instance_method new_msg, old_msg
    self.class.send :alias_method, new_msg, old_msg
  end
end
