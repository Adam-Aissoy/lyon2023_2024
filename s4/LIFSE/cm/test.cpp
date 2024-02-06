  #include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
int main() {
    pid_t pid;
    pid = fork();
    if (pid == -1) {
        perror("fork");
        exit(1);
    }
    if (pid == 0) {
        printf("Je suis le fils, mon PID est %d, le PID de mon pere est %d\n", getpid(), getppid());
        execlp("ls", "ls", "-l", NULL);
        perror("execlp");
        exit(1);
    } else {
        printf("Je suis le pere, mon PID est %d, le PID de mon fils est %d\n", getpid(), pid);
    }
    return 0;
}