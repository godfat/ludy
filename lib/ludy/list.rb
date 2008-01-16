
module Ludy
  # fib = 0 : 1 : [x+y | (x, y) <- zip fib (tail fib)]
  # combos = List[->(x,y){[x,y]}, 0..1, 2..3]
  class List # :nodoc:
    private :initialize
    class << self
      def [] target, *args
        raise ArgumentError.new("you need at least #{target.arity} arguments(sources) for #{target}") if args.size < target.arity
        sources = args[0...target.arity]
        conditions = args[target.arity..-1]
        create_array sources, conditions
      end

      private
      def create_array sources, conditions
        sources.traspose.flatten
      end
    end
  end
end
