#include "File.h"

File::File ()  { } //appel automatique au constructeur de Liste pour la donnée membre l

File::~File () { } //appel automatique au destructeur de Liste pour la donnée membre l

File& File::operator = (const File & f) { l = f.l; return *this; }

unsigned int File::nbElements () const { return l.nbElements(); }

void File::enfiler (ElementF e) { l.ajouterEnQueue(e); }

void File::defiler () { l.supprimerTete(); }

ElementF File::premierDeLaFile () const { return l.iemeElement(0); }

bool File::estVide () const { return l.estVide(); }
