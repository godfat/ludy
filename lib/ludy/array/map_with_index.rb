
class Array
  def map_with_index
    i = -1
    map{ |e| i+=1; yield e, i; }
  end
end
