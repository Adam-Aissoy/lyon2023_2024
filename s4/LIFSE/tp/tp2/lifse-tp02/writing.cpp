#include <iostream>
#include <string>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(void) {

  char tab[12];
  tab[0] = 'a';
  tab[1] = 'b';
  tab[2] = 'c';
  tab[3] = 'd';
  tab[4] = 'e';
  tab[5] = 'f';
  tab[6] = 'g';
  tab[7] = 'h';
  tab[8] = 'i';
  tab[9] = 'j';
  tab[10] = '\n';
  tab[11] = '\0';

  int fd;

  // première ouverture et écriture dans le fichier
  // ouverture du fichier
  fd = open("test.txt", O_WRONLY | O_CREAT | O_TRUNC, S_IRUSR | S_IWUSR);
  if(fd == -1) {
    std::cerr << "Erreur : " << strerror(errno) << std::endl;
    exit(1);
  }

  // écriture dans le fichier

  // deuxième ouverture et écriture dans le fichier
  
  return 0;
}

