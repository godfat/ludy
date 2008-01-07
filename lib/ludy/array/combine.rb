
require 'ludy/symbol/to_msg'

class Array
  def combine *target; self.zip(*target).map &:'inject &:+'.to_msg; end
  def combine! *target; replace combine(*target); end
end
