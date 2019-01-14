##############################################################################
# zelimo definirati pivotiranje na mestu za tabelo [a]. Ker bi zeleli
# pivotirati zgolj dele tabele, se omejimo na del tabele, ki se nahaja med
# indeksoma [start] in [end].
#
# Primer: za [start = 0] in [end = 8] tabelo
#
# [10, 4, 5, 15, 11, 2, 17, 0, 18]
#
# preuredimo v
#
# [0, 2, 5, 4, 10, 11, 17, 15, 18]
#
# (Moznih je vec razlicnih resitev, pomembno je, da je element 10 pivot.)
#
# Sestavi funkcijo [pivot(a, start, end)], ki preuredi tabelo [a] tako, da bo
# element [ a[start] ] postal pivot za del tabele med indeksoma [start] in
# [end]. Funkcija naj vrne indeks, na katerem je po preurejanju pristal pivot.
# Funkcija naj deluje v casu O(n), kjer je n dolzina tabele [a].
#
# Primer:
#
#     >>> a = [10, 4, 5, 15, 11, 2, 17, 0, 18]
#     >>> pivot(a, 1, 7)
#     3
#     >>> a
#     [10, 2, 0, 4, 11, 15, 17, 5, 18]
##############################################################################

def pivot(a,start,end): 
    pivot = a[start]
    index_pivota = start
    i = start
    if start >=end : 
        pass
    for i in range(start, end + 1):
        for j in range (i+1, end + 1):
            if a[i] >= pivot:
                if a[j] <= pivot :
                    a[i], a[j] = a[j], a[i]
                    
    
    
    return a.index(pivot)



##############################################################################
# Tabelo a zelimo urediti z algoritmom hitrega urejanja (quicksort).
#
# Napisite funkcijo [quicksort(a)], ki uredi tabelo [a] s pomocjo pivotiranja.
# Poskrbi, da algoritem deluje 'na mestu', torej ne uporablja novih tabel.
#
# Namig: Definirajte pomozno funkcijo [quicksort_part(a, start, end)], ki
#        uredi zgolj del tabele [a].
#
#   >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#   >>> quicksort(a)
#   [2, 3, 4, 5, 10, 11, 15, 17, 18]
##############################################################################
def quicksort_part(a,start,end):
    if start >= end : 
        pass
    else :
        index = pivot(a,start,end)
        quicksort_part(a,start,index)
        quicksort_part(a, index + 1, end)

def quicksort(a):
    quicksort_part(a,0 , len(a)-1)
    return a

 
##############################################################################
# V tabeli zelimo poiskati vrednost k-tega elementa po velikosti.
#
# Primer: ce je
#
# >>> a = [10, 4, 5, 15, 11, 3, 17, 2, 18]
#
# potem je tretji element po velikosti enak 5, ker so od njega mansi elementi
#  2, 3 in 4. Pri tem stejemo indekse od 0 naprej, torej je "nicti" element 2.
#
# Sestavite funkcijo [kth_element(a, k)], ki v tabeli [a] poisce [k]-ti
# element po velikosti. Funkcija sme spremeniti tabelo [a]. Cilj naloge je, da
# jo resite brez da v celoti uredite tabelo [a].
##############################################################################
# # def kth_element(a, k): 
# #     for i in range (0, len(a)+ 1): 

    
                
                # pivot(a,start,end) postavi pivot
                # quick sort levi in desni del
