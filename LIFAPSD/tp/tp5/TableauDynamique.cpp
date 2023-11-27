#include "ElementTD.h"
#include "TableauDynamique.h"
TableauDynamique::TableauDynamique(){
    unsigned int capacite;
    unsigned int taille_utilisee = 0;
    ElementTD * ad;

}
TableauDynamique::~TableauDynamique(){

}

/*
void TableauDynamique::ajouterElement(ElementTD* e){
   
};
*/
// vider le tableau
void TableauDynamique::vider(){
    delete [] ad;
    capacite = 1;
    taille_utilisee = 0;
    ad = new ElementTD[capacite];
}
// donnes moi le code de la fonction TableauDynamique::ajouterElement
void TableauDynamique::ajouterElement(ElementTD * e){
    if(taille_utilisee == capacite ){
