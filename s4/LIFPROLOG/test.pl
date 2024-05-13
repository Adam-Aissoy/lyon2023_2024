% CC AUTOMNE 2022 PRO-LOG

/* Définir un predicat porduitScalaire(L1, L2, L3) renvoie la somme de la multiplication des elements : L1 = (x1, x2) L2 = (y1, y2), L3 = X1*Y1 + X2*Y2 */

produitScalaire([],[],0).
produitScalaire([X|L1],[Y|L2], R):- produitScalaire(L1,L2,N), R is N + X * Y.

/* On supprime N fois l element X de la liste L, on renvoie la liste a jour danns R */

mystere(0,_,L,L):- !.
mystere(N,X,[X|L],R):- !,Nm1 is N - 1, mystere(Nm1,X,L,R).
mystere(N,X,[Y|L],[Y|R]):- mystere(N,X,L,R).