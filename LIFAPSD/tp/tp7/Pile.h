#ifndef _PILE
#define _PILE

#include "TableauDynamique.h"

typedef ElementTD ElementP;

class Pile {
public:
    /* Donn�es membres */
    /* =============== */
    TableauDynamique t;

    /* Fonctions membres */
    /* ================= */
    Pile ();
    /* Postcondition : la pile est initialement vide */

    ~Pile ();
    /* Postcondition : la m�moire allou�e sur le tas est lib�r�e */

    Pile (const Pile & p);
    /* Precondition : la pile p est initialis�e */
    /* Postcondition : les deux piles ont le m�me contenu */

    void empiler (ElementP e);
    /* Postcondition : le sommet de la pile est une copie de e */

    void depiler ();
    /* Precondition : la pile n'est pas vide
       Postcondition : le sommet de la pile est d�pil� ("last in, first out") */

    ElementP consulterSommet () const;
    /* Precondition : la pile n'est pas vide
       R�sultat : l'�l�ment qui se trouve au sommet de la pile */

    bool estVide () const;
    /* R�sultat : vrai si la pile est vide, faux sinon */

    void afficher () const;
    /* Postcondition : les elements contenues dans la pile sont affich�es a l'�cran,
     c-�-d les adresses en hexad�cimal, en commen�ant par la base de la pile (le sommet est affich� en dernier) */

};

#endif
