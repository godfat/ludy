
require 'ludy/version'

if Ludy.ruby_before '1.8.7'
  begin
    require 'facets/enumerable/combos'
  rescue LoadError
    require 'ludy/array/combos'
  end
  class Array
    # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
    def product *args
      args.unshift(self).combos
    end
  end
end
