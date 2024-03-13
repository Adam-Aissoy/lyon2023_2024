/*
 * JoueurHumain.java                                               23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.joueur;

import java.util.Scanner;
import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Coup;
import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Plateau;

/**
 * Représente un joueur choisissant son prochain coup de manière aléatoire
 * (probabilité uniforme associée à chaque coup possible). 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class JoueurHumain extends Joueur {
    private Scanner entreeJoueur;
    
    public JoueurHumain(int id) {
        super(id);
        entreeJoueur = new Scanner(System.in);
    }
    
    
    /**
     * Attend une saisie utilisateur et la refuse tant qu'il ne s'agit pas
     * d'un entier valide. 
     * 
     * @return l'entier saisi par l'utilisateur. 
     */
    private int saisirCoord() {
        String entreeUtil;
        while (!entreeJoueur.hasNextInt()) {
            entreeUtil = entreeJoueur.next();
            System.out.print(entreeUtil + " n'est pas un nombre entier. "
                           + System.lineSeparator()
                           + "Veuillez refaire votre saisie : ");
        }
        
        return entreeJoueur.nextInt();
    }
    
    
    /**
     * Demande à l'utilisateur la saisie des coordonnées du coup qu'il 
     * souhaite jouer. 
     * 
     * @return le coup souhaité par le joueur. 
     */
    private Coup saisirCoup() {
        int x, y;
        Coup coupJoueur;
        
        System.out.print("x : ");
        x = saisirCoord();
        System.out.print("y : ");
        y = saisirCoord();
        coupJoueur = new Coup(x, y);
        
        return coupJoueur;
    }
    
    
    @Override
    public Coup getCoup(Plateau etatJeu) {
        Coup coupJoueur = saisirCoup();
        
        /* Tant que le coup fourni est incorrect : on demande à l'utilisateur
         * de ressaisir les coordonnées de son coup. */
        while(!etatJeu.coupPossible(coupJoueur)) {
            System.out.println("Coordonnées incorrectes. "
                             + System.lineSeparator()
                             + "Veuillez refaire votre saisie : ");
            coupJoueur = saisirCoup();
        }
        
        return coupJoueur;
    }
}
