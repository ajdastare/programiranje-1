(* 1. naloga *)
(* a) *)
let  razlika_kvadratov x y = 
  (x + y)*(x+y) - (x*x + y*y) 

(* b) *)
let uporabi_na_paru (a,b) f = 
  (f a  , f b)


  (* d) *)
  (* let rec razdeli sez = 
    let rec raz n acc p acc = function
    | [] -> (List.rev n acc , List.rev p acc )
    | *)

(* 2. naloga *)

type 'a tree =
  | Empty
  | Node of 'a tree * 'a * 'a tree

let rec padajoca v = function
  |Empty -> []
  | Node (lt, x , rt ) when v > x  -> []
  | Node(lt, x,rt) -> 
    let left = padajoca x lt in 
    let right = padajoca x rt in
    if List.length left > List.length right then 
          x :: left
        else 
          x :: right

let rec narascujoca v = function 
  |Empty -> []
  |Node (lt,x,rt) when x < v -> []
  |Node(lt,x, rt) -> 
    let left  = narascujoca x lt in 
    let right = narascujoca x rt in 
    if List.length left > List.length right then
        x :: left
        else
        x :: right
let rec monotona_pot = function 
  |Empty -> []
  let pure_left = monotona_pot lt in 
  let pure_right = monotona_pot rt in 
  let left_to_right = (padajoca x lt) @ [x] @ (narascujoca x rt) in
  let right_to_left = (padajoca x rt) @ [x] @ (narascujoca x lt) in 
  let options = [pure_left; pure_right; left_to_right; right_to_right]
 let leaf x = Node(Empty, x, Empty) 

let test_tree = 
  let left_t = Node(leaf 0,2, Empty) in 
      let right_t = Node(leaf 6,7, leaf 11) in 
        Node(left_t,5,right_t)

(* deli in vladaj-> razdeliš na pod drevesa - na vakem od podreves uporabiš in potem združiš skupaj.



*) 
(* 3. naloga *)
type 'a veriga =
  |Filter of('a -> bool ) * 'a list * 'a veriga
  | Ostalo of 'a list 


let test = 
Filter ((fun x -> x>0), [],
Filter ((fun x -> x < 10),[]
Ostalo []))

(* b *)
(* let vstavi x veriga =
  match veriga with
  |Ostalo (element)
  | *)


  
let rec poisci x = function 
  |Ostalo elementi -> List.mem x elementi
  |Filter (f, elementi, filtri) -> 
       if f x then List.mem x elementi else poisci x filtri
      

let rec izprazni = function 
  |Ostalo elementi -> (Ostalo [], elementi),
  |Filter (f , elementi, filtri) ->
     let prazni_filtri, pobrani_elementi = izprazni filtri in
     let vsi_elementi = elementi @ pobrani_elementi in
     (FIlter (f,[], prazni_filtri), vsi_elementi)

  let dodaj f veriga = 
       let veriga' = Filter(f, [], veriga)in
       let prazna_veriga, elementi = izprazni veriga' in 
       List.fold left (fun v x -> vstavi x v) prazna_veriga elementi

       (* ustvarimo filter, odstranimo vse elemente filtra potem pa enega po enga dodajamo  not *)