#include <iostream>
// Exercise 1 
int compteurAysoy(){
    int n,compteur,i,j;
    std::cout<<" Quelle est la valeur de n ? "<<std::endl;
    std::cin>>n;
    compteur = 0; 
    i = 1;
    while (i<n)
    {
        j=i+1;
        while (j<=n)
        {
            compteur += 1;
            j+=1;
        }
        i *=2;
    }
    std::cout << " compteur = "<< compteur<<std::endl;
   return compteur;

}
// Exercise 2
void tri_par_insertion(){}
int main(){
    int res= compteurAysoy();
    std::cout << "res = "<< res<<std::endl;
    // Exercise 2
    //float tab [5];
    float tab [6]= {5.1,2.4,4.9,6.8,1.1,3.0};
    std::cout <<* tab << std::endl;
    std::cout << tab[2]<<std::endl;
    return 0 ;
}