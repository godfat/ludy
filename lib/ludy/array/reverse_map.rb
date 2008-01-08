
class Array
  # synonymy for reverse.map
  def reverse_map &block
    reverse.map(&block)
  end
end
