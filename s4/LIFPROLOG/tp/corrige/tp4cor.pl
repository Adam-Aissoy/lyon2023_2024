/* TP4 */

/* Labyrinthe */

couloir(entree, thesee).
couloir(entree, ariane).
couloir(thesee, minotaure).
couloir(thesee,sombre).
couloir(claire, sombre).
couloir(claire, sortie).
couloir(minotaure, sortie).
couloir(ariane, claire).
couloir(sombre,sortie).

passage(X,Z) :- couloir(X,Z).
passage(X,Z) :- couloir(Z,X).

/* X et Y salles donnees, Liste resultat, Liste taboue donnee */
chemin(X, X, [X], _) :- !.
chemin(X, Y, [X|R], Ltaboue) :- passage(X,Z), not(member(Z,Ltaboue)), chemin(Z, Y, R, [Z|Ltaboue]).

/* Pour avoir une solution :
?- chemin(entree,sortie,Parcours,[entree]),member(ariane,Parcours),not(member(minotaure,Parcours)).
Parcours = [entree, ariane, claire, sombre, sortie] ;
Parcours = [entree, ariane, claire, sortie] ;
No
*/

/* Coupure */

/* soustrait(L1,L2,L3) soustrait les elements de L2 a L1 pour donner L3 */
/* version "sans coupure" */
/* soustrait(L1,L2,L3) : L3 est la liste L1-L2 */
soustrait([],_,[]).
soustrait([X|L],L2,L3) :- member(X,L2), soustrait(L,L2,L3).
soustrait([X|L],L2,[X|L3]) :- not(member(X,L2)), soustrait(L,L2,L3).

/*?- soustrait([a,b,c,d,e],[b,d],K).
K = [a, c, e] ;
No
*/

/* version avec coupure */
soustrait2([],_,[]).
soustrait2([X|L],L2,L3) :- member(X,L2), !, soustrait2(L,L2,L3).
soustrait2([X|L],L2,[X|L3]) :- soustrait2(L,L2,L3).

/* Meme fonctionnement, par contre si on enleve la coupure, le predicat donne des reponses fausses */
 
 
 /* disjoints avec la negation */
 disjoints(L1,L2) :- not((member(X,L1),member(X,L2))).
 
  /* Triangle de nombres */
 
 /* permutation */
 permute([],[]).
 permute(L,[X|L2]) :- member(X,L), enleve(X,L,L1), permute(L1,L2).
 
 enleve(_,[],[]).
 enleve(X,[X|L],L) :- !.
 enleve(X,[Y|L],[Y|L1]) :- enleve(X,L,L1). 
 
 /* triangle de nombres */
 /* triangle(liste_de_6_nombres) */
 triangle([N1,N2,N3,N4,N5,N6]) :- permute([1,2,3,4,5,6],[N1,N2,N3,N4,N5,N6]), M1 is N1+N2+N3,
 	M2 is N1+N6+N5, M3 is N3+N4+N5, M1==M2, M2==M3.
 	
 /* findall(L,triangle(L),L1), length(L1,N). donne 24 */
 
  /* premiere version : repond oui a aime(toto,jardinage) parce que n'unifie pas aime(toto,jardinage)
 avec la tete de clause aime(X,sport) et passe donc directement a la suivante */
 jeune(alfred).
 jeune(toto).
 aime(X,sport) :- jeune(X),!.
 aime(_,jardinage).
 
 /* version corrigee */
 aime2(X,Quoi) :- jeune(X),!,Quoi=sport.
 aime2(_,jardinage).
 
 
 /* inserer(X,L1,L2) l'insertion de X dans la liste triée L1 donne L2 */
 inserer(X,[],[X]).
 inserer(X,[Y|L],[X,Y|L]) :- X=<Y.
 inserer(X,[Y|L],[Y|L1]) :- X>Y, inserer(X,L,L1).
 
 /* version en remplaçant le test par une coupure */
 inserer2(X,[],[X]).
 inserer2(X,[Y|L],[X,Y|L]) :- X=<Y,!.
 inserer2(X,[Y|L],[Y|L1]) :- inserer2(X,L,L1).
 
 /* meme probleme que precedemment pour le test faux : n'unifie pas avec la tete de clause
 donc ne passe pas sur la coupure. Moralite : comme d'habitude, quand on ecrit le predicat en
 pensant a une utilisation (ici calculer le troisieme argument) il est dangereux de l'utiliser
 autrement */
 
 /* version qui marche 	aussi dans le cas du test faux */
 inserer3(X,[],[X]).
 inserer3(X,[Y|L],T) :- X=<Y,!,T=[X,Y|L].
 inserer3(X,[Y|L],[Y|L1]) :- inserer3(X,L,L1).
