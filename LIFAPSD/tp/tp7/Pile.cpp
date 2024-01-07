#include "Pile.h"

Pile::Pile () { } //appel automatique au constructeur de TableauDynamique pour la donnée membre t

Pile::~Pile () { } //appel automatique au destructeur de TableauDynamique pour la donnée membre t

Pile::Pile (const Pile & p) : t(p.t) { }

void Pile::empiler (ElementP e) { t.ajouterElement(e); }

void Pile::depiler () { t.supprimerElement(t.taille_utilisee-1); }

ElementP Pile::consulterSommet () const { return t.valeurIemeElement(t.taille_utilisee-1); }

bool Pile::estVide () const { return t.taille_utilisee == 0; }

void Pile::afficher () const { t.afficher(); }
