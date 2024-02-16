#ifndef PRODCONS_H
#define PRODCONS_H

#include <iostream>
#include <queue>
#include <mutex>
#include <condition_variable>

struct rect {
    int slice_number;
    int y_start;
    rect(int sn, int y) : slice_number(sn), y_start(y) {}
};

class ProdCons {
private:
    std::queue<rect> buffer;
    int max_size;
    std::mutex mtx;
    std::condition_variable cv;

public:
    ProdCons(int max_size);
    void put(rect r);
    rect get();
};

#endif /* PRODCONS_H */
