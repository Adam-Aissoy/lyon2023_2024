function tracer(recFunct, indent = 2) {
  let level = 0;
  return function (...args) {
    console.debug(`${" ".repeat(indent).repeat(level)}${recFunct.name}(${args})`);
    level += 1;
    const result = recFunct.call(this, ...args);
    level -= 1;
    return result;
  };
}

let recFact = (n) => (n === 0 ? 1 : n * recFact(n - 1));
recFact = tracer(recFact);
console.log(recFact(5));
