#include <iostream>
#include <string.h>

int main(int argc, char **argv){
    /* question 1 */
    char tab[11];
    tab[0]= 'a'; tab[1]= 'b'; tab[2]= 'c'; tab[3]= 'd'; tab[4]= 'e';tab[5]= 'f'; tab[6]= 'g'; tab[7]= 'h'; tab[8]= 'i'; tab[9]= 'j';
    tab[10] = '\0';
    std::cout << tab << std::endl;
    /* question  2 */
    std::string line("klmnopqrstuvwxyz");
    std::cout << line << std::endl;

    /*Faites la même chose en utilisant une objet str de la classe std::string*/
    /*
    - Afin de vous habituer à la manipulation des buffers (qui serviront pour les appels systèmes), créez un tableau de taille
    plus grand (char big_tab[21];) dont vous initialiserez chacun des éléments avec le caractère '-' (sauf le dernier qui
    contiendra le caractère spécial).
    */
    char big_tab[21];
    for(int i=0; i < sizeof(big_tab); i++){
        big_tab[i] = '-';
    }
    big_tab[sizeof(big_tab)-1] ='\0';
    std::cout << big_tab << std::endl;
    //std::cout << sizeof(big_tab) << std::endl;
   
    //5) En utilisant la fonction memcpy(), copiez les cinq derniers éléments de tab (la chaîne de caractères fghij) dans les cinq
    //derniers éléments de big_tab. Affichez le contenu de big_tab afin de vérifier votre appel à memcpy().
    memcpy(big_tab+15, tab+5,5);
    std::cout << big_tab << std::endl;
   
    
    //6) Toujours avec la fonction memcpy(), copiez les éléments d’indices 3 à 7 de str dans les éléments d’indices 3 à 7 de big_tab
    //(documentez vous sur la méthode c_str de la classe std::string). Affichez à nouveau le contenu de big_tab afin de
    //vérifier votre appel.
    

    return 0;
}