(*----------------------------------------------------------------------------*]
 Funkcija [map f list] sprejme seznam [list] oblike [x0; x1; x2; ...] in
 funkcijo [f] ter vrne seznam preslikanih vrednosti, torej
 [f(x0); f(x1); f(x2); ...].
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # let plus_two = (+)2 in
   map plus_two [0; 1; 2; 3; 4];;
 - : int list = [2; 3; 4; 5; 6]
[*----------------------------------------------------------------------------*)
let reverse =
  let rec aux acc = function
    | [] -> acc
    | x :: xs -> aux (x :: acc) xs
  in
  aux []

let rec map f list = 
  let rec map' f acc l = 
    match l with 
    |[] -> reverse acc
    | x :: xs -> map' f (f x :: acc) xs
  in map' f [] list 
(*----------------------------------------------------------------------------*]
 Funkcija [zip_enum_tlrec] sprejme seznama [x_0; x_1; ...] in [y_0; y_1; ...]
 ter vrne seznam [(0, x_0, y_0); (1, x_1, y_1); ...]. Funkcija je repno
 rekurzivna. Če seznama nista enake dolžine vrne napako.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # zip_enum_tlrec ["a"; "b"; "c"] [7; 3; 4];;
 - : (int * string * int) list = [(0, "a", 7); (1, "b", 3); (2, "c", 4)]
[*----------------------------------------------------------------------------*)
let rec zip_enum_tlrec sez1 sez2 = 
  let rec zip' s1 s2 i acc = 
    match s1, s2 with 
    |[],[] -> reverse(acc)
    |_, [] -> failwith "Lists not exact length"
    |[], _ -> failwith "Lists not exact length" 
    |x :: xs, y :: ys -> zip' xs ys (i+1) ((i,x,y):: acc)
  in zip' sez1 sez2 0 []

  (*----------------------------------------------------------------------------*]
 Funkcija [apply_sequence f x n] vrne seznam zaporednih uporab funkcije [f] na
 vrednosti [x] do vključno [n]-te uporabe, torej
 [x; f x; f (f x); ...; (f uporabljena n-krat na x)].
 Funkcija je repno rekurzivna.
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 # apply_sequence (fun x -> x * x) 2 5;;
 - : int list = [2; 4; 16; 256; 65536; 4294967296]
 # apply_sequence (fun x -> x * x) 2 (-5);;
 - : int list = []
[*----------------------------------------------------------------------------*)
 
let rec ne_dela_apply_sequence f x n = 
  let rec apply' acc f x n =
    if n < 0 
      then acc
    else 
    apply' (f x :: acc) f (f x ) (n-1)
 in reverse(apply' [] f x) 
 
 
 let rec apply_sequence f x n =
  let rec apply_sequence' acc f x n =
    if n < 0 then
      acc
    else
      apply_sequence' (f x :: acc) f (f x) (n - 1)
  in reverse(apply_sequence' [] f x n)