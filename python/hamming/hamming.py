def distance(strand_a, strand_b):
    if len(strand_a) != len(strand_b):
        raise ValueError("Same length expected")

    res = 0
    for a, b in zip(strand_a, strand_b):
        if a != b:
            res += 1
    return res
