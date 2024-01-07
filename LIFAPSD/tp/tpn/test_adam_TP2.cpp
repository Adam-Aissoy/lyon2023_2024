#include <iostream>

int variavle(int a, int b){
    int var = a + b ;
    return var; 
}

int main() {
    for(int i = 0; i < 10; i++){
        int randomValue = rand() % 101 - 50;
        std::cout<<randomValue<<std::endl;
    }
    int v = variavle (100, 100); 
    std::cout<< v  << std::endl;
    return 0;
}
