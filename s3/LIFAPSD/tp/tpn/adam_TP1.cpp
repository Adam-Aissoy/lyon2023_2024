#include <iostream>
using namespace std;
// using namespace string;
#include <string>

// TPn 1 

struct JeuPendu{
    string solution;
    string mot; 
    int essai;

};
void debutJeu(JeuPendu Jeu){
    cout<<"saisir la soulution"<<endl;
    cin>>Jeu.solution; 
    Jeu.essai = 10;

}
void afficherJeu(JeuPendu jeu ){
    cout<<"mot "<< jeu.mot<< endl; 
    cout<<"essais restant  "<< jeu.essai<< endl; 
 
}
void essaiCaractere (JeuPendu Jeu){

}
int main(){
    cout<< "je suis ici"<<endl;
    JeuPendu jeu; 
    afficherJeu(jeu);

    return 0; 
}