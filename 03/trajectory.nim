# You start on the open square (.) in the top-left corner and need to reach the bottom (below the bottom-most row on your map).
# The toboggan can only follow a few specific slopes (you opted for a cheaper model that prefers rational numbers); start by counting all the trees you would encounter for the slope right 3, down 1:
# From your starting position at the top-left, check the position that is right 3 and down 1. Then, check the position that is right 3 and down 1 from there, and so on until you go past the bottom of the map.
# The locations you'd check in the above example are marked here with O where there was an open square and X where there was a tree:
# ..##.........##.........##.........##.........##.........##.......  --->
# #..O#...#..#...#...#..#...#...#..#...#...#..#...#...#..#...#...#..
# .#....X..#..#....#..#..#....#..#..#....#..#..#....#..#..#....#..#.
# ..#.#...#O#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#..#.#...#.#
# .#...##..#..X...##..#..#...##..#..#...##..#..#...##..#..#...##..#.
# ..#.##.......#.X#.......#.##.......#.##.......#.##.......#.##.....  --->
# .#.#.#....#.#.#.#.O..#.#.#.#....#.#.#.#....#.#.#.#....#.#.#.#....#
# .#........#.#........X.#........#.#........#.#........#.#........#
# #.##...#...#.##...#...#.X#...#...#.##...#...#.##...#...#.##...#...
# #...##....##...##....##...#X....##...##....##...##....##...##....#
# .#..#...#.#.#..#...#.#.#..#...X.#.#..#...#.#.#..#...#.#.#..#...#.#  --->
# In this example, traversing the map using this slope would cause you to encounter 7 trees.
# Starting at the top-left corner of your map and following a slope of right 3 and down 1, how many trees would you encounter?
from strutils import split

proc countTrees(map: seq[string]): int =
    var (row, col) = (0, 0)
    var rowSize = map.len()
    var colSize = map[0].len()
    while row < map.len():
        var (r, c) = (row mod rowSize, col mod colSize)
        
        if map[r][c] == '#':
            result += 1
        
        row += 1
        col += 3

var map = readFile("trajectory.txt").string.split("\n")
echo countTrees(map)