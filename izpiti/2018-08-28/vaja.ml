(* 1.naloga *)
(* a) primer *)
let razlika_kvadratov x y =
  (x + y ) * (x + y) - (x*x + y*y)

(* b) primer *)
let razlika_kvadratov_par f (a,b)= 
  (f a , f b)

(* c) primer *)
let ponovi_seznam n sez = 
  let rec ponovi n acc = 
    match n with
    |k when k <= 0 -> acc
    |k -> ponovi (n-1) (sez @ acc)
  in ponovi n []

  
(* d) primer *)
let rec razdeli sez = 
  let rec razdeli' negativni pozitivni sez =
    match sez with
    |[] -> (negativni, pozitivni)
    | x :: xs  -> if x < 0 then 
    razdeli' (x :: negativni) pozitivni xs
    else
    razdeli' negativni (x :: pozitivni) xs
  in razdeli' [] [] sez


(* 3.naloga *)

type 'a tree =
  | Empty
  | Node of 'a tree * 'a * 'a tree


let rec najdaljsa_pot drevo = 
  match drevo with 
  |Node(lt,x,rt)