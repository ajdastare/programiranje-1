
(* ========== Vaja 1: Uvod v OCaml  ========== *)

(*----------------------------------------------------------------------------*]
 Funkcija [penultimate_element] vrne predzadnji element danega seznama. V
 primeru prekratkega seznama vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # penultimate_element [1; 2; 3; 4];;
 - : int = 3
[*----------------------------------------------------------------------------*)
(* let rec ultimate_element list = *)


let rec penultimate_element list = 
  match list with
  | [] -> failwith "List too short"
  | x :: [] -> failwith "List too short"
  | x :: y :: [] -> x
  | x :: y :: ys -> penultimate_element (y :: ys)

  (* let rec penultimate_element = function
  [] ->  *)


(*----------------------------------------------------------------------------*]
 Funkcija [get k list] poišče [k]-ti element v seznamu [list]. Številčenje
 elementov seznama (kot ponavadi) pričnemo z 0. Če je k negativen, funkcija
 vrne ničti element. V primeru prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # get 2 [0; 0; 1; 0; 0; 0];;
 - : int = 1
[*----------------------------------------------------------------------------*)

let rec get k list =
  match k, list with
  | _, [] -> failwith "List too short"
  | k, x :: xs when k <= 0 -> x
  | k, x :: xs -> get (k-1) xs

(*----------------------------------------------------------------------------*]
 Funkcija [double] podvoji pojavitve elementov v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # double [1; 2; 3];;
 - : int list = [1; 1; 2; 2; 3; 3]
[*----------------------------------------------------------------------------*)

let rec double list = 
  match list with 
  | [] -> failwith "List too short"
  | x :: []  -> x :: x :: []
  | x :: xs -> x :: x :: double xs

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

  (* v primeru ko k ni manjši od nič vemo da imamo prvi element x :: xs (ostali elementi ), let nam shrani levi del  v left_list, desni v right_list *)
  

(*----------------------------------------------------------------------------*]
 Funkcija [delete k list] iz seznama izbriše [k]-ti element. V primeru
 prekratkega seznama funkcija vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # delete 3 [0; 0; 0; 1; 0; 0];;
 - : int list = [0; 0; 0; 0; 0]
[*----------------------------------------------------------------------------*)

let rec delete k list =
  match k, list with 
  | k, list when (k < 0) -> failwith "k too small"
  | 0, x :: xs -> xs
  | k, [] -> failwith "List too small"
  | k, x :: xs -> x :: delete (k - 1) xs

(*----------------------------------------------------------------------------*]
 Funkcija [slice i k list] sestavi nov seznam, ki vsebuje elemente seznama
 [list] od vključno [i]-tega do izključno [k]-tega. Predpostavimo, da sta [i] in
 [k] primerna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # slice 3 6 [0; 0; 0; 1; 2; 3; 0; 0];;
 - : int list = [1; 2; 3]
[*----------------------------------------------------------------------------*)

let rec slice i k list =
  match i, k, list with
  | _,_, [] -> []
  | 0, 1 , x :: xs -> [x] 
  | 0, k, x :: xs -> x :: slice 0 (k - 1) xs
  | i, k, x :: xs -> slice (i - 1) k xs

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
  | x, _ , [] -> [x]
  | x, 0, list -> x :: list
  | x, k, list when (k < 0)  -> x :: list
  | x, _ , l :: ls  -> l :: insert x (k-1) ls


(*----------------------------------------------------------------------------*]
 Funkcija [rotate n list] seznam zavrti za [n] mest v levo. Predpostavimo, da
 je [n] v mejah seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # rotate 2 [1; 2; 3; 4; 5];;
 - : int list = [3; 4; 5; 1; 2]
[*----------------------------------------------------------------------------*)

let rec rotate n list =
  match n, list with
  | _, [] -> []
  | 0, list -> list
  | _ , x :: y -> rotate (n - 1) (y @ [x])

 
(*----------------------------------------------------------------------------*]
 Funkcija [remove x list] iz seznama izbriše vse pojavitve elementa [x].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # remove 1 [1; 1; 2; 3; 1; 2; 3; 1; 1];;
 - : int list = [2; 3; 2; 3]
[*----------------------------------------------------------------------------*)

let rec remove x list = 
  match x, list with
  | _, [] -> []
  | x, t :: ys when (x = t) -> remove x ys
  | x, t :: ts -> t :: remove x ts

(*----------------------------------------------------------------------------*]
 Funkcija [is_palindrome] za dani seznam ugotovi ali predstavlja palindrom.
 Namig: Pomagaj si s pomožno funkcijo, ki obrne vrstni red elementov seznama.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # is_palindrome [1; 2; 3; 2; 1];;
 - : bool = true
 # is_palindrome [0; 0; 1; 0];;
 - : bool = false
[*----------------------------------------------------------------------------*)
(* 
let rec is_palindrome list = 
  dolzina = len(list)
  if rotate dolzina lis = list -> return(True)
  else -> return(False) *)

  let is_palindrome list =
   let rec aux l0 l1 =
       match (l0, l1) with
       | _,[] -> (true,[])
       | hd :: tl, [x] -> (hd = x, tl)
       | _, hd1 :: tl1 -> let (pal, ll) = aux l0 tl1 in
             match ll with
             | [] -> (pal, [])
             | hd::tl -> (pal && hd1 = hd, tl) in
   match list with
   [] -> true
   | _ -> fst (aux list list)

(*----------------------------------------------------------------------------*]
 Funkcija [max_on_components] sprejme dva seznama in vrne nov seznam, katerega
 elementi so večji od istoležnih elementov na danih seznamih. Skupni seznam ima
 dolžino krajšega od danih seznamov.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # max_on_components [5; 4; 3; 2; 1] [0; 1; 2; 3; 4; 5; 6];;
 - : int list = [5; 4; 3; 3; 4]
[*----------------------------------------------------------------------------*)

let rec max_on_components l0 l1 =
  match l0 , l1 with
  | x :: xs, y :: ys ->
  if (x >= y ) then
  x :: max_on_components xs ys
  else 
  y :: max_on_components xs ys
  | [], _ -> []
  | _, [] -> []


(*----------------------------------------------------------------------------*]
 Funkcija [second_largest] vrne drugo največjo vrednost v seznamu. Pri tem se
 ponovitve elementa štejejo kot ena vrednost. Predpostavimo, da ima seznam vsaj
 dve različni vrednosti.
 Namig: Pomagaj si s pomožno funkcijo, ki poišče največjo vrednost v seznamu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # second_largest [1; 10; 11; 11; 5; 4; 10];;
 - : int = 10
[*----------------------------------------------------------------------------*)
let max l = 
  match l with
  [] -> failwith "None"
  |h::t ->  let rec helper (seen,rest) =
              match rest with 
              [] -> seen
              |h'::t' -> let seen' = if h' > seen then h' 
                        else seen in 

                         let rest' = t'
              in helper (seen',rest')
            in helper (h,t) 

let rec second_largest seznam = max (remove (max seznam) seznam)





