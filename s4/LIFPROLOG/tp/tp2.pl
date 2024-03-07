/*
Définir le prédicat bulle(L1,L2) qui construit la liste L2 qui est la liste L1 dans laquelle l’élément
le plus petit est remonté en première place.
*/

/* Adam Aysoy Option  */
bulle([],[]).
bulle([X],[X]).
bulle([X|L1],[Y,X|L2]):- bulle(L1,[Y|L2]), X >= Y.
bulle([X|L1],[X,Y|L2]):- bulle(L1,[Y|L2]), X < Y.
/* Définir le prédicat tribulle(L1,L2) qui implémente le tri à bulles */

tribulle(L,L):- bulle(L,L).
tribulle(L1,L2):- bulle(L1,L3),tribulle(L3,L2).

/*
2. Arbre Binaire
Définir un prédicat qui vérifie l’appartenance d’un élément à un arbre. Comment le prédicat se
comporte-t-il en génération ? Que se passe-t-il si on inverse l’ordre des clauses ?
*/
appartient(X,[X,_,_]).
appartient(X,[Y,FG,_]):- 
    X\== Y, appartient(X,FG).
appartient(X,[Y,_,FD]):- 
    X\== Y, appartient(X,FD).
/*test Arbre */
arbreAdamAysoy([6,[4,[1,[],[]],[8,[],[]]],[9,[],[]]]).

/* Définir un prédicat qui construit la liste des valeurs des feuilles d’un arbre */
feuille([X,[],[]],[X]).
feuille([_,FG,FD],L):- feuille(FG,LG),feuille(FD,LD),append(LG,LD,L).

/*
3. Arbre binaire de recherche
On considère des arbres binaires de recherche (ABR) dont les étiquettes sont des nombres positifs.
• Définir un prédicat d'insertion d'un élément dans un ABR.
*/
insertion(X,[],[X,[],[]]).
insertion(X,[Y,FG,FD],[Y,FG1,FD]):- 
    X<Y, insertion(X,FG,FG1).
insertion(X,[Y,FG,FD],[Y,FG,FD1]):-
    X>Y, insertion(X,FD,FD1).
/*
Définir un prédicat qui calcule le plus grand élément d'un ABR et retourne également l'arbre privé
de cet élément.
*/
maxABR([X,[],[]],X,[]).
maxABR([X,FG,FD],M,[X,FG,FD1]):-FD\==[],
    maxABR(FD,M,FD1).
/*Définir un prédicat qui supprime un élément d'un ABR.*/
suppression(X,[X,[],[]],[]).
suppression(X,[X,FG,[]],FG).
suppression(X,[X,[],FD],FD).
suppression(X,[X,FG,FD],[M,FG,FD1]):- 
    maxABR(FG,M,FG1), suppression(M,FG,FG1),FD1=FD.
suppression(X,[Y,FG,FD],[Y,FG1,FD]):-
    X<Y, suppression(X,FG,FG1).
suppression(X,[Y,FG,FD],[Y,FG,FD1]):-
    X>Y, suppression(X,FD,FD1).
/* 
fonction somme Adam Aysoy test 
 */
somme([],0):-!.
somme([X|Queue],Res):- somme(Queue,Res1),Res is X+Res1.
