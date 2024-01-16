#include <iostream>
#include <cmath>
#include <stdlib.h> 
struct Vecteur3D {
    float x,y,z;
}; 
/* la norme de vecteur*/
float Vecteur3DGetNorme(const Vecteur3D &v) {
    return (sqrt(v.x*v.x + v.y*v.y + v.z*v.z));
}
void Vecteur3DNormaliser(Vecteur3D &v) {
    float intermediaire = Vecteur3DGetNorme(v);
    v.x = v.x/intermediaire; 
    v.y = v.y/intermediaire; 
    v.z = v.z/intermediaire;
    /*
    std::cout << v.x << " sep " << v.y << " sep " << v.z << std::endl;
    */
   std::cout<<Vecteur3DGetNorme(v)<<std::endl;
   
}
/* Verifie si le vecteur passer en par#include <stdlib.h> ametre est normaliser ou pas*/
bool Vecteur3DEstNormaliser( Vecteur3D &v){
    /*  j'ai rajouté */
    /*
    float intermediaire = Vecteur3DGetNorme(v);
    v.x = v.x/intermediaire; 
    v.y = v.y/intermediaire; 
    v.z = v.z/intermediaire;
    */
    if (Vecteur3DGetNorme(v)== 1) return true;
    else return false;
}
/* retoune la somme de deux vecteur*/
Vecteur3D Vecteur3DAdd(const Vecteur3D &v1, const Vecteur3D &v2){
    Vecteur3D newVecteur3d;
    newVecteur3d.x = v1.x+v2.x;newVecteur3d.y = v1.y+v2.y ; newVecteur3d.z = v1.z+v2.z;
    return(newVecteur3d);
}
/*Affiche le vecteur */
void Vecteur3DAfficher (const Vecteur3D &v){
    std::cout<<"vecteur"<<"= {"<<v.x<<","<<v.y<<","<<v.z<<"}" << std::endl;
}

/* Exercice 4 */
/* remplissage auto alea*/
void Vecteur3DRemplirTabVecteur (Vecteur3D  tab [] , int taille  ){
    for(int i=0; i<taille; i++){
        tab[i].x = ((rand()% 200 ) - 100)/10.0;
        tab[i].y = ((rand()% 200 ) - 100)/10.0;
        tab[i].z = ((rand()% 200 ) - 100)/10.0;
    }
}
/* Affichage Tableau de vecteur 3D*/
void Vecteur3DAfficherTabVecteur(Vecteur3D tab [],int taille ){
    std::cout<<"TableauVecteur = (";
    for(int i=0; i < taille; i++){
       Vecteur3DAfficher(tab[i]);
       std::cout<<";";
    }
    std::cout<<")"<<std::endl;
}
/*Une fonction Vecteur3DMaxTabVecteurs qui retourne l’indice du vecteur de plus grande norme dans
un tableau de vecteurs passé en paramètre. La taille du tableau est aussi passée en paramètre*/
int Vecteur3DMaxTabVecteurs(Vecteur3D tab [],int taille){
    int indice=0;
    int intermediaire = -1 ;
    for(int i=0;i<taille-1;i++){
        
        if(Vecteur3DGetNorme(tab[i])<Vecteur3DGetNorme(tab[i+1])){
            if(intermediaire < Vecteur3DGetNorme(tab[i+1])){
                intermediaire = Vecteur3DGetNorme(tab[i+1]); 
                indice = i+1;
            } 
        }
        else if(intermediaire < Vecteur3DGetNorme(tab[i])){
                intermediaire = Vecteur3DGetNorme(tab[i]); 
                indice = i;
            }
        // return indice;
    }
    return indice;
}
/* programme principale */
int main () {
    
    /* test mes fonctions */


    Vecteur3D vecteur1 = {5,2,1};
    Vecteur3D vecteur2 = {0,3,2};

    /*
    Vecteur3D testVec = {1/sqrt(3),1/sqrt(3),1/sqrt(3)};
    
    Vecteur3DGetNorme(testVec);
    std::cout<<"testVec avant la nrmalisation "<<std::endl;
    Vecteur3DAfficher (testVec);
    Vecteur3DNormaliser(testVec);
    Vecteur3DEstNormaliser(testVec); 
    std::cout<<"testVec apres la nrmalisation "<<std::endl;
    Vecteur3DAfficher(testVec);
    if (Vecteur3DEstNormaliser(testVec)) std::cout << " est testVec normalise" << std::endl;
    else std::cout << " n'est pas testVec normalise" << std::endl;
    
    
    */
    
    
    std::cout << "vecteur1 non normalise: ";
    Vecteur3DAfficher(vecteur1);
    std::cout << std::endl;
    std::cout << "vecteur2 non normalise: ";
    Vecteur3DAfficher(vecteur2);
    std::cout << std::endl;
    std::cout << "somme: ";
    Vecteur3DAfficher(Vecteur3DAdd(vecteur1,vecteur2));
    std::cout << std::endl;
    Vecteur3DNormaliser(vecteur1);
    Vecteur3DNormaliser(vecteur2);
    std::cout << "vecteur1 normalise: ";
    Vecteur3DAfficher(vecteur1);
    std::cout << std::endl;
    std::cout << "vecteur2 normalise: ";
    Vecteur3DAfficher(vecteur2);
    std::cout << std::endl;
    std::cout << "somme: ";
    Vecteur3D somme = Vecteur3DAdd(vecteur1,vecteur2);
    Vecteur3DAfficher(somme);
    if (Vecteur3DEstNormaliser(somme)) std::cout << " est normalise" << std::endl;
    else std::cout << " n'est pas normalise" << std::endl;

    /*exo 4 */
     Vecteur3D v4[10]; 
    Vecteur3DRemplirTabVecteur(v4 ,10);
    Vecteur3DAfficherTabVecteur(v4,10);
    Vecteur3DMaxTabVecteurs(v4,10);
    /* end main prof */

    /* TP 2 */


    /*
    a.Dans quel ordre sont empilés les éléments d’un tableau ? La case 0 a-t-elle l’adresse la plus haute ou la plus
    basse ?
    b. Dans quel ordre sont empilés les paramètres d’une fonction ou d’une procédure ?
    c. Dans quel ordre sont empilées les données membres d’un objet ?
    d. Les variables locales d’un même sous-programme sont-elles, comme en TD, dans l’ordre dans lequel elles
    étaient déclarées dans le code ?
    e. Lorsque l’un des paramètres d’un sous-programme est un tableau, combien d’octets ce paramètre occupe-
    t-il dans la frame du sous-programme ? Le tableau est-il recopié dans cette frame ?
    f. Quel écart observez-vous entre l’adresse la plus haute et l’adresse la plus basse, parmi les adresses
    affichées ? Cet écart correspond-il à l’écart théorique (celui de votre trace « papier ») ? Demandez à votre
    encadrant d’où vient cette différence. 
    */
    /* test prof */
    std::cout << "je suis ici" << std::endl;
    float monFloat ;
    int monTab [10 ];
    std::cout << "Adresse de monFloat : " << (long int) &monFloat;
    std::cout << "Taille occupée par monTab : " << sizeof(monTab);
    // test pour repondre a la question 1.a 
    for (int i = 0; i<10; i++){
        std::cout<<"l'adresse du tab["<< i << "]= "<< (long int) &monTab[i]<<std::endl;
    }
    return 0;
}

/*
All questions: 
--> appel à la fonction Vecteur3DGetNorme dans la fonction Vecteur3DEstNormaliser ; Elle appele que fonction ? avant Normaliser ou aprés ? 

*/