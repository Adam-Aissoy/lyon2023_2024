/*
 * Joueur.java                                                        23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.joueur;

import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Coup;
import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Plateau;

/**
 * Représente un joueur ayant un identifiant et une stratégie de jeu. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public abstract class Joueur {
    /** L'identifiant du joueur. */
    private int id;
    
    
    public Joueur(int id) {
        this.id = id;
    }

    
    /**
     * Choisit un coup en fonction de l'état actuel du jeu et de la stratégie
     * du joueur. 
     * 
     * @param etatJeu l'état du jeu de Morpion. 
     * @return le coup choisi par le joueur. 
     */
    public abstract Coup getCoup(Plateau etatJeu);
    
    
    /* Getter */
    public int getId() {
        return id;
    }
}
