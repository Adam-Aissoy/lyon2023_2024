
(* that's firt comment and first function *)
(* somme of two int *)
let somme ( a : int ) ( b : int ) : int = a + b ;; 

(* somme of  int list  *)
let rec sommeList ( l : int list   ) : int = 
match l with 
| [] -> 0
| tete::queue -> tete + sommeList queue;;