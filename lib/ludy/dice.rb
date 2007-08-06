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

module Ludy

  class Dice
    attr_reader :amounts, :faces
    def initialize amounts = 1, faces = 20
      @amounts = amounts
      @faces = faces
    end
    def roll
      @amounts.roll @faces
    end
    def min; @amounts; end
    def max; @amounts*@faces; end
  end

  class DiceSet
    attr_reader :min, :max
    def initialize *args
      @diceset = args
      @min = @max = 0
      @diceset.each{ |i|
        @min += i.min
        @max += i.max
      }
    end
    def roll
      result = 0
      @diceset.each { |i| result += i.roll }
      result
    end
    def << dice
      @diceset << dice
      @min += dice.min
      @max += dice.max
      self
    end
  end

end

class Numeric
  def roll faces = 20
    return nil unless self > 0 &&  self.integer? &&
                     faces > 0 && faces.integer?
    result = 0
    1.step(self){ |i| result += rand(faces) + 1 }
    result
  end
  def dice faces = 20
    Ludy::Dice.new self, faces
  end
end
