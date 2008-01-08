
class Array
  # strip the last element
  # [1,2,3].body
  # -> [1,2]
  def body
    self[0..-2]
  end
end
