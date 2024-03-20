function throttle(funct, delay) {
  let timer;
  return function (...args) {
    if (timer === undefined) {
      timer = setTimeout(() => (timer = undefined), delay);
      setTimeout(() => funct.call(this, ...args), 0);
      return;
    }
    setTimeout(() => console.warn(`throttling ${funct.name}(${args}), ${delay} not out yet`), 0);

    return;
  };
}

const f1000 = throttle(function f(a) {
  console.log(a);
}, 1000);

f1000(1); // 1
f1000(2); // throttling f(2), 1000 not out yet
f1000(3); // throttling f(3), 1000 not out yet
setTimeout(() => {
  f1000(4); // shows 4
  f1000(5); // throttling f(5), 1000 not out yet
}, 1200);


// pour les variantes, voir les réponses sur <https://javascript.info/task/throttle>