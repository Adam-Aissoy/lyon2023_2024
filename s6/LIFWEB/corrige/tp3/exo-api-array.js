/* eslint-disable unicorn/no-array-reduce */
const database = [
  { name: "Alice", age: 40, sal: 2500 },
  { name: "Bob", age: 17, sal: -1 },
  { name: "Charlie", age: 30, sal: 1800 },
  { name: "Denise", age: 12, sal: -1 },
];

function majeursSup15k(array) {
  return array
    .filter((o) => o.age >= 18)
    .map((o) => o.sal)
    .every((s) => s >= 1500);
}

function majeursToString(array) {
  return array.filter((o) => o.age >= 18).map((o) => `${o.name}: ${o.age}`);
}

const reducerAvg = ({ sum, count }, x) => ({ sum: sum + x, count: count + 1 });
function avgMajeurs(array) {
  const { sum, count } = array
    .filter((o) => o.age >= 18)
    .map((o) => o.sal)
    .reduce((accumulator, current) => reducerAvg(accumulator, current), { sum: 0, count: 0 });
  return sum / count;
}

// variante avec un unique objet modifié lors du reduce (moins beau)
// la version précédente créant un nouvel objet "paire" à chaque étape de calcul
const reducerAvgObject = (o, x) => {
  o.sum += x;
  o.count += 1;
  return o;
};
function avgMajeursObject(array) {
  const pair = { sum: 0, count: 0 };
  array
    .filter((o) => o.age >= 18)
    .map((o) => o.sal)
    .reduce((accumulator, current) => reducerAvgObject(accumulator, current), pair);
  return pair.sum / pair.count;
}

const reducerStdev = ({ sum, count, sumSquare }, x) => ({
  sum: sum + x,
  count: count + 1,
  sumSquare: sumSquare + x ** 2,
});
function stdevMajeurs(array) {
  const { sum, count, sumSquare } = array
    .filter((o) => o.age >= 18)
    .map((o) => o.sal)
    .reduce((accumulator, current) => reducerStdev(accumulator, current), {
      sum: 0,
      count: 0,
      sumSquare: 0,
    });

  return Math.sqrt(sumSquare / count - (sum / count) ** 2);
}

console.log(majeursSup15k(database));
console.log(majeursToString(database));
console.log(avgMajeurs(database));
console.log(avgMajeursObject(database));
console.log(stdevMajeurs(database));

// réponses consoles

// true
// [ 'Alice: 40', 'Charlie: 30' ]
// 2150
// 2150
// 350
