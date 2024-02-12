(* LIFPF TP3 Récursion sur les arbres *)

(**********************************************************************)
(* Arbres binaires *)
(**********************************************************************)

(**
Arbres binaires avec feuilles vides, 
le contenu est seulement sur les noeuds.    
*)
type arbre_bin = ABVide | ABNoeud of int * arbre_bin * arbre_bin

(* Quelques arbres pour tester *)
let ab1 = ABNoeud (3, ABVide, ABVide)
let ab2 = ABNoeud (5, ab1, ABVide)
let ab3 = ABNoeud (7, ABVide, ab1)
let ab4 = ABNoeud (11, ab2, ab3)

(**
Taille d'un arbre binaire.
@param a l'arbre dont on veut calculer la taille
@return le nombre d'int stockés dans l'arbre
*)
let rec taille_ab (a : arbre_bin) : int =
  match a with
  | ABVide -> 0
  | ABNoeud (_, fg, fd) -> 1 + taille_ab fg + taille_ab fd
;;

assert (taille_ab ab1 = 1);;
assert (taille_ab ab2 = 2);;
assert (taille_ab ab3 = 2);;
assert (taille_ab ab4 = 5)

(**
Fait le produit des éléments d'un arbre binaire.
Un arbre vide aura 1 comme produit   
@param a l'arbre dont on veut faire le produit des éléments
@return le produit (1 pour l'arbre vide)
*)
let rec produit_ab (a : arbre_bin) : int =
  match a with
  | ABVide -> 1
  | ABNoeud (n, fg, fd) -> n *let rec arbre_bin_rech_of_int_list (l : int list) : arbre_bin =
    match l with
    | [] -> ABVide
    | x :: l' -> insere_arbre_bin_recherche x (arbre_bin_rech_of_int_list l')
  ;;
   produit_ab fg * produit_ab fd
;;

assert (produit_ab ABVide = 1);;
assert (produit_ab ab1 = 3);;
assert (produit_ab ab2 = 15);;
assert (produit_ab ab3 = 21);;
assert (produit_ab ab4 = 3465)

(**
Construit la liste des éléments d'un arbre binaire. Les éléments sont produits
dans l'ordre de parcours infix, c'est à dire les éléments du fils gauche puis
l'élément du noeud puis ceux fils droit.

@param a l'arbre binaire dont on veut les éléments 
@return la liste des éléments de l'arbre
*)
let rec list_of_arbre_bin (a : arbre_bin) : int list =
  match a with
  | ABVide -> []
  | ABNoeud (n, fg, fd) ->
      (* On peut aussi utiliser la fonction concatene du TP2 *)
      list_of_arbre_bin fg @ (n :: list_of_arbre_bin fd)
;;

assert (list_of_arbre_bin ABVide = []);;
assert (list_of_arbre_bin ab1 = [ 3 ]);;
assert (list_of_arbre_bin ab2 = [ 3; 5 ]);;
assert (list_of_arbre_bin ab3 = [ 7; 3 ]);;
assert (list_of_arbre_bin ab4 = [ 3; 5; 11; 7; 3 ])

(**
Insère un élément dans un arbre binaire de recherche.

@param e l'élément à insérer
@param a l'arbre dans lequel on fait l'insersion
@return un arbre binaire de recherche contenant les éléments de a ainsi que e
*)
let rec insere_arbre_bin_recherche (e : int) (a : arbre_bin) : arbre_bin =
  match a with
  | ABVide -> ABNoeud (e, ABVide, ABVide)
  | ABNoeud (x, fg, fd) ->
      if e < x then ABNoeud (x, insere_arbre_bin_recherche e fg, fd)
      else ABNoeud (x, fg, insere_arbre_bin_recherche e fd)

let abr1 = insere_arbre_bin_recherche 7 ABVide
let abr2 = insere_arbre_bin_recherche 5 abr1
let abr3 = insere_arbre_bin_recherche 3 abr2
let abr4 = insere_arbre_bin_recherche 11 abr3;;

assert (list_of_arbre_bin abr1 = [ 7 ]);;
assert (list_of_arbre_bin abr2 = [ 5; 7 ]);;
assert (list_of_arbre_bin abr3 = [ 3; 5; 7 ]);;
assert (list_of_arbre_bin abr4 = [ 3; 5; 7; 11 ])

(**
Créée un arbre binaire de recherche contenant les éléments de la liste

@param l la liste contenant les éléments à placer dans l'arbre à créer
@return l'arbre binaire de recherche contenant les éléments de l
*)
let rec arbre_bin_rech_of_int_list (l : int list) : arbre_bin =
  match l with
  | [] -> ABVide
  | x :: l' -> insere_arbre_bin_recherche x (arbre_bin_rech_of_int_list l')
;;

assert (list_of_arbre_bin (arbre_bin_rech_of_int_list []) = []);;
assert (list_of_arbre_bin (arbre_bin_rech_of_int_list [ 3 ]) = [ 3 ]);;
assert (list_of_arbre_bin (arbre_bin_rech_of_int_list [ 3; 5 ]) = [ 3; 5 ]);;
assert (list_of_arbre_bin (arbre_bin_rech_of_int_list [ 5; 3 ]) = [ 3; 5 ]);;

assert (
  list_of_arbre_bin (arbre_bin_rech_of_int_list [ 1; 2; 3; 4 ]) = [ 1; 2; 3; 4 ])
;;

assert (
  list_of_arbre_bin (arbre_bin_rech_of_int_list [ 4; 2; 1; 3 ]) = [ 1; 2; 3; 4 ])

(**
Trie une list d'int en utilisant un arbre binaire de recherche

@param l la liste à trier
@return la liste triée
*)
let tri_abr (l : int list) : int list =
  list_of_arbre_bin (arbre_bin_rech_of_int_list l)
;;

assert (tri_abr [] = []);;
assert (tri_abr [ 3 ] = [ 3 ]);;
assert (tri_abr [ 3; 5 ] = [ 3; 5 ]);;
assert (tri_abr [ 5; 3 ] = [ 3; 5 ]);;
assert (tri_abr [ 1; 2; 3; 4 ] = [ 1; 2; 3; 4 ]);;
assert (tri_abr [ 4; 2; 1; 3 ] = [ 1; 2; 3; 4 ])

(**********************************************************************)
(* Expressions arithmétiques et variables *)
(**********************************************************************)

(**
Type représentant les opérateurs binaires.    
*)
type binop = Plus | Moins | Mult | Div

(**
Expressions arithmétiques + let    
*)
type expr =
  | Cst of int
  | Binop of binop * expr * expr
  | Var of string
  | Let of string * expr * expr

(** affichage **)
let rec string_of_expr (e : expr) : string =
  let string_of_binop (b : binop) =
    match b with Plus -> " + " | Moins -> " - " | Mult -> " * " | Div -> " / "
  in

  match e with
  | Cst n -> string_of_int n
  | Binop (op, l, r) ->
      "(" ^ string_of_expr l ^ string_of_binop op ^ string_of_expr r ^ ")"
  | Var x -> x
  | Let (v, e1, e2) ->
      "(let " ^ v ^ " = " ^ string_of_expr e1 ^ " in " ^ string_of_expr e2 ^ ")"

(** Erreurs *)
type eval_err = DivZero | VarNonDef

(** Résultats: int ou erreur *)
type resultat = Ok of int | Err of eval_err

(**
Évalue une expression dans un environnement
*)
let rec eval_expr (e : expr) (env : (string * int) list) : resultat =
  match e with
  | Cst n -> Ok n
  | Binop (op, e1, e2) -> (
      match (eval_expr e1 env, eval_expr e2 env) with
      | Ok v1, Ok v2 -> (
          match op with
          | Plus -> Ok (v1 + v2)
          | Moins -> Ok (v1 - v2)
          | Mult -> Ok (v1 * v2)
          | Div -> if v2 = 0 then Err DivZero else Ok (v1 / v2))
      | Err e, _ -> Err e
      | _, Err e -> Err e)
  | Var x -> (
      match List.assoc_opt x env with None -> Err VarNonDef | Some n -> Ok n)
  | Let (x, e1, e2) -> (
      match eval_expr e1 env with
      | Ok v1 -> eval_expr e2 ((x, v1) :: env)
      | Err e -> Err e)

let e1 = Cst 3
let e2 = Binop (Plus, Cst 3, Cst 5)
let e3 = Binop (Div, Cst 3, Cst 0)
let e4 = Let ("a", Cst 3, Binop (Moins, Var "a", Cst 3))
let e5 = Let ("a", Cst 3, Var "b");;

assert (eval_expr e1 [] = Ok 3);;
assert (eval_expr e2 [] = Ok 8);;
assert (eval_expr e3 [] = Err DivZero);;
assert (eval_expr e4 [] = Ok 0);;
assert (eval_expr e5 [] = Err VarNonDef);;
assert (eval_expr e5 [ ("b", 11) ] = Ok 11)

(**********************************************************************)
