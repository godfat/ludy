
require File.join(File.dirname(__FILE__), '..', 'lib', 'puzzle_generator')

p = PuzzleGenerator::Puzzle.new :level => 7, :timeout => 5, :invoke_max => 5
p.display_map
p p.tried_times
p p.tried_duration

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
