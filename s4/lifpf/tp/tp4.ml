(*
TP4 
1. Arbre n-aires   
1.1 type arbre n-aires
*)
type 'a arbre_n = 
  | Feuille of 'a
  | Noeud of 'a arbre_n list
;;
let arbre_n1 : int arbre_n= Feuille 2 ;;
let arbre_n2 : 'a arbre_n= Feuille 3;;
let arbre_nAdamAysoy : 'a arbre_n= Noeud [(Feuille 45)] ;;

let arbre_n3: 'a arbre_n= (Noeud [(Noeud [(Feuille 45)])]);;

(*1.2 Hauteur d'un arbre *)
let rec hauteur_arbre (arbre : 'a arbre_n): int = 
  | Feuille _ -> 1 
  | Noeud lf -> 1 + hauteur_foret lf
    
and hauteur_foret (arbre1 : 'a arbre_n list) : int =
