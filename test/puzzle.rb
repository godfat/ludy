
require File.join(File.dirname(__FILE__), '..', 'lib', 'puzzle_generator')

p = PuzzleGenerator::Puzzle.new :level => 15, :timeout => 20, :invoke_max => 5
p.display_map
p p.tried_times
p p.tried_duration
