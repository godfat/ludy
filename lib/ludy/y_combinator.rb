
require 'ludy/lazy'

module Ludy

  Y = lambda{|f|
    lambda{|x| lazy{f[x[x]]} }[lambda{|x| lazy{f[x[x]]} }]
  }

end
