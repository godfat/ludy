
module Ludy

  Z = lambda{|f|
    lambda{|x| f[lambda{|y| x[x][y]}]}[
      lambda{|x| f[lambda{|y| x[x][y]}]}
    ]
  }

end
