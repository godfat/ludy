
module Ludy

  # the Z combinator, without lazy stuff
  Z = lambda{|f|
    lambda{|x| f[lambda{|y| x[x][y]}]}[
      lambda{|x| f[lambda{|y| x[x][y]}]}
    ]
  }

end # of Ludy
