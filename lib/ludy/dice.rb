
module Ludy

  class Dices
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
  # roll dices (with amounts equal to self.to_i) with faces = ?
  def roll faces = 20
    return nil unless self > 0 &&  self.integer? &&
                     faces > 0 && faces.integer?
    result = 0
    1.step(self){ |i| result += rand(faces) + 1 }
    result
  end

  # create dices with faces = ?
  def dices faces = 20
    Ludy::Dice.new self, faces
  end
end
