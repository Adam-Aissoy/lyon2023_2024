/*  
nom : Adam 
prenom : Oumar Adam
numero : p2110686
*/
/* 1 probleme du taquin */

initial([2,8,3,1,6,4,7,Vide,5]).
final([1,2,3,8,Vide,4,7,6,5]).
interdit([1,2,3,8,4,5,6,7,Vide]).

operateur([Vide,X,Y,Z|Q],pousser_bas,[X,Vide,Y,Z|Q]).
operateur([X,Vide,Y,Z|Q],pousser_haut,[Vide,X,Y,Z|Q]).
operateur([X,Y,Vide,Z|Q],pousser_gauche,[X,Y,Vide,Z|Q]).
operateur([X,Y,Z,Vide|Q],pousser_droite,[X,Y,Z,Vide|Q]).








/*quel est le nombre de coups de la premiere solution que vous trouvez ?*/
/*quel est le nombre de coups de la premiere solution que vous trouvez avec cette stratégie pour le probleme du taquin?*/


