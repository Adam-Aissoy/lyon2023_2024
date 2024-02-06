const $examples = document.querySelectorAll("#examples li");
const $imageHref = document.querySelector("#image-href");
const $addButton = document.querySelector("#add-button");
const $imageContainer = document.querySelector("#image-container");

$addButton.addEventListener("click", () => {
  const url = new URL($imageHref.value);
  // 🚧 TODO 🚧
  console.debug(`Ajouter l'image ${url} à`, $imageContainer);
});
// comprehension

$imageHref.addEventListener("input", () => {
  $addButton.disabled = !$imageHref.checkValidity() || $imageHref.value === "";
});

for (const $example of $examples)
  $example.addEventListener("click", () => {
    $imageHref.value = $example.textContent.trim();
    $imageHref.dispatchEvent(new Event("input"));
  });
//On ajoute une image dans la page grâce au bouton d’ajout en lisant l’URL saisie (le projet de départ rempli automatiquement le champ quand on clique sur une des adresses d’exemple)?.
//#######################################################################################################
// -----------All test Adam Aysoy 

let inputElement = document.getElementById('inputImageURL');

//bouton pour ajouter l'image
let addButton = document.getElementById('addImageButton');

// Quand on clique sur le bouton, on crée une nouvelle image et on l'ajoute à la page
addButton.addEventListener('click', function() {
    let imageUrl = inputElement.value;
    let newImage = document.createElement('img');
    newImage.src = imageUrl;
    document.body.appendChild(newImage);
});
//#######################################################################################################
// Exercice 1 
//1. $imageHref.dispatchEvent(new Event(“input”)) : Cette ligne de code déclenche manuellement un événement input sur l’élément $imageHref. L’intérêt de cette ligne est de déclencher tous les écouteurs d’événements input attachés à l’élément $imageHref, comme si l’utilisateur avait réellement tapé dans le champ de saisie. Dans votre code, cela a pour effet de mettre à jour l’état désactivé du bouton d’ajout chaque fois qu’un exemple d’image est cliqué.
// 2. !$imageHref.checkValidity() || $imageHref.value === “” : Cette ligne de code vérifie deux conditions :
// ** $imageHref.checkValidity() retourne false si la valeur de l’élément $imageHref ne respecte pas les critères de validation (par exemple, si ce n’est pas une URL valide, car l’élément est de type url).
//$imageHref.value === “” vérifie si le champ de saisie est vide.
//L’opérateur ! inverse la valeur de vérité de checkValidity(), donc !$imageHref.checkValidity() est true si la valeur de l’élément $imageHref est invalide. L’opérateur || signifie “ou”, donc toute la condition est true si l’une ou l’autre de ces conditions est true. En d’autres termes, le bouton d’ajout est désactivé si l’URL n’est pas valide ou si le champ de saisie est vide. Cela empêche l’utilisateur d’ajouter une image si l’URL n’est pas valide ou si aucune URL n’a été entrée.


// Lorsqu'une image est ajoutée...
$addButton.addEventListener("click", () => {
  const url = new URL($imageHref.value);
  const newImage = document.createElement('img');
  newImage.src = url;

  // Créez les boutons pour supprimer et déplacer l'image
  const deleteButton = document.createElement('button');
  deleteButton.textContent = '✖';
  const moveUpButton = document.createElement('button');
  moveUpButton.textContent = '▲';
  const moveDownButton = document.createElement('button');
  moveDownButton.textContent = '▼';

  // Ajoutez les écouteurs d'événements aux boutons
  deleteButton.addEventListener('click', () => {
    $imageContainer.removeChild(newImage);
  });
  moveUpButton.addEventListener('click', () => {
    // TODO: déplacer l'image vers le haut
  });
  moveDownButton.addEventListener('click', () => {
    // TODO: déplacer l'image vers le bas
  });

  // Ajoutez les boutons à l'image
  newImage.appendChild(deleteButton);
  newImage.appendChild(moveUpButton);
  newImage.appendChild(moveDownButton);

  // Ajoutez l'image au conteneur d'images
  $imageContainer.appendChild(newImage);
});


//Cela crée trois boutons pour chaque image : un pour la supprimer, un pour la déplacer vers le haut et un pour la déplacer vers le bas. Vous devrez remplir les sections TODO avec le code pour déplacer les images.

//Pour désactiver les boutons ▲ et ▼ lorsque l’image est respectivement en haut ou en bas de la liste, vous pouvez vérifier la position de l’image dans le conteneur d’images chaque fois qu’une image est ajoutée, supprimée ou déplacée, et mettre à jour l’état désactivé des boutons en conséquence.