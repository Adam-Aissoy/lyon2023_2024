/*************** TP1 ****************/

homme(albert).
homme(jean).
homme(paul).
homme(bertrand).
homme(louis).
homme(benoit).

femme(germaine).
femme(christiane).
femme(simone).
femme(marie).
femme(sophie).

pere(albert,jean).
pere(jean,paul).
pere(paul,bertrand).
pere(paul,sophie).
pere(jean,simone).
pere(louis,benoit).

mere(germaine,jean).
mere(christiane,simone).
mere(christiane,paul).
mere(simone,benoit).
mere(marie,bertrand).
mere(marie,sophie). 

/* Questions a poser dans Prolog :
?- homme(paul).
Yes
?- femme(benoit).
No
?- femme(X).
X = germaine ;
X = christiane ;
X = simone ;
X = marie ;
X = sophie ;
No
?- homme(X).
X = albert ;
X = jean ;
X = paul ;
X = bertrand ;
X = louis ;
X = benoit ;
No
?- mere(marie,sophie).
Yes
?- mere(marie,benoit).
No
?- mere(X,jean).
X = germaine ;
No
?- pere(paul,X).
X = bertrand ;
X = sophie ;
No
?- homme(X),pere(X,_).
X = albert ;
X = jean ;
X = jean ;
X = paul ;
X = paul ;
X = louis ;
No
*/


/* X est un parent de Y, pere ou mere */

parent(X,Y) :- mere(X,Y).
parent(X,Y) :- pere(X,Y).

/* X est le fils de Y */

fils(X,Y) :- parent(Y,X),homme(X).

/*  X est la fille de Y */

fille(X,Y) :- parent(Y,X),femme(X).


/* X est le grand-pere de Y */

grand-pere(X,Y) :- parent(P,Y), pere(X,P).

/* X est la grand-mere de Y */

grand-mere(X,Y) :- parent(P,Y), mere(X,P).

/* X est le frere de Y */

frere(X,Y) :- homme(X), pere(P,X), pere(P,Y), mere(M,X), mere(M,Y), X \== Y.

/* X est la soeur de Y */

soeur(X,Y) :- femme(X), pere(P,X), pere(P,Y), mere(M,X), mere(M,Y), X \== Y.

/* Traduction d'enonces */
aime(marie,vin).
aime(pierre,X) :- aime(X,vin).
vole(X,Y) :- voleur(X), aime(X,Y).
voleur(pierre).
/* vole(X,Y) donne X=pierre et Y=marie */

/* Longueur d'une liste, la liste est donnee, le resultat est un entier */

longueur([],0).
longueur([_|Y],N) :- longueur(Y,M), N is M+1.

/* concat (on refait append). Les 2 premieres listes sont donnees, la troisieme est le resultat */
concat([],L,L).
concat([X|L1],L2,[X|L3]) :- concat(L1,L2,L3).

/* L est une liste palindrome (liste donnee) */

palindrome([]).
palindrome([_]).
palindrome([X|L]) :- append(L1,[X],L), palindrome(L1).

/* rang_pair(X,Y) extrait les elements de la liste X (donnee) qui ont des indices de rang pair afin de
 construire la liste Y (resultat) */
rang_pair([],[]).
rang_pair([_],[]).
rang_pair([_,Y|L],[Y|L2]) :- rang_pair(L,L2).

/* indice(X,L,N), calcule N (resultat) l'indice de la première occurrence de X (donnee) dans L (donnee), X appartenant a L */

indice(X,[X|_],1).
indice(X,[Y|L],N) :- X\==Y, indice(X,L,Nm1), N is Nm1+1.

/* pour trouver le ieme element d'une liste :
?- indice(X,[a,b,c,d,e],3).

X = c
*/

/* Remplacement des occurences de X dans une liste par Y. Les 3 premiers parametres sont des donnees, le dernier le resultat */

remplace(_,_,[],[]).
remplace(X,Y,[X|L1],[Y|L2]) :- remplace(X,Y,L1,L2).
remplace(X,Y,[Z|L1],[Z|L2]) :- Z \== X, remplace(X,Y,L1,L2).

/* Calcul (resultat) de la somme des (i*Xi) d'une liste donnee
Utilisation d'un accumulateur */

somme(L,R) :- sommebis(L,1,R).
sommebis([],_,0).
sommebis([X|L],I,S2) :- J is I+1, sommebis(L,J,S1), S2 is X*I+S1.

/* partage(L,X,L1,L2), L et X donnes, calcule L1 qui contient les elements de L inf a X,
 et L2 ceux sup ou = a X */
 partage([],_,[],[]).
 partage([Y|L],X,[Y|L1],L2) :- Y<X, partage(L,X,L1,L2).
 partage([Y|L],X,L1,[Y|L2]) :- Y>=X, partage(L,X,L1,L2).
 

