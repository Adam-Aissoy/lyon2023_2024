#include <Coup>

public class Plateau {
    public int longueur, largeur;
    public int  [][] etatIdPlateau;
    public Plateau(int longueur, int largeur) {
        this.longueur = longueur;
        this.largeur = largeur;
        this.etatIdPlateau = new int[longueur][largeur];
    }
    public void initialiser (){
        for (int i = 0; i < longueur; i++) {
            for (int j = 0; j < largeur; j++) {
                etatIdPlateau[i][j] = 0;
            }
        }
    }
    public void appliquerCoup(Coup coup , int id ){
        etatIdPlateau[coup.x][coup.y] = id;

    }
    public void afficher() {
        for (int i = 0; i < longueur; i++) {
            for (int j = 0; j < largeur; j++) {
                System.out.print(etatIdPlateau[i][j] + " ");
            }
            System.out.println();
        }
    }
    
}
