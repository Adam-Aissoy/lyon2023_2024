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
  | ABNoeud(valeur, fils_gauche,fils_droit) -> 
      if valeur > element then ABNoeud (valeur,insere_arbre_bin_recherche  fils_gauche element , fils_droit) 
      else if valeur < element then ABNoeud(valeur ,fils_gauche ,insere_arbre_bin_recherche  fils_droit element)
      else  
        ABNoeud(valeur,fils_gauche,fils_droit)
    ;;




(** test Adam Aysoy *)
let arbre_binaire_recherche = ABVide;;
let arbre_apres_insertion = insere_arbre_bin_recherche arbre_binaire_recherche 5 ;;
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
(* Exemple d'utilisation et test avec assert *)
let arbre_binaire_exemple =
  ABNoeud (2,
    ABNoeud (1, ABVide, ABVide),
    ABNoeud (3, ABVide, ABVide))
    > Tester `insere_arbre_bin_recherche` en utilisant `assert`.
;;
assert (list_of_arbre_bin arbre_binaire_exemple = [1; 2; 3]);;


