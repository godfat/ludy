
require 'ludy/version'

if Ludy.ruby_before '1.8.7'
  class Symbol
    # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
    def to_proc; lambda{ |*args| args.shift.__send__ self, *args }; end
  end
end
