
require 'ludy/lazy'

module Ludy

  # the Y combinator, with lazy stuff
  Y = lambda{|f|
    lambda{|x| lazy{f[x[x]]} }[lambda{|x| lazy{f[x[x]]} }]
  }

end # of Ludy
