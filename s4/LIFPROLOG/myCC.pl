/*  
test cc1 Adam Aysoy 
*/
divisibles([],_,[]).
divisibles([X|L],Y,[X|L1]):- ModX is X mod Y,ModX =:=0, divisibles(L,Y,L1).
divisibles([X|L],Y,L1):- ModX is X mod Y,ModX =\=0, divisibles(L,Y,L1).