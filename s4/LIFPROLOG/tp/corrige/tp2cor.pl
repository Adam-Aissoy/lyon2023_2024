/* Tri bulles */
/* bulle(L1,L2) L1 liste de nb donnee, L2 liste de nb resultat, dont le minimum est en premier */
bulle([],[]).
bulle([X],[X]).
bulle([X|L],[X,Z|L1]) :- bulle(L,[Z|L1]), X=<Z.
bulle([X|L],[Z,X|L1]) :- bulle(L,[Z|L1]), X>Z.

/* dans cette premiere version, on peut effectuer l'appel recursif pour rien, a cause du test apres,
d'ou une deuxieme version*/

bulle2([],[]).
bulle2([X],[X]).
bulle2([X|L],[Min,Max|L1]) :- bulle2(L,[Z|L1]), Min is min(X,Z), Max is max(X,Z).

/* tribulle(L,Lt) L liste de nb donnee, Lt liste de nb resultat, triee */
tribulle([],[]).
tribulle([X|L],[Z|L2]) :- bulle2([X|L],[Z|L1]), tribulle(L1,L2).

/* Arbres binaires */

a1([6,[4,[1,[],[]],[8,[],[]]],[9,[],[]]]).
a2([6,[4,[1,[],[]],[]],[9,[],[]]]).

/* appartenance a un arbre */
/* test et generation, la generation donne un parcours d'arbre */

element1(X,[X,_,_]).
element1(X,[Y,G,_]) :- X\==Y, element1(X,G).
element1(X,[Y,_,D]) :- X\==Y, element1(X,D).
/* donne un parcours prefixe */

element2(X,[Y,G,_]) :- X\==Y, element2(X,G).
element2(X,[X,_,_]).
element2(X,[Y,_,D]) :- X\==Y, element2(X,D).
/* donne un parcours infixe */

element3(X,[Y,G,_]) :- X\==Y, element3(X,G).
element3(X,[Y,_,D]) :- X\==Y, element3(X,D).
element3(X,[X,_,_]).
/* donne un parcours postfixe */

/* liste des feuilles d'un arbre */
/* feuilles(A,L) A arbre donne, L liste resultat */
feuilles([],[]).
feuilles([N,[],[]],[N]).
feuilles([_,G,[]],L) :-G\==[], feuilles(G,L).
feuilles([_,[],D],L) :-D\==[], feuilles(D,L).
feuilles([_,G,D],L) :- G\==[], D\==[],feuilles(G,L1),feuilles(D,L2), append(L1,L2,L).
/* un predicat "feuille(A)" vrai si A est une feuille permettrait de simplifier ce predicat */

/* Arbres binaires de recherche */
abr1([6,[4,[1,[],[]],[5,[],[]]],[9,[],[]]]).
abr2([6,[4,[1,[],[]],[]],[9,[],[]]]).


/* insertion d'un element aux feuilles d'un ABR */
/* insere(X,A,R) X nb donne, A ABR donne, R ABR resultat */
insere(X,[],[X,[],[]]).
insere(X,[N,G,D],[N,G1,D]) :- X =< N, insere(X,G,G1). 
insere(X,[N,G,D],[N,G,D1]) :- X > N, insere(X,D,D1). 

/* calcul et suppression du maximum : suprmax(ABR donne, nb resultat,ABR resultat prive du max) */
suprmax([N,G,[]],N,G).
suprmax([N,G,D],M,[N,G,D1]) :- D\==[], suprmax(D,M,D1).

/* suppression d'un element dans un ABR : supr(nb donne, ABR donne, ABR resultat) */
supr(_,[],[]).
supr(X,[N,G,D],[N,G1,D]) :- X<N, supr(X,G,G1).
supr(X,[N,G,D],[N,G,D1]) :- X>N, supr(X,D,D1).
supr(X,[X,[],D],D).
supr(X,[X,G,[]],G) :- G\==[].
supr(X,[X,G,D],[M,G1,D]) :- G\==[], D\==[], suprmax(G,M,G1).

/* construction d'un ABR (resultat) a partir d'une liste (donnee) */
construire([],[]).
construire([X|L],A) :- construire(L,A1), insere(X,A1,A).

/* tri d'une liste via la construction d'un ABR */
/* L liste de nb donnee, L1 liste de nb triee resultat */
triarbre(L,L1) :- construire(L,A), infixe(A,L1).

/* liste (resultats) du parcours infixe d'un arbre (donne) */
infixe([],[]).
infixe([N,G,D],L) :- infixe(G,L1), infixe(D,L2), append(L1,[N|L2],L).

/* Ensembles */
/* to_list(L1,L2) L1 liste donnee, L2 liste resultat sans repetition */
to_list([],[]).
to_list([X|L],[X|L2]) :- elimine_tout(L,X,L1), to_list(L1,L2).

elimine_tout([],_,[]).
elimine_tout([X|L],X,L1) :- elimine_tout(L,X,L1).
elimine_tout([Y|L],X,[Y|L1]) :- X\==Y, elimine_tout(L,X,L1).

/* deux listes-ensembles donnees */
inclus([],_).
inclus([X|L],L1) :- member(X,L1), inclus(L,L1).

/* L1 L2 deux listes-ensembles donnees, L3 resultat */
inter(L1,L2,L3) :- findall(X,(member(X,L1),member(X,L2)),L3).

inter2([],_,[]).
inter2([X|L1],L2,[X|L3]) :- member(X,L2), inter2(L1,L2,L3).
inter2([X|L1],L2,L3) :- not(member(X,L2)), inter2(L1,L2,L3).