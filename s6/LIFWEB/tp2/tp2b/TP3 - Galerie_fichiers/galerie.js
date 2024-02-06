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
 