/* les precedents dans tp 1 */

#include <iostream>
using namespace std;
/* Calcul d’un coefficient binomial à l’aide du triangle de Pascal */
int comb(int n, int p) {
    int tmp1, tmp2;
    std::cout <<"Calcul du nb de combinaisons de "<<p<<" elts parmi "<<n<<std::endl;

    if ((p==0) || (n==p))
        return 1;
    tmp1 = comb(n-1, p-1); /* premier appel récursif */
    tmp2 = comb(n-1, p); /* second appel récursif */
    return tmp1 + tmp2;
}
int main() {
    int c;
    c = comb(4, 3);
    std::cout << "c vaut " << c << std::endl;
    return 0;
}