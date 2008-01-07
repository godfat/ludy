
class Array
  def untranspose
    result = ([nil]*self.first.size).map{[]}
    self.each{ |zipped|
      zipped = zipped.clone
      result.each{ |r| r << zipped.shift }
    }
    result
  end
  def untranspose!; replace untranspose; end
end
