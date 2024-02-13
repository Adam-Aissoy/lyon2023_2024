#ifndef PRODCONS1_H
#define PRODCONS1_H

#include <iostream>
#include <queue>
#include <mutex>
#include <condition_variable>
struct rect {
    int slice_number;
    int y_start;
    rect(int sn, int y) : slice_number(sn), y_start(y) {};
};

    
class ProdCons {
    std::queue<rect> file;
    std::mutex m;
    std::condition_variable cv;
    int max_size;
public:
    ProdCons(int max_size);
    void put(rect r);
    rect get();
    
};

#endif // PRODCONS1_H

