
class Array
  def foldr func, init
    self.reverse_each{ |i| init = func[i, init] }
    init
  end
end
