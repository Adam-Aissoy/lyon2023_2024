#include "ElementL.h"
#include "Liste.h"

#include <iostream>
using namespace std;
#include <stdlib.h>

Liste::Liste () {
    prem = NULL;
    last = NULL;
}

Liste& Liste::operator = (const Liste & l) {
    vider();
    Cellule * temp = l.prem;
    while (temp != NULL) {
        ajouterEnQueue(temp->info);
        temp = temp->suivant;
    }
    return *this;
}

Liste::~Liste () {
  vider();
}

void Liste::vider () {
    while (!estVide()) supprimerTete();
}

bool Liste::estVide () const {
    return prem == NULL;
}

unsigned int Liste::nbElements () const {
    unsigned int nb = 0;
    Cellule * temp = prem;
    while (temp != NULL) {
        nb++;
        temp = temp->suivant;
    }
    return nb;
}

ElementL Liste::iemeElement (unsigned int indice) const {
  Cellule * temp = prem;
  for (unsigned int j = 0; j < indice; j++) {
      temp = temp->suivant;
      if (temp == NULL) {cout << "Erreur Liste::iemeElement : indice trop grand"; exit(1);}
  }
  return temp->info;
}

void Liste::modifierIemeElement (unsigned int indice, ElementL e) {
  Cellule * temp = prem;
  for (unsigned int j = 0; j < indice; j++) {
      temp = temp->suivant;
      if (temp == NULL) {cout << "Erreur Liste::iemeElement : indice trop grand"; exit(1);}
  }
  temp->info = e;
}

void Liste::afficherGaucheDroite () const {
    Cellule * temp = prem;
    while (temp != NULL) {
        afficherElementL(temp->info);
        cout << " ";
        temp = temp->suivant;
    }
    cout << endl;
}

void Liste::afficherDroiteGauche () const {
    Cellule * temp = last;
    while (temp != NULL) {
        afficherElementL(temp->info);
        cout << " ";
        temp = temp->precedent;
    }
    cout << endl;
}

void Liste::ajouterEnTete (ElementL e) {
  Cellule * temp = new Cellule;
  temp->info = e;
  temp->suivant = prem;
  temp->precedent = NULL;

  // Attention au cas d'une liste qui etait vide
  if (estVide()) last = temp;
  else prem->precedent = temp;

  prem = temp;
}

void Liste::supprimerTete () {
  Cellule * temp = prem;
  prem = prem->suivant;
  if(prem != NULL) prem->precedent = NULL;
  else last = NULL;
  delete temp;
}

void Liste::ajouterEnQueue (ElementL e) {
  if (estVide()) ajouterEnTete(e);
  else {
      Cellule * temp = new Cellule;
      temp->info = e;
      temp->suivant = NULL;
      temp->precedent = last;

      last->suivant = temp;
      last = temp;
    }
}

int Liste::rechercherElement (ElementL e) const {
  Cellule * temp = prem;
  bool trouve = false;
  int pos = 0;
  while ((temp != NULL) && !trouve) {
      if (estEgalElementL(temp->info, e)) trouve = true;
      else {
          temp = temp->suivant;
          pos++;
      }
  }
  if (trouve) return pos;
  else return -1;
}

void Liste::insererElement (ElementL e, unsigned int indice) {
  Cellule *c, *nouv;

  if (estVide() || (indice == 0)) ajouterEnTete(e);
  else if (indice == nbElements()) ajouterEnQueue(e);
  else {
      // 1 <= indice < nombre d'elements
      c = prem;
      for (unsigned int i = 0; i < indice; i++) c = c->suivant;
      // c pointe sur la cellule avant laquelle il faut inserer e
      nouv = new Cellule;
      nouv->info = e;
      nouv->suivant = c;
      nouv->precedent = c->precedent;

      c->precedent->suivant = nouv;
      c->precedent = nouv;
    }
}

void Liste::trier() {
    // Tri par insertion
    if (prem == NULL || prem->suivant == NULL) return ; // rien a faire si moins de 2 elements

    Cellule * dernieretriee = prem;
    Cellule * aplacer = prem->suivant;
    Cellule * c;

    while (aplacer != NULL) { // boucle principale sur les elements a placer
        c = prem;
        while ((c != aplacer) && (c->info < aplacer->info)) c = c->suivant;
        // En sortie du while, on sait que :
          // (1) soit c->info est superieur a aplacer->info : on doit inserer aplacer entre le precedent de c et c.
          // (2) soit c == aplacer : aplacer est a sa place

        Cellule * precC = c->precedent;
        Cellule * precAPlacer = aplacer->precedent;
        Cellule * suivAPlacer = aplacer->suivant;

        if (c != aplacer) {  // cas 1
            if (precC != NULL) precC->suivant = aplacer;
            else prem = aplacer;
            if (suivAPlacer == NULL) last = precAPlacer;
            else suivAPlacer->precedent = precAPlacer;
            // deinsertion aplacer
            precAPlacer->suivant = suivAPlacer;
            // insertion [precC,C]
            aplacer->suivant = c;
            aplacer->precedent = precC;
            c->precedent = aplacer;
            // iteration
            dernieretriee->suivant = suivAPlacer;
        }
        else { // cas 2
            dernieretriee = aplacer;
        }
        aplacer = dernieretriee->suivant;
    }
}

