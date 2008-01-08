
class Array
  def rotate size = 1
    head = size > 0 ? self.last(size) : self[(-size)..-1]
    tail = self - head
    head + tail
  end
end
