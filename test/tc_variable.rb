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
require_ludy 'variable'

class TestVariable < Test::Unit::TestCase
  include Ludy
  class Qoo
    def cool
      'cool ~~~~'
    end
  end

  def test_variable
    x = var Qoo.new
    y = x

    assert_equal x.__obj__, y.__obj__
    assert_equal Qoo, x.__obj__.class
    assert_equal Qoo, x.class

    assert_equal 'cool ~~~~', x.cool
    assert_equal 'cool ~~~~', y.cool

    x.__obj__ = nil

    assert x.nil?
    assert y.nil?
  end
end
