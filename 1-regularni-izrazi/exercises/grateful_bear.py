###############################################################################
# Grateful Bear
#
# In this exercise we will write a few functions that help us analyse literary
# texts, such as the Carinthian folk tale *Grateful Bear*.
#
###############################################################################

test_text = """Gori nekje v gorah, ne ve se vec, ali je bilo pri Macigoju ali
Naravniku, je sivala gospodinja v senci pod drevesom in zibala otroka. Naenkrat
prilomasti - pa prej ni nicesar opazila - medved in ji moli taco, v kateri je
tical velik, debel trn. zena se je prestrasila, a medved le milo in pohlevno
godrnja. Zato se zena ojunaci in mu izdere trn iz tace. Mrcina kosmata pa zvrne
zibel, jo pobase in oddide. cez nekaj casa pa ji zopet prinese zibel, a zvhano
napolnjeno s sladkimi hruskami . Postavil jo je na tla pred zacudeno mater in
odracal nazaj v goscavo. "Poglej no", se je razveselila mati, "kaksen hvalezen
medved. Zvrhano zibelko sladkih hrusk mi je prinesel za en sam izdrt trn"."""

###############################################################################
# 1) Write a function [find_words] that returns a set of all the  words in a
#    string containing the given substring.
#
# Hint: Use the regex character for the boundary [\b].
#
# >>> find_words(test_text, 'de')
# {'izdere', 'debel', 'oddide', 'zacudeno'}
###############################################################################

import re
text = []

def find_words(niz, podniz): 
    r1 = re.findall(r"\b\w*" + podniz + r"\w*\b", niz)
    return r1


###############################################################################
# 2) Write a function [find_prefix] which returns the set of all words in a
#    string starting with the given prefix.
#
# >>> find_prefix(test_text, 'zi')
# {'zibala', 'zibel', 'zibelko'}
###############################################################################

def find_prefix(niz,podniz):
    besede = re.findall(r"\b" + podniz + r"\w*", niz )
    return besede

###############################################################################
# 3) Write a function [find_suffix] which returns the set of all words in a
#    string ending with the given suffix.
#
# >>> find_suffix(test_text, 'la')
# {'zibala', 'razveselila', 'prestrasila', 'sivala', 'opazila', 'tla'}
###############################################################################
def find_suffix(niz,podniz):
    m = set()
    vzorec = r"\w+" +  podniz
    match = re.findall(vzorec, niz)
    beseda = re.findall(r"\b"+r"\w+"+podniz+ r"\b", niz )
    for x in match: 
        m.add(x)
    return m

###############################################################################
# 4) Write a function [double_letters] that returns the set of words in a
#    string that contain the same letter twice consecutively.
#
# >>> double_letters('A volunteer is worth twenty pressed men.')
# {'volunteer', 'pressed'}
###############################################################################
def double_letters():
    m 
    beseda =  re.findall(r"\b\w*"+ r"([\w])\2"+ r"\w*\b","A volunteer is worth twenty pressed men.")
    return beseda


