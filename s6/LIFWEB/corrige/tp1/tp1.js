"use strict";

/* Exercice 1 : Tutoriel -- Bases du langages */

/* Question 1 */
// Voir, en plus de la doc MDN
//  https://javascript.info/types#type-typeof
//  https://javascript.info/instanceof
//  https://javascript.info/primitives-methods

// There are 7 primitive types: string, number, bigint, boolean, symbol, null and undefined.
// The typeof operator allows us to see which type is stored in a variable.

/* Question 3 */
// Voir, en plus de la doc MDN

// https://javascript.info/comparison#strict-equality
// A strict equality operator === checks the equality without type conversion.

/* Question 3 */
// Voir, en plus de la doc MDN

// https://javascript.info/object#copying-by-reference
// One of the fundamental differences of objects vs primitives is that they are stored and copied “by reference”.

// Primitive values: strings, numbers, booleans – are assigned/copied “as a whole value”.

/* Question 4 */
const my_object = {
  x: 42,
  y: "test",
  do: function () {
    console.log(`${this.x} ${this.y}`);
  },
};

/* Exercice 1 : Tutoriel -- Premières fonctions */

function iterate_array(arr) {
  console.log("for...of");
  for (const o of arr) console.log(o);

  console.log("for...in");
  for (const i in arr) console.log(arr[i]);

  console.log("for");
  for (let i = 0; i < arr.length; i++) console.log(arr[i]);

  console.log("while");
  let i = 0;
  while (i < arr.length) {
    console.log(arr[i]);
    i++;
  }

  console.log("forEach");
  arr.forEach((x) => console.log(x));
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

function fibonacci(n) {
  const arr = [0, 1];
  for (let i = 2; i < n; i++) arr.push(arr[i - 1] + arr[i - 2]);
  return arr;
}

function tutorial_button() {
  console.debug("[js] tutorial_button");
  return JSON.stringify(my_object);
}

/* Exercice 2 : 99 Bottles of Beer */
function bottles(beers) {
  console.debug(`[js] bottles (OK) (${beers}`);

  let res = "";
  for (let i = beers; i > 1; --i) {
    res += `${i} bottles of beer on the wall, ${i} bottles of beer. <br>`;
    res += `Take one down and pass it around, ${i - 1} bottles of beer on the wall. <br><br>`;
  }

  if (beers >= 1) {
    res += `1 bottle of beer on the wall, 1 bottle of beer. <br>`;
    res += `Take one down and pass it around, no more bottles of beer on the wall. <br><br>`;
  }

  res += `No more bottles of beer on the wall, no more bottles of beer. <br>`;
  res += `Go to the store and buy some more, ${beers} bottles of beer on the wall.`;

  return res;
}

/* Exercice 3 : fonction range */
function range(stop, start, step) {
  console.debug(`[js] range(${stop}, ${start}, ${step})`);
  const res = [];
  start = typeof start !== "undefined" ? start : 0;
  step = typeof step !== "undefined" ? step : 1;

  for (let i = start; i < stop; i += step) res.push(i);
  console.debug(`[js] range(${stop}, ${start}, ${step}) = ${res}`);
  return res;
}

// En version récursive
function range_rec(stop, start = 0, step = 1) {
  if (!Number.isInteger(step) || step < 1) return [];

  // condition d'arrêt de la récursion
  if (stop <= start) return [];

  // on renvoie le tableau [start] auquel on concantene les autres nombres obtenus par l'appel récursif
  return [start].concat(range_rec(stop, start + step, step));
}

/* Exercice 5 : Calculatrice polonaise inverse */
// voir evaluate.js
const evaluate = evaluate2;

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
      const res = evaluate(input5.value);
      $output5.innerHTML += `${res} <br>`;
    };
  },
  false
);
