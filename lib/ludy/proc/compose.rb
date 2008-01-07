
class Proc
  def compose *procs, &block
    procs << block if block
    lambda{ |*args| ([self] + procs).reverse.inject(args){ |val, fun| fun[*val] } }
  end
end
