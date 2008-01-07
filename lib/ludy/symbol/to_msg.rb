
class Symbol
  def to_msg; lambda{ |*args| eval "args[0].#{self.to_s} #{args[1..-1].join ', '}" }; end
end
