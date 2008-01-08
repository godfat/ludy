
require 'ludy/symbol/to_proc'
require 'ludy/array/foldr'
require 'ludy/array/reverse_map'

class Array
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
