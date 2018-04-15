def verify(isbn):
    nums = isbn.replace("-", "")
    if len(nums) != 10:
        return False

    sum = 0
    for i, num in enumerate(nums):
        try:
            number = int(num)
        except ValueError:
            if num == "X" and i == 9:
                number = 10
            else:
                return False
        sum = sum + (i + 1) * number
    return sum % 11 == 0
