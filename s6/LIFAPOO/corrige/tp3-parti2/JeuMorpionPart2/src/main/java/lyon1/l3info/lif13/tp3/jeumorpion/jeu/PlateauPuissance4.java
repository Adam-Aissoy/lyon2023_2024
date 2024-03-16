/*
 * PlateauPuissance4.java                                             30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.jeu;

/**
 * Représente le plateau de jeu de Morpion au travers d'une matrice dans laquelle
 * chaque élément représente une case du plateau. 
 * 
 * @author julien.lacombe
 * @author remy.chaput
 * @version 1.0
 */
public class PlateauPuissance4 extends Plateau {

    private static final int LONGUEUR = 4;
    private static final int LARGEUR = 4;

    /**
     * Définit un plateau de jeu.
     *
     */
    public PlateauPuissance4() {
        super(LONGUEUR, LARGEUR);
    }

    /**
     * Applique le coup du joueur id aux coordonnées correspondantes sur
     * le plateau de jeu.
     *
     * @param coup le coup joué par le joueur.
     * @param id l'identifiant du joueur.
     * @throws IllegalArgumentException si l'identifiant du joueur est 0.
     * @throws ArrayIndexOutOfBoundsException si au moins l'une des coordonnées
     *                                        fournies est incorrecte.
     */
    @Override
    public void appliquerCoup(Coup coup, int id)
            throws IllegalArgumentException, ArrayIndexOutOfBoundsException {
        if (id <= 0) {
            throw new IllegalArgumentException("L'identifiant du joueur doit être "
                    + "un entier strictement positif. ");
        }

        // Sinon : on applique le coup aux coordonnées spécifiées.
        this.etatIdPlateau[coup.getY()][coup.getX()] = id;
    }
    
    
    /**
     * Détermine si un coup aux coordonnées fournies est possible ou pas. 
     * 
     * @param x la coordonnée en abscisse de la case. 
     * @param y la coordonnée en ordonnée de la case. 
     * @return True si le coup est possible ;
     *         False sinon. 
     */
    @Override
    public boolean coupPossible(int x, int y) {
        // Si la case n'est pas dans le plateau, ou est déjà jouée, => faux.
        if (!(coupDansPlateau(x, y) && getEtatIdCase(x, y) == 0)) {
            return false;
        }

        // Soit la case est tout en bas (y == longueur), soit elle est
        // située au-dessus d'une case non-vide (un pion se pose par-dessus
        // une colonne d'autres pions).
        return y == LONGUEUR - 1 || getEtatIdCase(x, y+1) != 0;
    }
    
            
}
