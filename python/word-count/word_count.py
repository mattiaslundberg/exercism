import re
from collections import Counter


def word_count(phrase):
    phrase = phrase.lower()
    phrase = re.sub(r"([^a-zA-Z0-9])'", r"\1", phrase)
    phrase = re.sub(r"'([^a-zA-Z0-9])", r"\1", phrase)
    phrase = re.split(r"[^a-zA-Z0-9']+", phrase)
    phrase = filter(lambda s: s != "", phrase)

    return dict(Counter(phrase))
