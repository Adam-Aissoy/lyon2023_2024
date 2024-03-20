/*
 * JeuDeMorpion.java                                                  23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.jeu;

import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;

/**
 * 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class JeuDeMorpion {
    /** Le nombre de joueurs participant au jeu. */
    public static final int N_JOUEURS = 2;
    
    /** Dimensions du plateau de jeu. */
    public static final int LONGUEUR = 3;
    public static final int LARGEUR = 3;
    
    /** Plateau de jeu du Morpion. */
    private Plateau plateau;
    
    /** Les joueurs participant au jeu. */
    private Joueur[] joueurs;
    
    /** L'index du joueur actuel dans la liste des joueurs. */
    private int idxJoueurActuel;

    
    public JeuDeMorpion(Joueur joueur1, Joueur joueur2) {
        joueurs = new Joueur[N_JOUEURS];
        joueurs[0] = joueur1;
        joueurs[1] = joueur2;
        plateau = new Plateau(LONGUEUR, LARGEUR);
        idxJoueurActuel = N_JOUEURS-1;
    }
    
    
    /**
     * Détermine si la partie est gagnée ou non. 
     * 
     * @return True  si la partie est gagnée ;
     *         False sinon.
     */
    private boolean partieGagnee() {
        // Vérifie si un joueur en alignant une ligne ou une colonne. 
        boolean colAlignee,
                ligAlignee;
        for (int i = 0; i < LONGUEUR; ++i) {
            colAlignee = plateau.getEtatIdCase(i, 0) != 0;
            ligAlignee = plateau.getEtatIdCase(0, i) != 0;
            
            for (int j = 1; j < LARGEUR; ++j) {
                colAlignee = colAlignee && (plateau.getEtatIdCase(i, 0) 
                                         == plateau.getEtatIdCase(i, j));
                ligAlignee = ligAlignee && (plateau.getEtatIdCase(0, i) 
                                         == plateau.getEtatIdCase(j, i));
            }
            
            if (colAlignee || ligAlignee) {
                return true;
            }
        }
        
        // Vérifie si un joueur a gagné en alignant une diagonale. 
        boolean diag1Alignee = plateau.getEtatIdCase(0, 0) != 0;
        boolean diag2Alignee = plateau.getEtatIdCase(0, LONGUEUR-1) != 0;
        for (int i = 0; i < LONGUEUR; ++i) {
            diag1Alignee = diag1Alignee && (plateau.getEtatIdCase(0, 0)
                                         == plateau.getEtatIdCase(i, i));
            diag2Alignee = diag2Alignee && (plateau.getEtatIdCase(0, LONGUEUR-1)
                                         == plateau.getEtatIdCase(i, LONGUEUR-1-i));
        }
        if (diag1Alignee || diag2Alignee) {
            return true;
        }
        return false;
    }
    
    
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
        for (int i = 0; i < LONGUEUR; ++i) {
            for (int j = 0; j < LARGEUR; ++j) {
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
