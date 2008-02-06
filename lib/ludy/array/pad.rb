
class Array
  # ensure the size is at least n, pad with n, default nil
  def pad n, t = nil
    return self if n <= size
    self + [t]*(n-size)
  end
  # inplace version of pad
  def pad! n, t = nil
    return self if n <= size
    concat([t]*(n-size))
  end
end
