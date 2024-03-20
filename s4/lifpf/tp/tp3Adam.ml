(* TP3 
2. Arbre binaire
*)


type arbre_bin =
  | ABVide                             
  | ABNoeud of int * arbre_bin * arbre_bin
;;


(*test Adam Aysoy *)


(* Variables globales d'arbres binaires test Adam Aysoy *)
let arbre_bin1 =
  ABNoeud (1,
    ABNoeud (2, ABVide, ABVide),
    ABNoeud (3, ABVide, ABVide))
;;
let arbre_bin2 =
  ABNoeud (10,
    ABNoeud (20, ABVide, ABVide),
    ABNoeud (30, ABVide, ABVide))
;;
let rec taille_ab arbre =
  match arbre with
  | ABVide -> 0
  | ABNoeud (_, fils_gauche, fils_droit) ->
      1 + taille_ab fils_gauche + taille_ab fils_droit
  ;;
(*fonction produit_ab*)

(*
let produit_ab_Adam_Aysoy_HS (a1 : arbre_bin) (a2 : arbre_bin): arbre_bin = 
  match a1 with
  | [] -> a2
  | a :: a2 ->  a1 * a2

;;
*)

let rec produit_ab arbre =
  match arbre with
  | ABVide -> 1  
  | ABNoeud (valeur, fils_gauche, fils_droit) ->
      valeur * produit_ab fils_gauche * produit_ab fils_droit
  ;;

assert (taille_ab ABVide = 0);;
assert (taille_ab arbre_bin1 = 1);;
assert (taille_ab arbre_bin2 = 2 );;

(*
assert (taille_ab ab1 = 1);;
assert (taille_ab ab2 = 2);;
*)

(* Tester la fonction avec assert *)
assert (produit_ab arbre_bin1 = 6);;
assert (produit_ab arbre_bin2 = 6000);;
let varAdamAysoy = 2+3;;


(*2.2 Arbre binaire de recherche *)
(*fg-noeud-fd*)
(*2.2.1 Insertion *)
let rec insere_arbre_bin_recherche (a : arbre_bin) (element : int ) = 
  match a with 
  | ABVide -> ABNoeud(element,ABVide,ABVide)
  | ABNoeud(valeur, fils_gauche,fils_droit) -> *)
      if valeur > element then ABNoeud (valeur,insere_arbre_bin_recherche  fils_gauche element , fils_droit) 
      else if valeur < element then ABNoeud(valeur ,fils_gauche ,insere_arbre_bin_recherche  fils_droit element)
      else  
        ABNoeud(valeur,fils_ga*)sere_arbre_bin_recherche arbre_binaire_recherche 5 ;;
let arbreAdamAysoy = ABVide;;
let arbreTest = insere_arbre_bin_recherche arbreAdamAysoy 5;;
let arbreTest2 = insere_arbre_bin_recherche arbreTest 6;;
arbreAdamAysoy;;

(*2.2.2 Transformation 
list_of_arbre_bin *)




(* Fonction pour obtenir une liste correspondant à un parcours infixe de l'arbre binaire *)

let rec list_of_arbre_bin arbre =
  match arbre with
  | ABVide -> []
  | ABNoeud (valeur, fils_gauche, fils_droit) ->
      list_of_arbre_bin fils_gauche @ [valeur] @ list_of_arbre_bin fils_droit
  ;;



(*Tester la fonction `list_of_arbre_bin` avec `assert`.*)

assert (list_of_arbre_bin ABVide = []);;
assert (list_of_arbre_bin arbre_Adam_Aysoy = [1;2;3;4;5] );;
assert (list_of_arbre_bin abinaire = [ 1; 6; 47; 7; 3 ]);;
assert (list_of_arbre_bin abinaire1 = [ 8 ]);;



(*> Écrire la fonction `arbre_bin_rech_of_int_list` qui transforme une liste en arbre binaire **de recherche**.

On utilisera `insere_arbre_bin_recherche` dans cette fonction.

> Tester `arbre_bin_rech_of_int_list` en utilisant `assert` et `list_of_arbre_bin` afin de simplifier l'écriture des tests.

Quelle propriété des arbres est-elle utile pour prédire le résultat de l'appel `list_of_arbre_bin (arbre_bin_rech_of_int_list l)` sur une liste `l` donnée ?

> Coder la fonction `tri_abr` qui utilise des fonctions codées dans ce TP pour trier une liste d'int. Tester cette fonction avec `assert`.*)

(*let rev arbre_bin_rech_of_int_list = function *)


(*
## 3. Évaluation d'expressions arithmétiques

Dans cette partie, on va implémenter un évaluateur d'expressions arithmétiques.

On commence par se donner un type pour représenter les différents opérateurs possibles:

```ocaml
type binop = Plus | Moins | Mult
```

On se donne ensuite un type pour représenter les expressions :

```ocaml
type expr =
  | Cst of int
  | Binop of binop * expr * expr
```
   
*) 
type binop = Plus | Moins | Mult;;
type expr =
  | Cst of int
  | Binop of binop * expr * expr
;;

let e1 = Binop ( Plus , Cst 2 , Cst 3 );;  
let e2 = Cst 2;;  
let e3 = Binop (Moins , Cst 3 , e1);;
(* Exemple type expr*)

let rec string_of_expr (e : expr) : string = 
  let string_of_binop (operateur : binop)=
    match operateur with 
    |Plus -> "+"
    |Moins -> "-"
    |Mult -> "*"
in match e with
  |Cst entier -> string_of_int entier
  | Binop (operateur , Cst entier1,Cst entier2) -> string_of_expr entier1 ^ string_of_binop operateur ^string_of_expr entier2;;

  let chaineTranslate = 
    string_of_expr ( Binop (Plus , Cst 45, Cst 12));;
  let chaineTranslate2 = string_of_expr (Cst 3);;
(*la je suis bien en forme pour faire tout mes tps *)