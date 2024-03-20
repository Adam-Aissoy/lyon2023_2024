/*
 * SimulateurTournoi.java                                             30/10/2019
 */

package lyon1.l3info.lif13.tp3.jeumorpion.run;


import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.JoueurAleatoire;
import lyon1.l3info.lif13.tp3.jeumorpion.tournoi.BuilderJeuDeMorpion;
import lyon1.l3info.lif13.tp3.jeumorpion.tournoi.BuilderJeuDePuissance4;
import lyon1.l3info.lif13.tp3.jeumorpion.tournoi.Tournoi;


/**
 * Classe de test permettant de lancer 2 tournois et de vérifier le
 * comportement du programme.
 * @author remy.chaput
 * @version 1.0
 */
public class SimulateurTournoi {

    public static void main(String[] args) {
        // On crée un tournoi à partir d'un Builder de JeuDeMorpion
        // (le tournoi va donc générer des instances de JeuDeMorpion)
        Tournoi tournoi = new Tournoi(new BuilderJeuDeMorpion());

        // On ajoute 5 Joueurs aléatoires
        Joueur joueur;
        for (int i = 0; i < 5; ++i) {
            joueur = new JoueurAleatoire(i+1);
            tournoi.addJoueur(joueur);
        }

        String gagnant = tournoi.jouerTournoi();
        System.out.println("Le gagnant du tournoi est : " + gagnant);

        // On peut faire de même avec un Tournoi de Puissance 4.
        // tournoi est toujours de type Tournoi, on a donc bien une classe
        // générique.
        tournoi = new Tournoi(new BuilderJeuDePuissance4());
        for (int i = 0; i < 3; ++i) {
            joueur = new JoueurAleatoire(i+1);
            tournoi.addJoueur(joueur);
        }

        gagnant = tournoi.jouerTournoi();
        System.out.println("Le gagnant du tournoi est : " + gagnant);
    }


}
