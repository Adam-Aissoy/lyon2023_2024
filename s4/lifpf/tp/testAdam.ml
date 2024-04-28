
(* that's firt comment and first function *)
(* somme of two int *)
let somme ( a : int ) ( b : int ) : int = a + b ;; 

(* somme of  int list  *)
let rec sommeList ( l : int list   ) : int = 
match l with 
| [] -> 0
| tete::queue -> tete + sommeList queue;;
(*assert sommeList*)
let l = [1; 2; 3; 4; 5; 6];;
sommeList l ;

(* test list.map *)
let rec map (f: 'a -> 'b ) (l: 'a list ) : 'b list =
  match l with
  | [] -> []
  | x :: l' -> (f x )::map f l';;
(*somme increment *)
let sommeIncrement (a : int ): int  = a+1;;
map sommeIncrement l;;
let cmp x y = x < y;;
let sup_3 (l:int list): int list = List.filter (cmp 3) l;;
