#include "File.h"
#include "Pile.h"
#include "ElementTD.h"
#include "ElementL.h"  // Assurez-vous d'inclure le fichier d'en-tête d'ElementL si nécessaire
#include <iostream>

int main(){
    // Création d'une file
    File myFile;
    
    // Test enfiler function
    myFile.enfiler(new int(1));
    myFile.enfiler(new int(2));
    myFile.enfiler(new int(3));

    // Test nbElements function
    std::cout << "Number of elements in the file: " << myFile.nbElements() << std::endl;

    // Test premierDeLaFile function
    ElementF firstElement = *myFile.premierDeLaFile();
    std::cout << "First element in the file: " << firstElement << std::endl;

    // Test defiler function
    myFile.defiler();

    // Test estVide function
    std::cout << "Is the file empty? " << (myFile.estVide() ? "Yes" : "No") << std::endl;

    // Clean up memory (assuming ElementF is a pointer type)
    while (!myFile.estVide()) {
        delete static_cast<int*>(myFile.premierDeLaFile());  // Assuming int* is the actual type; adjust accordingly
        myFile.defiler();
    }

    return 0;
}