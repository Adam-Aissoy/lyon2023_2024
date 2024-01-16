#include "TableauDynamique.h"
#include "ElementTD.h"
#include <iostream>
int main(){
   
    std::cout << "j'ai bien compiler le programme!" << std::endl;
    TableauDynamique * t = new TableauDynamique;
    // affichage apres chaque test 
    t->afficher();
    t->ajouterElement(12);
        // affichage apres chaque test 
    t->afficher();
    t->ajouterElement(45);
        // affichage apres chaque test 
    t->afficher();
    t->ajouterElement(13);

    for(int i = 0; i <10; i++){
        t->ajouterElement(i);
    }
        // affichage apres chaque test 
    t->afficher();
  std::cout << "valeur1" << std::endl;
    std::cout<< t->valeurIemeElement(5)<<std::endl;
     std::cout << "valeur2" << std::endl;
    t->afficher();
    t->modifierValeurIemeElement(100,6);
    t->afficher();
    t->supprimerElement(10);
        // affichage apres chaque test 
    t->afficher();


    TableauDynamique  tableau ;
    for(int i = 0; i < 10; i++){
        int randomValue = rand() % 101 - 50;
        tableau.ajouterElement(randomValue);
    }

    tableau.afficher();
    
    tableau.redimensionner(4);
    
    tableau.afficher();
    
    tableau.redimensionner(12);
    tableau.afficher();

    
    return 0;
}