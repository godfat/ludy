
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy/test/helper')
require 'ludy/deprecated/curry'

class Array
  def test_curry a, b, c, d, e
    [a, b, c, d, e]
  end
  include Ludy::Curry
end

class TestCurry < Test::Unit::TestCase
  include Ludy
  def test_curry
    func1 = [1,2,3].cfoldr[:-.to_proc]
    assert_equal 2, func1[0]

    assert_equal [8,10,12], [4,5,6].cmap(&:*.to_proc.curry[2])

    result = [2,3,4,5,6]
    func2 = result.ctest_curry[2]
    func3 = func2[3]
    func4 = func3[4]
    func5 = func4[5]
    func6 = func5[6]

    assert_equal result, result.ctest_curry[2,3,4,5,6]
    assert_equal result, func2[3,4,5,6]
    assert_equal result, func3[4,5,6]
    assert_equal result, func4[5,6]
    assert_equal result, func5[6]
    assert_equal result, func6
  end
end
