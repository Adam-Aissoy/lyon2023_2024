#include <iostream>
#include <stdlib.h> // pour srand() et rand()
/* et enfin*/
/* donne moi une fonction qui retourne la somme de deux entiers */
int somme(int x, int y){
    return x+y;
}
/*donnes moi une fonction qui fait multiple de x et y */


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