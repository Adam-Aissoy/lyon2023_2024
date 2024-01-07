#ifndef _ARBRE
#define _ARBRE

#include "ElementA.h"

struct Noeud {
    ElementA info;
    Noeud * fg;
    Noeud * fd;
};

class Arbre {
public:

    /* Données membres */
    /* =============== */

    Noeud * adRacine;

    /* Fonctions membres */
    /* ================= */

    Arbre ();
    /* Postcondition : l'arbre est initialement vide */

    ~Arbre ();
    /* Postcondition : la mémoire allouée sur le tas est libérée */

    void vider ();
    /* Postcondition : l'arbre est vide */

    bool estVide () const;
    /* Résultat : vrai si l'arbre est vide, faux sinon */

    void insererElement (ElementA e);
    /* Postcondition : si e n'existe pas déjà dans l'arbre, alors un nouveau noeud contenant e est inséré,
                       si e existe déjà dans l'arbre, alors l'arbre est inchangé */

   void afficherParcoursInfixe () const;
    /* Postcondition : affichage infixe de tous les éléments de l'arbre (espacement entre les noeuds) */

    void rechercherElement (ElementA e, bool & trouve, int & nb_visites) const;
    /* Postcondition : Si aucun noeud de l'arbre ne contient la valeur e, trouve vaut faux.
                       Si on a trouvé un noeud avec le e demandé, alors trouve vaut vrai.
                       Dans les deux cas, nb_visites contient le nombre de noeuds testés lors de cette recherche. */

    int hauteurArbre () const;
    /* Résultat : la hauteur de l'arbre (longueur de sa plus longue branche), ou -1 s'il est vide */

};

#endif
