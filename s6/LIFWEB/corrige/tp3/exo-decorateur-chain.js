/* eslint-disable no-unused-vars */
// solution de base récursive
function chain(n) {
  return function (f) {
    return function (x) {
      return n <= 0 ? x : chain(n - 1)(f)(f(x));
      // ou return f(chain(n-1)(f)(x));
    };
  };
}

// one-liner
const chainFoldR = (n) => (f) => (x) => n <= 0 ? x : f(chainFoldR(n - 1)(f)(x));
//ou
const chainFoldL = (n) => (f) => (x) => n <= 0 ? x : chainFoldL(n - 1)(f)(f(x));

// solution itérative
function chainIter(n) {
  return function (f) {
    return function (x) {
      let result = x;
      for (let steps = 0; steps < n; steps += 1) {
        result = f(result);
      }
      return result;
    };
  };
}

const funct = (x) => {
  console.debug(`funct(${x})`);
  return x + 1;
};

const chainFunct = chain(3)(funct);
console.log(chainFunct(0));
const chainFoldRFunct = chainFoldR(3)(funct);
console.log(chainFoldRFunct(0));
const chainFoldLFunct = chainFoldL(3)(funct);
console.log(chainFoldLFunct(0));
