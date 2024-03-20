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
Le zèbre
On considère cinq maisons, toutes de couleur différente (rouge, bleu, jaune, blanc, vert), dans
lesquelles logent cinq professionnels (peintre, sculpteur, diplomate, docteur et violoniste) de
nationalité différente (anglaise, espagnole, japonaise, norvégienne et italienne) ayant chacun une
boisson favorite (thé, jus de fruits, café, lait et vin) et un animal favori (chien, escargot, renard,
cheval et zèbre).
On dispose des faits suivants :
1. l’Anglais habite la maison rouge
2. l’Espagnol possède un chien
3. le Japonais est peintre
4. l’Italien boit du thé
5. le Norvégien habite la première maison à gauche
6. le propriétaire de la maison verte boit du café
7. la maison verte est juste à droite de la blanche
8. le sculpteur élève un escargot
9. le diplomate habite la maison jaune
10. on boit du lait dans la maison du milieu
11. le Norvégien habite à coté de la maison bleue
12. le violoniste boit du jus de fruit
13. le renard est dans une maison voisine du médecin
14. le cheval est à coté de la maison du diplomate
Il s’agit de trouver le possesseur du zèbre et le buveur de vin.
On suppose que les maisons sont numérotées de 1 à 5 de gauche à droite. On gère une liste C de 5
couleurs, une liste N de 5 nationalités, une liste B de 5 boissons, une liste A de 5 animaux et une
liste P de 5 professions (il ne faut pas les définir, c’est Prolog qui les construira pour trouver la
solution).
Par exemple si les listes sont :
N = [anglais, italien, norvegien, . . .]
C = [rouge, vert, bleu, . . .]
A = [zebre, cheval, renard, . . .]
cela signifie que l’Italien vit dans la maison verte, qu’il a un cheval, etc., car italien, vert et cheval
occupent la même position dans les listes.
• Définir le prédicat meme_maison(X,L1,Y,L2) vrai si X et Y sont dans la même position dans les
listes L1 et L2. Par exemple pour le fait 1, on pourra dire que ‘anglais’ est à la même place dans la
liste N (liste des nationalités) que ‘rouge’ dans la liste C (liste des couleurs).
*/
meme_maison(X,L1,Y,L2