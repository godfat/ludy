
class Array
  def reverse_map &block
    reverse.map(&block)
  end
end
