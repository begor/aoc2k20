# Before you leave, the Elves in accounting just need you to fix your expense report (your puzzle input); apparently, something isn't quite adding up.
# Specifically, they need you to find the two entries that sum to 2020 and then multiply those two numbers together.
# For example, suppose your expense report contained the following:
# 1721
# 979
# 366
# 299
# 675
# 1456
# In this list, the two entries that sum to 2020 are 1721 and 299. Multiplying them together produces 1721 * 299 = 514579, so the correct answer is 514579.
# Of course, your expense report is much larger. Find the two entries that sum to 2020; what do you get if you multiply them together?
import sets
from sequtils import map
from strutils import parseInt, split

proc twoSum(xs: seq[int], target: int): (int, int) =
    var diffs = initHashSet[int]()
    for x in xs:
        diffs.incl(x)
    
    for x in xs:
        if diffs.contains(target - x):
            result = (x, target - x)

var xs = readFile("balance.txt").string.split("\n").map(parseInt)
var (first, second) = twoSum(xs, 2020)
echo first * second
