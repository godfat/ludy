
class Array
  # fold from right to left
  def foldr func, init
    reverse_each{ |i| init = func[i, init] }
    init
  end
end
