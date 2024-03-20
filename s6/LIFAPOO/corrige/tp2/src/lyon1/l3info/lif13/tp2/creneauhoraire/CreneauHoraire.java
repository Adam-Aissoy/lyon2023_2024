/*
 * CreneauHoraire.java                                                16/10/2019
 */
package lyon1.l3info.lif13.tp2.creneauhoraire;

import java.util.Scanner;

/**
 * Représente un créneau horaire composé d'un numéro de jour, d'une heure et
 * d'une minute de début ainsi que d'une durée en minutes. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class CreneauHoraire implements Cloneable {
    /* Rappel : pour respecter le principe d'encapsulation, les attributs de  
     * classe doivent être en private ou protected et accessibles uniquement 
     * via des getters/setters. */
    /** Numéro du jour de début. */
    protected int jour;
    
    /** Heure de début. */
    protected int heure;
    
    /** Minute de début. */
    protected int minute;
    
    /** Durée du créneau en minutes. */
    protected int duree;
    
    
    public CreneauHoraire(int jour, int heure, int minute, int duree) {
        /* Remarque : lorsque 2 variables ont le même nom, c'est celle dont 
         * le contexte est le proche qui est utilisée par défaut. On doit donc
         * ici utiliser this pour indiquer que l'on parle du membre de la 
         * classe et pas d'un argument du constructeur. */
        this.jour = jour;
        this.heure = heure;
        this.minute = minute;
        this.duree = duree;
    }
    

    /* Getters & Setters. La plupart des IDE proposent une génération automatique
     * de ceux-ci. Par exemple, si vous êtes sous NetBeans : clic droit dans le
     * fichier courant >> Insert Code >> Getter & Setter. */
    public int getJour() {
        return jour;
    }

    public void setJour(int jour) {
        this.jour = jour;
    }

    public int getHeure() {
        return heure;
    }

    public void setHeure(int heure) {
        this.heure = heure;
    }

    public int getMinute() {
        return minute;
    }

    public void setMinute(int minute) {
        this.minute = minute;
    }

    public int getDuree() {
        return duree;
    }

    public void setDuree(int duree) {
        this.duree = duree;
    }

    
    @Override
    public boolean equals(Object obj) {
        /* Si les références sont identiques -> il s'agit du même objet, et
         * donc des mêmes valeurs. */
        if (this == obj) {
            return true;
        }
        // Si on se compare à une référence null.
        if (obj == null) {
            return false;
        }
        // Si l'objet auquel on se compare n'est pas de la même classe.
        if (getClass() != obj.getClass()) {
            return false;
        }
        
        /* A ce stade, on est sûr que l'objet auquel on se compare existe et 
         * est de la même classe que nous.
         * Pour pouvoir comparer les valeurs des attributs de this à celles 
         * de cet objet, on effectue un downcast : */
        final CreneauHoraire autre = (CreneauHoraire) obj;
        
        // Si une seule des valeurs diffère -> false. 
        if (this.jour != autre.jour) {
            /* Remarque : les attributs privés de autre sont accessibles sans 
             * passer par ses getters uniquement parce que nous sommes dans une 
             * classe du même type. Dans tout autre cas, il faut toujours utiliser
             * les getters / setters. Plus de détails ici :
             * https://stackoverflow.com/questions/17027139/access-private-field-of-another-object-in-same-class */
            return false;
        }
        if (this.heure != autre.heure) {
            return false;
        }
        if (this.minute != autre.minute) {
            return false;
        }
        if (this.duree != autre.duree) {
            return false;
        }
        // Sinon : les 2 objets ont des valeurs identiques -> true. 
        return true;
    }

    
    /* C'est une bonne pratique lorsqu'on définit equals d'aussi override
     * la fonction hashCode. Il s'agit d'une fonction qui à toute instance
     * d'une classe doit renvoyer un nombre entier unique. Le principe est
     * de combiner multiplicativement (généralement à l'aide d'un nombre 
     * premier) l'ensemble des attributs d'une instance pour en fournir un 
     * entier unique associé. 
     *
     * Plutôt que d'utiliser equals, certaines collections telles que HashMap, 
     * HashSet ... utilisent la valeur du hash code pour améliorer leur 
     * performance.
     * 
     * Pour plus de détails, vous pouvez consulter la section 97.2.3. de : 
     * https://jmdoudoux.developpez.com/cours/developpons/java/chap-techniques_java.php
     */
    @Override
    public int hashCode() {
        final int nbPremier = 37; // Nombre premier choisi arbitrairement.
        int hash = 7; // La valeur du hash code qui sera retournée.
        hash = nbPremier * hash + this.jour;
        hash = nbPremier * hash + this.heure;
        hash = nbPremier * hash + this.minute;
        hash = nbPremier * hash + this.duree;
        return hash;
    }

    
    @Override
    protected Object clone() {
        CreneauHoraire clone = null;
        
        try {
            /* On récupère ce que renvoie le clone de la classe mère, et on le
             * downcast en CreneauHoraire. */
            clone = (CreneauHoraire) super.clone();
        } catch(CloneNotSupportedException cnse) {
            // N'arrive normalement jamais (on implémente Cloneable). 
            cnse.printStackTrace(System.err);
        }
        
        /* Si un des attributs de classe n'était pas de type primitif, il
         * serait nécessaire d'appeler sa méthode clone ici. */
        
        return clone;
    }

    
    @Override
    public String toString() {
        return "CreneauHoraire{" + "jour=" + jour + ", heure=" 
             + heure + ", minute=" + minute + ", duree=" + duree + '}';
    }
    
    
    /**
     * Demande à l'utilisateur de re-saisir un nombre entier suite à la 
     * saisie d'une valeur incorrecte par celui-ci. 
     * 
     * @param sc le scanner à utiliser. 
     * @param le nombre entier incorrect saisi. 
     * @return le nouveau nombre entier saisi. 
     */
    private static int demanderRessaisie(Scanner sc, int nombre) {
        System.out.print(nombre + " est une valeur incorrecte."
                       + System.lineSeparator()
                       + "Veuillez refaire votre saisie : ");
        return saisirNbEntier(sc);
    }
    
    
    /**
     * Demande la saisie d'un nombre entier à l'utilisateur et refuse sa saisie
     * tant qu'il n'en a pas fourni un. 
     * 
     * @param sc le scanner à utiliser. 
     * @return le nombre entier saisi. 
     */
    private static int saisirNbEntier(Scanner sc) {
        String entreeUtil;
        
        // Tant que la saisie de l'utilisateur n'est pas un nombre entier. 
        while (!sc.hasNextInt()) {
            /* On le signale à l'utilisateur en affichant sa saisie, et on
             * lui redemande. */
            entreeUtil = sc.next();
            System.out.print(entreeUtil + " n'est pas un nombre entier. "
                           + System.lineSeparator()
                           + "Veuillez refaire votre saisie : ");
            /* Remarque : System.lineSeparator() est équivalent à \n ou \r\n. 
             *            La valeur retournée s'adapte en fonction de l'OS. */ 
        }
        
        return sc.nextInt();
    }
    
    
    /**
     * Demande la saisie des valeurs que doit prendre le créneau depuis 
     * l'entrée standard et crée le créneau horaire correspondant.
     * 
     * @return le créneau horaire saisi. 
     */
    public static CreneauHoraire saisirCreneau() {
        Scanner sc = new Scanner(System.in);
        int jour, heure, minute, duree;
        CreneauHoraire creneauSaisi;
        
        System.out.println("Veuillez saisir les valeurs du créneau à créer. ");
        
        /* Saisie des différentes valeurs du créneau, en vérifiant à chaque
         * fois qu'il s'agit d'un nombre entier dans un domaine de valeurs
         * correct */
        System.out.print("Numéro du jour : ");
        jour = saisirNbEntier(sc);
        while (jour <= 0) {
            jour = demanderRessaisie(sc, jour);
        }
        
        System.out.print("Heure : ");
        heure = saisirNbEntier(sc);
        while (heure <= 0 || heure >= 24) {
            heure = demanderRessaisie(sc, heure);
        }
        
        System.out.print("Minute : ");
        minute = saisirNbEntier(sc);
        while (minute <= 0 || minute >= 60) {
            minute = demanderRessaisie(sc, minute);
        }
        
        System.out.print("Durée (en minutes) : ");
        duree = saisirNbEntier(sc);
        while (duree <= 0) {
            duree = demanderRessaisie(sc, duree);
        }
        /* Note : pensez toujours à factoriser le plus possible votre code
         * afin de faciliter la réutilisabilité et la lisibilité. Cela vous
         * évitera également du temps perdu à copier/coller du code. Dès que
         * vous avez envie de copier du code, c'est qu'il est probablement temps
         * d'écrire des fonctions !
        
         * Remarque : le code précédent est en fait encore davantage 
         * factorisable. Les conditions du type x <= a1 || x >= a2 peuvent être 
         * passées en argument de fonction, notamment à l'aide des expressions 
         * lambda (depuis Java 8), ce qui permettrait de factoriser les 4 blocs 
         * précédents en 1 seul. 
         */

        creneauSaisi = new CreneauHoraire(jour, heure, minute, duree);
        return creneauSaisi;
    }
}
