import re


def hey(phrase):
    phrase = phrase.strip()

    if phrase[-1:] == "?":
        if phrase == phrase.upper() and re.match(r"[a-zA-Z]+", phrase):
            return "Calm down, I know what I'm doing!"
        else:
            return "Sure."
    elif re.sub(r"\W+", "", phrase) == "":
        return "Fine. Be that way!"
    elif phrase == phrase.upper() and re.match(r".*[a-zA-Z]+.*", phrase):
        return "Whoa, chill out!"
    else:
        return "Whatever."
