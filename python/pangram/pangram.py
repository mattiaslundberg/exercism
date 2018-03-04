import string


def is_pangram(sentence):
    sentence = set(sentence.lower())
    return sentence.issuperset(string.ascii_lowercase)
