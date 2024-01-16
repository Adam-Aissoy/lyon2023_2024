#include <iostream>
using namespace std;

struct PERSON {   // Declare PERSON struct type
    int age;   // Declare member types
    long ss;
    float weight;
    char name[25];
} family_member;   // Define object of type PERSON

struct CELL {   // Declare CELL bit field
    unsigned short character  : 8;  // 00000000 ????????
    unsigned short foreground : 3;  // 00000??? 00000000
    unsigned short intensity  : 1;  // 0000?000 00000000
    unsigned short background : 3;  // 0???0000 00000000
    unsigned short blink      : 1;  // ?0000000 00000000
} screen[25][80];       // Array of bit fields

int main() {
    struct PERSON sister;   // C style structure declaration
    PERSON brother;   // C++ style structure declaration
    sister.age = 13;   // assign values to members
    brother.age = 7;
    cout << "sister.age = " << sister.age << '\n';
    cout << "brother.age = " << brother.age << '\n';
    cout << " sister.ss = " << sister.ss << '\n';

    CELL my_cell;
    my_cell.character = 1;
    cout << "my_cell.character = " << my_cell.character;
}
// Output:
// sister.age = 13
// brother.age = 7
// my_cell.character = 1

#include <iostream>

class NbComplexe {
private:
    double re; // Partie réelle
    double im; // Partie imaginaire

public:
    // Constructeur par défaut
    NbComplexe() : re(0.0), im(0.0) {}

    // Constructeur avec deux paramètres
    NbComplexe(double real, double imag) : re(real), im(imag) {}

    // Constructeur par copie
    NbComplexe(const NbComplexe& other) : re(other.re), im(other.im) {}

    // Destructeur
    ~NbComplexe() {}

    // Méthode pour saisir le nombre complexe au clavier
    void saisir() {
        std::cout << "Entrez la partie réelle : ";
        std::cin >> re;
        std::cout << "Entrez la partie imaginaire : ";
        std::cin >> im;
    }

    // Méthode pour afficher le nombre complexe
    void afficher() const {
        if (im >= 0) {
            std::cout << re << " + " << im << "i" << std::endl;
        } else {
            std::cout << re << " - " << -im << "i" << std::endl;
        }
    }

    // Méthode pour multiplier par un autre nombre complexe
    void multiplier(const NbComplexe& other) {
        double newRe = re * other.re - im * other.im;
        double newIm = im * other.re + re * other.im;
        re = newRe;
        im = newIm;
    }
};

int main() {
    // Création d'un nombre complexe comme une copie du précédent
    NbComplexe complexe1(3.0, -2.5);
    NbComplexe complexe1Copie(complexe1);

    std::cout << "Nombre complexe copié : ";
    complexe1Copie.afficher();

    // Création d'un nombre complexe sur le tas (avec new)
    NbComplexe* complexeTas = new NbComplexe(1.0, 2.0);

    std::cout << "Nombre complexe sur le tas : ";
    complexeTas->afficher();

    // Multipliez les deux nombres complexes
    complexe1.multiplier(*complexeTas);

    std::cout << "Résultat de la multiplication : ";
    complexe1.afficher();

    // N'oubliez pas de libérer la mémoire allouée sur le tas
    delete complexeTas;

    return 0;
}
