/*
 * JeuDeMorpion.java                                                  30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.jeu;

import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;

/**
 * 
 * 
 * @author julien.lacombe
 * @author remy.chaput
 * @version 1.1
 */
public class JeuDeMorpion extends Jeu {

    public JeuDeMorpion(Joueur joueur1, Joueur joueur2) {
        super(joueur1, joueur2, new PlateauMorpion());
    }
    
    
    /**
     * Détermine si la partie est gagnée ou non. 
     * 
     * @return True  si la partie est gagnée ;
     *         False sinon.
     */
    @Override
    protected boolean partieGagnee() {
        final int longueur = plateau.getLongueur();
        final int largeur = plateau.getLargeur();
        // Vérifie si un joueur en alignant une ligne ou une colonne. 
        boolean colAlignee,
                ligAlignee;
        for (int i = 0; i < longueur; ++i) {
            colAlignee = plateau.getEtatIdCase(i, 0) != 0;
            ligAlignee = plateau.getEtatIdCase(0, i) != 0;
            
            for (int j = 1; j < largeur; ++j) {
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
        boolean diag2Alignee = plateau.getEtatIdCase(0, longueur-1) != 0;
        for (int i = 0; i < longueur; ++i) {
            diag1Alignee = diag1Alignee && (plateau.getEtatIdCase(0, 0)
                                         == plateau.getEtatIdCase(i, i));
            diag2Alignee = diag2Alignee && (plateau.getEtatIdCase(0, longueur-1)
                                         == plateau.getEtatIdCase(i, longueur-1-i));
        }
        return diag1Alignee || diag2Alignee;
    }

}
