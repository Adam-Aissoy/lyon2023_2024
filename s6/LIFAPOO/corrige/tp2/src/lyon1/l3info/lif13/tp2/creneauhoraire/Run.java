/*
 * Run.java                                                           16/10/2019
 */
package lyon1.l3info.lif13.tp2.creneauhoraire;

import java.util.ArrayList;

/**
 * Classe principale, utilisée pour les tests. 
 * 
 * Remarque : on n'effectue ici que des tests basiques mais une bonne 
 * pratique est d'utiliser des tests unitaires à l'aide d'un framework 
 * tel que JUnit.
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class Run {
    
    public static void testerPartie1() {
        System.out.println("Tests Partie 1 : ");
        /* Définition de 2 objets créneau horaire différents mais de valeurs 
         * identiques.  */
        CreneauHoraire c1 = new CreneauHoraire(87, 10, 0, 1);
        CreneauHoraire c2 = new CreneauHoraire(87, 10, 0, 1);
        
        /* L'opérateur == compare les références : comme c1 et c2 contiennent 
         * les références de 2 objets différents, == retourne false. */
        System.out.println("(c1 == c2) = " + (c1 == c2));
        
        /* En revanche, equals compare la valeur des objets, et non pas leur
         * référence. Si cette méthode est correctement définie pour la classe
         * CreneauHoraire, elle doit renvoyer true. 
         * Rappel : equals est une fonction disponible pour n'importe quel
         * objet Java, automatiquement héritée depuis la classe Object. */
        System.out.println("(c1.equals(c2)) = " + (c1.equals(c2)));
        
        /* Test du clonage : l'objet cloné et le clone ne doivent pas avoir la 
         * même référence (== retourne false) mais doivent avoir les mêmes 
         * valeurs (equals retourne true). */
        CreneauHoraire clone = (CreneauHoraire) c1.clone();
        System.out.println(System.lineSeparator() + 
                           "Test 1.1 - clone. Attendu : false puis true. ");
        System.out.println("(c1 == clone) = " + (c1 == clone));
        System.out.println("(c1.equals(clone)) = " + (c1.equals(clone)));
        
        // Test de la saisie de créneau horaire. 
        System.out.println(System.lineSeparator() + 
                           "Test 1.2 - saisirCreneau. ");
        CreneauHoraire c3 = CreneauHoraire.saisirCreneau();
        
        System.out.println();
    }
    
    
    public static void testerPartie2() {
        System.out.println("Tests Partie 2 : ");
        
        // Test de compareTo : 
        CreneauHoraireComparable chc1 = new CreneauHoraireComparable(1, 14,  0, 120);
        CreneauHoraireComparable chc2 = new CreneauHoraireComparable(1, 16, 15, 120);
        CreneauHoraireComparable chc3 = new CreneauHoraireComparable(1, 14,  0,  60);
        CreneauHoraireComparable chc4 = new CreneauHoraireComparable(1, 14,  0, 180);
        
        System.out.println("Test 2.1 - compareTo. Attendu : 0, 1 puis -1. ");
        System.out.println(chc1.compareTo(chc2));
        System.out.println(chc1.compareTo(chc3));
        System.out.println(chc1.compareTo(chc4));
        
        /* + de tests sur compareTo : référence null, avec un objet 
         * d'une autre classe ... */
        System.out.println();
    }
    
    
    public static void testerPartie3() {
        System.out.println("Tests Partie 3 : ");
        System.out.println("Test 3.1 - Tentative d'insertion d'éléments "
                         + " dans une instance de ListeTriee : ");
        ListeTriee lt1 = new ListeTriee();
        
        System.out.println("Avec un élément non Comparable : ");
        CreneauHoraire c1 = new CreneauHoraire(87, 10, 0, 1);
        try {
            lt1.add(c1);
            System.out.println("NOK : insertion possible. ");
        } catch (Exception e) {
            System.out.println("OK  : insertion impossible. ");
        }
        
        System.out.println("Avec un élément Comparable : ");
        CreneauHoraireComparable chc1 = new CreneauHoraireComparable(1, 14,  0, 120);
        try {
            lt1.add(chc1);
            System.out.println("OK  : insertion possible. ");
        } catch (Exception e) {
            System.out.println("NOK : insertion impossible. ");
        }
        
        System.out.println("Avec une collection d'éléments non Comparable : ");
        ArrayList<CreneauHoraire> collec1 = new ArrayList<>();
        collec1.add(new CreneauHoraire(87, 10, 0, 1));
        collec1.add(new CreneauHoraire(87, 10, 0, 1));
        collec1.add(new CreneauHoraire(87, 10, 0, 1));
        try {
            lt1.addAll(collec1);
            System.out.println("NOK : insertion possible. ");
        } catch (Exception e) {
            System.out.println("OK  : insertion impossible. ");
        }
        
        System.out.println("Avec une collection d'éléments Comparable : ");
        ArrayList<CreneauHoraireComparable> collec2 = new ArrayList<>();
        collec2.add(new CreneauHoraireComparable(87, 10, 0, 1));
        collec2.add(new CreneauHoraireComparable(87, 10, 0, 1));
        collec2.add(new CreneauHoraireComparable(87, 10, 0, 1));
        try {
            lt1.addAll(collec2);
            System.out.println("OK  : insertion possible. ");
        } catch (Exception e) {
            System.out.println("NOK : insertion impossible. ");
        }
        
        
        System.out.println(System.lineSeparator() 
                         + "Test 3.2 - vérification du tri. ");
        System.out.println("Avec des ajouts successifs d'éléments : ");
        ListeTriee<CreneauHoraireComparable> lt2 = new ListeTriee<>();
        lt2.add(new CreneauHoraireComparable(87, 10, 0, 60));
        lt2.add(new CreneauHoraireComparable(87, 10, 0, 120));
        lt2.add(new CreneauHoraireComparable(87, 10, 0, 30));
        lt2.add(new CreneauHoraireComparable(87, 10, 0, 90));
        lt2.add(new CreneauHoraireComparable(87, 10, 0, 60));
        System.out.println(lt2.toString());
        /* Pas besoin de redéfinir toString() : le toString() de ArrayList
         * utilise une concaténation des toString() des membres de l'ArrayList. */
        
        System.out.println("Avec l'ajout direct d'une collection non triée : ");
        ListeTriee<CreneauHoraireComparable> lt3 = new ListeTriee<>();
        ArrayList<CreneauHoraireComparable> collec3 = new ArrayList<>();
        collec3.add(new CreneauHoraireComparable(87, 10, 0, 60));
        collec3.add(new CreneauHoraireComparable(87, 10, 0, 120));
        collec3.add(new CreneauHoraireComparable(87, 10, 0, 30));
        collec3.add(new CreneauHoraireComparable(87, 10, 0, 90));
        collec3.add(new CreneauHoraireComparable(87, 10, 0, 60));
        lt3.addAll(collec3);
        System.out.println(lt3.toString());
        
        /* Avantages de l'utilisation de la généricité :
         * https://docs.oracle.com/javase/tutorial/java/generics/why.html */
    }
    
    
    /**
     * Tests de CreneauHoraire et de CreneauHoraireComparable. 
     */
    public static void main(String[] args) {
        testerPartie1();
        testerPartie2();
        testerPartie3();
    }
}
