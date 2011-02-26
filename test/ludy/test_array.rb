
require './test/helper'
require 'ludy/array'
require 'ludy/symbol/to_proc' if RUBY_VERSION < '1.9.0'

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

    assert_equal ['ab','ba'], ['a','b'].combine(['b','a'])
  end
  def test_rotate
    assert_equal [2,3,1], [1,2,3].rotate
    assert_equal [2,3,1], [1,2,3].rotate(-2)
    assert_equal [1,2,3], [1,2,3].rotate(-3)
    assert_equal [1,2,3], [1,2,3].rotate(0)
    assert_equal [2,3,1], [1,2,3].rotate(1)
    assert_equal [3,1,2], [1,2,3].rotate(2)
    assert_equal [1,2,3], [1,2,3].rotate(3)
  end
  def test_combos
    assert_equal [[0,2],[0,3],[1,2],[1,3]], [[0,1],[2,3]].combos
    assert_equal [[0,2,4],[0,2,5],[0,3,4],[0,3,5],[1,2,4],[1,2,5],[1,3,4],[1,3,5]], [[0,1],[2,3],[4,5]].combos
    assert_equal [[0,3],[0,4],[0,5],[1,3],[1,4],[1,5],[2,3],[2,4],[2,5]], [[0,1,2],[3,4,5]].combos
    assert_equal [[0,3],[0,4],[1,3],[1,4],[2,3],[2,4]], [[0,1,2],[3,4]].combos
    assert_equal [[0,2],[0,3],[0,4],[1,2],[1,3],[1,4]], [[0,1],[2,3,4]].combos
  end
  def test_map_with_index
    assert_equal [1,3,5], [1,2,3].map_with_index{|e,i|e+i}
  end
  def test_tail
    assert_equal [2,3,4], [1,2,3,4].tail
  end
  def test_pad
    assert_equal [1,2,3,nil,nil], [1,2,3].pad(5)
    assert_equal [1,2,3], [1,2,3].pad(3)
    assert_equal [1,2,3], [1,2,3].pad(2)
    assert_equal [1,2,3], [1,2,3].pad(-2)
    assert_equal [1,2,3], [1,2,3].pad(0)
    a = [1,2,3]
    a.pad! 5, 6
    assert_equal [1,2,3,6,6], a
  end
end

