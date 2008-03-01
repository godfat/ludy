
require 'ludy/version'

class Array
  if Ludy::ruby_before '1.9.0'
    require 'ludy/array/foldr'
    require 'ludy/symbol/to_proc' if Ludy::ruby_before '1.9.0'
    # for each combos
    #  [[0,1],[2,3]].combos
    #  => [[0,2],[0,3],[1,2],[1,3]]
    def combos
      result = []
      radixs = reverse.map(&:size)
      inject(1){|r, i| r * i.size}.times{ |step|
        result << foldr(lambda{ |i, r|
                          radix = radixs[r.size]
                          r.unshift i[step % radix]
                          step /= radix unless radix.nil?
                          r
                        }, [])
      }
      result
    end
  else
    require 'ludy/array/tail'
    # for each combos
    #  [[0,1],[2,3]].combos
    #  => [[0,2],[0,3],[1,2],[1,3]]
    # simply:
    #  array.first.product *array.tail
    def combos
      first.product(*tail)
    end
  end
end
