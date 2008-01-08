
class Array
  def rotate size = 1
    head = size > 0 ? last(size) : self[(-size)..-1]
    tail = self - head
    head + tail
  end
  def rotate!
    replace rotate
  end
end
