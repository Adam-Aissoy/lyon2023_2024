# Programmation fonctionnelle: TP8

## Séances précédentes

Terminer les TPs précédents.

## Calculatrice programmable

On prend comme point de départ la calculatrice du [TP3](tp3.md).

On veut maintenant ajouter dans la calculatrice la possibilité de coder des fonctions.

On ajoute deux constructeurs aux expressions:

- `Fun` pour représenter la création d'une fonction (ce qui correspond à un `fun x -> exp` en en OCaml et à λx.expr en λ-calcul);
  - Ce constructeur aura deux données: le nom de la variable et l'expression correspondant au corps de la fonction.
- `App` pour représenter l'application d'une fonction
  - Ce constructeur aura également deux données: l'expression qui donnera la fonction à appeler et l'expression qui donnera l'argument à passer à cette fonction.

On modifie également le type `resultat` car un résultat peut maintenant être une fonction:

- `Ok` devient `Int`
- On ajoute un constructeur `Fermeture` qui représente une fermeture, c'est à dire une fonction et sont environnement d'exécution
  - Ce constructeur aura 3 données: le nom du paramètre, l'expression du corps de la fonction et enfin l'environnement de la fonction (représenté par une liste de paires `string * resultat`)

Il reste à mettre à jour la fonction d'évaluation des expressions.

Les environnements sont maintenant représentés, comme dans les fermetures, par les listes de paires `string * resultat`.

Il faut maintenant coder l'évaluation des nouvelles expressions.

L'évaluation d'un `Fun` consiste à créer la fermeture correspondante.
La variable et l'expression sont déjà fournies dans les données du `Fun`.
Pour l'environnement, on pourra dans un premier temps prendre tout l'environnement courant.

L'évaluation d'un `App` consiste à:

1. Évaluer l'expression qui calcule la fonction. Celle-ci doit renvoyer une fermeture (voir les erreurs plus loin)
2. Évaluer l'expression de l'argument.
3. Créer un nouvel environnement constitué de l'environnement de la fermeture auquel on ajoute la paire (x,v) où x est le nom du paramètre de la fermeture et v est la valeur calculée pour l'argument.
4. Évaluer le corps de la fonction dans ce nouvel environnement

**Erreurs:** si un appel récursif à une évaluation produit une erreur, on renverra cette erreur.
Si l'évaluation d'une expression calculant une fonction (_c.-à-d._ la première expression d'un `App`) produit un `Int`, on renverra une nouvelle erreur `PasUneFonction` (à ajouter au type `eval_err`).
Si une `Fermeture` est passée en argument à un opérateur binaire, renvoyer une nouvelle erreur `PasUnInt`.

**Pour aller plus loin:** maintenant que l'on dispose d'une construction pour appliquer des fonctions, les opérateurs binaires pourraient être recodés comme des des fonctions _natives_.
Une fonction native peut être représentée par une fonction OCaml qui prend un résultat en argument et renvoie un nouveau résultat.
Si on veut coder une fonction à deux arguments, il suffit de la curryfier, c'est-à-dire que le `resultat` renvoyé par la fonction OCaml associée est à nouveau une fonction native qui prendra le deuxième argument qui renverra le résultat final.
Ajouter un constructeur `Native` dans le type `resultat` et modifier la fonction d'évaluation en traitant le cas de `Native` similairement au cas `Fermeture`, sauf pour `App`.
Pour ce dernier cas, on évaluera simplement l'argument puis on appelera la fonction OCaml donnée dans `Native` pour obtenir le résultat.
Enfin on écrira des fonctions natives pour les 4 opérateurs binaires et on créera un environnement initial associant à chaque symbole binaire sa fonction native.
Dans les tests, on remplacera l'utilisation de Binop par des `App` avec comme fonction la variable ayant le symbole binaire concerné, par exemple: `(App(App(Var "+", Cst 2), Cst 3))` permet de représenter `2 + 3`.
