#include <iostream>
class NbComplexe
{
private:
    int AdamPrivate;
public:
    float re, im;
    NbComplexe(){
        re = 0;
        im = 0;
    };
    ~NbComplexe(){
        std::cout << "Destructeur" << std::endl;
       
    };
    void saisir(NbComplexe &c){
        std::cout << "saisir la patie reel : ";
        std::cin >> c.re;
        std::cout << "saisir la patie imaginaire : ";
        std::cin >> c.im;
    };
    void afficher(NbComplexe c){
        if(c.im<0) {
            std::cout << c.re << " - " << -c.im << "i" << std::endl;
        }else
        {
            std::cout << c.re << " + " << c.im << "i" << std::endl;
        }
    };
};
int main(){
    NbComplexe c;
    c.saisir(c);
    c.afficher(c);
    return 0;
}

