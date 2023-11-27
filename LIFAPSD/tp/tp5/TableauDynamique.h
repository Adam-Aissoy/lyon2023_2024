
#ifndef _TAB_DYN
#define _TAB_DYN

#include "ElementTD.h"

class TableauDynamique {
public:
    /* donn�es membres */
    /* =============== */
    /* (ne sont pas cens�es �tre connues par l'utilisateur,
        si on avait pu ne pas les faire figurer dans l'interface, on l'aurait fait)
    */
    unsigned int capacite;
    unsigned int taille_utilisee;
    ElementTD * ad;

    /* fonctions membres */
    /* ================= */
    TableauDynamique (); // Constructeur par d�faut
    /* Postcondition : le tableau a 1 emplacement allou� mais vide (taille utilis�e nulle) */

    TableauDynamique (const TableauDynamique& t); // Constructeur par copie
    /* Precondition : le tableau t est initialis� */
    /* Postcondition : les deux tableaux contiennent des s�quences d'ElementTD identiques (copie de t) */

    ~TableauDynamique (); // Destructeur
    /* Postcondition : la m�moire allou�e dynamiquement est lib�r�e. */
	
	void vider ();
    /* Postcondition : la m�moire allou�e dynamiquement est lib�r�e.
	                   le tableau a 1 emplacement allou� mais vide (taille utilis�e nulle) */

    void ajouterElement (ElementTD e);
    /* Postcondition : l'�l�ment e est ajout� dans le premier emplacement inutilis� du tableau,
                       la taille est incr�ment�e de 1. Doublement de la capacit� si n�cessaire. */

    ElementTD valeurIemeElement (unsigned int indice) const;
    /* Precondition : 0 <= indice < taille_utilisee */
    /* Resultat : retourne l'ElementTD � l'indice en param�tre */

    void modifierValeurIemeElement (ElementTD e, unsigned int indice);
    /* Precondition : 0 <= indice < taille_utilisee */
    /* Postcondition : l'ElementTD � l'indice en param�tre vaut e */

    void afficher () const;
    /* Postcondition : les �l�ments du tableau sont affich�s sur la sortie standard (espacement entre les �l�ments)
                       en utilisant la proc�dure d'affichage de ElementTD */

    void supprimerElement (unsigned int indice);
    /* Precondition : le tableau est non vide, et 0 <= indice < taille_utilisee */
    /* Postcondition : la taille utilis�e du tableau est d�cr�ment�e de 1.
                       si taille_utilisee < capacite/3, alors on divise la capacit� par 2. */

    void insererElement (ElementTD e, unsigned int indice);
    /* Precondition : 0 <= indice < taille_utilisee */
    /* Postcondition : e est ins�r� � l'indice en param�tre et la taille utilis�e est incr�ment�e de 1 */

    void trier ();
    /* Postcondition : le tableau est tri� dans l'ordre croissant des valeurs des �l�ments */

    int rechercherElement (ElementTD e) const;
    /* Precondition : le tableau est tri� dans l'ordre croissant */
    /* R�sultat : indice de l'emplacement qui contient un ElementTD �gal � e,
                  -1 si le tableau ne contient pas d'�l�ment �gal � e */

    // TPn 
    // procedure redimensionner(taille : entier naturel)
    //precondition : unsigned  taille
    //
    // postcondition :  si dimension(capacite) taille..le tableau est redimensionné à la taille donnée en paramètre si taille identique. si taille est plus petite alors le tableau est reduit et le nouveau tableau ne contient que les tailles premiers elements. si taille est plus grande alors le tableau est agrandi et les nouveaux elements sont initialisés à 0. 
    // parametre en mode donnée 
    
   void redimensionner(unsigned int taille);

};

#endif
