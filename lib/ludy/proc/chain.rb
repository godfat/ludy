
class Proc
  #   TODO: missing traversal of chain
  # create a chain of proc. whenever you call the chain,
  # each proc would be called. the return value would be
  # all the results saved orderly in a array.
  def chain *procs, &block
    procs << block if block
    lambda{ |*args|
      result = []
      ([self] + procs).each{ |i|
        result += [i[*args]].flatten
      }
      result
    }
  end
end
