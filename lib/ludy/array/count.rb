
if RUBY_VERSION < '1.9.0'
  begin
    require 'facets'
  rescue LoadError
    class Array
      # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
      def count t
        inject(0){|r,i| i==t ? r+=1 : r}
      end
    end
  end
end
