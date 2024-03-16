/*
 * BuilderJeuDeMorpion.java                                           30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.tournoi;


import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Jeu;
import lyon1.l3info.lif13.tp3.jeumorpion.jeu.JeuDeMorpion;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;


/**
 * Builder spécialisé dans la construction d'instances de JeuDeMorpion.
 * 
 * @author remy.chaput
 * @version 1.0
 */
public class BuilderJeuDeMorpion extends Builder {

    public BuilderJeuDeMorpion() {
        // Constructeur sans argument par défaut.
        super(); // On appelle le constructeur de la classe mère.
    }

    /**
     * Crée une nouvelle instance de Jeu (en particulier de JeuDeMorpion).
     *
     * On utilise l'annotation Override pour indiquer qu'on surcharge une méthode
     * de la classe mère.
     * Le compilateur Java fonctionnerait sans cette annotation, mais en la voyant,
     * il va déclencher une vérification : si la méthode n'existe pas dans la
     * classe mère (par ex: faute de frappe), il y aura un avertissement.
     *
     * @param j1 Le premier joueur
     * @param j2 Le deuxième joueur
     * @return Une nouvelle instance de Jeu, contenant les joueurs j1 et j2
     */
    @Override
    public Jeu getPartie(Joueur j1, Joueur j2) {
        // On construit une instance de JeuDeMorpion et on la retourne
        // Remarque: on a une variable de type "JeuDeMorpion", pourtant la
        // signature de la méthode indique "Jeu". Pour rappel, ceci est
        // appelé un "upcast" : on caste notre variable en une classe
        // plus haute dans la hiérarchie.
        // (tout JeuDeMorpion est un Jeu)
        return new JeuDeMorpion(j1, j2);

        /*
         * Le processus de "upcast" détaillé :
         * JeuDeMorpion jdm = new JeuDeMorpion(j1, j2);
         * Jeu jeu = (Jeu) jdm;
         * return jeu;
         */
    }

}
