(*----------------------------------------------------------------------------*]
 Definirajte tipa [euro] in [dollar], kjer ima vsak od tipov zgolj en
 konstruktor, ki sprejme racionalno število.
 Nato napišite funkciji [euro_to_dollar] in [dollar_to_euro], ki primerno
 pretvarjata valuti (točne vrednosti pridobite na internetu ali pa si jih
 izmislite).

 Namig: Občudujte informativnost tipov funkcij.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # dollar_to_euro;;
 - : dollar -> euro = <fun>
 # dollar_to_euro (Dollar 0.5);;
 - : euro = Euro 0.4305
[*----------------------------------------------------------------------------*)
type euro = Euro of float
type dollar = Dollar of float 

let dollar_to_euro dollar = 
  match dollar with 
  |Dollar v -> Euro (0.2 *. v)
(*----------------------------------------------------------------------------*]
 Definirajte tip [currency] kot en vsotni tip z konstruktorji za jen, funt
 in švedsko krono. Nato napišite funkcijo [to_pound], ki primerno pretvori
 valuto tipa [currency] v funte.

 Namig: V tip dodajte še švicarske franke in se navdušite nad dejstvom, da vas
        Ocaml sam opozori, da je potrebno popraviti funkcijo [to_pound].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # to_pound (Yen 100.);;
 - : currency = Pound 0.007
[*----------------------------------------------------------------------------*)
(* type yen = Yen of float in
type funt = Funt of float in 
type krona = Krona of float in *)
type currency = 
  | Yen of float
  | Funt of float
  | Krona of float

let to_pound c = 
  match c with 
  |Yen v -> Funt (1.0 *. v)
  |Funt v -> Funt v
  |Krona v -> Funt (2.0  *. v)


(*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*]
 Želimo uporabljati sezname, ki hranijo tako cela števila kot tudi logične
 vrednosti. To bi lahko rešili tako da uvedemo nov tip, ki predstavlja celo
 število ali logično vrednost, v nadaljevanju pa bomo raje konstruirali nov tip
 seznamov.

 Spomnimo se, da lahko tip [list] predstavimo s konstruktorjem za prazen seznam
 [Nil] (oz. [] v Ocamlu) in pa konstruktorjem za člen [Cons(x, xs)] (oz.
 x :: xs v Ocamlu).
[*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*)

(*----------------------------------------------------------------------------*]
 Definirajte tip [intbool_list] z konstruktorji za:
  1.) prazen seznam,
  2.) člen z celoštevilsko vrednostjo,
  3.) člen z logično vrednostjo.

 Nato napišite testni primer, ki bi predstavljal "[5; true; false; 7]".
[*----------------------------------------------------------------------------*)




type intbool_list =
    | Empty
    | Integer of int * intbool_list
    | Bool of bool * intbool_list

let primer = Integer(5, Bool(false, Bool(true,  Integer(7, Empty))))
  
(*----------------------------------------------------------------------------*]
 Funkcija [intbool_map f_int f_bool ib_list] preslika vrednosti [ib_list] v nov
 [intbool_list] seznam, kjer na elementih uporabi primerno od funkcij [f_int]
 oz. [f_bool].
[*----------------------------------------------------------------------------*)
(* let rec intbool_map f_int f_bool ib_list =
  match ib_list with
  |x :: xs when  x of type Integer -> (f_int x):: intbool_map f_int f_bool xs
   *)
  (* let rec intbool_map f_int f_bool ib_list = 
    match ib_list with
    | x :: xs -> if (x = bool)
                    then (f_bool v) :: intbool_map f_int f_bool xs
                  else 
                        (f_int v) :: intbool_map f_int f_bool xs
   *)
   (* let intbool_map f_int f_bool = function  *)
   let rec intbool_map (f_int: int -> int) (f_bool : bool -> bool) =  function
  | Empty -> Empty
  | Integer (i, ib_list) ->
                Integer (f_int i, intbool_map f_int f_bool ib_list)
  | Bool (b, ib_list) ->
                Bool(f_bool b, intbool_map f_int f_bool ib_list)
  (*----------------------------------------------------------------------------*]
 Funkcija [intbool_reverse] obrne vrstni red elementov [intbool_list] seznama.
 Funkcija je repno rekurzivna.
[*----------------------------------------------------------------------------*)

let rec intbool_reverse intbool_list = 
  let rec  reverse acc intbool_list = 
    match intbool_list with
    |Integer(i, xs) -> 
          let new_acc = Integer(i, acc) in reverse new_acc xs
    |Bool(b, xs)->
          let new_acc = Bool(b, acc) in reverse new_acc xs
    |Empty -> acc
  in reverse Empty intbool_list

(*----------------------------------------------------------------------------*]
 Funkcija [intbool_separate ib_list] loči vrednosti [ib_list] v par [list]
 seznamov, kjer prvi vsebuje vse celoštevilske vrednosti, drugi pa vse logične
 vrednosti. Funkcija je repno rekurzivna in ohranja vrstni red elementov.
[*----------------------------------------------------------------------------*)

