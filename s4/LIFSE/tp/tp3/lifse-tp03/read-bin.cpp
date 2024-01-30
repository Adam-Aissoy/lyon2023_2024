#include <cstdio>
#include <cstring>

#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

int main(int argc, char* argv[]) {
  int ascii = 0;
  if(argc < 2 || argc > 3) {
    fprintf(stderr, "At least one and at most two arguments must be provided.\n");
    return 1;
  }
  if(argc == 3) ascii = 1;

  int fd = open(argv[1], O_RDONLY);
  if(fd == -1) {
    fprintf(stderr, "Unable to open \"%s\".\n", argv[1]);
    return 1;
  }

  int ret;
  do {
    char c;
    ret = read(fd, &c, 1);
    if(ret == 1) printf("%02hhx\t", c); // affiche c en hexadécimal
    if(ascii) printf("%c", c);
    putchar('\n');
  } while(ret == 1);
  putchar('\n'); // affiche un retour à la ligne
  if(ret == -1) return -1;

  ret = close(fd);
  if(ret == -1) return -1;
  
  return 0;
}
