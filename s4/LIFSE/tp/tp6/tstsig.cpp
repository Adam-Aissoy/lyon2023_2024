/*
1) Le processus principal (c’est-à-dire la fonction d’entête int main(void)) doit exécuter la boucle infinie suivante :
while ( true ) {
cout << " mise en sommeil " << endl << flush ;
sleep (60);
}
À l’exécution, votre programme ne doit a priori jamais se terminer, et ainsi rester bloqué dans la boucle infine. Tout ce
qu’il va faire, c’est afficher « mise en sommeil » une première fois, puis toutes les 60 secondes.
*/
#include <iostream>
#include <unistd.h>
#include <signal.h>
#include <cstring>
#include <sys/wait.h>

void handler(int sig) {
    static int cpt = 0;
    if (sig == SIGUSR1) {
        std::cout << "Signal " << sig << " reçu" << std::endl;
        cpt++;
        if (cpt == 5) {
            std::cout << "fin du programme" << std::endl;
            exit(0);
        }
    }
}

int main(void) {
    struct sigaction action;
    memset(&action, 0, sizeof(action));
    action.sa_handler = handler;
    sigaction(SIGUSR1, &action, NULL);

    pid_t r = fork();
    if (r > 0) {
        for (int i = 1; i <= 26; i++) {
            sleep(1);
            std::cout << i << std::endl;
            kill(r, SIGCONT);
            pause();
        }
    } else {
        for (char c = 'a'; c <= 'z'; c++) {
            pause();
            std::cout << c << std::endl;
            kill(getppid(), SIGCONT);
        }
    }
    return 0;
}
