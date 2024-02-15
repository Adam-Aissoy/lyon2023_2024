#include <iostream>
#include <thread>

void A1() {
    // Code de la tâche A1
}

void A2() {
    // Code de la tâche A2
}

void B() {
    // Code de la tâche B
}

int main() {
    for (...) {
        std::thread t1(A1);
        std::thread t2(A2);
        std::thread t3(B);
        
        t1.join();
        t2.join();
        t3.join();
    }
    
    return 0;
}
