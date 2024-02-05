(* Listes et paires *)
(* Questions 1 & 2 *)
let rec map2 (f : 'a -> 'b -> 'c) (l1 : 'a list) (l2 : 'b list) :
    'c list =
  match (l1, l2) with
  | [], _ -> []
  | _, [] -> []
  | x1 :: l1', x2 :: l2' -> f x1 x2 :: map2 f l1' l2'

(* Questions 3 & 4 *)
let rec zip (l1 : 'a list) (l2 : 'b list) : ('a * 'b) list =
  match (l1, l2) with
  | [], _ -> []
  | _, [] -> []
  | x1 :: l1', x2 :: l2' -> (x1, x2) :: zip l1' l2'

(* Questions 5 & 6 *)
let unzip (l : ('a * 'b) list) : 'a list * 'b list =
  List.fold_right
    (fun p pl -> (fst p :: fst pl, snd p :: snd pl))
    l ([], [])

(* Question 7 *)
let map2 (f : 'a -> 'b -> 'c) (l1 : 'a list) (l2 : 'b list) :
    'c list =
  List.map (fun p -> f (fst p) (snd p)) (zip l1 l2)

(* Expressions booléennes *)
(* Question 8 *)
type boolexpr =
  | Var of string
  | Vrai
  | Non of boolexpr
  | Et of boolexpr * boolexpr

(* Questions 9 & 10 *)
let rec eval (env : (string * bool) list) (expr : boolexpr) :
    bool option =
  match expr with
  | Var v -> List.assoc_opt v env
  | Vrai -> Some true
  | Non expr' -> (
      match eval env expr' with
      | None -> None
      | Some b -> Some (not b))
  | Et (expr1, expr2) -> (
      match (eval env expr1, eval env expr2) with
      | Some b1, Some b2 -> Some (b1 && b2)
      | _, _ -> None)

(* Modules et arbres de recherche *)

(* Donné dans l'énoncé *)
module type Cmp = sig
  type t
  type cmp_t = Lt | Gt | Eq

  val cmp : t -> t -> cmp_t
end

(* Question 11 *)
module type ENS_T = sig
  type ens
  type elt

  val appartient : elt -> ens -> bool
  val insere : elt -> ens -> ens
end

module ABR_T (M : Cmp) : ENS_T with type elt = M.t = struct
  (* Question 12 *)
  type ens = Vide | Noeud of (M.t * ens * ens)
  type elt = M.t

  (* Question 13 *)
  let rec appartient v a =
    match a with
    | Vide -> false
    | Noeud (v2, fg, fd) -> (
        match M.cmp v v2 with
        | Lt -> appartient v fg
        | Gt -> appartient v fd
        | Eq -> true)

  (* Question 14 *)
  let rec insere v a =
    match a with
    | Vide -> Noeud (v, Vide, Vide)
    | Noeud (v2, fg, fd) -> (
        match M.cmp v v2 with
        | Lt -> Noeud (v2, insere v fg, fd)
        | Gt -> Noeud (v2, fg, insere v fd)
        | Eq -> a)
end
