/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tp1.exercice2;

/**
 *
 * @author FA
 */
public class Moto {

    private Moteur moteur;
    private Roue[] tabRoues;
    private Phare[] tabPhares;
    
    public Moto() { // constructeur par défaut (pas de paramètre), initialisation par défaut des attributs
        
        moteur = new Moteur();
        
        tabRoues = new Roue[2];
        tabRoues[0] = new Roue();
        tabRoues[1] = new Roue();
        
        tabPhares = new Phare[2];
        tabPhares[0] = new Phare();
        tabPhares[1] = new Phare();
        
        
    }
    
    
    public void démarrer() {
        
        moteur.setÉtat(true);
        tabPhares[0].setÉtat(true);
        tabPhares[1].setÉtat(true);
        
    }

    public void accélérer() {
     
        if (moteur.getÉtat() && tabPhares[0].getÉtat() && tabPhares[1].getÉtat()) {
            moteur.enclencher();
        } else {
            System.out.println("Accélération impossible !");
        }
        
    }
    
    
    
    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        
        Moto m = new Moto();
        
        m.accélérer();
        
        m.démarrer();
        
        m.accélérer();
        
    }
    
}
