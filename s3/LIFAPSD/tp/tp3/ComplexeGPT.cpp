#include <iostream>

class NbComplexe {
private:
    double re; // Partie réelle
    double im; // Partie imaginaire

public:
    // Constructeur par défaut
    NbComplexe() : re(0.0), im(0.0) {}

    // Constructeur avec initialisation
    NbComplexe(double real, double imag) : re(real), im(imag) {}

    // Méthode pour saisir le nombre complexe au clavier
    void saisir() {
        std::cout << "Entrez la partie réelle : ";
        std::cin >> re;
        std::cout << "Entrez la partie imaginaire : ";
        std::cin >> im;
    }

    // Méthode pour afficher le nombre complexe
    void afficher() {
        if (im >= 0) {
            std::cout << re << " + " << im << "i" << std::endl;
        } else {
            std::cout << re << " - " << -im << "i" << std::endl;
        }
    }
   
};

int main() {
    // Création d'un nombre complexe sur la pile
    NbComplexe complexe1(3.0, -2.5);

    // Affichage du nombre complexe
    std::cout << "Nombre complexe initial : ";
    complexe1.afficher();

    // Saisie d'un nouveau nombre complexe
    NbComplexe complexe2;
    std::cout << "Saisissez un nouveau nombre complexe : " << std::endl;
    complexe2.saisir();

    // Affichage du nouveau nombre complexe
    std::cout << "Nouveau nombre complexe : ";
    complexe2.afficher();

     // Reponse Exercice 1 question d 
    std::cout << "Taille d'un nombre complexe en octets : " << sizeof(NbComplexe) << std::endl;


    return 0;
}
