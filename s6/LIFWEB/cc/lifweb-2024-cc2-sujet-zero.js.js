/* eslint-disable unicorn/no-unreadable-iife */
/* eslint-disable no-unused-vars */

/*
    LIFWEB 2024 -- CC2 TP noté
    SUJET ZÉRO

    Compléter les exercices demandés en 60 minutes (hors tiers-temps).
    Déposer dans la cellule correspondante de Tomuss le fichier JS complété et UNIQUEMENT ce fichier.

    Les rendus par mail ne seront PAS pris en compte.
    Un fichier qui ne se charge pas correctement ne sera PAS pris en compte.

    Tous les documents et l'accès à internet sont autorisés : votre code, les corrections, MDN, stack-overflow, etc.
    Vous pouvez utiliser votre ordinateur personnel ou les ordinateurs de la salle de TP.

    Toute communication entre humains est INTERDITE.
    Les IAs/LLMs (ChatGPT, GitHub Copilot, etc.) sont INTERDITS.
    Si vous utilisez Copilot ou un outil similaire dans votre IDE, DÉSACTIVEZ-LE.
*/

// On donne la "base de données" suivante

const database = [
  { city: "CUSHMAN", pop: 36_963, state: "MA" },
  { city: "BARRE", pop: 4546, state: "MA" },
  { city: "CHICOPEE", pop: 31_495, state: "MA" },
  { city: "WESTOVER AFB", pop: 1764, state: "MA" },
  { city: "BELLFLOWER", pop: 702, state: "IL" },
  { city: "CARLOCK", pop: 1066, state: "IL" },
  { city: "CHENOA", pop: 2898, state: "IL" },
  { city: "CLINTON", pop: 10_043, state: "IL" },
  { city: "COLFAX", pop: 1391, state: "IL" },
  { city: "CONGERVILLE", pop: 802, state: "IL" },
  { city: "COOKSVILLE", pop: 478, state: "IL" },
  { city: "DECATUR", pop: 9323, state: "TX" },
  { city: "ERA", pop: 264, state: "TX" },
  { city: "FORESTBURG", pop: 805, state: "TX" },
  { city: "LAKE KIOWA", pop: 24_108, state: "TX" },
  { city: "GORDONVILLE", pop: 1664, state: "TX" },
];

// Exercice 1
//
// Compléter la fonction suivante qui calcule la population totale
// de l'Illinois (state: "IL").
//
// Pour avoir la totalité des points, l'écrire de la façon la plus
// concise et fonctionnelle possible.
//
// La moitié des points est attribuée pour une solution correcte mais
// qui utilise des variables mutables ou des boucles.

const totalPopulationIL = (data) => 0; /* TODO #1*/

console.assert(totalPopulationIL(database) === 17_380);

// Exercice 2
//
// Compléter la fonction suivante pour qu'elle génère des élements <option>
// contenant la liste des états présents dans la base de données passée en paramètre.
//
// La fonction doit retourner un DocumentFragment qui sera ajouté au <select> dans le DOM dans l'exercice 4.
//
// S'assurer que les <option> sont triés par ordre alphabétique.
//
// Pour éliminer les doublons, on peut utiliser un Set.
// https://stackoverflow.com/questions/9229645/remove-duplicate-values-from-js-array

function generateSelect(data) {
  /* TODO #2 */
  return document.createDocumentFragment();
}

// pour tester
const testDiv = document.createElement("div");
testDiv.append(generateSelect(database));
console.log(testDiv.innerHTML);
// doit afficher quelque chose comme
// <option value="IL">IL</option><option value="MA">MA</option><option value="TX">TX</option>

// Exercice 3
//
// Le contenu de la base de données est disponible dans le fichier suivant :
// http://lifweb.pages.univ-lyon1.fr/Annales/CC2/lifweb-2024-cc2-sujet-zero.json
//
// Une base de page web est disponible dans le fichier suivant :
// http://lifweb.pages.univ-lyon1.fr/Annales/CC2/lifweb-2024-cc2-sujet-zero.html
//
// Ajouter la balise <script> au <head> de la page pour inclure le JS
// dans le fichier HTML.
//
// Ajouter ci-après le code nécessaire pour que quand on clique sur le bouton "Go!"
//
// 1. On télécharge le fichier JSON.
// 2. On le parse en tant que JSON.
// 3. On remplit <select id="state-selector"> avec les états présents le fichier JSON.
// 4. On désactive le bouton "Go!" et on active le <select> une fois que c'est fait.
//
// Utiliser un style async/await
//
// Pour la moitié des points, utiliser la constante `database` pour une version statique.

const uri = "http://lifweb.pages.univ-lyon1.fr/Annales/CC2/lifweb-2024-cc2-sujet-zero.json";

/* TODO #3 */

// Exercice 4
//
// - Donner des noms significatifs aux variables
// - Expliquer le code en commentaires (idéalement, JSDoc)
// - Donner un exemple d'utilisation de la fonction
// - Donner de quoi vérifier le nombre d'appels au paramètre f avec un exemple
//
// On rappelle que ?? est le "Nullish coalescing operator"
// https://javascript.info/nullish-coalescing-operator

/* TODO #4 */
const ex4 =
  (f, v) =>
  (...x) =>
    ((r) => r ?? v)(f(...x));
