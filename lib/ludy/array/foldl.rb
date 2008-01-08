
class Array
  # fold from left to right (it just like inject)
  def foldl func, init; inject init, &func; end
end
