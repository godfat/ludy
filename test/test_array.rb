
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/array'
require 'ludy/symbol/to_proc'

class TestArray < Test::Unit::TestCase
  def test_filter
    assert_equal [1,2,3], [1,18,29,9,4,3,2,1,3,7].filter{|i| i<=3}.sort.uniq
  end
  def test_folds
    assert_equal  6, [1,2,3].foldl(:+.to_proc, 0)
    assert_equal(-6, [1,2,3].foldl(:-.to_proc, 0))
    assert_equal  6, [1,2,3].foldr(:+.to_proc, 0)
    assert_equal  2, [1,2,3].foldr(:-.to_proc, 0)
  end
  def test_combine
    assert_equal [4, 6], [1,2].combine([3,4])
    assert_equal [9, 12], [1,2].combine([3,4], [5,6])

    a = [[1,2],[3,4],[5,6]]
    assert_equal [9, 12], a.inject(&:combine)
    assert_equal [9, 12], a.shift.combine(*a)

    a = [18,29]
    a.combine! [12, 1]
    assert_equal [30, 30], a
  end
  def test_unzip_and_untranspose
    a = [1,2,3]
    b = %w{a b c}
    assert_equal [a, b], a.zip(b).to_a.untranspose
    assert_equal [a, b], [a, b].transpose.untranspose
    assert_equal a, a.zip(b).to_a.unzip

    c = [nil, false, true]
    assert_equal [a, b, c], a.zip(b, c).to_a.untranspose
    assert_equal [a, b, c], [a, b, c].transpose.untranspose
    assert_equal a, a.zip(b, c).to_a.unzip
  end
end

