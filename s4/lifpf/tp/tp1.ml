(**********************************************************************)
(* 1.1 *)
(3 * 2) + (5 / 2);;
3.2 +. (7.4 /. 2.0);;
"AC" ^ "/" ^ "DC";;
true || (false && false);;

(* && est prioritaire sur || *)
(false && false) || true;;

(* 3 < 2.0 provoque une erreur car 3 et 2.0 n'ont pas le même type *)

(**********************************************************************)
(* 1.2 *)

(* float_of_int 3.0 provoque une erreur car 3.0 n'est pas un int *)
float_of_int 3;;
int_of_float;;
int_of_float 3.5 + 2;;
float_of_int (int_of_float 3.6 + 2) +. 1.5;;
(not false) && false;;
2 < 3 && "b" < "ab";;

(**********************************************************************)
(* 1.3 *)
let x1 = 3.5 +. float_of_int 2 in
x1 +. 3.0
;;

let x1 = 3.5 +. float_of_int 2 in
let x2 = x1 *. x1 in
x2 *. 2.0
;;

(**********************************************************************)
(* 1.4 *)

(if true then 3 else 5) > 4

(**********************************************************************)
(* 2 *)
let f x = x + 1;;

3 + f 3

let discriminant a b c = (b *. b) -. (4.0 *. a *. c)

(* Le type affiche par l'interpréteur est float -> float -> float -> float *)

(**
[discriminant a b c] calcule le discriminant d'un trinôme.
Cette fonction est utile pour trouver les racines d'un trinôme.
@param a le coefficient d'ordre 2    
@param b le coefficient d'ordre 1
@param c le coefficient d'ordre 0
@return le discriminant
*)
let discriminant (a : float) (b : float) (c : float) : float =
  (b *. b) -. (4.0 *. a *. c)
;;

discriminant;;
discriminant 2.0 8.0 8.0

(* Erreur de type sur l'utilisation de a dans la def suivante: *)
(*
   let discriminant (a:int) (b:float) (c:float): float =
       b *. b -. 4.0 *. a *. c;;
*)

(**********************************************************************)

(* 3.1 *)
type couleur = Rouge | Jaune | Bleu;;

(* La valeur Rouge est bien définie et reconnue comme étant de type couleur *)
Rouge;;

(* L'égalité est bien (pré)définie sur les couleurs *)
Rouge = Rouge;;
Rouge != Bleu;;

(* De même il existe un ordre par défaut sur les couleurs *)
Bleu > Jaune

type couleur = Rouge | Jaune | Bleu | Violet | Orange | Vert

type couleur =
  | Rouge
  | Jaune
  | Bleu
  | Violet
  | Orange
  | Vert
  | RJB of int * int * int
;;

(* le type est "int * float" c'est-à-dire une paire d'int et de float *)
3, 5.6;;

(* c'est le triplet de type int * int * int *)
3, 5, 6

(**********************************************************************)
(* 3.2 *)

let nom_couleur c =
  match c with
  | Rouge -> "rouge"
  | Jaune -> "jaune"
  | Bleu -> "bleu"
  | Vert -> "vert"
  | Violet -> "violet"
  | Orange -> "orange"
  | _ -> "mélange"

(*
  let nom_couleur c =
  match c with
  | Rouge -> "rouge"
  | Jaune -> "jaune"
  | Bleu -> "bleu"
  | Vert -> "vert"
  | Violet -> "violet"
  | Orange -> "orange";;
 Erreur: this pattern-matching is not exhaustive.
 Elle indique que le match ne couvre pas tous les cas possibles.
*)

(*
  let nom_couleur c =
  match c with
  | _ -> "mélange"
  | Rouge -> "rouge"
  | Jaune -> "jaune"
  | Bleu -> "bleu"
  | Vert -> "vert"
  | Violet -> "violet"
  | Orange -> "orange";;
 Erreur: this pattern-matching is not exhaustive.
 Elle indique que le match ne couvre pas tous les cas possibles.
*)

(**
Génère le paragraphe pour [n] bouteilles de bières.
@param n le nombre de bouteilles de bièere sur le mur au début du paragraphe.
@return le paragraphe
*)
let paragraphe_bottles (n : int) : string =
  match n with
  | 0 ->
      "No more bottles of beer on the wall, no more bottles of beer.\n"
      ^ "Go to the store and buy some more, 99 bottles of beer on the wall."
  | 1 ->
      "1 bottle of beer  on the wall, 1 bottle of beer.\n"
      ^ "Take one down and pass it around, no more bottles of beer on the wall."
  | 2 ->
      "2 bottles of beer on the wall, 2 bottles of beer.\n"
      ^ "Take one down and pass it around, 1 bottle of beer on the wall."
  | k ->
      string_of_int k ^ " bottles of beer on the wall, " ^ string_of_int k
      ^ " bottles of beer.\n" ^ "Take one down and pass it around, "
      ^ string_of_int (k - 1)
      ^ " bottles of beer on the wall."
;;

(* tests *)

paragraphe_bottles 0;;
paragraphe_bottles 1;;
paragraphe_bottles 2;;
paragraphe_bottles 7

(**********************************************************************)
(* 4 *)

(**
Renvoie la somme des n premiers entiers
@param n le nombre d'entiers à sommer
@return la somme
*)
let rec sum_n (n : int) : int = if n <= 0 then 0 else n + sum_n (n - 1)

(**
[factorielle n] calcule la factorielle des [n] premiers entiers
@param n doit être supérieur ou égal à 1
@return !n
*)
let rec factorielle n = if n <= 1 then 1 else n * factorielle (n - 1)

(**********************************************************************)
(* 5 *)
(* Erreur car on essaie d'ajouter une string dans une int list
   "2" :: 3 :: [];;
*)

(**
Cette fonction calcule la longueur d'une liste de `string`.
@param l la liste dont on veut la longueur
@return la longueur de l
*)
let rec longueur (l : string list) : int =
  match l with [] -> 0 | _ :: l2 -> 1 + longueur l2

(* La valeur de l'élément de list n'est pas utilisée dans le deuxième cas du match.
   On a donc pas besoin de la recupérer dans une variable et on met _ pour plus de clarté. *)

(**
    Cette fonction calcule la somme des éléments de la liste
    @param l la liste dont on veut additionner les éléments
    @return la somme des éléments de la liste
*)
let rec sum_f (l : float list) : float =
  match l with [] -> 0.0 | x :: l2 -> x +. sum_f l2

(**
Cette fonction concatène les éléments de la liste en les séparant par [sep].
@param l la liste dont on veut concaténer les éléments
@param sep le séparateur
@return les éléments de la liste [l] concaténé et séparés les uns des autres par [sep]
*)
let rec join_s (l : string list) (sep : string) : string =
  match l with
  | [] -> ""
  | s :: [] -> s
  | s :: l2 ->
      (* Plus général que le cas précédent car l2 n'est pas forcément vide.
         Comme le match applique le premier cas dans l'ordre du programme,
         Les listes à 1 élément ne passent pas dans le 3eme cas du match. *)
      s ^ sep ^ join_s l2 sep
;;

(* test *)
join_s [ "a"; "b"; "c" ] "|"

(**
Cette fonction créée une liste des int de n à 0 inclus.
@param n l'int de début de liste
@return la liste des entiers décroissants    
*)
let rec liste_n_0 (n : int) : int list =
  if n <= 0 then [ 0 ] else n :: liste_n_0 (n - 1)
;;

(* test *)
liste_n_0 12

(**
[bottles_of_list [n1; n2; ...]] crée la liste des paragraphes de la chanson 99
bottles of beer pour n1 puis n2 ... bouteilles.
@param l la liste des nombres de bouteilles à transformer
@return la liste des paragraphes correspondant aux int de l
*)
let rec bottles_of_list (l : int list) : string list =
  match l with
  | [] -> []
  | n :: l2 -> paragraphe_bottles n :: bottles_of_list l2

let chanson_99_bottles =
  let nums = liste_n_0 99 in
  let paragraphes = bottles_of_list nums in
  join_s paragraphes "\n\n"
;;

print_endline chanson_99_bottles
