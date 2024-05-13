#include <iostream>
#include <unistd.h>
#include <sys/wait.h>
#include <cstdlib>
using namespace std;


int main(int argc, char *argv[]) {
    int a = 2;
    int ret = fork();
    if (ret == 0) { //   processus fils
        sleep(1);
        cout << a << endl;
    }
    else { // processus père
        a = 4;
        cout << a << endl;
    }
    return EXIT_SUCCESS ;
}