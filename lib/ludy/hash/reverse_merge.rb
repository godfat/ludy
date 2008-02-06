
class Hash
  # if the keys of input hash exists, don't merge in it
  def reverse_merge hash
    dup.reverse_merge! hash
  end
  # inplace version of reverse_merge
  def reverse_merge! hash
    replace hash.merge(self)
  end
end
