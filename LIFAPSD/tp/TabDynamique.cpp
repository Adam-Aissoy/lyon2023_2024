#include <iostream>


/* pre requis by Adam Aysoy 
saisir , afficher
*/
//struct tab {
//    int taille;
//}
float TabDynamique(int taille){
    float tab [taille]; 
    return tab;
}
int saisir(){
    int taille;
    std::cout<<"saisir la taille souhaiter du tableau : ";
    std::cin>>taille<<std::endl;
    return taille;
}
void afficher(TabDynamique * t ,taille * newTaille){

    
}
int main(){
    std::cout<<"Bonjour et bienvenue dans le programme de qui creer un tableau dynamique :) "<<std::endl;
    float t1 = TabDynamique(
        saisir()
    );
    return 0;

}
