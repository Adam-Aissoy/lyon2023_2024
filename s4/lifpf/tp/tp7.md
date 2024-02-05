# TP7 - Applications OCaml

> **Attention sur les machines de TP** les projets `dune` ne fonctionne pas bien
> dans les répertoires utilisateurs sur les machines de TP. Il faut donc
> travailler dans un répertoire local de la machine. Utilisez `/tmp/p123456789`
> comme répertoire de travail, où `p123456789` est votre login étudiant.
>
> Il est préférable de travailler avec un projet forge (voir [rappels gitlab](../gitlab.md))

**Remarque** `dune` créée un répertoire `_build` qu'il ne faut pas versionner. Pour éviter de le versionner créer à la racine du répertoire cloné un fichier `.gitignore` (attention au `.`) avec la ligne suivante (ajouter la ligne au fichier s'il existe déjà):

```gitignore
_build
```

## 0. Compléments API OCaml

### 0.1. Entrées sorties en OCaml

En OCaml, il existe deux types permettant de lire et d'écrire dans des fichiers, sur les entrées/sorties standard, sur une socket réseau, etc:

- `in_channel`: ce type représente des objets (des canaux) à partir desquels on peut lire des octets
- `out_channel`: ce type représente des objets (des canaux) dans lesquels on peut écrire des octets

Comme dans beaucoup de langages, les entrées / sorties standard et erreur sont prédéfinies dans le module `Stdlib` (qui est ouvert automatiquement dans chaque fichier):

- `stdin: in_channel`: entrée standard
- `stdout: out_channel`: sortie standard
- `stderr: out_channel`: sortie erreur

Pour lire dans un fichier, on utilise `open_in: string -> in_channel` qui fourni un `in_channel` qui lira les octets dans le fichier. Pour écrire, on utilisera `open_out: string -> out_channel`.

Pour lire dans un canal d'entrée, on peut utiliser `input_line: in_channel -> string` pour lire une ligne.
Remarque: si la fin du fichier est atteinte OCaml génère une exception.
Cette notion n'ayant pas été vue en cours, les fonctions de lecture du contenu intégral d'un fichier seront fournies si le besoin s'en fait sentir.

Pour écrire concrètement dans un canal de sortie, on peut par exemple utiliser `output_string: out_channel -> string -> unit`. Comme cette fonction ne calcule pas de valeur, elle renvoie une valeur spéciale `()` de type `unit`. `()` est la seule valeur de ce type. Ce type représente les actions en OCaml. C'est un peu l'équivalent du type `void` de C.

Enfin une fois les traitements terminés sur un fichier, il faut le fermer via `close_in: in_channel -> unit` ou `close_out: out_channel -> unit`.

**[Documentation](https://v2.ocaml.org/releases/4.14/api/Stdlib.html#1_Inputoutput)** des entrées/sorties de base en OCaml.

## 1. Application usine de jouets

### 1.1. Reprise de l'usine de jouets

> Terminer la partie 2. du [TP5](tp5.md) sur l'usine de lutins.

### 1.2. Gestion de données JSON

Dans le fichier `lib/dune`, ajouter la bibliothèque `yojson`, en ajoutant au besoin une section `libraries` après `name`:

```ocaml
(library
 (name lutins)
 (libraries yojson))
```

La bibliothèque `yojson` permet de lire des fichiers au format [JSON](https://fr.wikipedia.org/wiki/JavaScript_Object_Notation).
Ci-dessous un exemple de fichier JSON:

```json
{
  "lutins": [
    "Harcèlemoutons",
    "Ravineur",
    "Courtaud",
    "Lèchecuillère",
    "Grattepot",
    "Lèchebol",
    "Claqueporte",
    "Gobeyahourt",
    "Chipesaucisse",
    "Zieutefenêtre",
    "Renifleporte",
    "Crocheviande",
    "Volebougie"
  ],
  "jouets": [
    "toupie",
    "osselets",
    "ballon",
    "nounours",
    "robot",
    "poupée",
    "cubes"
  ],
  "jours": {
    "lundi": { "attribution": "longueur_nom", "nombre": "toujours_42" },
    "mardi": { "attribution": "premiere_lettre", "nombre": "carre_nom" },
    "mercredi": { "attribution": "longueur_nom", "nombre": "diff_nom" },
    "jeudi": { "attribution": "premiere_lettre", "nombre": "toujours_42" },
    "vendredi": { "attribution": "longueur_nom", "nombre": "carre_nom" },
    "samedi": { "attribution": "premiere_lettre", "nombre": "diff_nom" },
    "dimanche": { "attribution": "longueur_nom", "nombre": "toujours_42" }
  }
}
```

Les fichiers JSON permettent de représenter des structures imbriquées arbitrairement.
Une fois lues depuis le fichier cette structure est représentée par un type inductif, [`Yojson.Basic.t`](https://ocaml-community.github.io/yojson/yojson/Yojson/Basic/index.html):

```ocaml
type t =
| `Null
| `Bool of bool
| `Int of int
| `Float of float
| `String of string
| `Assoc of (string * t) list
| `List of t list
```

Attention à la syntaxe avec les quotes inversées `` `   `` devant les constructueurs.
`Yojson` utilise des constructeurs particuliers qui sont distingués via cette syntaxe.
En pratique et dans le cadre de ce programme, on pourra les utiliser comme des constructeurs habituels, mais les messages d'erreurs seront un peu différents.
Il sera ici particulièrement important de **bien spécifier les types des fonctions** qui vont manipuler ces structures.

L'exemple de fichier ci-dessus produira uniquement des structures utilisant les 3 constructeurs suivants:

- `` `String`` pour les valeurs textuelles comme par exemple `"Harcèlemoutons"` qui sera représenté par la structure `` `String "Harcèlemoutons"``
- `` `List`` pour les listes de valeurs comme `[ "toupie", "osselets"]` qui sera représentée par la structure: `` `List [ `String "toupie"; `String "osselets"]``
- `` `Assoc`` pour les dictionnaires clé-valeur comme `{ "attribution": "longueur_nom", "nombre": "toujours_42" }` qui sera représentée par la structure: `` `Assoc [("attribution", `String "longueur_nom"); ("nombre", `String "toujours_42")]``.

Une `` `List`` ou une `` `Assoc`` peuvent contenir des éléments plus complexe que des `` `String``.
Par exemple la version simplifiée du fichier précédent:

```json
{
  "lutins": ["Harcèlemoutons", "Ravineur"],
  "jouets": ["toupie", "osselets"],
  "jours": {
    "lundi": { "attribution": "longueur_nom", "nombre": "toujours_42" },
    "mardi": { "attribution": "premiere_lettre", "nombre": "carre_nom" }
  }
}
```

sera représentée par la structure suivante:

```ocaml
`Assoc [
    ("lutins", `List [ `String "Harcèlemoutons"; `String "Ravineur" ]);
    ("jouets", `List [ `String "toupie"; `String "osselets"]);
    ("jours", `Assoc [
        ("lundi", `Assoc [("attribution", `String "longueur_nom");
                          ("nombre", `String "toujours_42")]);
        ("mardi", `Assoc [("attribution", `String "premiere_lettre");
                          ("nombre", `String "carre_nom")])
    ])
]
```

Dans le module `Usine` ajouter une fonction `get_lutins: Yojson.Basic.t -> string list` qui renverra la liste des lutins à partir d'une structure issue d'un fichier similaire au fichier exemple ci-dessus. Il faudra donc aller chercher la liste dans l'entrée "lutins" et traduire la liste de `` `String``.

Faire de même pour les jouets avec une fonction `get_jouets: Yojson.Basic.t -> string list`. Essayez de mutualiser du code entre ces deux fonctions en créant une ou plusieurs fonctions intermédiaires.

Tester ces deux fonctions via `assert` en utilisant l'exemple de structure ci-dessus.

### 1.3. Configuration de l'usine à partir du fichier json

On souhaite maintenant créer l'association contenant la configuration par jour à partir du contenu d'un fichier JSON structuré comme le fichier exemple précédent.
Dans le fichier exemple, chaque jour de la semaine se voit associé deux chaînes de caractères:

- la chaîne correspondant à la clé `attribution` va permettre de désigner la fonction à utiliser pour choisir le jouet qui sera fabriqué par un lutin;
- la chaîne correspondant à la clé `nombre` va permettre de désigner la fonction à utiliser pour, étant donné un lutin et un jouet, savoir combien d'exemplaires du jouet le lutin va fabriquer.

Commencer par créer un module `FonctionsUsine` contenant les fonctions suivantes:

- `longueur_nom (jouets: string list) (lutin: string): string option` qui renverra le `i`<sup>ème</sup> jouet de la liste `jouets` si la longueur du (nom du) lutin est `i` (c.f. [String.length](https://v2.ocaml.org/releases/4.14/api/String.html#VALlength)). On travaillera modulo la longueur de la liste de jouets pour gérer les noms de lutins trop longs.
- `premiere_lettre` fonctionne comme la précédente, mais en utilisant pour `i` le code ASCII de la premère lettre du nom du lutin (c.f. [Char.code](https://v2.ocaml.org/releases/4.14/api/Char.html#VALcode) et [String.get](https://v2.ocaml.org/releases/4.14/api/String.html#VALget)).
- `toujours_42: string -> string -> int option` renverra toujours `Some 42`.
- `carre_nom: string -> string -> int option` reverra la somme des carrés des longueurs des chaînes passées en argument.
- `diff_nom: string -> string -> int option` renverra la taille de la différence symétrique des ensembles de lettres de chaînes passées en argument. Autrement dit, elle renvoie le nombre de caractères apparaissant dans la première chaîne mais pas dans la deuxième additionné au nombre de caractères apparaissant dans la deuxième mais pas dans la première.

Dans `usine.ml`, créer une fonction `fonctions_choix_jouets (jouets: string list): (string * (string -> string option)) list` qui prend en argument une liste de jouets et créer la liste d'association contenant les paires `("premiere_lettre", FonctionsUsine.premiere_lettre jouets)` et `("longueur_nom", FonctionsUsine.longueur_nom jouets)`.
On remarque l'application partielle des fonctions `FonctionsUsine.premiere_lettre` et `FonctionsUsine.longueur_nom` pour obtenir des fonctions de type `string -> string option` que l'on pourra placer dans une `configuration`.

Réaliser un travail similaire pour créer une liste d'association pour obtenir les fonctions permettant d'obtenir le nombre de jouets fabriqués par un lutin pour un modèle de jouet.

Créer enfin une fonction `configurations_of_json: Yojson.Basic.t -> ((jour, configuration) Association.assoc_t) option` qui prendra une structure JSON similaire au fichier exemple et construira une structure similaire à la variable globale contenant les configurations de chaque jour (normalement de type `(jour, configuration) Association.assoc_t`). La fonction reverra en fait une `option` qui vaudra `None` si la structure JSON contient des valeurs inconnues pour le nom des fonctions ou s'il y manque des informations (par exemple si elle ne contient pas de jouets).

Pour terminer, dans le module `LutinsApp`, modifier le code de façon à:

- prendre un argument supplémentaire en ligne de commande (le nom du fichier JSON à lire);
- lire le contenu du fichier via la fonction `Yojson.Basic.from_channel: in_channel -> Yojson.Basic.t` (le `in_channel` étant lui-même obtenu via `open_in` comme expliqué au début du TP);
- utiliser la structure obtenue pour fabriquer les listes de lutins et de jouets, créer la configurations des jours et enfin calculer la quantité produite pour chaque jouet en fonction du jour indiqué comme autre argument en ligne de commande.
