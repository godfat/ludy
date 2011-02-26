
require 'ludy/version'

class Array
  # it would be defined if RUBY_VERSION < '1.9.0', see rdoc in ruby 1.9
  def choice
    self[rand(size)]
  end unless method_defined?(:choice)
  # the choosen element would be deleted. return the choosen
  def choice!
    i = rand size
    r = self[i]
    self.delete_at i
    r
  end
end
