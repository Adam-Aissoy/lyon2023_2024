/*
 * SimulateurDeMorpion.java                                           23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.run;

import lyon1.l3info.lif13.tp3.jeumorpion.jeu.JeuDeMorpion;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.JoueurAleatoire;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.JoueurHumain;

/**
 * Lance une partie de Morpion. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class SimulateurDeMorpion {
    public static void main(String[] args) {
        Joueur j1 = new JoueurHumain(1),
               j2 = new JoueurAleatoire(2),
               gagnant;
        JeuDeMorpion jeu = new JeuDeMorpion(j1, j2);
        gagnant = jeu.jouerPartie();
        if (gagnant != null) {
            System.out.println("Le joueur " + gagnant.getId() + " a gagné !");
        } else {
            System.out.println("Partie terminée : égalité !");
        }
    }
}
