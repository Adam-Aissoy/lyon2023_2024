/*
nom : ADAM 
prenom : Oumar Adam
numero etudiant : p2110686
*/
/*Exercice 1 
partage(L,X,L1,L2)


*/
partage([],_,[],[]).
partage([X|L],Y,L1,L2):- X<Y, L1=[X|L3], partage(L,Y,L3,L2).
partage([X|L],Y,L1,L2):- X>=Y, L2=[X|L3], partage(L,Y,L1,L3).

/*test assert by Adam*/
/* assert(partage([3,1,4,7,5,8,2],4,L1,L2),L1 = [3, 1,2],L2 = [4,7, 5, 8]).*/
/*

?- [adam].
true.

?- partage([3,1,4,7,5,8,2],4,L1,L2).
L1 = [3, 1, 2],
L2 = [4, 7, 5, 8] ;
false.

*/




/*Exercice 2.
remplace(L,Lr,NL)

*/
remplace([],_,[]).
remplace([X|L],Lr,R):- member([X,Y],Lr), R=[Y|L2], remplace(L,Lr,L2).
remplace([X|L],Lr,R):- not(member([X,_],Lr)), R=[X|L2], remplace(L,Lr,L2).
/*test 


?- remplace([a,z,e,r,t,y,e,y,o,p],[[a,g],[y,u]],R).
R = [g, z, e, r, t, u, e, u, o|...] ;
false.

?-
*/


/*Exercice 3
liaison(paris,lyon).
liaison(paris,newyork).
liaison(lyon,bruxelles).
liaison(bruxelles,newyork).
liaison(lyon,strasbourg).
liaison(strasbourg,franckfort).
la liaison peut etre empruntée dans le deux sens comme celui de labyrinthe

*/
liaison(paris,lyon).
liaison(paris,newyork).
liaison(lyon,bruxelles).
liaison(bruxelles,newyork).
liaison(lyon,strasbourg).
liaison(strasbourg,franckfort).


/*voyager(Ville1,Ville2,Trajet)
.*/
/* definition du predicat voyager */
liaison(X,Y):-liaison(Y,X).
voyager(Ville1,Ville2,direct):- liaison(Ville1,Ville2),liaison(Ville2,Ville1), Ville1\=Ville2.
voyager(Ville1,Ville2,[Ville3|L]):- liaison(Ville1,Ville3), liaison(Ville3,Ville2), Ville1\=Ville2.
voyager(Ville1,Ville2,[]):- not(liaison(Ville1,Ville2)).


/*
voyager(Ville1,Ville2,direct):- liaison(Ville1,Ville2).
voyager(Ville1,Ville2,[Ville3|L]):- liaison(Ville1,Ville3), liaison(Ville3,Ville2), Ville1\=Ville2.
voyager(Ville1,Ville2,[]):- not(liaison(Ville1,Ville2)).
*/
/*test


?- voyager(lyon,paris,L).
L = direct ;
L = direct ;
L = direct ;
L = direct .

*/
/*
Exercice 4

*/
culture(A,B,C,D,E,F):- A=orge, D=tournesol, F=ble, B=mais, C=ble, E=orge.
/*test


?- culture(A,B,C,D,E,F).
A = E, E = orge,
B = mais,
C = F, F = ble,
D = tournesol.

?-*/


