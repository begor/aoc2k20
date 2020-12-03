# Your flight departs in a few days from the coastal airport; the easiest way down to the coast from here is via toboggan.
# The shopkeeper at the North Pole Toboggan Rental Shop is having a bad day. "Something's wrong with our computers; we can't log in!" You ask if you can take a look.
# Their password database seems to be a little corrupted: some of the passwords wouldn't have been allowed by the Official Toboggan Corporate Policy that was in effect when they were chosen.
# To try to debug the problem, they have created a list (your puzzle input) of passwords (according to the corrupted database) and the corporate policy when that password was set.
# For example, suppose you have the following list:
# 1-3 a: abcde
# 1-3 b: cdefg
# 2-9 c: ccccccccc
# Each line gives the password policy and then the password. The password policy indicates the lowest and highest number of times a given letter must appear for the password to be valid. For example, 1-3 a means that the password must contain a at least 1 time and at most 3 times.
# In the above example, 2 passwords are valid. The middle password, cdefg, is not; it contains no instances of b, but needs at least 1. The first and third passwords are valid: they contain one a or nine c, both within the limits of their respective policies.
# How many passwords are valid according to their policies?
from sequtils import map, filter
from strutils import parseInt, split

type
  PasswordPolicy = object
    character: char
    min, max: int
    password: string

proc parsePolicy(input: string): PasswordPolicy =
    var tokens = input.split(" ")
    var minmax = tokens[0].split("-").map(parseInt)
    var (min, max) = (minmax[0], minmax[1])
    var character = tokens[1][0]
    var password = tokens[2]
    return PasswordPolicy(character: character, min: min, max: max, password: password)

proc validatePolicy(passwordPolicy: PasswordPolicy): bool = 
    var actual = 0
    for ch in passwordPolicy.password:
        if ch == passwordPolicy.character:
            actual += 1

    return actual >= passwordPolicy.min and actual <= passwordPolicy.max

# --- Part Two ---
# While it appears you validated the passwords correctly, they don't seem to be what the Official Toboggan Corporate Authentication System is expecting.

# The shopkeeper suddenly realizes that he just accidentally explained the password policy rules from his old job at the sled rental place down the street! The Official Toboggan Corporate Policy actually works a little differently.

# Each policy actually describes two positions in the password, where 1 means the first character, 2 means the second character, and so on. (Be careful; Toboggan Corporate Policies have no concept of "index zero"!) Exactly one of these positions must contain the given letter. Other occurrences of the letter are irrelevant for the purposes of policy enforcement.

# Given the same example list from above:

# 1-3 a: abcde is valid: position 1 contains a and position 3 does not.
# 1-3 b: cdefg is invalid: neither position 1 nor position 3 contains b.
# 2-9 c: ccccccccc is invalid: both position 2 and position 9 contain c.
# How many passwords are valid according to the new interpretation of the policies?

func validatePolicyV2(passwordPolicy: PasswordPolicy): bool = 
    var (first, second) = (passwordPolicy.min-1, passwordPolicy.max-1)
    var password = passwordPolicy.password
    var ch = passwordPolicy.character
    if first < 0 or first >= password.len() or second < 0 or second >= password.len():
        return true

    return password[first] != password[second] and (password[first] == ch or password[second] == ch)

var policies = readFile("passwords.txt").string.split("\n").map(parsePolicy)
var validPoliciesV1 = policies.filter(validatePolicy)
echo validPoliciesV1.len()
var validPoliciesV2 = policies.filter(validatePolicyV2)
echo validPoliciesV2.len()


