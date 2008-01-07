
module Ludy


end

module Kernel
  def cut target, &block
    (class << target; self; end)
  end
end

class Name
  def name
    'name'
  end
end

cut Name do
  def name
    "<#{super}>"
  end
  def g
    '??'
  end
end
