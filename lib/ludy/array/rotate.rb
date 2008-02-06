
class Array
  # rotate right with size.
  # if the size is negative, rotate left.
  #   [1,2,3].rotate
  #   => [3,1,2]
  #
  #   [1,2,3].rotate -1
  #   => [2,3,1]
  #
  #   [1,2,3].rotate 2
  #   => [2,3,1]
  def rotate n = 1
    return self if empty? or n == 0
    self[-n..-1] + self[0...-n]
  end
  # in-place version of rotate
  def rotate!
    replace rotate
  end
end
