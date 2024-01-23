#include <iostream>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cstring>

int main(void) {
  char txt[256] = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna "
                  "aliqua. Ut enim ad minim veniam, quis nostrud exercitation "
                  "ullamco laboris nisi ut aliquip ex ea commodo consequat.";
  std::cout << txt << std::endl;
  
  int wrong_fd = open("nofile.txt", O_RDONLY);
  int ret = write(10, txt, 256 * sizeof(char));

  return 0;
}
