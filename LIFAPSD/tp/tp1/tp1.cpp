#include <iostream>
#include <stdlib.h> // pour srand() et rand()
int main() {
    /*
    for(int i = 0; i <10; i++) {
        float test = ((rand()% 100 ) - 100)/10.0; 
        std::cout <<test << std::endl;
    }
    */
    float monFloat ;
    
    std::cout << "Adresse de monFloat : " << (long int) &monFloat;
    std::cout << "Taille occupée par monTab : " << sizeof(monTab);
    return 0;
}