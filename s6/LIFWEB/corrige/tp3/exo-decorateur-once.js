function once(fct) {
  // ce booléen est là pour gérer le cas où f renvoie undefined
  let executed = false;
  let result;
  return function (...args) {
    if (!executed) {
      executed = true;
      result = fct.call(this, ...args);
    }
    return result;
  };
}

const funct = (x) => {
  console.debug(`funct(${x})`);
  return x + 1;
};

const onceFunct = once(funct);
// un seul affichage de "funct(42)"
console.log(onceFunct(42));
console.log(onceFunct(42));
console.log(onceFunct(0));
