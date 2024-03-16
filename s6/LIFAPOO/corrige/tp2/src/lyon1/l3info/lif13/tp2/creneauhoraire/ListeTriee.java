/*
 * ListeTriee.java                                                   16/10/2019
 */
package lyon1.l3info.lif13.tp2.creneauhoraire;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

/**
 * Une ArrayList qui maintient ses éléments triés dans l'ordre croissant. 
 * Remarque : les éléments triés en sont pas nécessairemment des créneaux 
 * horaires. 
 * 
 * @author julien.lacombe
 * @version 1.0
 * @param <E> le type des objets stockées dans la liste. 
 */
public class ListeTriee<E> extends ArrayList<Comparable<E>> {
    
    /**
     * Vérifie qu'un objet implémente bien Comparable. 
     * Lève une exception sinon. 
     * 
     * @param obj l'objet à vérifier. 
     */
    public void verifImplComparable(Object obj) {
        if (!(obj instanceof Comparable)) {
            throw new IllegalArgumentException("L'objet à ajouter à la liste "
                                             + "doit implémenter Comparable. ");
        }
    }
    
    
    /**
     * Vérifie que les objets d'une collection implémente bien tous Comparable. 
     * Lève une exception sinon. 
     * 
     * @param c la collection à vérifier. 
     */
    public void verifCollecImplComparable(Collection c) {
        for (Object element : c) {
            verifImplComparable(element);
        }
    }
    

    @Override
    public boolean addAll(Collection c) {
        /* Pas de garantie que les éléments de la collection fournie implémentent
         * Comparable -> vérification. */
        verifCollecImplComparable(c);
        
        for (Object element : c) {
            Comparable<E> elem = (Comparable<E>) element;
            this.add(elem);
        }
        return true; // Insertion réussie. 
        
        // Alternativement :
        // Trie la collection fournie dans l'ordre ascendant de ses éléments. 
//        Collections.sort((List) c);
//        return super.addAll(c);
    }


    @Override
    public boolean add(Comparable<E> e) {
        /* Devenu inutile avec la mise en place de la généricité qui impose 
         * directement dans la signature de la fonction que l'argument 
         * implémente Comparable. */
//        verifImplComparable(e);
        
        int i;
        /* Tant qu'on n'a pas atteint la fin de la liste et que l'élément à
         * ajouter est strictement supérieur à l'élément courant : on itère. */
        for (i = 0 ; i < this.size()
          && e.compareTo((E) this.get(i)) > 0 ; ++i) {}

        super.add(i, e); // On ajoute l'élément à l'index correspondant. 
        return true; // Insertion réussie. 
    }
    
    
    /* Puisque la liste doit être maintenue en ordre croissant, l'argument index
     * devient inutilisable -> on redirige vers les méthodes correspondantes 
     * n'utilisant pas d'index. */
    @Override
    public boolean addAll(int index, Collection c) {
        return this.addAll(c);
    }
    
    @Override
    public void add(int index, Comparable<E> element) {
        this.add(element);
    }
}
