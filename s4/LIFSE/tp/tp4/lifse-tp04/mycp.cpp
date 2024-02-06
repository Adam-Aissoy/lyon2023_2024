/* Copie d'un fichier avec les primitives systèmes open, read, write*/
#include <signal.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdio.h>
#include <iostream>
#include <string>

/*
 * Décommenter la ligne ci-dessous pour activer les wrappers read() et write()
 * pour tester les cas particuliers.
 */
//#include "test-read-write.h"

using namespace std;

#define LEN 20

// Fonction d'aide en cas de mauvais appel du programme
void print_usage(const string &name) {
  cerr << "Usage : " << name << " source destination" << endl;
}

int main(int argc, char *argv[]) {
  char buf[LEN], *p;
  int fdin, fdout;
  int nbrd, nbwr, nbrem;
  
  if(argc < 3) { // Gestion de la ligne de commande (ldc).
    print_usage(argv[0]);
    return 1;
  }

  // Ouverture du fichier source dont le nom est argv[1]
  if((fdin = open(argv[1], O_RDONLY)) < 0) {
    cerr << "Erreur : " << strerror(errno) << endl;
    return 1;
  }

  // ouverture du fichier destination dont le nom est argv[2]
  // man open (section "Linux Programmer's Manual") pour les options
  if((fdout = open(argv[2], O_WRONLY|O_CREAT|O_TRUNC, S_IRUSR|S_IWUSR)) == -1) {
    cerr << "Erreur : " << strerror(errno) << endl;
    close(fdin);
    return 1;
  }
  
  // MODIFIER ICI
if((nbrd=read(fdin,buf,LEN))==-1) {
    cerr << "Erreur : " << strerror(errno) << endl;
    close(fdin);
    close(fdout);
    return 1;
  }
/////////////////////////////////////////

/*
une première version de la copie dans laquelle :
1 - vous tentez de lire LEN octets du fichier source pour les ranger dans le buffer,
2 - vous écrivez le contenu du buffer dans le fichier de destination.
Utilisez un unique appel à read(), suivi d’un unique appel à write(), sans vous préoccuper des cas d’erreurs dans les-
quels ces appels retournent -1. Dans cette question, on suppose que le fichier d’entrée comporte plus de LEN caractères :
expérimentez avec un fichier in.txt qui contient une phrase d’au moins 20 caractères.
5) Consultez la page de manuel de read() pour vérifier qu’un appel à cette primitive retourne -1 en cas d’erreur. Faites en
sorte que, si jamais votre appel à read() retourne -1, alors votre programme se termine après avoir affiché le code d’erreur
contenu dans la variable globale errno (à l’aide de strerror(), en prenant example sur le code déjà fourni)). Que se
passe-t-il si le fichier contient strictement moins de LEN caractères ? Est-ce un comportement désirable ? Expérimentez
puis corrigez le cas échéant !
Copie d’un fichier :
1) Vous devez avoir dans votre répertoire de travail le fichier in.pdf, qui va nous servir de fichier de test pour le pro-
gramme mycp. Quelle est la taille de ce fichier en octets (ls -l) ? Jetez un œil au contenu du fichier également (avec
evince in.pdf ou xpdf in.pdf par exemple). Testez ./mycp in.pdf out.pdf : quel est l’effet produit sur out.pdf
(ls -l et evince) ?
2) Consultez à nouveau la page de manuel de read : vérifiez ce que signifie une valeur de retour non nulle de read() ? Dans
quel cas sait-on que l’on a atteint la fin du fichier ? Dans quel cas doit-on considérer qu’il y a une erreur, et qu’il faut
définitivement abandonner ?
3) Consultez la page de manuel de write() : doit-on forcément considérer qu’un appel va permettre d’écrire le nombre d’oc-
tets passé en paramètre ? Dans quel cas doit-on considérer qu’il y a une erreur, et qu’il faut définitivement abandonner ?
4) Modifiez votre programme mycp.cpp de façon à copier tout le contenu du fichier d’entrée dans le fichier de destination.
Pour cela, inspirez vous du « patron » suivant :
char buf[LEN]; // Buffer à utiliser pour les lectures/écritures.
char ∗p; // Pointeur pour avancer dans le buffer buf.
int nbrd; // Nombre d’octets lus sur fdin à chaque appel de read().
int nbwr; // Nombre d’octets que l’on arrive à écrire sur fdout à chaque appel de write().
int nbrem; // Nombre d’octets dans le buffer restants à écrire sur fdout.
do {
// Lire avec read() au plus LEN caractères sur fdin en les rangeant dans buf.
// Soit nbrd le nombre de caractères lus par read dans fdin.
// En cas d’erreur lors du write(), terminer le programme en retournant EXIT_FAILURE.
nbrem = nbrd; // Nombre d’octets qu’il va falloir écrire sur fdout.
p = buf; // On place le pointeur au début du buffer.
while(nbrem > 0) { // On reprend tant qu’il reste des octets du buffer à écrire
L. Gonnord, N. Louvet, M. Moy, G. Pichon, F. Zara 1/2
Université Lyon 1, Département Informatique TP 4 LIFSE – printemps 2024
// On tente d’écrire avec write() les nbrem octets restants (à partir de l’adresse p) vers fdout.
// Soit nbwr le nombre d’octets que l’on a réussi à écrire.
// En cas d’erreur lors du write(), terminer le programme en retournant EXIT_FAILURE.
// Mettre à jour nbrem en fonction de nbwr.
// Mettre à jour p pour avancer dans le buffer.
}
} while(nbrd > 0);
Utilisez man read et man write pour bien vérifier les paramètres de read et de write. N’oubliez pas de bien gérer les
cas d’erreurs de read, et d’afficher les messages correspondant au code présent dans errno. Tous les messages d’erreurs
doivent être envoyés vers la sortie d’erreur standard (utilisez cerr).
5) Testez votre programme avec ./mycp in.pdf out.pdf ; assurez-vous que le fichier copié fait bien la même taille en
octets que le fichier initial (ls -l). Assurez-vous également que les deux fichiers contiennent bien le même document. Le
plus efficace est de faire par exemple diff in.pdf out.pdf qui ne doit pas produire de sortie, s’il dit « Binary files in.pdf
and out.pdf differ » revoyez votre copie ! On peut aussi vérifier avec un lecteur de pdf (evince out.pdf par exemple) que
out.pdf est bien le bon fichier.
6) Justifiez l’utilisation d’un buffer buf au lieu d’une copie octet par octet qui serait clairement plus simple.
7) Comme pour le TP précédent, les cas « intéressants » (write qui n’écrit pas tout ce qu’on lui demande, erreurs d’entrée sor-
tie, etc.) ne se produisent pas souvent en pratique, et il est pourtant indispensable de les gérer correctement. Nous vous
fournissons un petit « wrapper » autour de read() et write() qui s’arrangent pour que ces cas arrivent avec une proba-
bilité plus forte. Décommentez la ligne #include "test-read-write.h" pour l’activer. Pour voir ce que fait le wrapper,
vous pouvez relancer votre commande avec DEBUG=t ./mycp in.pdf out.pdf, vous verrez des affichages comme «
On simule une erreur de read(). », « write() écrit moins que demandé. », etc. indiquant que le wrapper vient
d’injecter une erreur. Vérifiez que votre programme se comporte toujours correctement avec ce wrapper. Relancez le wrap-
per un grand nombre de fois pour être sûr de couvrir tous les cas. Vous pouvez par exemple lancer une vingtaine de fois la
commande :
./mycp in.pdf out.pdf && diff in.pdf out.pdf
*/
  do {
    if((nbrd=read(fdin,buf,LEN))==-1) {
      cerr << "Erreur : " << strerror(errno) << endl;
      close(fdin);
      close(fdout);
      return 1;
    }
    nbrem = nbrd;
    p = buf;
    while(nbrem > 0) {
      if((nbwr=write(fdout,p,nbrem))==-1) {
        cerr << "Erreur : " << strerror(errno) << endl;
        close(fdin);
        close(fdout);
        return 1;
      }
      nbrem -= nbwr;
      p += nbwr;
    }
  } while(nbrd > 0);  
  // FIN DE LA MODIFICATION
 
 

////////////////////////////////////////////

  close(fdin);
  close(fdout);
  
  return EXIT_SUCCESS;
}

