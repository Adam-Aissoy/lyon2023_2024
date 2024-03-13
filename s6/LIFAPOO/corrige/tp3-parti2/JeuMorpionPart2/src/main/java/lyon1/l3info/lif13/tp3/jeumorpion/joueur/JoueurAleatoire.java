/*
 * JoueurAleatoire.java                                               23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.joueur;

import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Coup;
import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Plateau;
import lyon1.l3info.lif13.tp3.jeumorpion.util.Tool;

/**
 * Représente un joueur choisissant son prochain coup de manière aléatoire
 * (probabilité uniforme associée à chaque coup possible). 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class JoueurAleatoire extends Joueur {
    public JoueurAleatoire(int id) {
        super(id);
    }
    
    
    @Override
    public Coup getCoup(Plateau etatJeu) {
        int x, y;
        Coup coupAlea;
        
        do {
            // Choisit un coup aléatoirement :
            x = Tool.monRandom(0, etatJeu.getLongueur()-1);
            y = Tool.monRandom(0, etatJeu.getLargeur()-1);
            coupAlea = new Coup(x, y);
        /* Tant que le coup choisi n'est pas possible. */
        } while (!etatJeu.coupPossible(coupAlea));
        
        /* Remarque : ce n'est pas demandé pour ce TP mais il serait plus
         * efficace d'avoir une fonction de Plateau retournant l'ensemble des 
         * coups actuellement possibles et de choisir aléatoirement un coup dans
         * cet ensemble indexé. On maintiendrait alors dans Plateau cet ensemble de 
         * coups possibles à jour (en enlevant une possibilité à chaque coup joué). 
         * Cela éviterait d'itérer en boucle en attendant que le coup choisi soit
         * possible. */
        
        return coupAlea;
    }
}
