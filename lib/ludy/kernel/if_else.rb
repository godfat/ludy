
module Kernel
  def if
    yield if self
  end
  def else
    if self then self
    else yield end
  end
end
