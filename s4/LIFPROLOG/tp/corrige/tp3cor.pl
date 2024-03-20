/*** TP3 ***/

/* Cryptarithmetique */
/* hors_de(X,L) X element donne, L liste donnee */
hors_de(_,[]).
hors_de(X,[Y|L]) :- X =\= Y,hors_de(X,L).

/* valeur(X,Inf,Sup,Deja_pris) X entier resultat, Inf et Sup entiers donnes,
Deja_pris liste d'entiers donnee */
valeur(Inf,Inf,_,Deja_pris) :- hors_de(Inf,Deja_pris).
valeur(X,Inf,Sup,Deja_pris) :-
    Inf < Sup,
    Inf_plus_1 is Inf+1,
    valeur(X,Inf_plus_1,Sup,Deja_pris).

/* trente([V,I,N,G,T,C,Q,R,E]) tous les parametres sont des  resultats entiers */
/* version dans laquelle les variables sont affectees en colonne, avec les tests des que possible */
trente([V,I,N,G,T,C,Q,R,E]) :- 
    valeur(T,1,9,[]),
    valeur(Q,0,9,[T]),
    E is (T+Q+Q) mod 10,
    hors_de(E,[T,Q]),
    R1 is (T+Q+Q) // 10,
    valeur(G,0,9,[T,Q,E]),
    valeur(N,0,9,[T,Q,E,G]),
    T =:= (G+N+N+R1) mod 10,
    R2 is (G+N+N+R1) // 10, 
    valeur(I,0,9,[T,Q,E,G,N]),
    N =:= (N+I+I+R2) mod 10,
    R3 is (N+I+I+R2) // 10 ,
    valeur(C,1,9,[T,Q,E,G,N,I]),
    E =:= (I+C+C+R3) mod 10,   
    R4 is (I+C+C+R3) // 10 ,
    valeur(V,1,9,[T,Q,E,G,N,I,C]),
    valeur(R,0,9,[T,Q,E,G,N,I,C,V]),
    V+R4 =:= R+10*T,
    ecrit([V,I,N,G,T,C,Q,R,E]).

/* trente_ligne([V,I,N,G,T,C,Q,R,E]) tous les parametres sont des  resultats entiers */
/* version dans laquelle le test est effecute en ligne, donc apres que toutes les lettres
soient affectees, la combinatoire est bien plus grande */
trente_ligne([V,I,N,G,T,C,Q,R,E]) :- 
    valeur(T,1,9,[]),
    valeur(Q,0,9,[T]),
    valeur(E,0,9,[T,Q]),
    valeur(G,0,9,[T,Q,E]),
    valeur(N,0,9,[T,Q,E,G]),
    valeur(I,0,9,[T,Q,E,G,N]),
    valeur(C,1,9,[T,Q,E,G,N,I]),
    valeur(V,1,9,[T,Q,E,G,N,I,C]),
    valeur(R,0,9,[T,Q,E,G,N,I,C,V]),
	T+10*G+100*N+1000*I+10000*V+2*(Q+10*N+100*I+1000*C) =:= E+10*T+100*N+1000*E+10000*R+100000*T,
    ecrit([V,I,N,G,T,C,Q,R,E]).

/*  comparaison du temps d'execution des 2 versions :
?- time(trente_ligne([V,I,N,G,T,C,Q,R,E])).
% 8,320,578 inferences, 0.544 CPU in 0.545 seconds (100% CPU, 15294758 Lips)
?- time(trente([V,I,N,G,T,C,Q,R,E])).      
% 2,210 inferences, 0.001 CPU in 0.001 seconds (93% CPU, 2466518 Lips) */


ecrit([V,I,N,G,T,C,Q,R,E]) :- tab(5),
    write(V),write(' '),write(I),write(' '),write(N),write(' '),
    write(G),write(' '),write(T),nl,tab(3),write('+'),tab(3),
    write(C),write(' '),write(I),tab(1),write(N),tab(1),write(Q),nl,
    tab(3),write('+'),tab(3),
    write(C),write(' '),write(I),tab(1),write(N),tab(1),write(Q),nl,
    tab(3),write('_____________'),nl,tab(1),write('='),tab(1),
    write(T),tab(1),write(R),write(' '),
    write(E),tab(1),write(N),tab(1),write(T),tab(1),write(E),nl.

/* Zebre */
/* meme_maison(X,LX,Y,LY) X et Y elements, LX et LY listes.
X et Y sont donnes, les elements de LX et LY ne sont pas forcements fixes,
ils prendront leurs valeurs par unification */
meme_maison(X,[X|_],Y,[Y|_]).
meme_maison(X,[_|LX],Y,[_|LY]) :- meme_maison(X,LX,Y,LY).

/* similaire */
maison_a_cote(X,[X|_],Y,[_,Y|_]).
maison_a_cote(X,[_,X|_],Y,[Y|_]).
maison_a_cote(X,[_|LX],Y,[_|LY]) :- maison_a_cote(X,LX,Y,LY).

/* similaire */
maison_a_droite(X,Y,[X,Y|_]).
maison_a_droite(X,Y,[_|L]) :- maison_a_droite(X,Y,L).

/* tous les parametres sont des resultats */
zebre(C,N,B,A,P,PossZebre,BoitVin) :-
        C=[_,_,_,_,_],
        N=[norvegien,_,_,_,_],
        B=[_,_,lait,_,_],
        A=[_,_,_,_,_],
        P=[_,_,_,_,_],
        meme_maison(anglais,N,rouge,C),
        meme_maison(chien,A,espagnol,N),
        meme_maison(japonais,N,peintre,P),
        meme_maison(italien,N,the,B),
        meme_maison(verte,C,cafe,B),
        maison_a_droite(blanche,verte,C),
        meme_maison(sculpteur,P,escargots,A),
        meme_maison(diplomate,P,jaune,C),
        maison_a_cote(norvegien,N,bleu,C),
        meme_maison(violoniste,P,jus_de_fruit,B),
        maison_a_cote(renard,A,medecin,P),
        maison_a_cote(cheval,A,diplomate,P),
        meme_maison(PossZebre,N,zebre,A),
        meme_maison(BoitVin,N,vin,B). 

/*?- zebre(C,N,B,A,P,PossZebre,BoitVin).

C = [jaune, bleu, rouge, blanche, verte]
N = [norvegien, italien, anglais, espagnol, japonais]
B = [vin, the, lait, jus_de_fruit, cafe]
A = [renard, cheval, escargots, chien, zebre]
P = [diplomate, medecin, sculpteur, violoniste, peintre]
PossZebre = japonais
BoitVin = norvegien ;

No*/
