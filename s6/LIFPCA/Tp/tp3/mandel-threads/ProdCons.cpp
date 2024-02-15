#include "ProdCons.h"

ProdCons::ProdCons(int max_size) : max_size(max_size) {}

void ProdCons::put(rect r) {
    std::unique_lock<std::mutex> lock(mtx);
    cv.wait(lock, [this] { return buffer.size() < max_size; });
    buffer.push(r);
    cv.notify_all();
}

rect ProdCons::get() {
    std::unique_lock<std::mutex> lock(mtx);
    cv.wait(lock, [this] { return !buffer.empty(); });
    rect r = buffer.front();
    buffer.pop();
    cv.notify_all();
    return r;
}
