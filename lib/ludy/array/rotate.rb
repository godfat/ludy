
class Array
  # rotate right with size.
  # if the size is negative, rotate left.
  #   [1,2,3].rotate
  #   => [2,3,1]
  #
  #   [1,2,3].rotate -1
  #   => [3,1,2]
  #
  #   [1,2,3].rotate 2
  #   => [3,1,2]
  def rotate n = 1
    return self if empty? or n == 0
    self[n..-1] + self[0...-n]
  end unless method_defined?(:rotate)
  # inplace version of rotate
  def rotate!
    replace rotate
  end unless method_defined?(:rotate!)
end
