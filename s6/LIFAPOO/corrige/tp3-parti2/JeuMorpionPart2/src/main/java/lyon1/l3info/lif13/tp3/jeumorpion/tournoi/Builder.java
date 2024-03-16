/*
 * Builder.java                                                       30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.tournoi;


import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Jeu;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;


/**
 * Représente un Builder qui construit une instance de Jeu (pattern "Factory").
 * Le Builder est abstrait et doit être spécialisé pour chaque type de Jeu
 * existant.
 * Chaque Builder spécialisé utilise la même méthode (même signature) pour
 * générer des instances de Jeu, ce qui permet la généricité.
 * 
 * @author remy.chaput
 * @version 1.0
 */
public abstract class Builder {

    public Builder() {
        // Constructeur sans argument.
        // On peut également ne pas le mettre, auquel cas Java en génère un
        // par défaut.
    }

    /**
     * Construit une nouvelle instance de Jeu à partir de deux Joueurs.
     *
     * @param j1 Le premier joueur
     * @param j2 Le deuxième joueur
     * @return Une nouvelle instance de Jeu, contenant les joueurs j1 et j2
     */
    public abstract Jeu getPartie(Joueur j1, Joueur j2);
    
}
