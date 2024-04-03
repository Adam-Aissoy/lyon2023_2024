hors_de(X, L) :- \+ member(X, L).

valeur(X, Xmin, Xmax, L) :-
    between(Xmin, Xmax, X),
    hors_de(X, L).

trente([V, I, N, G, T, C, Q, R, E]) :-
    valeur(V, 1, 9, []),
    valeur(I, 0, 9, [V]),
    valeur(N, 0, 9, [V, I]),
    valeur(G, 0, 9, [V, I, N]),
    valeur(T, 1, 9, [V, I, N, G]),
    valeur(C, 1, 9, [V, I, N, G, T]),
    valeur(Q, 0, 9, [V, I, N, G, T, C]),
    valeur(R, 0, 9, [V, I, N, G, T, C, Q]),
    valeur(E, 0, 9, [V, I, N, G, T, C, Q, R]),
    
    E is (T + Q + Q) mod 10,
    R is (T + Q + Q) // 10,
    N is (G + C + C + R) mod 10,
    G is (I + I + C) mod 10,
    C is (V + N + N) mod 10,
    T is (V + C + C) mod 10.
/*
my pseudo code :
    - on va recuperer l'indice de l'un pour verifier s'il est dans la meme position que l'autre 
*/


% Définition du prédicat meme_maison(X,L1,Y,L2)
meme_maison(X, [X|_], Y, [Y|_]).
meme_maison(X, [_|L1], Y, [_|L2]) :- meme_maison(X, L1, Y, L2).

% Définition du prédicat maison_a_cote(X,L1,Y,L2)
maison_a_cote(X, [X,Y|_], Y, [Y,X|_]).
maison_a_cote(X, [Y,X|_], Y, [X,Y|_]).
maison_a_cote(X, [_|L1], Y, [_|L2]) :- maison_a_cote(X, L1, Y, L2).

% Définition du prédicat maison_a_droite(X,Y,L)
maison_a_droite(X, Y, [X,Y|_]).
maison_a_droite(X, Y, [_|L]) :- maison_a_droite(X, Y, L).

% Définition du prédicat zebre(C,N,B,A,P,PossZebre,BoitVin)
zebre(C,N,B,A,P,PossZebre,BoitVin) :-
    % Attribution des valeurs
    permutation([anglais,espagnol,japonais,norvegien,italien], N),
    permutation([rouge,vert,bleu,blanche,jaune], C),
    permutation([chien,escargot,renard,cheval,zebre], A),
    permutation([the,cafe,jus_de_fruit,vin,lait], B),
    permutation([peintre,sculpteur,diplomate,medecin,violoniste], P),
    % Règles
    meme_maison(anglais, N, rouge, C),
    meme_maison(espagnol, N, chien, A),
    meme_maison(japonais, N, peintre, P),
    meme_maison(italien, N, the, B),
    maison_a_droite(norvegien, bleu, C),
    meme_maison(vert, C, cafe, B),
    maison_a_cote(vert, C, blanche, C),
    meme_maison(sculpteur, P, escargot, A),
    meme_maison(diplomate, P, jaune, C),
    maison_a_cote(lait, B, lait, B),
    maison_a_cote(norvegien, C, bleu, C),
    meme_maison(violoniste, P, jus_de_fruit, B),
    maison_a_cote(renard, A, medecin, P),
    maison_a_cote(cheval, A, diplomate, P),
    % Résultats
    meme_maison(zebre, A, PossZebre, N),
    meme_maison(vin, B, BoitVin, N).

% Test du prédicat zebre
:- zebre(C,N,B,A,P,PossZebre,BoitVin), write([C,N,B,A,P,PossZebre,BoitVin]), nl.

