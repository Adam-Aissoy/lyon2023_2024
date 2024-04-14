/*  
nom : Adam 
prenom : Oumar Adam
numero : p2110686
*/

/*recherche(EtatCourant,EtatFinal,ListeTaboue,ListeOp) tous donnes sauf ListeOp */
:- dynamic interdit/1.

recherche(Ef,Ef,_,[]) :- !.
recherche(Ec,Ef,Lt,[Op|Lop]) :- operateur(Ec,Op,Es),
						not(member(Es,Lt)),
						not(interdit(Es)),
						write(Ec), write(' '), write(Op), write(' '), write(Es),nl,
						recherche(Es,Ef,[Es|Lt],Lop).


resoudre(Sol) :- initial(Ei), final(Ef), recherche(Ei,Ef,[Ei],Sol).



/* 1 --------------- */
initial([[2,8,3],[1,6,4],[7,Vide,5]]).
final([[1,2,3],[8,Vide,4],[7,6,5]]).


/*les 4 operateurs pour resoudre le probleme du taquin*/
operateur([[Vide,X,Y,Z],Q],pousser_bas,[[X,Vide,Y,Z],Q]).
operateur([[X,Vide,Y,Z],Q],pousser_haut,[[Vide,X,Y,Z],Q]).
operateur([[X,Y,Vide,Z],Q],pousser_gauche,[[X,Y,Vide,Z],Q]).
operateur([[X,Y,Z,Vide],Q],pousser_droite,[[X,Y,Z,Vide],Q]).


/*
test 

?- trace(resoudre).
%         resoudre/1: [all]
true.
 (13) pousser_haut([[2, 8, 3], [1, 6, 4], [7, _102, 5]], _198) ?



*/

/*resoudre(Sol) :- initial(Ei), final(Ef), recherche(Ei,Ef,[Ei],Sol).
test operateur 
?- operateur([[2,8,3,1,6,4,7,Vide,5],pousser_haut,[1,8,3,2,6,4,7,Vide,5]).
*/





/*2---------------- */
resoudrePlus(Videst) :- initial(Ei), final(Ef), recherchePlus(Ei,Ef,[Ei],Sol), length(Sol, N), write(N), nl, write(Sol), nl, Dest = Ef.
recherchePlus(Ef,Ef,_,[]) :- !.
recherchePlus(Ec,Ef,Lt,[Op|Lop]) :- operateur(Ec,Op,Es),
						not(member(Es,Lt)),
						not(interdit(Es)),
						write(Ec), write(' '), write(Op), write(' '), write(Es),nl,
						recherche+(Es,Ef,[Es|Lt],Lop).

/*
test


*/

/*test*/
/*resoudrePlus(Sol) :- initial(Ei), final(Ef), recherchePlus(Ei,Ef,[Ei],Sol).
*/

/*3----------------*/
resoudre_min(Videst) :- initial(Ei), final(Ef), recherche_min(Ei,Ef,[Ei],Sol), length(Sol, N), write(N), nl, write(Sol), nl, Dest = Ef.
recherche_min(Ef,Ef,_,[]) :- !.
recherche_min(Ec,Ef,Lt,[Op|Lop]) :- operateur(Ec,Op,Es),
						not(member(Es,Lt)),
						not(interdit(Es)),
						write(Ec), write(' '), write(Op), write(' '), write(Es),nl,
						recherche_min(Es,Ef,[Es|Lt],Lop).
/* test all predicats */
/*assert(operateur([2,8,3,1,6,4,7,Vide,5],[[2,8,3,1,6,4,Vide,7,5]], [1,8,3,2,6,4,7,Vide,5]),[1,8,3,2,6,4,7,Vide,5]).*/
/*assert(pousser_haut([2,8,3,1,6,4,7,Vide,5],[1,8,3,2,6,4,7,Vide,5]),[1,8,3,2,6,4,7,Vide,5]).*/
				

