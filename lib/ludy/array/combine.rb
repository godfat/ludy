
require 'ludy/symbol/to_proc'

class Array
  # example:
  #  [1,2,3].combine [2,4,6]
  #  => [3,6,9]
  #
  #  [1,2].combine [1,2], [1,2]
  #  => [3,6]
  #
  #  ['a','b'].combine ['b','a']
  #  => ['ab','ba']
  def combine *target; zip(*target).map{|i|i.inject(&:+)}; end
  # inplace version of combine
  def combine! *target; replace combine(*target); end
end
