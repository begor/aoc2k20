# First part
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

# Second part:
# The Elves in accounting are thankful for your help; one of them even offers you a starfish coin they had left over from a past vacation. They offer you a second one if you can find three numbers in your expense report that meet the same criteria.
# Using the above example again, the three entries that sum to 2020 are 979, 366, and 675. Multiplying them together produces the answer, 241861950.
# In your expense report, what is the product of the three entries that sum to 2020?
import algorithm
import sets
from sequtils import map
from strutils import parseInt, split

proc twoSumIndecies(xs: seq[int], target: int): (int, int) =
    var start = 0
    var fin = xs.len() - 1
    result = (-1, -1)

    while start < fin:
        var t = xs[start] + xs[fin]

        if t == target:
            return (start, fin)
        elif t < target:
            start += 1
        else:
            fin -= 1
    

# A + B + C = T
# A + B = T - C
proc threeSumIndecies(xs: seq[int], target: int): (int, int, int) =
    for first, x in xs:
        var (second, third) = twoSumIndecies(xs, target - x)
        if second >= 0 and third >= 0 and first != second and first != third:
            return (first, second, third)


var xs = sorted(readFile("balance.txt").string.split("\n").map(parseInt))
var (first, second, third) = threeSumIndecies(xs, 2020)
if first >= 0 and second >= 0 and third >= 0:
    echo xs[first] * xs[second] * xs[third]
else:
    echo "not found"
