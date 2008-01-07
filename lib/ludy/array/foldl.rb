
class Array
  def foldl func, init; self.inject init, &func; end
end
