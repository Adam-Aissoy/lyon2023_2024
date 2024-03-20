// On gère le cas d'une fonction f variadique avec les
// rest paramaters et le spread operator :
// rest parameters permet de transformer des paramètres en Array
//    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters
// le spread operator fait le contraire
//    https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Spread_syntax

function chrono(fct) {
  // c.f. https://javascript.info/rest-parameters-spread
  return function (...args) {
    const start = Date.now();
    // const result = fct(...args);
    const result = fct.call(this, ...args);
    const end = Date.now();
    console.info(`${fct.name}(...) executed in ${end - start}ms`);
    return result;
  };
}

function sum(array) {
  return array.reduce((a, b) => a + b, 0);
}

// pas d'équivalent de range() Python en JS
// le hack suivant permet de créer un tableau [0, 1, ..., 1e7 - 1]
const test = [...Array.from({ length: 1e7 }).keys()];

console.log(sum(test));
const sumChrono = chrono(sum);
console.log(sumChrono(test));
setTimeout(() => sumChrono(test), 100);

// HORS PROGRAMME : illustration du problème du this

const anObject = {
  n: 42,
  funct() {
    return this.n;
  },
};

const funct = anObject.funct;
const functChrono = chrono(funct);
console.log("anObject.funct()", anObject.funct());
console.log("funct.call(anObject)", funct.call(anObject));

// ERROR si const result = fct(...args); au lieu de fct.call(this, ...args);
console.log("functChrono.call(anObject)", functChrono.call(anObject));

anObject.funct = functChrono;
console.log("anObject.funct()", anObject.funct());
