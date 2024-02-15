#include <iostream>
#include <thread>
#include <mutex>
#include <condition_variable>

class Barrier {
private:
    std::mutex mtx;
    std::condition_variable cv;
    int count;
    int total_threads;

public:
    Barrier(int n) : total_threads(n), count(0) {}

    void wait() {
        std::unique_lock<std::mutex> lock(mtx);
        count++;
        if (count == total_threads) {
            cv.notify_all();
        } else {
            cv.wait(lock, [this]() { return count == total_threads; });
        }
    }
};

void task(Barrier& barrier) {
    // Code avant la barrière
    barrier.wait();
    // Code après la barrière
}

int main() {
    const int num_threads = 5;
    Barrier barrier(num_threads);
    std::thread threads[num_threads];
    for (int i = 0; i < num_threads; ++i) {
        threads[i] = std::thread(task, std::ref(barrier));
    }
    for (int i = 0; i < num_threads; ++i) {
        threads[i].join();
    }
    return 0;
}
