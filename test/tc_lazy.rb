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
require File.join(File.dirname(__FILE__), '..', 'lib', 'ludy')
require_ludy 'lazy'

class TestLazy < Test::Unit::TestCase
  include Ludy
  def setup; @data = 0; end
  def get; @data += 1; end
  def test_lazy
    assert_equal 0, @data
    v = lazy{get}
    assert_equal 0, @data
    assert_equal 1, v
    assert_equal '1', v.to_s
    assert_equal 1, v
    assert_equal '1', v.to_s
  end
end
