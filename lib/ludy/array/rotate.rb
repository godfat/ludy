
class Array
  # rotate right with size.
  # if the size is negative, rotate left.
  # [1,2,3].rotate
  # => [3,1,2]
  #
  # [1,2,3].rotate -1
  # => [2,3,1]
  #
  # [1,2,3].rotate 2
  # => [2,3,1]
  def rotate size = 1
    head = size > 0 ? last(size) : self[(-size)..-1]
    tail = self - head
    head + tail
  end
  # in-place version of rotate
  def rotate!
    replace rotate
  end
end
