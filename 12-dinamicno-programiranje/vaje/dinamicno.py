test_matrix = [ [ 1 , 2 , 0 ],
      [ 2 , 4 , 5 ],
      [7 ,0 ,1 ] ]

# def max_cheese(M) : 
#     n = stevilo_vrstic = len(M)
#     m = stevilo_stolpcev = len(M[0])
#     M_d = M[0].[1:m]
#     M_s =
#     desno = max_cheese(M_d)
#     spodnja = max_cheese(M_s)

#     if desno >= spodnja : 
#         M[0][0] + desno
#     else :
#         M[0][0] + spodnja
        


#     for n in range(
#     a[][]

#a) podnaloga bi bila da uporabiš memoizacijo


def best_value_uniquest(articles, max_w):
    def best_val(max_w):
        options = []

        for item in atricles: 
            (name, price, weight) = item 
            if w + weight < 0 : 
                pass
            else : 
                option = best_val(w + wight) + price
                options.append(option)
        if options:
            return max(options)
        else : 
            return 0
    return best_val(max_w)

        