## Variables

```ocaml

let x_g = 3;;

let x = 2 in 3 + x * x;;

let x = 5 in
let y = x + 2 in
x * y;;

let x =
    let y = 3
    in y * y
in x + 10;;

```

## Appels de fonction

```ocaml
not false;;

log 10.0;;

abs (int_of_string "-3");;

hypot 3.0 4.0;;

hypot (2.5 +. 0.5) (2.0 *. 2.0);;

hypot 2.0 1.5 *. 2.0 ;;

hypot 2.0 (1.5 *. 2.0) ;;
```

## Définitions de fonction

```ocaml
let carre (x:int): int = x * x;;

let carre2 x = x * x;;

let cube x = x * x * x
in cube 2;;

let cube (x:int): int =
    let carre3 y = y * y
    in carre3 x * x;;
cube 4;;
carre3;;
```

## Énumérations

```ocaml
type jour =
   | Lundi
   | Mardi
   | Mercredi
   | Jeudi
   | Vendredi
   | Samedi
   | Dimanche
;;

Lundi;;

Mercredi;;

Lundi = Mercredi;;

Lundi < Mercredi;;

```

## Filtrage

```ocaml
match Lundi with
| Mardi -> 2
| Mercredi -> 3
| Lundi -> 1
| Vendredi -> 5
| Dimanche -> 7
| Samedi -> 6
| Jeudi -> 4
;;

match Lundi with
| Mardi -> 2
| Mercredi -> 3
| Lundi -> 1
| Vendredi -> 5
| Dimanche -> 7
| Samedi -> 6
(* | Jeudi -> 4 *)
;;

let weekend (j: jour): bool =
    match j with
    | Samedi -> true
    | Dimanche -> true
    | autre -> false
;;

let weekend (j: jour): bool =
    match j with
    | Samedi -> true
    | Dimanche -> true
    | _ -> false
;;
```

## Nuplet

```ocaml
match (3.5, "coucou") with
| (_, s) -> s^" tout le monde"
;;
```

## Filtrage sur types de base

```ocaml
let is_zero (n: int): bool =
match n with
| 0 -> true
| _ -> false
;;

is_zero 1;;

is_zero 0;;
```

## Types sommes avec données

```ocaml
type nombre =
  | Int of int
  | Float of float
  | Cplx of float * float
  | Nan
;;

Int 3;;

Cplx (3.0, 7.2);;

let int_of_nombre (n: nombre): int =
    match n with
    | Int i -> i
    | Float f -> int_of_float f
    | Cplx (r,_) -> int_of_float r
    | Nan -> 0
;;

int_of_nombre (Cplx (3.0, 7.2));;
```

## Pattern matching en profondeur

```ocaml
let is_zero (n: nombre): bool =
    match n with
    | Int 0 -> true
    | Float 0.0 -> true
    | Cplx (0.0, 0.0) -> true
    | _ -> false
;;
```

## Rappel récursivité

```ocaml
(**
Fonction qui calcule la somme des carrés des n premiers entiers
@param n le nombre d'entiers
@return la somme
*)
let rec somme_carres (n: int): int =
    if n <= 0
    then 0
    else n * n +  somme_carres (n-1);;
```

## Listes

```ocaml
let l1 = 1 :: 3 :: 5 ::[] ;;
let l2 = [ 1; 3; 5 ];;
l1 = l2;;

type resultat = Aucun | Int of int;;

(**
Cette fonction donne le maximum d'un liste d'int
@param l la liste dont on veut le max
@return le max ou Aucun si la liste est vide
*)
let rec maximum (l: int list): resultat =
    match l with
    | [] -> Aucun
    | x :: [] -> Int x
    | x :: l2 ->
        match maximum l2 with
        | Aucun -> Int x
        | Int y -> if x > y
                   then Int x
                   else Int y
;;

maximum [ 2; 1; 5; 3 ];;
maximum [ 2 ];;
maximum [];;

(**
Calcule le maximum dans une liste de liste d'int
@param ll la liste de liste
@return le max ou Aucun s'il n'y a pas d'int dans ll
*)
let rec maximum2 (ll: int list list): resultat =
    match ll with
    | [] -> Aucun
    | l :: [] -> maximum l
    | l :: ll2 ->
        let ml = maximum l in
        let mll2 = maximum2 ll2 in
        match ml, mll2 with
        | Aucun, m -> m
        | m, Aucun -> m
        | Int m1, Int m2 ->
            if m1 < m2
            then Int m2
            else Int m1
;;

maximum2 [ [2; 3]; [4; 1]; [1; 6; 8]];;
maximum2 [ []; [1]; [0; 0]];;
maximum2 [ []; [] ];;
maximum2 [];;
```
