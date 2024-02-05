(* Exemple de commentaire  
TP 2 Adam Aysoy *)

(* Exercice 1 *)  
(* 1. Concaténations de listes*) 
(*1.1 Concaténation de deux listes *)
(**
   - l new list qui contient les éléments de l1 et l2 
   
   *)
   (**hdh*)
let rec concatene (l1:int list) (l2 : int list ): int list  = match l1 with
  | [] -> l2
  | x::l -> x::(concatene l l2);;
concatene [2;3;6] [5;6;9];;
(* 1.2.a Concaténation (applatissement) d'une liste de liste *)
(**
- contition d'une liste a partir de (int list) list   
*)
let rec applatit (l : (int list) list): int list = 
  match l with
  | [] -> []
  | x::l -> concatene x (applatit l);;
applatit [[2;3;6];[5;6;9]; [45;86;10]];;
(* 1.2.b Concaténation (applatissement) d'une liste de liste sans concatene *)
let rec applatit2 (l : (int list) list): int list = 
  match l with
  | [] -> []
  | x::l -> x@(applatit2 l);;

  
applatit2 [[2;3;6];[5;6;9]; [45;86;10]];;
(** test question applatit3 *)
let rec applatit3 (l : (int list) list): int list = 
  match l with
  | [] -> []
  | x::l -> x::(applatit2 l);;
applatit3 [[2;3;6];[5;6;9]; [45;86;10]];;
(*2 Retournement de liste*)
(* Fonction renverse_ajoute : 'a list -> 'a list -> 'a list
   Renverse la liste en utilisant une liste auxiliaire pour ajouter en tête *)
   let rec renverse_ajoute l acc =
    match l with
    | [] -> acc
    | hd :: tl -> renverse_ajoute tl (hd :: acc);;
  
  (* Fonction renverse : 'a list -> 'a list
     Renverse une liste *)
  let renverse l = renverse_ajoute l [];;
  
  (* Tests *)
  renverse [1; 2; 3] = [3; 2; 1];;
  renverse [] = [];;
  (*tri par insertion*)
  (*3.1 insertion dans une liste triee *)

(* Fonction insertion : int -> int list -> int list
   Insère un élément à la bonne position dans une liste triée *)
let rec insertion x l =
  match l with
  | [] -> [x]
  | hd :: tl -> if x <= hd then x :: l else hd :: insertion x tl;;

(* Tests *)
insertion 3 [1; 2; 4; 5] = [1; 2; 3; 4; 5];;
insertion 3 [1; 2; 3; 4; 5] = [1; 2; 3; 3; 4; 5];;
 (*3.2 Tri par insertion *)
(* Fonction tri_insertion : int list -> int list
   Trie une liste par insertion *)
   let rec tri_insertion l =
    match l with
    | [] -> []
    | hd :: tl -> insertion hd (tri_insertion tl);;
  
  (* Tests *)
  tri_insertion [1; 4; 2; 3] = [1; 2; 3; 4];;
  tri_insertion [1; 2; 3; 4] = [1; 2; 3; 4];;
(*4 recherche dans une listed'association *)
(*4.1 type de resultat*)  
(* Type somme pour le résultat de la recherche *)
type resultat_assoc = Valeur of string | Absent;;

(* Fonction cherche : int -> (int * string) list -> resultat_assoc
   Cherche la valeur associée à une clé dans une liste d'association *)
let rec cherche cle assoc =
  match assoc with
  | [] -> Absent
  | (c, v) :: tl -> if c = cle then Valeur v else cherche cle tl;;

(* Tests *)
cherche 1 [(1, "un"); (2, "deux"); (3, "trois")] = Valeur "un";;
cherche 4 [(1, "un"); (2, "deux"); (3, "trois")] = Absent;;

(*5 calculatrice en notation polonaise *)
(* Type pour les opérations binaires *)
type binop = Plus | Moins | Mult | Div

(* Type pour les éléments d'expression *)
type elt_expr = Op of binop | Cst of int

(* Type pour le résultat de l'évaluation *)
type resultat_expr = Ok of int | ErrDivZero | ErrExpr

(* Fonction eval_op : binop -> resultat_expr -> resultat_expr -> resultat_expr
   Évalue le résultat d'un opérateur binaire *)
let eval_op op r1 r2 =
  match (op, r1, r2) with
  | (_, ErrDivZero, _) | (_, _, ErrDivZero) | (_, ErrExpr, _) | (_, _, ErrExpr) -> ErrExpr
  | (Plus, Ok x, Ok y) -> Ok (x + y)
  | (Moins, Ok x, Ok y) -> Ok (x - y)
  | (Mult, Ok x, Ok y) -> Ok (x * y)
  | (Div, Ok x, Ok 0) -> ErrDivZero
  | (Div, Ok x, Ok y) -> Ok (x / y);;

(* Tests *)
eval_op Plus (Ok 1) (Ok 2) = Ok 3;;
eval_op Moins (Ok 2) (Ok 3) = Ok (-1);;
eval_op Div (Ok 3) (Ok 0) = ErrDivZero;;
eval_op Div (Ok 5) ErrExpr = ErrExpr;;

(* Fonction eval_expr : elt_expr list -> resultat_expr list
   Évalue une suite d'
