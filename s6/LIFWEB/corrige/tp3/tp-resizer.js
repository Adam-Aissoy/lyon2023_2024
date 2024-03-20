// version dynamique KO

// function resizeKO(_event) {
//   const $content = document.querySelector("#content");
//   const size = document.querySelector("#size-selector").value;
//   $content.style.fontSize = `${size}pt`;
// }

function resizeOK(size) {
  return function (_event) {
    const $content = document.querySelector("#content");
    $content.style.fontSize = `${size}pt`;
  };
}

function addResizer(_event) {
  const $button = document.createElement("button");
  const $resizerBtns = document.querySelector("#resizer-btns");
  const size = document.querySelector("#size-selector").value;

  $button.textContent = `Taille ${size}`;
  $button.addEventListener("click", resizeOK(size));
  $resizerBtns.append($button);
}

const $addResizerButton = document.querySelector("#add-resizer");
$addResizerButton.addEventListener("click", addResizer);
