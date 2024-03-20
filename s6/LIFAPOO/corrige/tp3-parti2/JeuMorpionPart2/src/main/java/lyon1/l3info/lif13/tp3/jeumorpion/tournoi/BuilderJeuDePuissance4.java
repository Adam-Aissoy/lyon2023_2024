/*
 * BuilderJeuDePuissance4.java                                        30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.tournoi;


import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Jeu;
import lyon1.l3info.lif13.tp3.jeumorpion.jeu.JeuPuissance4;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;


/**
 * Builder spécialisé dans la construction d'instances de JeuDeMorpion.
 * 
 * @author remy.chaput
 * @version 1.0
 */
public class BuilderJeuDePuissance4 extends Builder {

    public BuilderJeuDePuissance4() {
        // Constructeur sans argument par défaut.
        super(); // On appelle le constructeur de la classe mère.
    }

    /**
     * Crée une nouvelle instance de Jeu (en particulier, JeuDePuissance4).
     *
     * @param j1 Le premier joueur
     * @param j2 Le deuxième joueur
     * @return Une nouvelle instance de Jeu, contenant les joueurs j1 et j2
     */
    @Override
    public Jeu getPartie(Joueur j1, Joueur j2) {
        // On construit une instance de JeuDePuissance4 et on la retourne
        // Voir BuilderJeuDeMorpion#getPartie pour plus d'informations.
        return new JeuPuissance4(j1, j2);
    }

}
