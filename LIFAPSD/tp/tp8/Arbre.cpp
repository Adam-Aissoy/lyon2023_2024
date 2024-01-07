#include "ElementA.h"
#include "Arbre.h"

#include <stdlib.h>
#include <iostream>
using namespace std;

#include "File.h"
#include "Pile.h"

Arbre::Arbre () {
    adRacine = NULL;
}

Arbre::~Arbre () {
	vider();
}

void Arbre::vider () {
    detruireDepuisNoeud(adRacine);
}

void Arbre::detruireDepuisNoeud(Noeud * & n) {
    if (n != NULL) {
        detruireDepuisNoeud(n->fg);
        detruireDepuisNoeud(n->fd);
        delete n;
		n = NULL;
    }
}

bool Arbre::estVide () const {
    return adRacine == NULL;
}

void Arbre::insererElement (ElementA e) {
    insererElementDepuisNoeud(e, adRacine);
}

void Arbre::insererElementDepuisNoeud(ElementA e, Noeud * & n) {
    if (n == NULL) {
        /* le sous arbre est vide */
        n = new Noeud;
        n->info = e;
        n->fg = NULL;
        n->fd = NULL;
    }
    else  {
        if (estInferieurElementA(e, n->info)) insererElementDepuisNoeud(e, n->fg);
        else if (estSuperieurElementA(e, n->info)) insererElementDepuisNoeud(e, n->fd);
        /* rien à faire sinon, déjà présent, arrêt de la récursion */
    }
}

void Arbre::afficherParcoursInfixe () const {
    affichageParcoursInfixeDepuisNoeud(adRacine);
    cout << endl;
}

void Arbre::affichageParcoursInfixeDepuisNoeud (const Noeud * n) const {
    if (n != NULL) {
      affichageParcoursInfixeDepuisNoeud(n->fg);
      afficherElementA(n->info);
      cout << " " ;
      affichageParcoursInfixeDepuisNoeud(n->fd);
    }
}

void Arbre::rechercherElement (ElementA e, bool & trouve, int & nb_visites) const {
    Noeud * n = adRacine;
    trouve = false;
    nb_visites = 0;
    while (n != NULL) {
        nb_visites++;
        if (estEgalElementA(e, n->info)) {
            trouve = true;
            return;
        }
        else if (estInferieurElementA(e, n->info)) n = n->fg;
        else n = n->fd;
    }
}

int Arbre::hauteurArbre () const {
    return calculHauteurDepuisNoeud(adRacine);
}

int Arbre::calculHauteurDepuisNoeud(const Noeud * n) const {
    /* Rappel : hauteur d'un arbre = longueur de sa plus longue branche.
       La hauteur d'un arbre vide est -1.
       Le principe de calcul est le suivant :
         - si un sous-arbre est vide, alors sa hauteur vaut -1
         - sinon, sa hauteur vaut 1 + max(hauteur fils gauche, hauteur fils droit)
    */
    int hgauche, hdroit, res;
    if (n == NULL) res = -1;
    else  {
        hgauche = calculHauteurDepuisNoeud(n->fg);
        hdroit = calculHauteurDepuisNoeud(n->fd);
        if (hgauche > hdroit) res = hgauche + 1;
        else res = hdroit + 1;
    }
    return res;
}

/* FONCTIONS D'AFFICHAGE (exercices 2 et 3) */
void Arbre::afficherParcoursEnLargeur () const {
    File f;
    Noeud * n;

    if (estVide()) { cout << "Arbre vide" << endl; return ; }

    f.enfiler(adRacine);
    while (!f.estVide()) {
        n = (Noeud *) f.premierDeLaFile();
        f.defiler();
        afficherElementA(n->info);
        cout << " ";
        if (n->fg != NULL) f.enfiler(n->fg);
        if (n->fd != NULL) f.enfiler(n->fd);
    }
    cout << endl;
}

void Arbre::afficherParcoursPostfixe () const {
    Pile pileA, pileB;
    Noeud * n;

    if (estVide()) { cout << "Arbre vide" << endl; return; }

    pileB.empiler(adRacine);

    while (!pileB.estVide()) {
        n = (Noeud *) pileB.consulterSommet();
        pileB.depiler();
        pileA.empiler(n);
        if (n->fg != NULL) pileB.empiler(n->fg);
        if (n->fd != NULL) pileB.empiler(n->fd);
    }

    while (!pileA.estVide()) {
        n = (Noeud *) pileA.consulterSommet();
        afficherElementA(n->info);
        cout << " ";
        pileA.depiler();
    }
    cout << endl;
}
