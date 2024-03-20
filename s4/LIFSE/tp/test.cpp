/*r ← fork()
si r > 0 alors // bloc exécuté par le processus père
  pour i de 1 à 26 faire
    sleep(1)
    print(i)
    kill(r, SIGCONT)
    pause()
    // le père attend que son fils se termine
    return 0

sinon // bloc exécuté par le processus fils
  pour c de ’a’ à ’z’ faire
  pause()
  print(c)
  kill(getppid(), SIGCONT)
  
return 0*/
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
