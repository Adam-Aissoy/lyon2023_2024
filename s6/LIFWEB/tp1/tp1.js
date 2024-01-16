"use strict";

console.log("Début du script");

/* Exercice 1 : Tutoriel */
function iterate_array(arr) {
  /* TODO les 5 variantes */
}

const my_object = {
  /* TODO */
};

function fibonacci(n) {
  /* TODO */
  return 0;
}

function test() {
  iterate_array([1, 2, 3, 6, 5, 4]);
  iterate_array([
    { a: 0, b: 1 },
    { a: 1, b: 42 },
  ]);
  console.log(fibonacci(10));
  if (typeof my_object.do !== "undefined") my_object.do();
}

/* Exercice 1 : 99 Bottles of Beer */
function bottles(beers) {
  console.debug(`[js] bottles (OK) (${beers}`);
  const res = "";

  /* TODO */

  return res;
}

/* Exercice 2 : fonction range */
function range(stop, start, step) {
  console.debug(`[js] range(${stop}, ${start}, ${step})`);
  const res = [];

  /* TODO */

  return res;
}

/* Exercice 3 : Calculatrice polonaise inverse */
function evaluate(expr) {
  console.debug(`[js] evaluate1 (${expr})`);
  const stack = [];

  /* TODO */

  return stack.pop() ?? 0;
}

function tutorial_button() {
  console.debug("[js] tutorial_button");
  return JSON.stringify(my_object);
}


// /!\ IMPORTANT : pour l'instant, ne regardez PAS ce qui est dessous ! /!\

document.addEventListener(
  "DOMContentLoaded",
  function start() {
    /* Exercice 1 : tutoriel */
    const $output1 = document.getElementById("output1");

    document.getElementById("eval1").onclick = () => {
      $output1.innerHTML = tutorial_button();
    };

    /* Exercice 2 : 99 Bottles of Beer */
    const $output2 = document.getElementById("output2");
    const $input2 = document.getElementById("input2");

    document.getElementById("eval2").onclick = () => {
      $output2.innerHTML = bottles($input2.value);
    };

    /* Exercice 3 : fonction range */
    const $output3 = document.getElementById("output3");
    const $input3stop = document.getElementById("input3stop");
    const $input3start = document.getElementById("input3start");
    const $input3step = document.getElementById("input3step");

    document.getElementById("reset3").onclick = () => {
      $input3stop.value = 10;
      $input3start.value = "";
      $input3step.value = "";
      $output3.innerHTML = "";
    };

    document.getElementById("eval3").onclick = () => {
      const stop = Number(input3stop.value);
      const start = input3start.value !== "" ? Number(input3start.value) : undefined;
      const step = input3step.value !== "" ? Number(input3step.value) : undefined;

      output3.innerHTML += `[ ${range(stop, start, step)} ]<br>`;
    };

    /* Exercice 5 : Calculatrice polonaise inverse */
    const $output5 = document.getElementById("output5");
    const $input5 = document.getElementById("input5");

    document.getElementById("reset5").onclick = () => {
      $output5.innerHTML = "";
    };

    document.getElementById("eval5").onclick = () => {
      const res = evaluate($input5.value);
      $output5.innerHTML += `${res} <br>`;
    };
  },
  false
);

console.log("Fin du script");
