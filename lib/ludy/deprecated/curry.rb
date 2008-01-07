
require 'ludy/proc/curry'

module Ludy

  module Curry
    def self.included target
      target.module_eval{
        instance_methods.each{ |m|
          next unless m =~ /^\w/
          module_eval <<-END
            def c#{m} *args, &block
              if args.size == method(:#{m}).arity
                self.__send__ :#{m}, *args, &block
              else
                method(:c#{m}).to_proc.send :__curry__, *args
              end
            end
          END
        }
      }
    end
  end

end

=begin
              method(:#{m}).to_proc.curry.call *args, &block
=end
