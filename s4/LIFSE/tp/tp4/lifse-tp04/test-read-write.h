#pragma once

#include <unistd.h>
#include <stdlib.h>
#include <errno.h>
#include <time.h>
#include <string.h>
#include <iostream>

/**
 * @brief Renvoie vrai une fois sur n en moyenne.
 */
static bool once_every(int n) {
  return rand() % n == 0;
}

/**
 * @brief Petite fonction de debug, qui affiche la chaîne en paramètre quand la
 * variable d'environnement DEBUG est non-vide. Utilisation en ligne de commande : 
 * DEBUG=t ./mycp foo bar
 * pour avoir des informations de debug affichées.
 */
static void debug(const char *msg)
{
  if (getenv("DEBUG") != NULL && strcmp(getenv("DEBUG"), ""))
  {
    std::cout << msg << std::endl;
  }
}

/**
 * Wrapper de test pour la fonction read. Permet de déclencher des
 * comportements autorisés mais rarement observés en pratique pour l'appel
 * système read. Respecte la spécification de read(2).
 */
static ssize_t test_read(int fd, void *buf, size_t count)
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
    debug("On simule une erreur de read().");
    errno = EIO;
    return -1;
  }
  else
  {
    // et des fois, on lit moins que demandé (mais on demande
    // toujours au moins un octet si count >0)
    size_t actual_count = count == 0 ? 0 : rand() % count + 1;
    // si count vaut 1, actual_count vaut aussi forcément 1
    ssize_t res = read(fd, buf, actual_count);
    if (res > 0 && (size_t)res < count)
    {
      debug("read() lit moins que demandé.");
    }
    return res;
  }
}

#define read(fd, buf, count) test_read(fd, buf, count)

/**
 * Wrapper de test pour la fonction write. Permet de déclencher des
 * comportements autorisés mais rarement observés en pratique pour l'appel
 * système write. Respecte la spécification de write(2).
 */
ssize_t test_write(int fd, const void *buf, size_t count)
{
  static bool may_raise_error = once_every(3);
  if (once_every(2))
  {
    // une fois sur deux, on appelle le vrai write normalement.
    return write(fd, buf, count);
  }
  else if (may_raise_error && once_every(4))
  {
    // des fois, on échoue volontairement, en choisissant un code d'erreur
    // crédible aléatoirement.
    debug("On simule une erreur de write().");
    int possible_errors[] = {EIO, EDQUOT, ENOSPC};
    errno = possible_errors[rand() % (sizeof(possible_errors) / sizeof(int))];
    return -1;
  }
  else
  {
    // et des fois, on écrit moins que demandé (mais on demande
    // toujours au moins un octet si count >0)
    size_t actual_count = count == 0 ? 0 : rand() % count + 1;
    // si count vaut 1, actual_count vaut aussi forcément 1
    ssize_t res = write(fd, buf, actual_count);
    if (res > 0 && (size_t)res < count)
    {
      debug("write() écrit moins que demandé.");
    }
    return res;
  }
}

#define write(fd, buf, count) test_write(fd, buf, count)

/*
 * Initialisation du générateur aléatoire au lancement du programme. C'est très
 * sale de faire ceci (j'ai tellement honte que je le mets à la fin), mais ça
 * permet de ne rien demander à l'utilisateur, et on a vraiment besoin d'un aléa
 * différent d'une exécution à l'autre.
 */
static int init = (srand(time(NULL)), 0);
