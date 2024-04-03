#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
int main() {
    int f = open("/root/i-can-haz-write-access-to-r00t.txt",O_WRONLY | O_CREAT);
    if (f < 0) {
        perror("Can’t open file");
        exit(1);
    }
    write(f, "pwned", strlen("pwned"));
    close(f);
}
     
     
// The program opens a file in write mode, writes the string "pwned" to it, and then closes the file. The file is created in the root directory, which is typically only writable by the root user. The program is compiled and setuid is set on the binary: