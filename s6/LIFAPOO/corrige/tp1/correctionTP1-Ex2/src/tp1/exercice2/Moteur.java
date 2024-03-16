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
public class Moteur {
    private boolean état = false; // true => allumé, false => éteint
    
    public void setÉtat(boolean _état) {
        état = _état;
    }
    
    public boolean getÉtat() {
        return état;
    }
    
    
    public void enclencher() {
        // code propre à définir
        System.out.println("Le moteur est enclenché");
    }
    
}
