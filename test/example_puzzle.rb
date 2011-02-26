
require 'ludy'
require 'puzzle_generator'

PuzzleGenerator.debug = true
pg = PuzzleGenerator::Puzzle.new :level => 4, :timeout => 2, :invoke_max => 5
begin
  pg.generate
  pg.display_map
rescue Ludy::Timeout => e
  puts e
ensure
  p pg.tried_times
  p pg.tried_duration
end

# level => 7
# 0  0  0  0  0  0
# 0  0  0  0  0  0
# 0  0  3  0  0  0
# 0  0  1  0  0  0
# 1  3  4  0  0  0
# 2  1  1  0  0  0
# 2  3  2  0  0  0
# 3  4  3  0  0  0
# 3  1  2  4  0  0
# 2  4  2  1  0  0

# level => 15
# 0  0  1  0  0  0
# 2  0  2  1  0  0
# 1  0  4  1  0  0
# 2  0  3  3  1  0
# 2  4  1  4  4  0
# 3  2  4  2  2  1
# 4  1  1  3  3  2
# 3  3  2  3  4  3
# 3  1  3  4  1  2
# 2  3  4  1  4  2

# level => 7
#  0  0  0  0  0  0
#  0  0  0  0  0  0
#  0  0  0  0  0  0
#  0  0  0  0  0  0
#  0  0  1  0  0  0
#  0  0  2  2  0  0
#  0  1  3  4  4  0
#  1  2  4  1  1  0
#  3  3  2  2  3  1
#  2  2  3  3  4  3
# [20, 9]
# [1.630587, 0.151272]

# level => 10
#  0  0  1  1  0  0
#  0  0  1  2  0  0
#  0  0  2  3  0  0
#  0  0  2  3  0  0
#  0  0  3  4  0  0
#  0  1  4  1  0  0
#  0  2  1  3  4  0
#  2  2  2  2  1  0
#  2  3  1  3  2  4
#  4  4  1  4  3  2
# [28, 1]
# [3.26917, 0.020366]

# level => 12
#  0  2  1  0  0  0
#  0  2  2  0  0  0
#  0  3  3  1  0  0
#  0  4  3  2  0  0
#  0  4  4  2  0  4
#  0  1  4  3  1  1
#  0  4  1  1  2  1
#  0  3  2  2  1  2
#  0  3  4  4  3  1
#  2  3  4  3  4  1
# [68, 1]
# [6.194671, 0.055699]

# level => 13
#  0  3  1  0  0  0
#  0  2  1  1  0  0
#  0  3  3  2  1  2
#  0  3  2  1  1  4
#  0  4  2  3  3  4
#  0  1  3  3  2  1
#  0  4  2  4  3  1
#  0  4  2  1  4  2
#  0  3  1  4  4  1
#  2  3  2  2  1  1
# [10, 1]
# [1.97002, 0.030499]

# level => 7
#  0  0  0  0  0  0
#  0  0  0  2  0  0
#  0  0  0  3  0  0
#  0  0  0  4  0  0
#  0  0  0  1  0  0
#  0  0  0  2  0  0
#  0  1  1  3  0  0
#  0  2  2  4  3  0
#  0  4  4  3  4  3
#  1  2  2  3  1  1
# [53, 17]
# [4.614123, 0.264156]

# level => 14
#  0  0  0  0  0  0
#  0  0  1  0  0  0
#  1  0  4  0  2  0
#  1  0  2  4  3  0
#  2  1  3  2  3  0
#  2  3  1  4  4  1
#  3  1  4  3  3  2
#  2  4  1  4  3  2
#  3  2  2  1  1  3
#  2  4  4  1  1  2
# [123, 1]
# [14.940386, 0.077763]

# level => 15
#  0  0  0  0  1  0
#  0  0  2  0  2  0
#  0  0  1  0  3  0
#  0  4  4  1  4  1
#  2  2  4  2  3  3
#  3  2  2  3  1  1
#  3  3  1  4  4  2
#  4  3  1  3  4  2
#  2  4  2  1  1  3
#  3  3  1  1  4  2
# [3650, 17]
# [464.755704, 1.220837]

# level => 15
# 0  2  0  0  1  0
# 0  4  2  1  3  0
# 4  3  3  2  2  0
# 2  4  3  3  2  0
# 1  2  2  3  3  0
# 1  1  4  2  3  0
# 2  1  3  4 16  0
# 1  2  2  1  3  1
# 4  1  4  4  2  3
# 1  1  3  4  1  1
# [1626, 1]
# [159.004594, 0.035997]

# level => 17 => broken...
# 0  2  0  1  1  0
# 0  4  2  2  3  0
# 4 <3  3  3> 2  1
# 2  4  3  3  2  2
# 1  2  2  2  3  3
# 1  1  4  4  3  2
# 2  1  3  1  1  2
# 1  2  2  1  3  1
# 4  1  4  4  2  3
# 1  1  3  4  1  1
# hacked from above XD

# level => 15
#  1  0  0  0  0  0
#  3  1  1  0  3  0
#  4  2  4  4  1  0
#  4  3  2  2  4  0
#  1  3  2  3  2  0
#  1  2  3  1  2  0
#  2  4  2  4  3  0
#  1  3  3  2  3  0
#  1  3  1  1 16  4
#  4  1  2  2  3  1
# [1139, 1]
# [115.270095, 0.031929]
