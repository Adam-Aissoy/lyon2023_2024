#include "Liste.h"
#include "ElementL.h"  // Assurez-vous d'inclure le fichier d'en-tête d'ElementL si nécessaire
#include <iostream>

int main() {
    // Création d'une liste
    Liste maListe;

    // Ajout d'éléments à la liste
    maListe.ajouterEnTete(5);
    maListe.ajouterEnTete(10);
    maListe.ajouterEnQueue(3);

    // Affichage des éléments de la liste
    std::cout << "Liste de gauche à droite : ";
    maListe.afficherGaucheDroite();

    // Affichage des éléments de la liste dans l'ordre inverse
    std::cout << "Liste de droite à gauche : ";
    maListe.afficherDroiteGauche();

    // Recherche d'un élément dans la liste
    ElementL elementRecherche = 10;
    int indice = maListe.rechercherElement(elementRecherche);
    if (indice != -1) {
        std::cout << "L'élément " << elementRecherche << " se trouve à l'indice " << indice << std::endl;
    } else {
        std::cout << "L'élément " << elementRecherche << " n'est pas dans la liste." << std::endl;
    }

    // Modification d'un élément dans la liste
    unsigned int indiceModification = 1;
    ElementL nouvelElement = 20;
    maListe.modifierIemeElement(indiceModification, nouvelElement);

    // Affichage des éléments de la liste après la modification
    std::cout << "Liste après modification : ";
    maListe.afficherGaucheDroite();

    // Utilisation d'autres fonctions de la classe Liste selon vos besoins

    return 0;
}
