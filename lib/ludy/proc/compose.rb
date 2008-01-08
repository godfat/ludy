
class Proc
  # function coposition
  # i.e., f compose g => f of g => f (g args)
  def compose *procs, &block
    procs << block if block
    lambda{ |*args| ([self] + procs).reverse.inject(args){ |val, fun| fun[*val] } }
  end
end
