# LIFPF: TP2 récursion sur les listes

Finir le [TP1](tp1.md) avant de commencer ce TP.

Le reste du TP consiste à travailler la récursion sur les listes.
Comme dans le TP précédent, on prendra soin:

- de **donner le type** des arguments et le type de retour de chaque fonction;
- d'écrire le commentaire de description de la fonction **avant** d'écrire la fonction.

_Remarque:_ _ajouter_ un commentaire au-dessus de la fonction n'est pas la même chose que d'écrire le commentaire _avant_ d'écrire la fonction. N'oubliez pas: vous écrivez avant tout ce commentaire pour vous aider à écrire la fonction et ensuite seulement pour la documenter.

On prendra également soin d'écrire des tests pour chaque fonction en écrivant des expressions du type `ma_fonction valeur1 valeur2 = valeur attendue;;` et en vérifiant avec l'interpréteur que ces tests s'évaluent à `true`.

## 1. Concaténations de listes

Dans cette partie on souhaite implémenter des fonctions qui vont concaténer des listes.

### 1.1 Concaténation de deux listes

Implémenter la fonction `concatene` qui prend deux `int list` et renvoie la liste constituée des éléments de la première suivis des éléments de la seconde.

Quelques exemples de tests (à compléter):

```ocaml
concatene [ 1; 2; 3 ] [ 4; 5; 6 ] = [ 1; 2; 3; 4; 5; 6 ];;
concatene [] [ 4; 5; 6 ] = [ 4; 5; 6 ];;
```

### 1.2 Concaténation (applatissement) d'une liste de liste

Implémenter la fonction `applatit` qui prend une `(int list) list` et renvoie la liste constituée de la concaténation des éléments de cette liste de liste.
Cette fonction utilisera la fonction `concatene` codée auparavant.

Quelques exemples de tests (à compléter):

```ocaml
applatit [ [ 1; 2 ]; [ 3; 4; 5 ]; []; [ 6 ] ] = [ 1; 2; 3; 4; 5; 6 ];;
applatit [ [ 1 ] ] = [ 1 ];;
```

Faire une deuxième version `applatit2` ayant la même spécification que `applatit` mais qui n'utilise **pas** `concatene`.
Tester cette fonction avec les mêmes tests que `applatit`.

## 2. Retournement de liste

On souhaite implémenter une fonction `renverse` qui renverse une liste.

L'algorithme naïf pour faire une inversion de liste consiste à inverser la queue de liste et à concaténer la tête de liste à la fin de la queue renversée.
Cet algorithme est cependant inefficace car il conduit à effectuer un nombre _quadratique_ (en fonction de la taille de la liste initiale) d'ajouts en tête de liste à cause de l'opération de concaténation.

On veut donc implémenter un algorithme plus efficace qui ne fait qu'un nombre _linéaire_ d'ajouts en tête de liste.
Pour cela on code une version modifiée `renverse_ajoute` qui prend **deux** listes en argument et renvoie la première renversée concaténée à la seconde, par exemple

```ocaml
renverse_ajoute [ 1; 2; 3 ] [ 4; 5; 6 ] = [ 3; 2; 1; 4; 5; 6]
```

On remarque que les égalités suivantes sont vraies :

```ocaml
renverse_ajoute [ 1; 2; 3 ] [ 4; 5; 6 ]
= renverse_ajoute [ 2; 3 ] [ 1; 4; 5; 6 ]
= renverse_ajoute [ 3 ] [ 2; 1; 4; 5; 6 ]
= renverse_ajoute [] [ 3; 2; 1; 4; 5; 6 ]
```

On peut aussi remarquer que `renverse` peut se coder très facilement à partir de `renverse_ajoute` puisque `renverse l = renverse_ajoute l []`.

Coder `renverse` en définissant `renverse_ajoute`.
Définir tout d'abord `renverse_ajoute` avant `renverse` et tester. Essayer ensuite d'intégrer la définition de `renverse_ajoute` à l'intérieur de celle de renverse via un `let rec renverse_ajoute ... in ...`.

## 3. Tri par insersion

On code [l'algorithme de tri par insertion](https://fr.wikipedia.org/wiki/Tri_par_insertion) qui consiste, pour chaque élément, à l'insérer à la bonne place dans le reste de la liste préalablement triée.

### 3.1 Insertion dans une liste triée

On commence donc par coder une fonction `insertion` qui insère un élément _à la bonne position_ dans une liste triée par ordre croissant.

Quelques tests à compléter:

```ocaml
insertion 3 [ 1; 2; 4; 5 ] = [ 1; 2; 3; 4; 5 ];;
insertion 3 [ 1; 2; 3; 4; 5 ] = [ 1; 2; 3; 3; 4; 5 ];;
```

### 3.2 Tri

Coder la fonction `tri_insertion` en utilisant `insertion`.

Quelques tests à compléter:

```ocaml
tri_insertion [ 1; 4; 2; 3 ] = [ 1; 2; 3; 4 ];;
tri_insertion [ 1; 2; 3; 4 ] = [ 1; 2; 3; 4 ];;
```

## 4. Recherche dans une liste d'association

On rappelle qu'une liste d'association est _une liste de paires `(clé, valeur)`_. L'opération principale sur les listes d'association est de chercher la valeur associée à une clé, si elle existe.

Dans cette question on considèrera que les clés sont de type `int` et les valeurs de type `string`.

### 4.1 Type résultat

Comme la clé n'est pas forcément présente dans la liste, on commence par créer un type somme `resultat` avec un constructeur représentant l'absence de valeur et un constructeur représentant le cas où une valeur a été trouvée.
Pour cela il faut essentiellement se poser la question des données éventuellement associées à chaque constructeur, ainsi que de leur type.

### 4.2 Fonction de recherche

Coder la fonction `cherche` qui va chercher une clé dans une liste d'association et renvoyer la valeur associée lorsqu'elle existe et utilisant le type `resultat`.

Bien penser à écrire des tests pour cette fonction.

## 5. Calculatrice en notation polonaise

On souhaite implémenter une calculatrice en notation polonaise, c'est-à-dire calculant le résultat d'expressions dans lesquelles les **opérateurs sont placés avant leur arguments**.
On donne quelques exemples dans le tableau suivant:

| Notation habituelle  | Notation polonaise |
| -------------------- | ------------------ |
| 3 \* 2               | \* 3 2             |
| 7 / 3                | / 7 3              |
| (7 / 3) + 5          | + / 7 3 5          |
| (3\*2) - ((7/3) + 5) | - \* 3 2 + / 7 3 5 |

On peut remarquer que cette notation permet de se passer de parenthèses.

Avant d'évaluer ce type d'expressions il faut pouvoir les représenter.
On va donc se munir d'un type pour représenter les opérateurs, d'un type représentant les éléments d'expression (c'est-à-dire un opérateur ou un nombre):

```ocaml
type binop = Plus | Moins | Mult | Div
type elt_expr = Op of binop | Cst of int
```

De plus l'évaluation d'une expression peut mal se passer pour deux raisons: une division par zéro ou une expression mal construite.
Par exemple `+ - 2 3` est mal construite car il manque un argument au `+`.
On va donc créer un type pour représenter un résultat ou une erreur:

```ocaml
type resultat = Ok of int | ErrDivZero | ErrExpr
```

### 5.1 Évaluation des opérations

Afin de simplifier le code de l'évaluateur, on commence par créer une fonction `eval_op` qui va évaluer le résultat d'un opérateur appliqué à des valeurs.
Comme il faut prendre en compte les erreurs de division par zéro, on renverra un `resultat` et pas un `int`. De plus comme cette fonction sera utilisée avec des arguments qui peuvent eux-même être obtenu via l'évaluation de d'autres expressions, on va prendre en argument des `resultat` et pas simplement des `int`. Si un résultat est une erreur, on renverra cette erreur au lieu d'effectuer le calcul. Ainsi le type de `eval_op` devra être `binop -> resultat -> resultat -> resultat`.

Quelques tests à compléter:

```ocaml
eval_op Plus (Ok 1) (Ok 2) = Ok 3;;
eval_op Moins (Ok 2) (Ok 3) = Ok (-1);;
eval_op Div (Ok 3) (Ok 0) = ErrDivZero;;
eval_op Div (Ok 5) ErrExpr = ErrExpr;;
```

### 5.2 Évaluation d'une suite d'expression

Une suite d'expressions est représentée par une liste d'éléments d'expression. On peut remarquer qu'une telle liste peut contenir plusieurs expressions, par exemple `+ 3 5 - 2 7`, est représentée par `[ Op Plus; Cst 3; Cst 5; Op Moins; Cst 2; Cst 7 ]` et correspond aux deux expressions écrites habituellement `3+5` et `2-7`.

On va coder une fonction `eval_expr` qui va évaluer une suite d'expressions et renvoyer une liste de résultats. Pour y arriver on peut faire les remarques suivantes:

- Il faut toujours évaluer le reste d'une suite d'expressions non vide.
- L'évaluation d'une constante est cette constante mais sous forme de résultat
- L'évaluation d'un opérateur binaire nécessite de récupérer le résultat des deux expressions suivantes, donc d'avoir déjà fait l'appel récursif pour évaluer le reste des expressions.
- Si l'appel récursif produit une liste de résultats contenant zéro ou un élément, il n'est pas possible d'évaluer un opérateur binaire. C'est le cas où l'expression est mal construite.

Quelques tests à compléter:

```ocaml
eval_expr [ Cst 3 ] = [ Ok 3 ];;
eval_expr [ Op Mult; Cst 3; Cst 2 ] = [ Ok 6 ];;
eval_expr [ Op Plus; Cst 3; Cst 5; Op Moins; Cst 2; Cst 7 ] = [ Ok 8; Ok (-5) ];;
eval_expr [ Op Plus; Op Div; Cst 7; Cst 3 ] = [ ErrExpr ];;
```
