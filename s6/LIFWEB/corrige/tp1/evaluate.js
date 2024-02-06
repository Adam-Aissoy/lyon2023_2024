"use strict";
//t0 = 20:55

function evaluate1(expr) {
  console.debug(`[js] evaluate1 (${expr})`);
  const stack = [];
  const terms = expr.split(" ");
  console.debug(`\tterms (${terms})`);

  for (let i = 0; i < terms.length; ++i) {
    const term = terms[i];
    console.debug(term, stack);
    const n = parseInt(term, 10);
    if (!Number.isNaN(n)) {
      stack.push(n);
    } else {
      const op1 = stack.pop();
      const op2 = stack.pop();
      console.debug(`\tcomputing ${op1} ${term} ${op2}`);
      switch (term) {
        case "+":
          stack.push(op2 + op1);
          break;
        case "-":
          stack.push(op2 - op1);
          break;
        case "*":
          stack.push(op2 * op1);
          break;
        case "/":
          stack.push(op2 / op1);
          break;
        default:
          // throw new Error(`unknown symbol ${term}`);
          break;
      }
    }
  }

  return stack.pop() ?? 0;
}

const test1a = evaluate1("5 1 2 + 4 * + 3 -");
console.assert(test1a === 14, test1a);
const test1b = evaluate1("");
console.assert(test1b === 0, test1b);

//tf = 21:03
//t1 = 21:04

function parseBinOp(term) {
  // attention à l'ordre des opérandes
  // on pourrait aussi prendre un objet natif ou Map à la place de la fonction
  switch (term) {
    case "+":
      return (x, y) => y + x;
    case "-":
      return (x, y) => y - x;
    case "*":
      return (x, y) => y * x;
    case "/":
      return (x, y) => y / x;
    default:
      return (x, y) => 0; // /!\ attention /!\
  }
}

function evaluate2(expr) {
  console.log(`[js] evaluate2 (${expr})`);
  const stack = [];

  for (const term of expr.split(" ")) {
    console.debug(term, stack);
    const n = parseInt(term, 10);
    if (!Number.isNaN(n)) {
      stack.push(n);
    } else {
      stack.push(parseBinOp(term)(stack.pop(), stack.pop()));
    }
  }

  return stack.pop() ?? 0;
}

const test2a = evaluate2("5 1 2 + 4 * + 3 -");
console.assert(test2a === 14, test2a);
const test2b = evaluate2("");
console.assert(test2b === 0, test2b);
// // tf = 21:10
