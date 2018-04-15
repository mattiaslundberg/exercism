from collections import Counter

# Score categories
# Change the values as you see fit
ONES = lambda d: number(d, 1)
TWOS = lambda d: number(d, 2)
THREES = lambda d: number(d, 3)
FOURS = lambda d: number(d, 4)
FIVES = lambda d: number(d, 5)
SIXES = lambda d: number(d, 6)


def number(ds, val):
    res = 0
    for d in ds:
        if d == val:
            res = res + val
    return res


def LITTLE_STRAIGHT(d):
    return 30 if sorted(d) == [1, 2, 3, 4, 5] else 0


def BIG_STRAIGHT(d):
    return 30 if sorted(d) == [2, 3, 4, 5, 6] else 0


def CHOICE(d):
    return sum(d)


def YACHT(d):
    c = Counter(d).most_common()
    if len(c) >= 1 and c[0][1] == 5:
        return 50
    return 0


def FULL_HOUSE(d):
    c = Counter(d).most_common()
    if len(c) == 2 and c[0][1] == 3 and c[1][1] == 2:
        return sum(d)
    return 0


def FOUR_OF_A_KIND(d):
    c = Counter(d).most_common()
    if len(c) >= 1 and c[0][1] >= 4:
        return c[0][0] * 4
    return 0


def score(dice, category):
    return category(dice)
