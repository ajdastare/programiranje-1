(* ========== Vaja 4: Iskalna Drevesa  ========== *)

(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 Ocaml omogoča enostavno delo z drevesi. Konstruiramo nov tip dreves, ki so
 bodisi prazna, bodisi pa vsebujejo podatek in imajo dve (morda prazni)
 poddrevesi. Na tej točki ne predpostavljamo ničesar drugega o obliki dreves.
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

type 'a tree =
     | Empty
     | Node of 'a tree * 'a * 'a tree

(*----------------------------------------------------------------------------*]
 Definirajmo si testni primer za preizkušanje funkcij v nadaljevanju. Testni
 primer predstavlja spodaj narisano drevo, pomagamo pa si s pomožno funkcijo
 [leaf], ki iz podatka zgradi list.
          5
         / \
        2   7
       /   / \
      0   6   11
[*----------------------------------------------------------------------------*)
let leaf x = Node(Empty, x, Empty) 

let test_tree = 
  let left_t = Node(leaf 0,2, Empty) in 
  let right_t = Node(leaf 6,7, leaf 11) in 
  Node(left_t,5,right_t)
  
(*----------------------------------------------------------------------------*]
 Funkcija [mirror] vrne prezrcaljeno drevo. Na primeru [test_tree] torej vrne
          5
         / \
        7   2
       / \   \
      11  6   0
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # mirror test_tree ;;
 - : int tree =
 Node (Node (Node (Empty, 11, Empty), 7, Node (Empty, 6, Empty)), 5,
 Node (Empty, 2, Node (Empty, 0, Empty)))
[*----------------------------------------------------------------------------*)

let rec mirror tree = 
     match tree with 
     |Empty -> Empty
     |Node(lt,x,rt) -> Node(mirror rt, x, mirror lt)
(*----------------------------------------------------------------------------*]
 Funkcija [height] vrne višino oz. globino drevesa, funkcija [size] pa število
 vseh vozlišč drevesa.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # height test_tree;;
 - : int = 3
 # size test_tree;;
 - : int = 6
[*----------------------------------------------------------------------------*)
let rec height = function
|Empty -> 0
|Node(lt,x,rt) -> 1 + max (height lt) (height rt)

let rec size tree = 
     let rec size' acc queue = 
     (* poglejmo kateri je naslednji element v vrsti za obravnavo *)
     match queue with 
     |[]-> acc
     |t :: ts -> (
          (* Obravnavamo drevo *)
          match t with 
          |Empty -> size' acc ts 
          (* Prazno drevo samo odstranimo iz vrste *)
          |Node(lt,x,rt) ->
          let new_acc = acc + 1 in 
          (* obravnavamo vozlišče *)
          let new_queue = lt :: rt  :: ts in 
          (* dodamo poddrevesa v vrsto *)
          size' new_acc new_queue
     )
          
     in 
     size' 0 [tree]
(* Podamo seznam dreves sicer si pa drevo zapomne kot število, kazalec *)
          
     



(*----------------------------------------------------------------------------*]
 Funkcija [map_tree f tree] preslika drevo v novo drevo, ki vsebuje podatke
 drevesa [tree] preslikane s funkcijo [f].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # map_tree ((<)3) test_tree;;
 - : bool tree =
 Node (Node (Node (Empty, false, Empty), false, Empty), true,
 Node (Node (Empty, true, Empty), true, Node (Empty, true, Empty)))
[*----------------------------------------------------------------------------*)
(* let rec map_tree f tree =
     match [tree] with 
     | [] -> []
     | t :: ts -> f t :: map_tree f ts *)



     (* let rec map' f drevo acc =
          match drevo with
          |[] -> acc
          | t :: ts -> match t with
          | Empty -> acc
          | Node(lt,x,rt) -> map' f ts [Node(f lt, f x, f rt)] @ acc

     in map' f [tree] [] *)

let rec map_tree f tree = 
     match tree with 
     |Empty -> Empty
     |Node(lt,x,rt) -> Node(map_tree f lt , f x, map_tree f rt)
     


(*----------------------------------------------------------------------------*]
 Funkcija [list_of_tree] pretvori drevo v seznam. Vrstni red podatkov v seznamu
 naj bo takšen, da v primeru binarnega iskalnega drevesa vrne urejen seznam.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # list_of_tree test_tree;;
 - : int list = [0; 2; 5; 6; 7; 11]
[*----------------------------------------------------------------------------*)
let rec list_of_tree tree = 
     let rec list' acc tree =
          match tree with 
          |Empty -> acc
          | Node(lf,x,rt) -> list' (x :: acc) lf @ list' [] rt

     in list' [] tree

(* let rec list_of_tree tree=
    let rec list' acc tree =
        match tree with
        | Empty -> acc
        | Node(levi, x, desni) -> list' (x :: acc) levi @ list' [] desni
    in list' [] tree *)
(*----------------------------------------------------------------------------*]
 Funkcija [is_bst] preveri ali je drevo binarno iskalno drevo (Binary Search 
 Tree, na kratko BST). Predpostavite, da v drevesu ni ponovitev elementov, 
 torej drevo npr. ni oblike Node( leaf 1, 1, leaf 2)). Prazno drevo je BST.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # is_bst test_tree;;
 - : bool = true
 # test_tree |> mirror |> is_bst;;
 - : bool = false
[*----------------------------------------------------------------------------*)
let rec urejen seznam = 
     match seznam with 
     | [] ->true
     | x :: [] -> true
     | x :: xs :: xy -> 
     if x <= xs then 
     urejen (xs :: xy)
      else
          false
     | x :: xs :: [] -> if x <= xs then 
          true
     else 
          false

let rec is_bst tree = urejen (list_of_tree tree) 



(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 V nadaljevanju predpostavljamo, da imajo dvojiška drevesa strukturo BST.
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

(*----------------------------------------------------------------------------*]
 Funkcija [insert] v iskalno drevo pravilno vstavi dani element. Funkcija 
 [member] preveri ali je dani element v iskalnem drevesu.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # insert 2 (leaf 4);;
 - : int tree = Node (Node (Empty, 2, Empty), 4, Empty)
 # member 3 test_tree;;
 - : bool = false
[*----------------------------------------------------------------------------*)
(* let rec insert element drevo = 
     match drevo with 
     |Empty -> Node(Empty,element,Empty)
     |Node(levi,x,desni) -> if element > x 
          let novi_desni = insert element desni in
          Node(levi, x, novi_desni)
     else
     let novi_levi = insert element levi in 
     Node(novi_levi, x, desni)
     
     *)
     let rec insert element tree=
          match tree with
          | Empty -> Node(Empty, element, Empty)
          | Node(levi, x, desni) ->
              if element < x then
                  let novi_levi = insert element levi in
                  Node(novi_levi, x, desni)
              else
                  let novi_desni = insert element desni in
                  Node(levi, x, novi_desni)


     let rec member element drevo = 
          match drevo with 
          |Empty -> false
          |Node(levi, x, desni) -> 
          if x = element then
               true
          else 
          if element < x then
               member element levi
          else 
                member element desni


(*----------------------------------------------------------------------------*]
 Funkcija [member2] ne privzame, da je drevo bst.
 
 Opomba: Premislte kolikšna je časovna zahtevnost funkcije [member] in kolikšna
 funkcije [member2] na drevesu z n vozlišči, ki ima globino log(n). 
[*----------------------------------------------------------------------------*)


(*----------------------------------------------------------------------------*]
 Funkcija [succ] vrne naslednjika korena danega drevesa, če obstaja. Za drevo
 oblike [bst = Node(l, x, r)] vrne najmanjši element drevesa [bst], ki je večji
 od korena [x].
 Funkcija [pred] simetrično vrne največji element drevesa, ki je manjši od
 korena, če obstaja.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # succ test_tree;;
 - : int option = Some 6
 # pred (Node(Empty, 5, leaf 7));;
 - : int option = None
[*----------------------------------------------------------------------------*)
(* let succ bst = 
     let rec min = function
     |Empty -> None
     |Node(x,Empty,_)-> Some x
     |Node(_,l,_)-> min l 
     in 
     match bst with
     |Empty  -> None
     |Node (_,_,r) -> min r *)
(* najprej sestavi funkcijo za iskanje minimuma v drevesu lahko si poamgaš s tem da je drevo BST al pa da ga daš v seznnam *)

let rec minimum drevo = 
     match drevo with
     | Empty -> failwith "Prazno"
     | Node(levo,x, desno) -> minimum levo
     | Node(Empty,x,desno) -> Some x

let rec minimum2 tree=
     let rec minimum' tree=
           match tree with
          | [] -> failwith "Prazno drevo"
          | x :: [] -> x
          | x :: xs -> min x (minimum' xs)
     in minimum' (list_of_tree tree)

let rec succ tree =
     match tree with 
     | Empty -> failwith "prazno"
     | Node(levi, x, desni) -> minimum2 desni
     | Node (Empty, x, desni ) -> failwith "Ni večjega elementa"
(*----------------------------------------------------------------------------*]
 Na predavanjih ste omenili dva načina brisanja elementov iz drevesa. Prvi 
 uporablja [succ], drugi pa [pred]. Funkcija [delete x bst] iz drevesa [bst] 
 izbriše element [x], če ta v drevesu obstaja. Za vajo lahko implementirate
 oba načina brisanja elementov.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # (*<< Za [delete] definiran s funkcijo [succ]. >>*)
 # delete 7 test_tree;;
 - : int tree =
 Node (Node (Node (Empty, 0, Empty), 2, Empty), 5,
 Node (Node (Empty, 6, Empty), 11, Empty))
[*----------------------------------------------------------------------------*)
(* let rec delete x = function
|Empty -> Empty
|(Node (y,l,r ) as t ) -> 
     if x < y then 
     Node (y, delete x l , r)
     else if x > y then
     Node(y, l , delete x r)
     else
     match succ t with
     |None -> l
     |Some -> 
     else (x  = y ) *)
let rec delete x tree =
      match tree with
     | Empty -> Empty (*Empty case*)
     | Node(Empty, y, Empty) when x = y -> Empty (*Leaf case*)
     | Node(Empty, y, rt) when x = y -> rt (*One sided*)
     | Node(lt, y, Empty) when x = y -> lt (*One sided*)
     | Node(lt, y, rt) when x <> y -> (*Recurse deeper*)
          if  y < x then
               Node(lt, y, delete x rt)
          else 
               Node(delete x lt, y, rt)
     (* | Node(lt, y, rt) -> (*SUPER FUN CASE*)
               match succ tree with
               | None -> failwith "How is this possible?!" (*this cannot happen :D*) (*Case ki bi ga dobil smo že pokril*)
               | Some z -> Node(lt, z, delete z rt)
        *)


(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 SLOVARJI

 S pomočjo BST lahko (zadovoljivo) učinkovito definiramo slovarje. V praksi se
 slovarje definira s pomočjo hash tabel, ki so še učinkovitejše. V nadaljevanju
 pa predpostavimo, da so naši slovarji [dict] binarna iskalna drevesa, ki v
 vsakem vozlišču hranijo tako ključ kot tudi pripadajočo vrednost, in imajo BST
 strukturo glede na ključe. Ker slovar potrebuje parameter za tip ključa in tip
 vrednosti, ga parametriziramo kot [('key, 'value) dict].
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)


(*----------------------------------------------------------------------------*]
 Napišite testni primer [test_dict]:
      "b":1
      /    \
  "a":0  "d":2
         /
     "c":-2
[*----------------------------------------------------------------------------*)
type ('key, 'value) dict = ('key * 'value) tree



  let test_dict = 
     let levo_d = Node(Empty,("a",0), Empty ) in
     let desno_d = Node(leaf ("c",-2),("d",2), Empty) in
     Node(levo_d,("b",1),desno_d)
    

     
(*----------------------------------------------------------------------------*]
 Funkcija [dict_get key dict] v slovarju poišče vrednost z ključem [key]. Ker
 slovar vrednosti morda ne vsebuje, vrne [option] tip.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # dict_get "banana" test_dict;;
 - : 'a option = None
 # dict_get "c" test_dict;;
 - : int option = Some (-2)
[*----------------------------------------------------------------------------*)
(* let rec get_dict k = function
|Empty -> None
| Node (('k,v))
       *)

let rec get_dict key dict = 
     match dict with
     |Empty -> None
     |Node(l, (k,v), d) -> 
     if k = key then Some(v)
     else if k > key then
          get_dict key l
     else 
          get_dict key d

      
(*----------------------------------------------------------------------------*]
 Funkcija [print_dict] sprejme slovar s ključi tipa [string] in vrednostmi tipa
 [int] in v pravilnem vrstnem redu izpiše vrstice "ključ : vrednost" za vsa
 vozlišča slovarja.
 Namig: Uporabite funkciji [print_string] in [print_int]. Nize združujemo z
 operatorjem [^]. V tipu funkcije si oglejte, kako uporaba teh funkcij določi
 parametra za tip ključev in vrednosti v primerjavi s tipom [dict_get].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # print_dict test_dict;;
 a : 0
 b : 1
 c : -2
 d : 2
 - : unit = ()
[*----------------------------------------------------------------------------*)
(* let rec print_string string =
     match string with
     |"_" -> print(_) *)

let rec print_dict = function
     |Empty -> ()
     |Node(levi, (k,v), desni) -> (print_dict levi);(print_string(k));(print_string(":"));(print_int(v));(print_string("\n"));(print_dict desni)
(*----------------------------------------------------------------------------*]
 Funkcija [dict_insert key value dict] v slovar [dict] pod ključ [key] vstavi
 vrednost [value]. Če za nek ključ vrednost že obstaja, jo zamenja.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # dict_insert "1" 14 test_dict |> print_dict;;
 1 : 14
 a : 0
 b : 1
 c : -2
 d : 2
 - : unit = ()
 # dict_insert "c" 14 test_dict |> print_dict;;
 a : 0
 b : 1
 c : 14
 d : 2
 - : unit = ()
[*----------------------------------------------------------------------------*)
let rec dict_insert key value dict = 
     match dict with
     |Empty -> Empty
     |Node(lt,(k,v), rt) when k = key -> Node(lt,(k,value),rt)
     |Node(lt,(k,v),rt) when k < key -> Node(lt,(k,v),dict_insert key value rt)
     |Node(lt,(k,v),rt) when k > key -> Node(dict_insert key value rt, (k,v), rt)
