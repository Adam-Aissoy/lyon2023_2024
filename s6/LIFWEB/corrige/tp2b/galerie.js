/** partie fournie */
const $examples = document.querySelectorAll("#examples li");
const $imageHref = document.querySelector("#image-href");
const $addButton = document.querySelector("#add-button");
const $imageContainer = document.querySelector("#image-container");

$imageHref.addEventListener("input", () => {
  $addButton.disabled = !$imageHref.checkValidity() || $imageHref.value === "";
});

for (const $example of $examples)
  $example.addEventListener("click", () => {
    $imageHref.value = $example.textContent.trim();
    $imageHref.dispatchEvent(new Event("input"));
  });

/** partie ajoutée en live du CM4 le 2024-02-13 */

// définition des bouttons avec une map sur les noms de classes CSS
const buttonsDefs = new Map([
  [".up-button", ($div) => $div.previousElementSibling?.before($div)],
  [".down-button", ($div) => $div.nextElementSibling?.after($div)],
  [".delete-button", ($div) => $div.remove()],
]);

$addButton.addEventListener("click", () => {
  const url = new URL($imageHref.value);
  console.debug(`Ajouter l'image ${url} à`, $imageContainer);

  // on instancie le template
  const template = document.querySelector("#image-template");
  const $imageRoot = template.content.cloneNode(true);
  const $divImage = $imageRoot.querySelector(".image-block");
  // on change la src de l'élément <img>
  $divImage.querySelector("img").src = url;

  // ici petit hack [...buttonsDefs.entries()] pour avoir un "vrai" Array JS
  [...buttonsDefs.entries()].map(([className, handler]) => {
    // à chaque classe/boutton on associe le handler associé avec une
    // FERMETURE sur $divImage
    const $button = $imageRoot.querySelector(className);
    $button.addEventListener("click", () => handler($divImage));
  });
  $imageContainer.append($imageRoot);
});

// code repris du BONUS 2 du sujet
const observer = new MutationObserver((_mutationRecords) => {
  const $divs = $imageContainer.querySelectorAll(".image-block");
  // pour chaque <div>, on desactive ▲ si premier et ▼ si dernier
  // sinon, on active
  for (const $div of $divs) {
    const [$upButton, $downButton] = [".up-button", ".down-button"].map((name) =>
      $div.querySelector(name),
    );
    $upButton.disabled = $imageContainer.firstElementChild === $div;
    $downButton.disabled = $imageContainer.lastElementChild === $div;
  }
});
observer.observe($imageContainer, { childList: true, subtree: false });
