#!/usr/bin/env ruby

#    Copyright (c) 2007, Lin Jen-Shin（a.k.a. godfat 真常）
#
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
#
#        http://www.apache.org/licenses/LICENSE-2.0
#
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.

require 'test/unit'
require(File.join(File.dirname(__FILE__), '..', 'lib', 'ludy'))
require_ludy 'curry'
require_ludy 'ludy_ext'
include Ludy
class Array
  def test_curry a, b, c, d, e
    [a, b, c, d, e]
  end
  include Curry
end
class TestCurry < Test::Unit::TestCase
  def test_curry
    func1 = [1,2,3].cfoldr[:-.to_proc]
    assert_equal 2, func1[0]

    assert_equal [8,10,12], [4,5,6].cmap(&:*.to_proc.curry(2))

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
