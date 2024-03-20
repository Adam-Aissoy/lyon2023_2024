/*
 * Coup.java                                                          23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.jeu;

/**
 * Représente un coup joué par un joueur par les coordonnées 2D de celui-ci. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class Coup {
    /** Coordonnée en abscisse. */
    private int x;
    
    /** Coordonnée en ordonnée. */
    private int y;
    
    
    public Coup(int x, int y) {
        this.x = x;
        this.y = y;
    }

    
    /* Getters. */
    public int getX() {
        return x;
    }
    
    public int getY() {
        return y;
    }
}
