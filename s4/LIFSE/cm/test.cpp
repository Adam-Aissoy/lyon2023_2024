#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
bool terminer = false; // drapeau de terminaison
    int cpt = 0; // compte les signaux SIGINT re¸cus
    void gest(int s) { // gestionnaire de signal
        cpt++;
        std::cout << "SIGINT re¸cu (cpt = " << cpt << ")" << std::endl;
        if(cpt == 5) terminer = true;
    }
int main(void) {
    struct sigaction s;
    sigaction(SIGINT, NULL, &s);
    s.sa handler = gest;
    sigaction(SIGINT, &s, NULL);
    while(true) {
        std::cout << "RRRRR..." << std::endl;
        sleep(1);
        if(terminer) break;
    }
    std::cout << "Je me termine..." << std::endl;
    return 0;
}