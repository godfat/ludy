
require 'ludy/arry/untranspose'

class Array
  def unzip; untranspose.first; end
  def unzip!; replace unzip; end
end
