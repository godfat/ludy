
class Symbol
  # it is like to_proc, but much more powerful
  # :'*2'.to_msg[5]
  # -> 10
  # :'to_s(16)'.to_msg[15]
  # -> "f"
  def to_msg; lambda{ |*args| eval "args[0].#{self.to_s} #{args[1..-1].join ', '}" }; end
end
