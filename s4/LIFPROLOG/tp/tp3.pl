 /*TP 3 

Cryptarithmétique
Il s’agit de trouver la valeur de chaque lettre de cette addition :
V I N G T
+ C I N Q
+ C I N Q
-------------
= T R E N T E
c’est-à-dire lier chaque lettre avec une valeur entre 0 et 9, sans que deux lettres différentes aient la
même valeur et sans que les chiffres les plus significatifs (les plus à gauche de chaque mot) ne
soient nuls.
• Définir le prédicat hors_de(X,L) qui est satisfait si X n’est pas élément de la liste L.
*/
hors_de(_,[]).
hors_de(X,[Y|L]) :- X\==Y, hors_de(X,L).
/*
Définir le prédicat valeur(X,Xmin,Xmax,L) qui donne une valeur entière X comprise entre Xmin
et Xmax qui n’est pas dans la liste L. C’est-à-dire qu’en demandant toutes les solutions au prédicat
quand X est inconnu, toutes les valeurs sont énumérées.
*/
valeur(X, X, _, L) :- hors_de(X, L).
valeur(X, Xmin, Xmax, L) :- 
    Xmin < Xmax,
    NextXmin is Xmin + 1,
    valeur(X, NextXmin, Xmax, L).
/*
• Définir le prédicat trente([V,I,N,G,T,C,Q,R,E]) qui trouve les valeurs qui permettent de résoudre
l’addition. Note : pour ce prédicat, vous avez besoin de calculer le modulo et la retenue.
– N is (9+3) 10 donne dans N la retenue de l’addition,
– N is (9+3) mod 10 donne dans N le modulo 10 de l’addition.
Pour cet exercice, vous devez, addition par addition, décrire l’équation dans son intégralité (E est le
modulo 10 de T + Q + Q, il y a peut-être une retenue, etc.).
La solution est : V = 9 I = 4 N = 8 G = 5 T = 1 C = 6 Q = 3 R = 0 E = 7
*/
trente([V,I,N,G,T,C,Q,R,E]) :- 
    valeur(V, 1, 9, []),
    valeur(I, 0, 9, [V]),
    valeur(N, 0, 9, [V,I]),
    valeur(G, 0, 9, [V,I,N]),
    valeur(T, 1, 9, [V,I,N,G]),
    valeur(C, 1, 9, [V,I,N,G,T]),
    valeur(Q, 0, 9, [V,I,N,G,T,C]),
    valeur(R, 0, 9, [V,I,N,G,T,C,Q]),
    valeur(E, 0, 9, [V,I,N,G,T,C,Q,R]),
    E is (T + Q + Q) mod 10,
    R is (T + Q + Q) // 10,
    N is (I + I + R) mod 10,
    G is (N + N + R) // 10,
    C is (I + I + R) // 10,
    V \== I, V \== N, V \== G, V \== T, V \== C, V \== Q, V \== R, V \== E,
    I \== N, I \== G, I \== T, I \== C, I \== Q, I \== R, I \== E,
    N \== G, N \== T, N \== C, N \== Q, N \== R, N \== E,
    G \== T, G \== C, G \== Q, G \== R, G \== E,
    T \== C, T \== Q, T \== R, T \== E,
    C \== Q, C \== R, C \== E,
    Q \== R, Q \== E,
    R \== E.

/* 
autre test 
*/


trente1([V, I, N, G, T, C, Q, R, E]) :-
    /* attribution des valeurs */
    valeur(V, 1, 9, []),
    valeur(I, 0, 9, [V]),
    valeur(N, 0, 9, [V, I]),
    valeur(G, 0, 9, [V, I, N]),
    valeur(T, 1, 9, [V, I, N, G]),
    valeur(C, 1, 9, [V, I, N, G, T]),
    valeur(Q, 0, 9, [V, I, N, G, T, C]),
    valeur(R, 0, 9, [V, I, N, G, T, C, Q]),
    valeur(E, 0, 9, [V, I, N, G, T, C, Q, R]),
    /* calculs */
    E is (T + Q + Q) mod 10.
    


/* Exécution */
/*   trente([V, I, N, G, T, C, Q, R, E]).  */ 




/*
Le zèbre
On considère cinq maisons, toutes de couleur différente (rouge, bleu, jaune, blanc, vert), dans
lesquelles logent cinq professionnels (peintre, sculpteur, diplomate, docteur et violoniste) de
nationalité différente (anglaise, espagnole, japonaise, norvégienne et italienne) ayant chacun une
boisson favorite (thé, jus de fruits, café, lait et vin) et un animal favori (chien, escargot, renard,
cheval et zèbre).
*/

