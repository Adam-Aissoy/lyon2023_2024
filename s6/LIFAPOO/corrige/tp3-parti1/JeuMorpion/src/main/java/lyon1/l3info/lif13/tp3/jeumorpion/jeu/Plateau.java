/*
 * Plateau.java                                                       23/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.jeu;

/**
 * Représente le plateau de jeu de Morpion au travers d'une matrice dans laquelle
 * chaque élément représente une case du plateau. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class Plateau {
    /** La longueur du tableau (en abscisse). */
    private int longueur;
    
    /** La largeur du tableau (en ordonnée). */
    private int largeur;
    
    /** La matrice représentant le plateau. Un élément vaut 0 si la case 
     *  correspondante est vide ; l'identifiant du joueur sinon. */
    private int[][] etatIdPlateau;
    
    
    /**
     * Définit un plateau de jeu de Morpion. 
     * 
     * @param longueur la longueur du tableau (en abscisse).
     * @param largeur  la largeur du tableau (en ordonnée).
     * @throws IllegalArgumentException si la largeur ou la longueur ne sont pas
     *                                  strictement positifs. 
     */
    public Plateau(int longueur, int largeur) 
            throws IllegalArgumentException {
        if (longueur <= 0) {
            throw new IllegalArgumentException("La longueur du plateau doit être "
                                             + "un entier strictement positif. ");
        }
        if (largeur <= 0) {
            throw new IllegalArgumentException("La largeur du plateau doit être "
                                             + "un entier strictement positif. ");
        }
        
        this.longueur = longueur;
        this.largeur = largeur;
        initialiser();
    }
    
    
    /**
     * (Ré-)Initialise le plateau de jeu. 
     */
    public void initialiser() {
        this.etatIdPlateau = new int[this.longueur][this.largeur];
        // Remarque : un nouveau tableau est par défaut rempli de 0 en Java. 
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
     * Détermine si les coordonnées fournies correspondent à une case située
     * sur le plateau. 
     * 
     * @param x la coordonnée en abscisse de la case. 
     * @param y la coordonnée en ordonnée de la case. 
     * @return True si les coordonnées sont correctes ;
     *         False sinon. 
     */
    public boolean coupDansPlateau(int x, int y) {
        return x >= 0 && y >= 0
            && x < longueur && y < largeur;
    }
    
    
    /**
     * Détermine si un coup fourni a ses coordonnées dans une case située sur le
     * plateau. 
     * 
     * @param coup le coup dont on veut savoir si les coordonnées sont correctes. 
     * @return True si les coordonnées sont correctes ;
     *         False sinon. 
     */
    public boolean coupDansPlateau(Coup coup) {
        return coup.getX() >= 0 && coup.getY() >= 0
            && coup.getX() < longueur && coup.getY() < largeur;
    }
    
    
    /**
     * Détermine si un coup aux coordonnées fournies est possible ou pas. 
     * 
     * @param x la coordonnée en abscisse de la case. 
     * @param y la coordonnée en ordonnée de la case. 
     * @return True si le coup est possible ;
     *         False sinon. 
     */
    public boolean coupPossible(int x, int y) {
        return coupDansPlateau(x, y) 
            && this.etatIdPlateau[y][x] == 0;
    }
    
    
    /**
     * Détermine si un coup fourni est possible ou pas. 
     * 
     * @param coup le coup dont on veut savoir s'il est applicable ou non. 
     * @return True si le coup est possible ;
     *         False sinon. 
     */
    public boolean coupPossible(Coup coup) {
        return coupDansPlateau(coup) 
            && this.etatIdPlateau[coup.getY()][coup.getX()] == 0;
    }
    

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        
        for (int i = 0; i < this.longueur; ++i) {
            for (int j = 0; j < this.largeur; ++j) {
                sb.append(this.etatIdPlateau[i][j]).append(' ');
            }
            sb.append(System.lineSeparator());
        }
        
        return sb.toString();
    }
    
    
    /* Getters. */
    public int getLongueur() {
        return longueur;
    }

    public int getLargeur() {
        return largeur;
    }

    /**
     * @param x la coordonnée en abscisse de la case. 
     * @param y la coordonnée en ordonnée de la case. 
     * @return la valeur de l'id du joueur associé à la case. 
     * @throws ArrayIndexOutOfBoundsException si au moins l'une des coordonnées 
     *                                        fournies est incorrecte. 
     */
    public int getEtatIdCase(int x, int y) 
            throws ArrayIndexOutOfBoundsException {
        return this.etatIdPlateau[y][x];
    }
}
