(* 1 naloga *)
let uporabi f a = 
  f a

let ibaropu f x g =
  g (f x)


  let rec zacetnih n xs = 
    let rec zac' n xs acc= 
      match n, xs with
      |0,_ -> acc
      |n,xs  when n > (List.length xs) -> failwith "listo short"
      |n, x :: xt -> zac' (n-1) xt (x :: acc)
    in zac' n xs []

(* 2.naloga *)
let type 'a neprazen_sez = Konec of 'a | Sestavljen of 'a * 'a neprazen_sez
let rec prvi  = function
      |x :: [] -> x
      |x :: xs :: xy -> x


  
(* a) Napišite funkciji prvi : ’a neprazen_sez -> ’a in zadnji : ’a neprazen_sez -> ’a , ki
vrneta prvi in zadnji element nepraznega seznama.

b) Napišite funkcijo dolzina : ’a neprazen_sez -> int, ki izraˇcuna dolžino nepraznega seznama.

c) Napišite funkcijo pretvori_v_seznam : ’a neprazen_sez -> ’a list, ki pretvori neprazen
seznam tipa ’a neprazen_sez v navaden seznam tipa ’a list.

d) Napišite funkcijo zlozi : (’b -> ’a -> ’b) -> ’b -> ’a neprazen_sez -> ’b, ki zloži
podano funkcijo preko nepraznega seznama. Delovanje funkcije naj bo podobno delovanju funkcije
List.fold_left. *)
(* 
3.naloga *)

let simetricen x = 
  dolzina = List.length x
  pol = dolzina / 2
  
