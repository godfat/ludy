
class Array
  def foldl func, init; inject init, &func; end
end
