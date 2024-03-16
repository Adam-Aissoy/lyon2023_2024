/*
 * Jeu.java                                                           30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.jeu;

import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;

/**
 * 
 * 
 * @author julien.lacombe
 * @author remy.chaput
 * @version 1.0
 */
public abstract class Jeu {

    /** Le nombre de joueurs participant au jeu. */
    public static final int N_JOUEURS = 2;
    
    /** Plateau de jeu. */
    protected Plateau plateau;
    
    /** Les joueurs participant au jeu. */
    private Joueur[] joueurs;
    
    /** L'index du joueur actuel dans la liste des joueurs. */
    private int idxJoueurActuel;

    
    /**
     * Constructeur de Jeu.
     * Remarque : Jeu est une classe abstraite, donc on ne peut pas l'instancier ;
     * mais nous avons besoin de définir ce constructeur pour les classes filles
     * (qui utiliseront `super()` pour s'initialiser).
     */
    public Jeu(Joueur joueur1, Joueur joueur2, Plateau plateau) {
        joueurs = new Joueur[N_JOUEURS];
        joueurs[0] = joueur1;
        joueurs[1] = joueur2;
        this.plateau = plateau;
        idxJoueurActuel = N_JOUEURS-1;
    }
    
    
    /**
     * Détermine si la partie est gagnée ou non.
     *
     * Remarque : l'algorithme de vérification de victoire pour le jeu de
     * Morpion et le Puissance4 sont similaires (en prenant en compte la taille
     * de grille différente). On pourrait donc, si on se limite à ces deux
     * seuls jeux, factoriser l'algorithme dans la classe Jeu.
     * Toutefois, si on prend l'idée d'implémenter un JeuEchec (par exemple),
     * ce n'est plus le cas.
     * 
     * @return True  si la partie est gagnée ;
     *         False sinon.
     */
    protected abstract boolean partieGagnee();
    
    
    /**
     * Détermine si la partie est terminée ou non en vérifiant si la partie est
     * gagnée ou si un coup est encore possible. 
     * 
     * @return True  si la partie est terminée ;
     *         False sinon.
     */
    public boolean partieTerminee() {
        if (partieGagnee()) {
            return true;
        }
        
        // Parcourt l'ensemble des cases du plateau. 
        for (int i = 0; i < plateau.getLongueur(); ++i) {
            for (int j = 0; j < plateau.getLargeur(); ++j) {
                // Si un coup est possible quelque part :
                if (plateau.coupPossible(i, j)) {
                    return false; // la partie n'est pas terminée. 
                }
            }
        }
        // Aucun coup n'est possible : la partie est terminée. 
        return true;
        
        /* Remarque : d'autres versions plus efficaces sont possibles ! 
         * - Maintenir une liste des coups possibles dans le plateau permettrait
         * d'éviter de reparcourir l'ensemble du plateau à chaque fois. 
         * - Stocker dans un attribut de classe le dernier coup joué permettrait
         * de faire les vérifications uniquement pour la ligne, la colonne et
         * éventuelle(s) diagonale(s) associées. 
         */
    }
    
    
    /**
     * @return le prochain joueur à jouer. 
     */
    private Joueur getJoueurSuivant() {
        idxJoueurActuel = (idxJoueurActuel+1) % N_JOUEURS;
        return joueurs[idxJoueurActuel];
    }
    
    
    /**
     * Déroule une partie de Morpion à 2 joueurs. 
     *
     * Remarque : en ayant défini nos méthodes Plateau#coupPossible,
     * Plateau#appliquerCoup et Jeu#partieGagnee (qui sont abstraites),
     * nous pouvons faire un algo pour jouer une partie commun à tous
     * les jeux.
     *
     * @return le joueur gagnant en cas de victoire ;
     *         null en cas d'égalité. 
     */
    public Joueur jouerPartie() {
        Joueur retour = null; // utilisé comme variable de parcours,et renvoyé comme étant
                              // le joueur gagnant
        System.out.println(plateau);
        while (!partieTerminee()) {
            retour = getJoueurSuivant();
            Coup c = retour.getCoup(plateau);
            if (plateau.coupPossible(c)) {
                plateau.appliquerCoup(c, retour.getId());
            } else {
                System.err.print("erreur");
                System.exit(1);
            }
            System.out.println(plateau);
        }
        if (!partieGagnee()) {
            retour = null;
        }
        return retour;
    }
    
}
