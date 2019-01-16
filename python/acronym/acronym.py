def abbreviate(words):
    acronym = ''
    space = True
    for ltr in words:
        if space and ltr.isalpha():
            acronym += ltr
            space = False
        elif ltr.isspace() or ltr == '-':
            space = True
    return acronym.upper()
