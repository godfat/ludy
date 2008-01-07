
class Symbol
  if RUBY_VERSION < '1.9.0'
    def to_proc; lambda{ |*args| args.shift.__send__ self, *args }; end
  end
end
