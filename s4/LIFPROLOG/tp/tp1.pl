/*tp 1*/
homme(albert).
homme(jean).
homme(paul).
homme(bertrand).
homme(dominique).
homme(benoit).
femme(germaine).
femme(christiane).
femme(simone).
femme(marie).
femme(sophie).
pere(albert,jean).
pere(jean,paul).
pere(paul,bertrand).
pere(paul,sophie).
pere(jean,simone).
pere(louis,benoit).
mere(germaine,jean).
mere(christiane,simone).
mere(christiane,paul).
mere(simone,benoit).
mere(marie,bertrand).
mere(marie,sophie).
/*
2.2 Questions
Traduire les questions suivantes en Prolog et vérifier les réponses :
Est-ce que Paul est un homme ? 
Est-ce que Benoit est une femme ?
Qui est une femme ?
Qui est un homme ?
Est-ce que Marie est la mère de Sophie ? de 
Benoit ?
Qui est la mère de Jean ?
Quels sont les enfants de Paul ?
Quels sont les hommes qui sont pères ?
--test Adam Aysoy 
mere(marie, sophie).
mere(marie, benoit).
*/


/*
Définition de prédicats
Définir les prédicats suivants :
• parent(X,Y) : X est un parent de Y, pere ou
mere ;
• fils(X,Y) : X est le fils de Y ;
• fille(X,Y) : X est la fille de Y ;
• grand_pere(X,Y) : X est le grand-père de Y ;
• grand_mere(X,Y) : X est la grand-mère de Y ;
• frere(X,Y) : X est le frère de Y ;
• sœur(X,Y) : X est la sœur de Y.
*/
parent(X,Y) :- pere(X,Y),mere(X,Y).
fils(X,Y) :- homme(X),parent(Y,X).
fille(X,Y) :- femme(X),parent(Y,X).
grand_pere(X,Y) :- homme(X),pere(X,Z),parent(Z,Y).
grand_mere(X,Y) :- femme(X),mere(X,Z),parent(Z,Y).
frere(X,Y) :- homme(X),parent(Z,X),parent(Z,Y),X\=Y.
soeur(X,Y) :- femme(X),parent(Z,X),parent(Z,Y),X\=Y.

/*
Traduction d’énoncés
Traduire en Prolog l'énoncé suivant :
Marie aime le vin
Pierre est un voleur
Pierre aime tous ceux qui aiment le vin
Si quelqu'un est un voleur et aime quelque chose alors il le vole
Qui vole quoi ?
*/
aime(marie,vin).
voleur(pierre).
aime(pierre,X) :-aime(X,vin).
vole(X,Y) :- voleur(X),aime(X,Y).

/*
Unification
Que donnent les unifications suivantes :
pierre=marie.
X=jean.
X=Y.
pierre=aime(X,Y).
pere(X,Y)=aime(T,jean).
X=parent(Y,paul).
[X,Y]=[a,b,c].
[X,Y|L]=[a,b,c].
[X|L]=[X,Y|L2].
pere(X,fille(X))=pere(jean,Y).
*/
/*
Exercices sur les listes
• Définir le prédicat longueur(L,N), qui étant donnée la liste L calcule sa longueur N.
• Définir le prédicat concat(L1,L2,L3) où L3 est le résultat de la concaténation de L1 et L2 (sans
utiliser append).
• Définir le prédicat palindrome(L) vrai si la liste L est sa propre image renversée.
• Définir un prédicat rang_pair(X,Y) qui extrait les éléments de la liste X qui ont des indices de
rang pair afin de construire la liste Y. Ex. rang_pair([a,b,c,d,e],L). -> L=[b,d]
• Définir le prédicat indice(X,L,N), qui étant donnés un élément X et une liste L, X appartenant à L,
calcule N l’indice de la première occurrence de X dans L. Peut-on utiliser ce prédicat pour formuler
une requête permettant de calculer le ième élément d’une liste ?
• Écrire le prédicat remplace(X1,X2,L1,L2) qui construit la liste L2 qui est la liste L1 dans laquelle
X1 est remplacé par X2.
• Écrire le prédicat somme(L,R) qui si L = (x1, x2, . . . , xn) calcule R =
€
ixi
i=1
n
∑
• Définir le prédicat partage(L,X,L1,L2), qui étant donnés une liste de nombre L et un nombre X,
calcule la liste L1 des nombres de L inférieurs à X, et la liste L2 des nombres de L supérieurs ou
égaux à X.
*/
longueur([],0).
longueur([_|Q],N) :- longueur(Q,NQ), N is NQ+1.

concat([],[],[]).
concat([],L2,L2).
concat(L1,[],L1).
concat([T|Q],L2,[T|L3]) :- concat(Q,L2,L3).

/* je veux le predicat palindrome sans utiliser le predicat renverse */
palindrome([]).
palindrome([_]).
palindrome([T|Q]) :- append(Reste_Liste,[X],Q),T==X,palindrome(Reste_Liste).


rang_pair([],[]).
rang_pair([_],[]).
rang_pair([_,Y|Q],[Y|L]) :- rang_pair(Q,L).

indice(X,L,N) :- append(Reste_Liste,[X|_],L),longueur(Reste_Liste,N).

/* version Adam Asyoy */
remplace1(X1,X2,L1,L2):- append(Reste_Liste,[X1|Q],L1),append(Reste_Liste,[X2|Q],L2).
/*version consigne Tp*/
remplace(_,_,[],[]).
remplace(X1,X2,[X1|Q],[X2|L]) :- remplace(X1,X2,Q,L).
remplace(X1,X2,[T|Q],[T|L]) :- x1\==x2,remplace(X1,X2,Q,L).




