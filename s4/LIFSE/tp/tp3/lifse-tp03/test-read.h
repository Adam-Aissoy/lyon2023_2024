#pragma once

#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <time.h>

// Initialisation du générateur aléatoire au lancement du programme. C'est très
// sale de faire ceci, mais ça permet de ne rien demander à l'utilisateur, et on
// a vraiment besoin d'un aléa différent d'une exécution à l'autre.
static int init = (srand(time(NULL)), 0);

/**
 * @brief Renvoie vrai une fois sur n en moyenne.
 */
static bool once_every(int n) {
  return rand() % n == 0;
}

/**
 * Wrapper de test pour la fonction read. Permet de déclencher des
 * comportements autorisés mais rarement observés en pratique pour l'appel
 * système read. Se comporte comme read(2).
 */
int test_read(int fd, void *buf, size_t count)
{
  static bool may_raise_error = once_every(3);
  if (once_every(2))
  {
    // une fois sur deux, on appelle le vrai read normalement.
    return read(fd, buf, count);
  }
  else if (may_raise_error && once_every(4))
  {
    // des fois, on échoue volontairement
    errno = EIO;
    return -1;
  }
  else
  {
    // et des fois, on lit moins que demandé (mais on demande
    // toujours au moins un octet)
    size_t actual_count = rand() % count + 1;
    // si count vaut 1, actual_count vaut aussi forcément 1
    return read(fd, buf, actual_count);
  }
}

#define read(fd, buf, count) test_read(fd, buf, count)
