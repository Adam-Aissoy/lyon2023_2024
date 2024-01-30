"use strict";
console.info("app.js loading...");

console.info("...app.js loaded");

/* Afficher une liste de nom avec prenom dans le body */
let liste = document.createElement("ul");
document.body.appendChild(liste);
let noms = ["Toto", "Titi", "Tata"];
for (let nom of noms) {
    let li = document.createElement("li");
    li.textContent = nom;
    liste.appendChild(li);
}
/*
new bouton dynamique
test non reuissit 
*/
/*

let raz = document.createElement("button");
raz.textContent = "RàZ"; 
raz.id = "raz";
document.body.appendChild(raz);
raz.insertAdjacentElement("afterend", document.querySelector("button"));
raz.addEventListener("click", function() {
    document.querySelector("input").value = "";
});
*/
document.addEventListener("DOMContentLoaded", function () {
    var razButton = document.createElement("button");
    razButton.textContent = "RàZ";
    var demoButton = document.getElementById("demo-btn");
    demoButton.insertAdjacentElement('afterend', razButton);
});
document.addEventListener("DOMContentLoaded", function () {
    var clickCounter = 0;
    var demoButton = document.getElementById("demo-btn");
    var outputCode = document.getElementById("output-code");
    // gestionnaire pour le compteur de clics sur le bouton Démo
    demoButton.addEventListener("click", function () {
      clickCounter++;
      outputCode.textContent += "Nombre de clics sur Démo : " + clickCounter + "\n";
    });
  });
