
class Proc
  # missing traversal of chain
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
