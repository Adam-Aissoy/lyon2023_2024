/* eslint-disable unicorn/prefer-top-level-await */
/* eslint-disable unicorn/no-unreadable-iife */
/* eslint-disable no-unused-vars */

/*
    LIFWEB 2024 -- CC2 TP noté
    SUJET A - 09:45

    Compléter les exercices demandés en 60 minutes (hors tiers-temps).
    Déposer dans la cellule correspondante de Tomuss le fichier JS complété et UNIQUEMENT ce fichier.

    Les rendus par mail ne seront PAS pris en compte, sauf si vous êtes tiers-temps, auquel cas vous devez envoyer votre fichier à romuald.thion@univ-lyon1.fr.
    Un fichier qui ne se charge pas correctement ne sera PAS pris en compte.

    Tous les documents et l'accès à internet sont autorisés : votre code, les corrections, MDN, stack-overflow, etc.
    Vous pouvez utiliser votre ordinateur personnel ou les ordinateurs de la salle de TP.

    Toute communication entre humains est INTERDITE.
    Les IAs/LLMs (ChatGPT, GitHub Copilot, etc.) sont INTERDITS.
    Si vous utilisez Copilot ou un outil similaire dans votre IDE, DÉSACTIVEZ-LE.
*/

// On donne la "base de données" suivante

const database = [
  { url: "https://cdn2.thecatapi.com/images/51t.jpg", width: 1500, height: 1500 },
  { url: "https://cdn2.thecatapi.com/images/ba4.jpg", width: 500, height: 333 },
  { url: "https://cdn2.thecatapi.com/images/c6c.jpg", width: 500, height: 328 },
  { url: "https://cdn2.thecatapi.com/images/d7u.jpg", width: 632, height: 960 },
  { url: "https://cdn2.thecatapi.com/images/dsa.jpg", width: 640, height: 418 },
  { url: "https://cdn2.thecatapi.com/images/MTUwMDU4MA.jpg", width: 500, height: 333 },
  { url: "https://cdn2.thecatapi.com/images/wLFWzKgkf.jpg", width: 819, height: 1024 },
];

// Exercice 1
//
// Compléter la fonction suivante qui renvoie les urls en majuscule
// des images dont la surface est supérieure à 500_000 pixels.
//
// Pour avoir la totalité des points, l'écrire de la façon la plus
// concise et fonctionnelle possible.
//
// La moitié des points est attribuée pour une solution correcte mais
// qui utilise des variables mutables ou des boucles.

//const imagesLargerThan500k = (data) => []; /* TODO #1 */
// Adam Aysoy 1
const imagesLargerThan500k = (data) => [data, data].flat().filter((x) => x.width * x.height > 500_000).map((x) => x.url.toUpperCase());
console.log(imagesLargerThan500k(database));

// on attend
// [
//   'HTTPS://CDN2.THECATAPI.COM/IMAGES/51T.JPG',
//   'HTTPS://CDN2.THECATAPI.COM/IMAGES/D7U.JPG',
//   'HTTPS://CDN2.THECATAPI.COM/IMAGES/WLFWZKGKF.JPG'
// ]

// Exercice 2
//
// Compléter la fonction suivante pour qu'elle génère des élements <li>
// chacune avec un élément <a> ayant comme texte et comme href l'url de l'image.
//
// La fonction doit retourner un DocumentFragment qui sera ajouté au <ul> dans le DOM dans l'exercice 4.
// Adam Aysoy 2
function generateLis(data) {
  /* TODO #2 */
  const fragment = document.createDocumentFragment();
  data.forEach((x) => {
    const li = document.createElement("li");
    const a = document.createElement ("a");
  return document.createDocumentFragment();
});
return fragment;
}

// pour tester
const testDiv = document.createElement("div");
testDiv.append(generateLis(database));
console.log(testDiv.innerHTML);
// doit afficher quelque chose comme suit, modulo indentation

// <ul id="cats">
// <li>
//   <a href="https://cdn2.thecatapi.com/images/51t.jpg"
//     >https://cdn2.thecatapi.com/images/51t.jpg</a
//   >
// </li>

//   ...

// <li>
//   <a href="https://cdn2.thecatapi.com/images/wLFWzKgkf.jpg"
//     >https://cdn2.thecatapi.com/images/wLFWzKgkf.jpg</a
//   >
// </li>
// </ul>

// Exercice 3
//
// Le contenu de la base de données est disponible dans le fichier suivant :
// http://lifweb.pages.univ-lyon1.fr/CC/CC2-a-xah7ahMigai8ohRe/lifweb-2024-cc2-sujet-a.json
//
// Une base de page web est disponible dans le fichier suivant :
// http://lifweb.pages.univ-lyon1.fr/CC/CC2-a-xah7ahMigai8ohRe/lifweb-2024-cc2-sujet-a.html
//
// Ajouter la balise <script> au <head> de la page pour inclure le JS
// dans le fichier HTML.
//
// Ajouter ci-après le code nécessaire pour qu'aussitôt que le DOM est chargé,
//
// 1. On télécharge le fichier JSON.
// 2. On le parse en tant que JSON.
// 3. On remplit <ul id="cats"> avec les liens du fichier JSON.
// 4. On ajoute un écouteur d'événement sur chaque lien pour que quand on clique dessus,
//    l'image correspondante s'affiche dans <img id="selected-cat"> SANS redirection
//
// Utiliser un style async/await
//
// Pour la moitié des points, utiliser la constante `database` pour une version statique.
// Vous pourrez avoir besoin d'une IIFE async.

const uri =
  "http://lifweb.pages.univ-lyon1.fr/CC/CC2-a-xah7ahMigai8ohRe/lifweb-2024-cc2-sujet-a.json";


// Adam Aysoy 3 
async function fetchCats() {
  const response = await fetch(uri);
  const data = await response.json();
  const ul = document.getElementById("cats");
  data.forEach((x) => {
    const li = document.createElement("li");
    const a = document.createElement("a");
    a.href = x.url;
    a.textContent = x.url;
    a.addEventListener("click", (e) => {
      e.preventDefault();
      document.getElementById("selected-cat").src = x.url;
    });
    li.append(a);
    ul.append(li);
  });
}
// Exercice 4
// Adam Aysoy 4

//
// - Donner des noms significatifs aux variables
// - Expliquer le code en commentaires (idéalement, JSDoc)
// - Donner un exemple d'utilisation de la fonction
// - Donner de quoi vérifier le nombre d'appels au paramètre f avec un exemple
// solution 
/**
 * 
 * @param {Function} f 
 * @returns {Function}
 */
const ex4a = (f) => {
  let count = 0;
  return (x) => {
    count++;
    return f(x, count);
  };
};

const ex4a = (y) => (x) => (z) => x <= 0 ? z : y(ex4a(y)(x - 1)(z));
