somme([], 0).
somme([T|Q], S) :- somme(Q, SQ), S is T + SQ.
/*this is not ...*/
% Adam Aysoy commentaire
/* je veux une fonction qui return la multiplication */
/* de deux nombres */
mult(X,Y) :- mult(X,Y,0). /* 0 is the neutral element of the multiplication */
mult(0,_,0). /* 1 is the negative element of the multiplication
mult(X,Y,Z) :- X1 is X-1, mult(X1,Y,Z1), Z is Z1+Y. */  
