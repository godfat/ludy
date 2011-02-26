
def list_unfoldr func, input, result = []
  if value = func[input]
    list_unfoldr(func, value.last, result << value.first)
  else
    result
  end
end

def query input
  list_unfoldr(lambda{ |value|
    if value == 0
      nil
    else
      [value, value - 1]
    end
  }, input)
end

p query(10)
