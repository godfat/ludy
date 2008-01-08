
module Ludy

  # dices, e.g., 4d6, 2d20, etc.
  class Dices
    attr_reader :amounts, :faces
    # the default dice is 1d20
    def initialize amounts = 1, faces = 20
      @amounts = amounts
      @faces = faces
    end
    # roll the dices
    def roll
      @amounts.roll @faces
    end
    # the possible min value these dices would roll out.
    def min; @amounts; end
    # the possible max value these dices would roll out.
    def max; @amounts*@faces; end
  end

  # a dice set could contain 4d6 + 2d20 and more dices.
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
    # roll the dice set
    def roll
      result = 0
      @diceset.each { |i| result += i.roll }
      result
    end
    # put dices into this dice set
    def << dices
      @diceset << dices
      @min += dices.min
      @max += dices.max
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
    Ludy::Dices.new self, faces
  end
end
