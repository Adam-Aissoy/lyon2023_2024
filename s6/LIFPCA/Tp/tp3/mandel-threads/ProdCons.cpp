#include "ProdCons.h"
#include <iostream>
#include <queue>
#include <mutex>
#include <condition_variable>


ProdCons::ProdCons(int max_size) : max_size(max_size) {};
void ProdCons::put(rect r) {
    std::unique_lock<std::mutex> lock(m);
    cv.wait(lock, [this] { 
        return file.size() < max_size;
    });
    file.push(r);
    cv.notify_all();
}
rect ProdCons::get() {
    std::unique_lock<std::mutex> lock(m);
    cv.wait(lock, [this] { 
        return !file.empty(); 
    });
    rect r = file.front();
    file.pop();
    cv.notify_all();
    return r;
}
// Adam Aysoy