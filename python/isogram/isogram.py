import re


def is_isogram(string):
    string = re.sub("[-| ]", "", string).lower()
    return len(list(string)) == len(set(string))
