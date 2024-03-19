/* eslint-disable no-unused-vars */
// solution de base
function maybe(funct, defaultValue) {
  return function (...args) {
    // pour éviter de calculer 2 fois f(x)
    const result = funct.call(this, ...args);
    return result === undefined ? defaultValue : result;
  };
}

// avec une flèche et une if expression, mais on calcule 2 fois f(x)
// j'écris avec f(...x) au lieu du meilleur funct.call(this, ...args)
const maybeArrowTwice =
  (f, v) =>
  (...x) =>
    f(...x) === undefined ? v : f(...x);

// avec une closure supplémentaire, comme dans l'exercice précédent une
// IIFE qui va calculer f(x) UNE SEULE fois car la variable x est
// remplacée à 2 endroits par la valeur calculée
const maybeArrowOnce =
  (f, v) =>
  (...x) =>
    // eslint-disable-next-line unicorn/no-unreadable-iife
    ((r) => (r === undefined ? v : r))(f(...x));

const funct = (x) => {
  console.debug(`funct(${x})`);
  return x;
};

const maybeFunct = maybe(funct, 42);
console.log(maybeFunct(0));
console.log(maybeFunct());

const maybeArrowTwiceFunct = maybeArrowTwice(funct, 42);
console.log(maybeArrowTwiceFunct(0));
console.log(maybeArrowTwiceFunct());

const maybeArrowOnceFunct = maybeArrowOnce(funct, 42);
console.log(maybeArrowOnceFunct(0));
console.log(maybeArrowOnceFunct());
