# $Id$

require File.join(File.dirname(__FILE__), %w[spec_helper])

describe Ludy do
end

# bowling.rb
class Bowling # :nodoc:
  def hit(pins)
  end

  def score
    0
  end
end

# bowling_spec.rb
describe Bowling do
  before(:each) do
    @bowling = Bowling.new
  end

  it "should score 0 for gutter game" do
    20.times { @bowling.hit(0) }
    @bowling.score.should == 0
  end
end

# EOF
