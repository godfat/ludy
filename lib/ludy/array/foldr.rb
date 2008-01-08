
class Array
  def foldr func, init
    reverse_each{ |i| init = func[i, init] }
    init
  end
end
