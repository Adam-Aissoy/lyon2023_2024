/*
 * PlateauMorpion.java                                                30/10/2019
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
public class PlateauMorpion extends Plateau {

    /**
     * Remarque : ces deux attributs statiques (des constantes) sont communs
     * à tous les plateaux. Donc on voudrait les inclure dans la classe
     * mère, et les surcharger dans les classes filles.
     * Problème : en Java, on ne peut pas surcharger un attribut statique.
     * Voir https://stackoverflow.com/questions/16202884/how-to-inherit-static-field-and-change-its-value
     *
     * Au final, on utilise ces champs comme constantes uniquement, donc
     * ce n'est pas grave (c'est comme si on écrivait `super(3,3)` dans le
     * constructeur).
     */
    private static final int LONGUEUR = 3;
    private static final int LARGEUR = 3;

    /**
     * Définit un plateau de jeu.
     */
    public PlateauMorpion() {
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
        return coupDansPlateau(x, y) && getEtatIdCase(x, y) == 0;
    }
    
            
}
