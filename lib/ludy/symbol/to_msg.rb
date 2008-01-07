
class Symbol
  def to_proc; lambda{ |*args| args.shift.__send__ self, *args }; end
end
