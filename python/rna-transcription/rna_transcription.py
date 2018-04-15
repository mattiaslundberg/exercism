TRANSLATIONS = {
    "C": "G",
    "G": "C",
    "T": "A",
    "A": "U",
}


def to_rna(dna_strand):
    return "".join(list(map(chr_to_rna, dna_strand)))


def chr_to_rna(chr):

    return TRANSLATIONS[chr]
