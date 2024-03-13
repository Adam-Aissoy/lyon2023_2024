/*
 * Tool.java                                                          23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.util;

/**
 * Classe proposant des fonctions utilitaires. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class Tool {
    /**
     * Renvoie un nombre entier (pseudo-)aléatoire compris entre min et max. 
     * 
     * @param max la valeur maximum que peut prendre l'entier aléatoire. 
     * @param min la valeur minimum que peut prendre l'entier aléatoire. 
     * @return l'entier aléatoire généré. 
     * @throws IllegalArgumentException si min est >= à max. 
     */
    public static int monRandom(int min, int max) 
            throws IllegalArgumentException {
        if (min >= max) {
            throw new IllegalArgumentException("La valeur minimale doit être strictement "
                                             + "inférieure à la valeur maximale. ");
        }
        
        /* Math.random() renvoie un nombre réel compris dans [0,1[
         * Multiplier par l'étendue puis ajouter le min => [min, max+1[ */
        int etendue = max - min + 1;
        int entierAlea = ((int) (Math.random() * etendue)) + min;
        
        return entierAlea;
        /* Remarque : il existe d'autres manières tout aussi justes de générer 
         * un entier aléatoire, parmi les + utilisées :
         * - le nextInt() de ThreadLocalRandom (depuis Java 1.7) ;
         * - le nextInt() de la classe Random. */
   }
}
