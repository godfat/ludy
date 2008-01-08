
require 'ludy/array/reverse_map'
require 'ludy/symbol/to_proc'
require 'ludy/array/foldr'

class Array
  # for each combos
  # [[0,1],[2,3]].combos
  # => [[0,2],[0,3],[1,2],[1,3]]
  def combos
    result = []
    radixs = reverse_map(&:size)
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
end
