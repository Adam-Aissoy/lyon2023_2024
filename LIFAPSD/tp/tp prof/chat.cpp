#include <iostream>

int main() {
    int taille;

    // Demandez à l'utilisateur de taper la taille du tableau
    std::cout << "Entrez la taille du tableau : ";
    std::cin >> taille;

    // Allouer dynamiquement un tableau de réels de la taille demandée
    double* tableau = new double[taille];

    // Demander à l'utilisateur d'entrer les valeurs pour le tableau
    std::cout << "Entrez les valeurs du tableau :\n";
    for (int i = 0; i < taille; ++i) {
        std::cout << "Valeur " << i + 1 << " : ";
        std::cin >> tableau[i];
    }

    // Afficher le tableau
    std::cout << "Tableau : ";
    for (int i = 0; i < taille; ++i) {
        std::cout << tableau[i] << " ";
    }
    std::cout << std::endl;

    // Libérer la mémoire allouée dynamiquement
    delete[] tableau;

    return 0;
}
