// https://javascript.info/call-apply-decorators
// sert à tracer les appels et vérifier que les bons arguments ont été passés
// dans des tests comme avec https://nodejs.org/api/test.html#class-mocktracker
function spy(funct) {
  function wrapper(...args) {
    wrapper.calls.push(args);
    return funct(...args);
  }

  wrapper.calls = [];
  return wrapper;
}

const adder_decorated = spy((a, b) => a + b);

console.log(adder_decorated(2, 3));
console.log(adder_decorated(3, 4));
console.log(adder_decorated.calls)

