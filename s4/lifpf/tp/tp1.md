# TP1: Découverte du langage OCaml

## 0. Environnement de travail

Les TPs s'effectueront sous Linux.

Vérifier que `ocaml` est disponible.

Configurer votre environnement selon le fichier [CONFIGURATION.md](../CONFIGURATION.md).

Vérifier que l'extension "OCaml Platform" est installée dans VSCode, l'installer si besoin.

Créer un fichier `tp1.ml`, ouvrir ce fichier avec Visual Studio Code.
Le plugin OCaml permet d'exécuter un code sélectionné avec les touches `[Shift] + [Enter]`.

## 1. Premiers pas avec l'interpréteur

Lancer l'interpréteur `ocaml` avec la commande

```bash
utop
```

ou simplement

```bash
ocaml
```

si `utop` n'est pas installé.

### 1.1. Types de base

On va commencer par utiliser l'interpréteur comme une calculatrice avancée.
Dans l'interpréteur, les expressions à calculer **doivent** se terminer par `;;`.

> Saisir quelques opérations sur les entiers, par exemple:
>
> ```ocaml
> 3*2+5/2;;
> ```

On remarque qu'en plus du résultat, l'interpréteur nous indique son type, ici `int`.

On peut également faire des opérations sur des nombres flottants, mais il faut
ajouter aux opérateur un `.`. Par exemple, pour OCaml `+` ne fonctionne que pour
les `int` et c'est `+.` qu'il faut utiliser pour additioner des `float`.

> Saisir quelques opérations arithmétiques sur des `float`.

OCaml possède également un type `string` (délimitées par des doubles quotes, par exemple `"abcd"`). On peut concaténer des chaînes avec l'opérateur `^`).

> Saisir quelques chaînes de caractères assemblées par concaténation.

Il est évidement possible d'utiliser les booléens en OCaml. Les constantes sont `true` et `false` et les opérateurs sont `&&` et `||`.

> Écrire une ou deux expressions booléennes dans l'interpréteur. Indiquer qui de `||` ou `&&` est prioritaire (c.-à-d. où sont les parenthèses dans une expression comme `a || b && c`)

Les opérateurs de comparaison s'écrivent `=` (attention il y a bien un seul signe `=`), `!=`, `>`, `<`, `>=`, `<=`. Ils permettent de comparer des valeurs de même type.

> Expliquer la différence de comportement entre ces deux expressions:
>
> ```ocaml
> 3 < 2;;
> ```
>
> et
>
> ```ocaml
> 3 < 2.0;;
> ```

### 1.2. Appels de fonction

En OCaml, les appels de fonctions sont sous la forme `f a1 a2 a3` où `f` est la
fonction et `a1`, `a2` et `a3` sont les arguments (les paramètres effectifs)
passés à la fonction. Cette syntaxe ressemble à celle d'une commande invoquée
avec des arguments dans un shell Unix. Elle peut également rappeler la syntaxe
d'appel des fonctions en Scheme, mais sans les parenthèses. Il sera cependant
parfois nécessaire de placer des parenthèses autour d'un argument si celui-ci
est lui-même un appel de fonction, par exemple dans l'expression `f (f2 a1) a2 a3`,
le premier argument `f2 a1` est placé entre parenthèses.

La fonction `float_of_int` permet de transformer un `int` en `float`.

> Dans l'interpréteur, appeler la fonction `float_of_int` en lui passant un `int` en argument.
> Essayer ensuite avec un `float` et expliquer ce qui c'est passé.
>
> Entrer l'expression `int_of_float ;;` dans l'interpréteur.
> Celui-ci affiche alors le type de la fonction.

Les opérateurs des expression arithmétiques sont moins prioritaires que les appels de fonction.
Par exemple `int_of_float 3.5 + 2` doit être lu comme `(int_of_float 3.5) + 2`.

> Écrire une expression combinant des opérateurs arithmétiques et ces deux fonctions.

La négation dans les booléens n'est pas un opérateur, mais simplement la fonction `not`.

> Expliquer le résultat de l'évaluation de `not false && false` en ajoutant les parenthèses implicites au bon endroit.

Remarque : les opérateurs en OCaml sont **aussi** des fonctions. En ajoutant des parenthèses directement autour d'un opérateur, il sera vu comme une fonction, par exemple on peut écrire `(&&) true false` au lieu de `true && false`.

> Récrire l'expression suivante en utilisant les opérateurs comme des fonctions:
>
> ```ocaml
> 2 < 3 && "b" < "ab"
> ```

### 1.3. Variables

Pour rappel, la syntaxe des définitions de variables est :

```ocaml
let ma_variable = sa_valeur in expression_qui_utilise_ma_variable
```

par exemple, saisir dans l'interpréteur:

```ocaml
let x1 = 3.5 +. float_of_int 2
in x1 +. 3.0;;
```

La construction `let ... in ...` est elle-même une expression et peut donc être utilisée dans d'autres expressions, y compris d'autres `let ... in ...`.
Cela permet en particulier de définir plusieurs variables à la suite :

```ocaml
let x1 = 3.5 +. float_of_int 2 in
let x2 = x1 *. x1 in
x2 *. 2.0 ;;
```

### 1.4 Conditionnelle

La conditionnelle `if ... then ... else ...` est une **expression** et pas une _instruction_ en OCaml, c'est-à-dire qu'elle a un résultat.

> **Prédire** puis vérifier le résultat de l'expression suivante:
>
> ```ocaml
> (if true then 3 else 5) > 4
> ```

## 2. Définition de fonctions

La construction `let` _sans_ le `in` permet de définir des variables _globales_.
On peut l'utiliser pour définir des fonctions comme suit:

```ocaml
let f a1 a2 a3 = valeur_de_retour;;
```

Par exemple une fonction `f` définie en $\lambda$-calcul par $\lambda x.(x+1)$ peut se définir en ocaml par:

```ocaml
let f x = x + 1;;
```

> Définir cette fonction dans `tp1.ml` puis l'utiliser dans une expression.
>
> Définir une fonction `discriminant` qui prend les trois coefficients `float` d'un trinôme $ax^2+bx+c$ et en calcule le discriminant ($b^2-4ac$).
>
> Quel est le type affiché par OCaml à la définition de cette fonction ?

Il est possible d'imposer les types des arguments avec la syntaxe suivante :

```ocaml
let f (a1:t1) (a2:t2): type_retour = valeur_de_retour;;
```

> Récrire la fonction `discriminant` en forçant le type des arguments à être des `float`.
> Tester que cette nouvelle définition marche dans l'interpréteur par exemple avec 2.0 8.0 et 8.0 comme valeurs de a, b et c.

Récrire une deuxième fois cette fonction en changeant le type de `a` en `int` sans changer le reste de la fonction. Expliquer l'erreur produite par l'interpréteur.

> Dans la suite de ce TP et dans les TPs suivants, on prendra soin de **toujours indiquer le type des fonctions** définies globalement.

OCaml est muni d'un outil, `ocamldoc`, qui permet de générer de la documentation à partir de commentaires spéciaux.

Voici une exemple de documentation à placer juste avant la définition de discriminant:

```ocaml
(**
[discriminant a b c] calcule le discriminant d'un trinôme.
Cette fonction est utile pour trouver les racines d'un trinôme.
@param a le coefficient d'ordre 2
@param b le coefficient d'ordre 1
@param c le coefficient d'ordre 0
@return le discriminant
*)
```

**Dans la suite de ce TP et pour les autres TP**, on écrira _toujours_ un commentaire spécial avant la définition d'une fonction définie globalement. Et on écrira toujours ce **commentaire avant de commencer à coder** la fonction.

## 3. Types somme

### 3.1 Définitions de types somme

Les types somme en OCaml sont des types dont les valeurs peuvent être construites de différentes manières.
L'exemple suivant illustre la syntaxe de définition de ces types :

```ocaml
type couleur = Rouge | Jaune | Bleu;;
```

Ici on définit un type `couleur` avec trois valeurs possibles (`Rouge`, `Jaune` et `Bleu`).

> Entrer les expressions suivantes dans l'interpréteur et expliquer ce qu'il affiche:
>
> ```ocaml
> Rouge;;
> Rouge = Rouge;;
> Rouge != Bleu;;
> Bleu > Jaune;;
> ```

`Rouge`, `Jaune` et `Bleu` sont appelés les _constructeurs_ du type `couleur`.

> Ajouter les couleurs Violet, Orange et Vert aux couleurs possibles en redéfinissant le type couleur.

Il est possible d'avoir des valeur plus riches en leur associant une ou plusieurs valeurs d'autres types. Par exemple on peut écrire la définition suivante:

```ocaml
type mes_valeurs =
  UnInt of int
| DeuxInt of int * int
| UneChaine of string
;;
```

Les constructeurs prennent ici des arguments, par exemple on peut fabriquer des valeurs de type `mes_valeurs` comme suit:

```ocaml
UnInt 3;;
UneChaine "toto";;
DeuxInt (3,4);;
```

> Ajouter un constructeur supplémentaire `RJB` au type couleur. Ce constructeur devra prendre 3 `int` en argument.

Remarque: quand on passe plusieurs arguments à un constructeur, ils sont passés sous forme de n-uplet (une paire pour `DeuxInt` et un triplet pour `RJB`). Les n-uplets sont prédéfinis en OCaml et possèdent leur propre type dont la syntaxe est `*`

> En utilisant l'interpréteur, indiquer quel est le type de `(3, 5.6)`. Quelle est la différence avec `(3, 5, 6)` ?

### 3.2 Pattern matching

OCaml possède la construction `match ... with ...` qui permet de décider de l'expression à évaluer en fonction de la valeur de l'expression indiquée dans le `match`. Par exemple:

```ocaml
match c with
| Rouge -> "rouge"
| Bleu -> "bleu"
| Jaune -> "jaune"
| _ -> "mélange"
```

s'évalue en `"rouge"` si `c` contient `Rouge` ou encore sur `"mélange"` si `c` n'est ni `Rouge`, ni `Jaune`, ni `Bleu`.

> Définir une fonction `nom_couleur` qui donne le nom d'une couleur sous forme de `string` si c'est une des 6 couleurs nommées ou la chaîne "mélange" par défaut, c'est-à-dire si la couleur est définie par le constructeur `RJB`.
>
> Réécrire la fonction `nom_couleur` en supprimant le dernier cas associé à la valeur "mélange", quelle erreur survient ?
>
> Faire une nouvelle version en plaçant le cas `_` en premier, quel avertissement l'interpréteur affiche-t-il ? Que peut-on en déduire sur l'ordre des cas dans un `match` ?

Dans le cas d'un constructeur avec des arguments, il est souvent utile de pouvoir récupérer la valeur de ceux-ci dans le pattern matching.

Par exemple on peut définir la fonction suivante qui donne le "niveau de rouge" d'une couleur (entre 0 et 255):

```ocaml
let niveau_rouge c =
    match c with
    | Rouge -> 255
    | Orange -> 255
    | Violet -> 255
    | RJB (r,j,b) -> r
    | _ ->  0;;
```

Ici, dans le cas où la couleur est définie via `RJB` la valeur dur premier argument est placée dans une variable `r` qui est réutilisée dans le résultat.

Le pattern matching peut aussi s'utiliser avec les types prédéfinis comme `int`, `string`, etc.

On veut implémenter un générateur pour les paroles de la chanson [99 bottles of beer](https://www.99-bottles-of-beer.net/lyrics.html). Pour cela on va commencer par générer un paragraphe en fonction du nombre de bouteilles de bières disponible. Regarder les paroles disponibles depuis la page de la chanson, en particulier les différences entre les 4 derniers paragraphes.

> Écrire une fonction `paragraphe_bottles` qui prend en argument un `int` et
> renvoie le paragraphe commençant par ce nombre de bouteilles. On aura besoin
> de la concaténation de `string` notée `^` et de la conversion d'`int` en
> `string`, notée `string_of_int`. `"\n"` permet de créer une nouvelle ligne. On
> utilisera `match` pour distinguer les cas 0, 1 ou 2 bouteilles du cas général
> à _n_ bouteilles.

## 4. Récursivité

Dans le cas de fonctions récursives, il faut ajouter le mot clé `rec` après le `let`:

```ocaml
(**
Renvoie la somme des n premiers entiers
@param n le nombre d'entiers à sommer
@return la somme
*)
let rec sum_n (n:int): int =
  if n <= 0
  then 0
  else n + sum_n (n-1);;
```

> Écrire une fonction `factorielle` qui calcule le produit des entiers entre 1 et _n_.

## 5. Listes

OCaml possède une structure de liste prédéfinie. La liste vide d'écrit `[]` et
l'ajout en tête de liste est réalisé par l'opérateur `::`. Cet opérateur est
associatif à droite et il est également possible d'utiliser la notation `[ x1; x2; ... ]`
(attention au `;` et pas `,`) pour représenter la liste contenant les élements
x1, x2, etc. Ainsi la liste contenant les `int` `1`, `2`, `3`, `5`, `7` peut
s'écrire de différentes manières comme par exemple:

```ocaml
1 :: (2 :: (3 :: (5 :: (7 :: []))))
1 :: 2 :: 3 :: 5 :: 7 :: []
[1; 2; 3; 5; 7]
```

Par ailleurs les listes OCaml doivent contenir des élements qui sont tous du même type.
Une liste contenant des `int` aura ainsi le type `int list`, une liste de `string` aura le type `string list`

> Expliquer l'erreur produite par l'expression `"2" :: 3 :: []`

Le pattern matching fonctionne sur les listes avec les notation introduites
ci-dessus. On peut par exemple écrire une fonction récursive pour calculer le
nombre d'éléments d'une liste d'`int`:

```ocaml
(**
Cette fonction calcule la longueur d'une liste de `string`.
@param l la liste dont on veut la longueur
@return la longueur de l
*)
let rec longueur (l: string list): int =
  match l with
  | [] -> 0
  | _ :: l2 -> 1 + longueur l2
  ;;
```

> Expliquer pourquoi on a indiqué `_` au lieu d'une variable dans le deuxième cas du `match`.
>
> Écrire une fonction `sum_f` qui fait la somme des éléments d'une `float list`.

Il peut parfois être utile dans un `match` sur une liste pour faire un cas
particulier avec des liste de taille 1, 2, etc.

> Utiliser la possibilité de faire un `match` avec un cas pour les listes de
> taille 1 (en plus du cas liste vide et du cas liste de taille >= 2) pour
> écrire une fonction `join_s` qui prend en argument un séparateur (de type
> `string`) et une liste de `string` et renvoie les éléments de la liste
> concaténés les un aux autres, mais en insérant le séparateur entre deux
> éléments. Attention, le séparateur ne doit pas apparaître avant le premier
> élément, ni après le dernier.

On peut aussi utiliser une fonction récursive pour fabriquer une liste

> Écrire une fonction `liste_n_0` qui prend en argument un `int` `n` et renvoie
> la liste contenant les `int` décroissants de `n` à `0` inclus.

On peut bien sûr faire les deux à la fois dans une même fonction: décomposer une
valeur de liste par cas avec un `match` et fabriquer une liste comme résultat.

> Écrire une fonction `bottles_of_list` qui prend une liste d'`int` et renvoie
> la liste composée des paragraphes de la chanson _99 bottles of beer_
> correspondant à chacun des éléments de la liste passée en paramètre. On pourra
> bien entedu réutiliser la fonction `paragraphe_bottles`.
>
> Créer une variable globale `chanson_99_bottles` dont la valeur est les paroles
> complètes de la chanson _99 bottles of beer_. On séparera chaque paragraphe du
> suivant avec "\n\n". Vérifier que la variable a la bonne valeur en l'affichant
> avec `print_endline chanson_99_bottles;;` .
