/*
Nom: Adam
Prenom : Oumar Adam
Numero : p2110686
*/
/* Tp resolution de probleme de satisfaction de contraintes */
/*1) 
*/
domaines(L) :- 
    L = [[1,[rouge,vert,bleu,jaune]],
        [2,[rouge,vert,bleu,jaune]],
        [3,[rouge,vert,bleu,jaune]],
        [4,[rouge,vert,bleu,jaune]],
        [5,[rouge,vert,bleu,jaune]],
        [6,[rouge,vert,bleu,jaune]],
        [7,[rouge,vert,bleu,jaune]]].
/* 
test
?- domaines(L).
L = [[1, [rouge, vert, bleu, jaune]], [2, [rouge, vert, bleu, jaune]], [3, [rouge, vert, bleu, jaune]], [4, [rouge, vert, bleu|...]], [5, [rouge, vert|...]], [6, [rouge|...]], [7, [...|...]]].
*/
voisins(X,Y) :- 
    L = [[1,2],[1,3],[1,7],[2,3],[2,4],[2,5],[3,4],[3,5],[3,6],[3,7],[4,5],[5,6],[6,7]],
    member([X,Y],L);member([Y,X],L).
   

/*test 

?- voisins(X,Y).
X = 1,
Y = 2 ;
X = 1,
Y = 3 ;
*/

consistants([X1,V1],[X2,V2]) :- 
    voisins(X1,X2) -> V1 \= V2;true.
consistants([X1,V1],[X2,V2]) :- 
    not(voisins(X1,X2)) -> V1 = V2;true.

/*
[5]  ?- consistants([1,rouge],[2,vert]).
true ;
true .
[13]  ?- consistants([1,rouge],[2,rouge]).
false.

*/
/*2)   genererEtTeste(Solution) 
?- genererEtTeste(Solution).
Solution = [[1, rouge], [2, jaune], [3, vert], [4, rouge], [5, bleu], [6, rouge], [7, bleu]] ;
*/



/*generer et tester */

tester(X,Y) :- 
    not((member(A,X),member(B,Y),consistants(A,B))).
tester([]).
tester([X|L]) :- 
    tester(X,L),tester(L).

genererEtTeste(Solution) :- 
    domaines(L),
    generer(L,Solution),
    tester(Solution).
generer([],[]).
generer([[X,D]|L],[[X,V]|S]) :- 
    member(V,D),
    generer(L,S).


/*test

?- generer(L,S).
L = S, S = [] ;
L = [[_A, [_B|_]]],
S = [[_A, _B]]
*/

/*

[6]  ?- genererEtTeste(Solution).
Solution = [[1, rouge], [2, rouge], [3, rouge], [4, rouge], [5, rouge], [6, rouge], [7, rouge]]
% Break level */


  
/*3) */
affectationPartielle(Solution) :- 
    domaines(L),
    affectationPartielle(L,[],Solution),
    tester(Solution).
affectationPartielle([],Solution,Solution).
affectationPartielle([[X,D]|L],Solution,Res) :- 
    member(V,D),
    affectationPartielle(L,[[X,V]|Solution],Res).

    /*
        affectationPartielle(Solution) .
Solution = [[7, rouge], [6, rouge], [5, rouge], [4, rouge], [3, rouge], [2, rouge], [1, rouge]] ;
    */






/**/
