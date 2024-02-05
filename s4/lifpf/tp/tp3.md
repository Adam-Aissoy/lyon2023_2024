# LIFPF TP3: récursion sur les arbres

**Lire complètement** chaque partie avant de la coder.

## 1. Retour sur le TP2

Finir les exercices du [TP2](tp2.md) jusqu'à 4.2 inclus.

## 2. Arbres binaires

Dans cette partie on va travailler sur les arbres binaires.

### 2.1 Quelques définitions simples

> Définir un type `arbre_bin` pour représenter les arbres binaires d'entiers (type `int`) avec un constructeur `ABVide` pour l'arbre vide et un constructeur `ABNoeud` pour les noeuds interne (qui contiendra un `int` et les deux arbres fils).
> Définir également quelques variables globales d'arbres binaires pour faciliter le test des fonctions à venir.
>
> Définir une fonction récursive `taille_ab` qui donne la taille d'un arbre binaire d'`int`, c'est-à-dire le nombre d'`int` qui y sont stockés. Tester la fonction en utilisant `assert` comme montré ci-dessous (en supposant que les variables globales `ab1` et `ab2` aient été bien définies).

```ocaml
assert (taille_ab ABVide = 0);;
assert (taille_ab ab1 = 1);;
assert (taille_ab ab2 = 2);;
```

> Définir la fonction `produit_ab` qui effectue le produit des éléments d'un arbre binaire d'`int`. On prendra la convention que le produit d'un arbre vide est 1 (expliquer pourquoi on a choisi cette valeur). Tester la fonction avec des `assert`.

### 2.2 Arbres binaires de recherche

Quelques rappels sur les arbres binaires de recherche:

- Un arbre binaire **de recherche** est un arbre binaire tel que pour tout noeud, les éléments du fils **gauche** sont tous _plus petits que l'élément du noeud_ et les éléments du fils **droit** sont _plus grand que l'élément du noeud_.
- Pour insérer un élément dans un arbre binaire de recherche on peut l'insérer récursivement à droite ou à gauche selon qu'il est plus petit ou plus grand que l'élément du noeud dans lequel on veut faire l'insersion.
- Dans un parcours _infixe_ d'un arbre binaire, on regarde d'abord les éléments du fils gauche, puis l'élément du noeud, puis les éléments du fils droit. Si on effectue un parcours infixe d'un arbre binaire de recherche, alors on visite les éléments de l'arbre **dans l'ordre croissant**.

#### 2.2.1 Insertion

> Écrire une fonction `insere_arbre_bin_recherche` qui insère une élément dans un arbre binaire de recherche. Précisez en commentaire ce qui est fait lorsque l'élément à ajouter est déjà présent dans l'arbre.

On rappelle que dans le cadre de l'UE, on ne fait **pas** de modification en place des données. Une telle insertion se fait donc forcément en _reconstruisant un nouvel arbre_ (même si certaines parties de l'ancien arbre peuvent être réutilisées).

> Tester `insere_arbre_bin_recherche` en utilisant `assert`.

#### 2.2.2 Transformation d'arbre

> Écrire une fonction `list_of_arbre_bin` qui calcule la liste contenant les éléments d'un arbre binaire. Cette liste devra correspondre à un parcours infixe de l'arbre. Ainsi, si l'arbre est _de recherche_ les entiers de la liste obtenue doivent être croissants.

On pourra utiliser la concaténation de liste du TP2 ou son équivalent dans la [bibliothèque standard OCaml](<https://v2.ocaml.org/api/Stdlib.html#VAL(@)>) pour simplifier le codage de cette fonction.
Il faudra bien réfléchir à la position de l'élément du noeud dans le résultat.

> Tester la fonction `list_of_arbre_bin` avec `assert`.

#### 2.2.3 Transformation d'arbre

> Écrire la fonction `arbre_bin_rech_of_int_list` qui transforme une liste en arbre binaire **de recherche**.

On utilisera `insere_arbre_bin_recherche` dans cette fonction.

> Tester `arbre_bin_rech_of_int_list` en utilisant `assert` et `list_of_arbre_bin` afin de simplifier l'écriture des tests.

Quelle propriété des arbres est-elle utile pour prédire le résultat de l'appel `list_of_arbre_bin (arbre_bin_rech_of_int_list l)` sur une liste `l` donnée ?

> Coder la fonction `tri_abr` qui utilise des fonctions codées dans ce TP pour trier une liste d'int. Tester cette fonction avec `assert`.

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

> Créer quelques variables globales contenant des expressions pour les tests à venir.

### 3.O Affichage d'expressions simples

> Coder la fonction `string_of_expr` qui prend en argument une expression et la transforme en une chaîne de caractères, les expressions étant notées en notation infixe et complètement parenthésées, comme par exemple `"(3 + (2 * 4))"`.
>
> Tester cette fonction en utilisant `assert` et les variables globales précédement créées.

### 3.1 Évaluation d'expressions simples

> Coder la fonction `eval_expr` qui prend en argument une expression et renvoie le résultat de son évaluation (un `int`).
>
> Tester cette fonction en utilisant `assert` et les variables globales précédement créées.

### 3.2 Division et erreurs

#### 3.2.1 Ajout de l'opérateur Div

On souhaite ajouter la division aux opérateurs possibles pour une expression. Pour cela il faut bien sûr _ajouter un constructeur_ au type `binop`.

> Modifier le type `binop` pour ajouter la division. Modifier la fonction `eval_expr` pour intégrer le cas de la division sans tenir compte des problèmes de division par zéro (pour le moment).

#### 3.2.2 Gestion de la division par zéro

La division par zéro produit une erreur.
Plutôt que de laisser l'erreur survenir lors de la division entre `int`, on va l'anticiper en gérant la possibilité qu'une expression s'évalue en une erreur et pas en un `int`.

On va donc créer un type `eval_err` pour représenter les erreurs possibles (pour le moment une seule erreur possible: la division par zéro):

```ocaml
type eval_err = DivZero
```

On créée également un type `resultat` qui est soit une erreur soit un int:

```ocaml
type resultat = Ok of int | Err of eval_err
```

> Modifier la fonction `eval_expr` pour qu'elle renvoie un `resultat` et pas un `int`.

Pour y arriver, on commencera par modifier la signature et renvoyer des valeurs contruites avec `Ok` pour les cas où il n'y a **pas** d'erreur. On réfléchira ensuite aux modfications nécessaires pour prendre en compte le fait que les appels récursifs produisent maintenant des `resultat` et pas des `int`. On utilisera le pattern matching pour distinguer les cas où l'évaluation d'une sous-expression produit une erreur des cas où elle se passe bien.

Enfin on ajoutera le test de la valeur du diviseur pour produire une erreur s'il vaut zéro.

> Modifier vos tests de la fonction `eval_expr` pour les adapter aux changements précédents. Ne pas oublier de tester la division et la division par zéro.

### 3.3 Variables

On souhaite ajouter la possibiliter d'utiliser des variables dans les expressions. On a besoin pour cela de deux choses: un cas supplémentaire dans le type des expressions pour pourvoir y faire apparaître une variable et un moyen de récupérer la valeur d'une variable lors de l'évaluation de l'expression.

Les variables sont représentées par leur nom dans les expressions:

```ocaml
type expr =
  | Cst of int
  | Binop of binop * expr * expr
  | Var of string (* nouveau constructeur dans expr *)
```

Pour représenter la valeur des variables, on va utiliser des listes d'association (comme dans le TP2). On va cependant utiliser ici les fonctions fournies par la bibliothèque standard d'OCaml.

On rappele que le type OCaml `'a option` permet de représenter une valeur (avec le constructeur `Some x` où `x` est la valeur) ou bien l'absence de valeur avec le constructeur `None`.

La fonction [`List.assoc_opt`](https://v2.ocaml.org/api/List.html#1_Associationlists) permet de chercher la valeur associée à une clé dans une liste d'association, c'est-à-dire dans une liste de paires (clé,valeur). C'est la version généralisée de la fonction `cherche` du TP2.

> Ajouter un constructeur `VarNonDef` au type `eval_err`.
>
> Modifier la fonction `eval_expr` pour qu'elle prenne un argument supplémentaire : une liste de paires `string * int` qui représentera **la valeur associée à chaque variable**. Utiliser cet argument pour gérer le cas des variables dans les expressions.

Pourquoi a-t-on ajouté le constructeur `VarNonDef` au type `eval_err` ?

> Modifier vos tests pour les ajuster aux changements précédents. Ajouter des tests pour les variables.

### 3.4 Let

On va terminer en ajouter le constructeur `Let` aux expressions, comme `let var = expr1 in expr2` de OCaml. Ce constructeur va prendre un nom de variable (`string`) et **deux** expressions. La première est l'expression à évaluer pour obtenir la valeur de la variable. La deuxième expression sera utilisée pour calculer le résultat du `Let`. Ce résultat est simplement le résultat de cette expression évaluée avec les valeurs de variables utilisées pour évaluer le `Let` auxquelles on a ajouté la valeur de la variable du `Let`.

```ocaml
type expr =
  | Cst of int
  | Binop of binop * expr * expr
  | Var of string
  | Let of string * expr * expr
```

Par exemple pour évaluer l'expression `Let ("x", Cst 3,  Binop (Plus, Cst 2, Var "x"))`, avec comme valeur de variables `[("y",42)]`, on évalue d'abord `Cst 3` avec les valeurs de variables `[("y",42)]`.
On obient alors comme résultat `Ok 3`.
On évalue alors `Binop (Plus, Cst 2, Var "x")` avec comme valeurs de variables `[("x", 3), ("y",42)]`.
On obient alors `Ok 5` qui sera le résultat de l'évaluation du `Let`.

> Apporter les modification nécessaires à la fonction `eval_expr` et ajouter les tests pour gérer le `Let`.
