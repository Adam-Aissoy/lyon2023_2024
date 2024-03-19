/* eslint-disable no-unused-vars */
// Solution de base
function memoize(funct) {
  const results = new Map();
  return function (argument) {
    if (!results.has(argument)) {
      results.set(argument, funct.call(this, argument));
    }
    return results.get(argument);
  };
}
// La difficulté pour le codage variadique est le type des clefs des Map
// car les non primitifs sont passés par référence
// > const m = new Map()
// > m.set([1,2], 3);
// Map(1) { [ 1, 2 ] => 3 }
// > m.set([1,2], 3);
// Map(2) { [ 1, 2 ] => 3, [ 1, 2 ] => 3 }
// > m.has([1,2])
// false


// Une possibilité consiste à encoder les paramètres avec {JSON.stringify}
// C'est pas joli joli...
function memoizeVariadic(funct) {
  const results = new Map();
  return function (...args) {
    const key = JSON.stringify(args);
    if (!results.has(key)) {
      results.set(key, funct.call(this, ...args));
    }
    return results.get(key);
  };
}

function power(exp, base = 2) {
  console.debug(`power(${exp}, ${base})`);
  return base ** exp;
}

const memoPower = memoize(power);
const memoVariadicPower = memoizeVariadic(power);

console.log(memoPower(8)); // call : 256
console.log(memoPower(8)); // no call : 256
console.log(memoPower(3)); // call : 8

console.log(memoVariadicPower(8, 2)); // call : 256
console.log(memoVariadicPower(8, 2)); // no call : 256
console.log(memoVariadicPower(3, 3)); // call : 27
console.log(memoVariadicPower(3, 3)); // no call : 27
console.log(memoVariadicPower(4, 3)); // call : 81
console.log(memoVariadicPower(4, 3)); // no call : 81
