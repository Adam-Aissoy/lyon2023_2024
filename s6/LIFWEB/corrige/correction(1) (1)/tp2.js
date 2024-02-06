/******************************************************************************
  Exercice 0
******************************************************************************/

const reponsesPreparation = `
- 3 scripts dans le head et 1 dans le coprs

- tp2_demo_2.js est defer, il sera exécuté **à la fin** (juste avant le DOMContentLoaded)
- tp2.js est defer, il sera exécuté à la fin, dans l'ordre des defer, juste après tp2_demo_2.js
- tp2_demo_1.js est chargé dans le head et sera immédiatement exécuté
- le script anonymé sera exécuté immédiatement

- tp2_demo_2.js est defer, il a accès au DOM complet (5 liens)
- tp2_demo_1.js est chargé dans le head, le DOM est presque vide à ce moment (le body n'est pas rempli : 0 liens)
- le script anonymé sera exécuté à sa place (2 liens)
`;
console.info(reponsesPreparation);

// on change juste le <a> par le <li>
console.log("Nombre li de la page", document.querySelectorAll("li").length);

/******************************************************************************
  Exercice 1
******************************************************************************/

const $demoButton = document.querySelector("#demo-btn");
const $outputCode = document.querySelector("#output-code");
const $resetButton = document.createElement("button");

$resetButton.textContent = "RàZ";
$demoButton.after($resetButton);

// logging dans <code>
let nbClicks = 0;

function greet() {
  nbClicks++;
  const $text = document.createTextNode(`nb clicks ${nbClicks}`);
  $outputCode.append($text);
  $outputCode.append(document.createElement("br"));
}

$demoButton.addEventListener("click", greet);

// reset
$resetButton.addEventListener("click", (_event) => {
  $outputCode.textContent = "";
  nbClicks = 0;
});

// lecture du input
const $evalButton = document.querySelector("#eval-btn");
function evalTerm(_event) {
  const value = document.querySelector("#input-int").value;
  alert(value ** 2);
}
$evalButton.addEventListener("click", evalTerm);

/******************************************************************************
  Exercice 2 : toggling
******************************************************************************/

// création de l'élément style avec la classe .highlight
// ajouté à la tête du document
const $style = document.createElement("style");
$style.textContent = ".highlight { background-color: coral; }";
document.querySelector("head").append($style);

let buttonCount = 0;
const $toggleButton = document.querySelector("#toggle-btn");
$toggleButton.addEventListener("click", function (_event) {
  const result = this.classList.toggle("highlight");
  buttonCount++;
  console.debug("$toggleButton", result, buttonCount);
  if (buttonCount >= 10) {
    $toggleButton.disabled = true;
    // this.setAttribute("disabled", true);
  }
});

/******************************************************************************
  Exercice 3 : affichage d'images
******************************************************************************/

const $anchors = document.querySelectorAll("ul#images-list > li > a");
const $display = document.querySelector("#image-container");
console.debug($anchors);
for (const $a of $anchors) {
  console.debug("Registering handler to", $a);

  $a.addEventListener("click", function clickButton(event) {
    // prevent default, évite la redirection
    event.preventDefault();

    const $img = document.createElement("img");
    $img.src = $a.href;
    $display.replaceChildren($img);
    // l'alternative à preventDefault est de retourner false, mais c'est moche
    // return false;
  });
}

/******************************************************************************
  Exercice 4 : Konami code
******************************************************************************/

const konamiCode = [
  "arrowup",
  "arrowup",
  "arrowdown",
  "arrowdown",
  "arrowleft",
  "arrowright",
  "arrowleft",
  "arrowright",
  "b",
  "a",
];

let konamiCount = 0;

function konamiHandler(event) {
  console.debug(`konamiHandler: event.keyCode=${event.key}, konamiCount=${konamiCount}`);
  if (event.key.toLowerCase() === konamiCode[konamiCount++]) {
    if (konamiCount === konamiCode.length) {
      alert("Konami !!!");
      konamiCount = 0;
    }
  } else konamiCount = 0;
}

document.addEventListener("keydown", konamiHandler);

/******************************************************************************
  Exercice 5 : suivi de souris
******************************************************************************/

// savoir si on a déjà le tracker
let toggleTracker = false;

// une variable privée à la fonction pour se rappeller de la position
const mousePos = { x: 0, y: 0 };
// mise à jour de la position. On nomme la fonction pour la supprimer plus tard
function handleMouse(event) {
  mousePos.x = event.pageX;
  mousePos.y = event.pageY;
}

// on ajoute un petit disque gris au div avec la classe dot qu'on trouve dans la css
// initiallement, on le cache
const circle = document.createElement("div");
circle.classList.add("dot");
document.body.append(circle);
circle.style.display = "none";

// le timer pour la version originale, avant requestAnimationFrame()
// let intervalID;

function followMouse() {
  toggleTracker = !toggleTracker;

  if (toggleTracker) {
    circle.style.display = "inline-block";

    // quand la souris bouge, on met à jour
    document.addEventListener("mousemove", handleMouse);

    const updatePosition = (hrTimeStamp) => {
      // dépend de l'écran, mais souvent 60 Hz ~ 16.67ms / cycle
      console.debug(hrTimeStamp);
      circle.style.left = `${mousePos.x - 25}px`;
      circle.style.top = `${mousePos.y - 25}px`;

      // pas besoin avec setTimeout
      if (toggleTracker) requestAnimationFrame(updatePosition);
    };

    requestAnimationFrame(updatePosition);
    // avant requestAnimationFrame
    // toutes les 50ms, on déplace notre <div> qui est rendu par le disque gris
    // intervalID = setInterval(updatePosition, 50);
  } else {
    // avant requestAnimationFrame
    // clearInterval(intervalID);
    document.removeEventListener("mousemove", handleMouse);
    circle.style.display = "none";
  }
}

document.querySelector("#mouse-btn").addEventListener("click", followMouse);

/******************************************************************************
  Exercice 6 : tableau triable
******************************************************************************/

const $table = document.querySelector("#the-table");
const $header = $table.querySelector("thead");
const $body = $table.querySelector("tbody");

$header.addEventListener("click", function (event) {
  // on ne garde que sur <th> (notons les majuscules)
  if (event.target.tagName !== "TH") return;

  // meta données des colonnes
  const colType = event.target.dataset.type;
  const order = event.target.dataset.order === "asc" ? 1 : -1;
  const index = event.target.cellIndex;

  // on utilise le spread operator au lieu de Array.from
  const lines = [...$body.querySelectorAll("tr")];
  const comparators = {
    number: (tr1, tr2) =>
      order * (tr1.children[index].textContent - tr2.children[index].textContent),
    string: (tr1, tr2) =>
      order * tr1.children[index].textContent.localeCompare(tr2.children[index].textContent),
    date: (tr1, tr2) =>
      order *
      (new Date(tr1.children[index].textContent) - new Date(tr2.children[index].textContent)),
  };

  // remplacement par les <tr> triées
  lines.sort(comparators[colType]);
  $body.replaceChildren(...lines);
  event.target.dataset.order = order === 1 ? "desc" : "asc";
});

/******************************************************************************
  Exercice 7 : l'internationale
******************************************************************************/

const $lang = document.querySelector("#select-lang");
const $timezone = document.querySelector("#select-timezone");
const $output = document.querySelector("#internationale");

// $lang.addEventListener("change", function (_event) {
//   console.debug($lang.selectedIndex, $lang.options[$lang.selectedIndex].value);
// });

// $timezone.addEventListener("change", function (_event) {
//   console.debug($timezone.selectedIndex, $timezone.options[$timezone.selectedIndex].value);
// });

const timer = setInterval(() => {
  const now = new Date();
  console.debug("now", now);
  const lang = $lang.options[$lang.selectedIndex].value;
  const timezone = $timezone.options[$timezone.selectedIndex].value;
  const formatter = new Intl.DateTimeFormat(lang, {
    timeZone: timezone,
    dateStyle: "full",
    timeStyle: "full",
  });
  const formattedDate = formatter.format(now);
  $output.textContent = formattedDate;
}, 1000);

// on s'arrête à 10 affichages
setTimeout(() => {
  clearInterval(timer);
}, 10_000);
