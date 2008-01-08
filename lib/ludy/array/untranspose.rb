
class Array
  # the opposite of transpose
  # something.transpose.untranspose would return original something
  def untranspose
    result = ([nil]*self.first.size).map{[]}
    self.each{ |zipped|
      zipped = zipped.clone
      result.each{ |r| r << zipped.shift }
    }
    result
  end

  # the in-place version of untranspose
  def untranspose!; replace untranspose; end
end
