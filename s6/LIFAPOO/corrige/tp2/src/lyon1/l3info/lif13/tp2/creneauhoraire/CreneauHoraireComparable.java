/*
 * CreneauHoraireComparable.java                                      16/10/2019
 */
package lyon1.l3info.lif13.tp2.creneauhoraire;

/**
 * Représente un créneau horaire dont la durée peut être comparée à d'autres. 
 * Utilise l'interface Comparable, qui permet l'utilisation du tri dans des 
 * collections (ex : ArrayList, SortedSet...) en se basant sur le retour de
 * compareTo. 
 * 
 * @author julien.lacombe
 * @version 1.0
 */
public class CreneauHoraireComparable extends CreneauHoraire 
                                      implements Comparable<CreneauHoraireComparable> {

    public CreneauHoraireComparable(int jour,   int heure, 
                                    int minute, int duree) {
        // On utilise le constructeur de CreneauHoraire. 
        super(jour, heure, minute, duree);
    }
    
    
    @Override
    public int compareTo(CreneauHoraireComparable obj) {
        /* Si les références sont identiques -> il s'agit du même objet, et
         * donc des mêmes valeurs. */
        if (this == obj) {
            return 0;
        }
        // Si on se compare à une référence null.
        if (obj == null) {
            throw new NullPointerException();
        }
        // Si l'objet auquel on se compare n'est pas de la même classe.
//        if (getClass() != obj.getClass()) {
//            throw new ClassCastException();
//        }
        /* => devenu inutile avec la généricité qui impose 
         *    que les 2 objets soient de la même classe */
        
        /* A ce stade, on est sûr que l'objet auquel on se compare existe et 
         * est de la même classe que nous.
         * Pour pouvoir comparer les valeurs des attributs de this à celles 
         * de cet objet, on effectue un downcast : */
//        final CreneauHoraireComparable autre = (CreneauHoraireComparable) obj;
        /* => l'objet est déjà du bon type grâce à la généricité */

        if (this.duree > obj.duree) {
            return 1;
        } else if (this.duree == obj.duree) {
            return 0;
        }
        // else
        return -1;
    }
}
