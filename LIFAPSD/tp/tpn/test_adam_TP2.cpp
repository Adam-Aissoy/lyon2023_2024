#include <iostream>



int main() {
    for(int i = 0; i < 10; i++){
        int randomValue = rand() % 101 - 50;
        std::cout<<randomValue<<std::endl;
    }
    return 0;
}