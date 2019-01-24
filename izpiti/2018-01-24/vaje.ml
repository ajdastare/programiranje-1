(* 1.naloga *)
(* 1.naloga *)

let rec izpisi_vsa_st sez =  
  match sez with
    |[] -> ()
    |x :: xs -> print_int x ; izpisi_vsa_st xs
(* 2 naloga *)
type 'a option = None | Some of 'a

(* 
let map2_opt  = function 
|_, [] -> None
|[], _ -> None
|x::xs, y::ys -> let rec' map acc: 
          (map2_opt x y) :: acc   *)

let rec map2_opt f l1 l2 = 
  let rec map' f l1 l2 acc =
    match l1, l2 with 
    |[],[] -> Some (List.rev acc)
    |_,[] -> None
    |[],_ -> None
    |x :: xs, y :: ys -> map' f xs ys ((f x y)::acc)
  in map' f l1 l2 []

(* 2 naloga  *)
  
(* type filter_tree =
  | Node of int * filter_tree * filter_tree
  | Leaf of int list


let test_filter_tree = 
  let left_leaf = [1] in
  let righ_leaf = [] in 
  let levi = Node(left_leaf,5,right_leaf) in
  let desni_left_leaf = [] in
  let desni_right_leaf = [19; 20] in 
  let desni = Node(desni_left_leaf, 15, desni_right_leaf) in
  Node(levi,10,desni)   *)

type filter_tree = Node of int * filter_tree * filter_tree
                 | Box of int list

let example_tree = Node(10,
                Node(5, (Box [1]), (Box [])),
                Node(15, (Box []), (Box [19;20])))


(* ==========================================================================
   NALOGA 2.2

   Filtracijsko drevo razvršča števila v škatle glede na njihovo vrednost.
   Vozlišče z vrednostjo "k" razvrsti število "n" v levo poddrevo če velja
   n <= k oz. v desno poddrevo če velja n > k.
   Ko število doseže škatlo, ga dodamo v seznam števil v škatli.
   Škatle lahko vsebujejo ponovitve in niso nujno urejene.

   Napišite funkcijo, ki sprejme število in filtracijsko drevo in vrne
   filtracijsko drevo z vstavljenim številom.

   Primer:
               10                                        10
             /    \            insert 12 t             /    \
    t =     5      15          ------------>          5      15
          /  \    /  \                              /  \    /  \
         [1] []  []  [19;20]                       [1] [] [12] [19;20]
   ========================================================================== *)
   let rec razvrsti st drevo = 
      match  drevo with
      |Node(x,rt,lt) -> if x < st
        then
           Node (x, razvrsti st rt, lt) 
        else 
        Node(x,rt,razvrsti st lt)
      |Box(x)-> Box(st :: x)
          
          
  (* let rec insert x ftree =
      match ftree with
        | Node(f, lt, rt) ->
            if f > x
              then Node(f, insert x lt, rt)
            else Node(f, lt, insert x rt)
        | Box(xs) -> Box(x::xs)
           *)
(* ==========================================================================
   NALOGA 2.3

   Napišite funkcijo, ki sprejem seznam celih števil in filtracijsko drevo
   in vrne filtracijsko drevo z vstavljenimi elementi seznama.
   Vrstni red vstavljanja ni pomemben.
   ========================================================================== *)
(* let rec vstavi seznam drevo =
  let rec vstavi' sez drevo =
    match sez, drevo with
    |[],_ -> 
    |x :: [], Box(y) -> then vstavi' xs Box(x :: y)
    |x :: xs, Node(y,rt,lt) if  x < y then Node(y, vstavi' (x::xs) rt, lt)
  in vstavi' seznam drevo  *)
(* ==========================================================================
   NALOGA 2.4

   Definirajte funkcijo, ki sprejme filtracijsko drevo in preveri ali
   so vsa števila v pravilnih škatlah glede na način razvrščanja.

   Primer:
       5                                      5
     /   \    ----> true                    /   \    ----> false
   [1;2] [7]                              [1]   [2;7]
   ========================================================================== *)
let rec boxed_correctly ftree = 
  match ftree with
  |Node(x,rt,lt)-> let koren = x in
    let rec boxed' levi desni koren =
      match levi, desni with
      |Box(sez1), Box(sez2) -> let levi_sez = sez1 in 
      let desni_sez = sez2 in 
      let rec primerjaj levi_sez desni_sez = 
        match levi_sez, desni_sez with
        |x :: xs, y :: ys -> if  x < koren && y > koren 
        then
        primerjaj xs ys
        else  
        false
        |[],y :: ys ->
        if  y > koren then 
        primerjaj [] ys
        else 
          false
        |x :: xs, [] -> if  x < koren  then  primerjaj xs []
        else 
          false
        |[],[] -> 
        true
      in primerjaj levi_sez desni_sez
    in boxed' lt rt koren


  
  
  
  
  
  
  
  
   (* let rec boxed_correctly ftree =
    let checker lower upper x =
      match (lower, upper) with
      | (None, None) -> true
      | (Some l, None) -> l <= x
      | (None, Some u) -> x < u
      | (Some l, Some u) -> l <= x && x < u
    in
    let rec values_between lower upper ftree =
      match ftree with
      | Box(xs) -> List.for_all (checker lower upper) xs
      | Node(f, lt, rt) ->
        (values_between lower (Some f) lt) && (values_between (Some f) upper rt)
    in
    values_between None None ftree                                                           *)


    (* 4.naloga *)

type vektor = int * int
type matrika = int * int * int * int