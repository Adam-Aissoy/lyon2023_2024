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