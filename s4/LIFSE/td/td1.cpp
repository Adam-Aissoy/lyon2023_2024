
#include <iostream>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <cstring>



/*
TD 1 
Exercice 1
- un appel a write permet de tenter d'ecrire count octects situes à l'adresse buf de la memoire vers le fichier desogne par le descriteur de fichier fd. 

- un appel a read lit dans le fichier designé par fd jusqu'à count octets et les ranges en memoire à partir de l'adresse buf.
    valeur de retour : nombre d'octets lus ou -1 en cas d'erreur. 


*/
/*
3) On suppose qu’un programme initialise un tableau de caractères déclaré par char tab[64]. Comment appeler write
pour écrire (au plus) tout le contenu de tab sur le descripteur de fichier fd? Même question si le tableau a été déclaré
par long tab[64]. Proposez des solutions avec ou sans sizeof
*/
int main(int argc, char *argv[])
{
    int fd;
    char buf[64];
    int nb;
    if (argc != 2)
    {
        fprintf(stderr, "usage: %s <file>\n", argv[0]);
        exit(1);
    }
    if ((fd = open(argv[1], O_RDONLY)) == -1)
    {
        perror(argv[1]);
        exit(1);
    }
    while ((nb = read(fd, buf, sizeof(buf))) > 0)
    {
        write(1, buf, nb);
    }
    close(fd);
    exit(0);
}
/*
--> Exercice 2
    1) En exécutant le programme read-bin ou write-bin depuis un shell, comment faire pour vérifier qu’il se termine en
retournant 0 ? Que nous apprend cette valeur de retour sur les opérations d’écriture et de lecture qui ont été exécutées
par le programme ?
*/

/*
EXERCICE 3  Écritures sur le disque avec write
On a un très grand tableau de n caractères en mémoire, et on dispose d’un pointeur de type char* vers le premier caractère de ce tableau : on veut écrire ce tableau dans un fichier régulier, via un descripteur de fichier fd. Donnez une fonction
writech pour cela, en procédant caractère par caractère. Donnez un exemple d’appel de votre fonction */
int writech(int fd, char *buf, int nb)
{
    int i;
    for (i = 0; i < nb; i++)
    {
        if (write(fd, buf + i, 1) == -1)
        {
            return -1;
        }
    }
    return 0;
}
