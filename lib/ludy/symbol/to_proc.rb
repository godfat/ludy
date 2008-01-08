
class Symbol
  if RUBY_VERSION < '1.9.0'
    # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
    def to_proc; lambda{ |*args| args.shift.__send__ self, *args }; end
  end
end
