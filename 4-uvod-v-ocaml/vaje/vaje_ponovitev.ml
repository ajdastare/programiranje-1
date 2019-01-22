(*----------------------------------------------------------------------------*]
 Funkcija [penultimate_element] vrne predzadnji element danega seznama. V
 primeru prekratkega seznama vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # penultimate_element [1; 2; 3; 4];;
 - : int = 3
[*----------------------------------------------------------------------------*)
(* let rec ultimate_element list = *)


let rec penultimate_element seznam =
  match seznam with 
  |[] -> failwith "list too short"
  |x :: [] -> failwith "list too short"
  |x :: y :: xs -> penultimate_element (y :: xs)
  | x :: y :: [] -> y
(*----------------------------------------------------------------------------*]
 Funkcija [get k list] poišče [k]-ti element v seznamu [list]. Številčenje
 elementov seznama (kot ponavadi) pričnemo z 0. Če je k negativen, funkcija
 vrne ničti element. V primeru prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # get 2 [0; 0; 1; 0; 0; 0];;
 - : int = 1
[*----------------------------------------------------------------------------*)

let rec get k l = 
  match k,l with
  |_,[] -> failwith "prekratek seznam"
  |0,[x] -> x
  |i, x :: xs  when (i < 0)  -> x
  |i, x :: xs when (i > 0) -> get (k-1) xs

(*----------------------------------------------------------------------------*]
 Funkcija [divide k list] seznam razdeli na dva seznama. Prvi vsebuje prvih [k]
 elementov, drugi pa vse ostale. Funkcija vrne par teh seznamov. V primeru, ko
 je [k] izven mej seznama, je primeren od seznamov prazen.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # divide 2 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2], [3; 4; 5])
 # divide 7 [1; 2; 3; 4; 5];;
 - : int list * int list = ([1; 2; 3; 4; 5], [])
[*----------------------------------------------------------------------------*)

let rec divide k list =
  match k, list with 
  | k, list when (k <= 0) -> ([],list)
  | k, [] -> ([],[])
  | k, x :: xs ->
  let (left_list, right_list)= divide (k-1) xs in 
  (x :: left_list, right_list)

(*----------------------------------------------------------------------------*]
 Funkcija [delete k list] iz seznama izbriše [k]-ti element. V primeru
 prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # delete 3 [0; 0; 0; 1; 0; 0];;
 - : int list = [0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)
let rec delete k list =
  match k, list with
  |k, l when k > List.length l -> failwith "list too short"
  |0, x :: xs -> xs
  |k, [] -> failwith "list too short"
  |k, x :: xs -> x ::delete (k-1) xs

  (*----------------------------------------------------------------------------*]
 Funkcija [slice i k list] sestavi nov seznam, ki vsebuje elemente seznama
 [list] od vključno [i]-tega do izključno [k]-tega. Predpostavimo, da sta [i] in
 [k] primerna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # slice 3 6 [0; 0; 0; 1; 2; 3; 0; 0];;
 - : int list = [1; 2; 3]
[*----------------------------------------------------------------------------*)
let rec slice i k list = 
  match i,k, list with 
  |_, _, [] -> failwith "list too short"
  |0,1, x :: xs -> [x]
  |0, k , x :: xs -> x :: slice 0 (k-1) xs
  |i, k , x :: xs -> slice (i-1) (k-1) xs
 

(*----------------------------------------------------------------------------*]
 Funkcija [insert x k list] na [k]-to mesto seznama [list] vrine element [x].
 Če je [k] izven mej seznama, ga funkcija doda na začetek oziroma na konec.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # insert 1 3 [0; 0; 0; 0; 0];;
 - : int list = [0; 0; 0; 1; 0; 0]
 # insert 1 (-2) [0; 0; 0; 0; 0];;
 - : int list = [1; 0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)
let rec insert x k list = 
  match x, k, list with 
  |x, k, l when (k > List.length l) -> l @ [x]
  |x , k , l when (k < 0 ) -> x :: l
  |x, 0, l -> x :: l 
  |x, k , y :: ys -> y :: insert x (k-1) ys

  
