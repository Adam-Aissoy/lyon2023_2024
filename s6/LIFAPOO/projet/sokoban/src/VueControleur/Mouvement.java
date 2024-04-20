package VueControleur;

import modele.Entite;
import modele.Direction;

public class Mouvement {
    private Entite entite;
    private Direction direction;

    public Mouvement(Entite e, Direction d) {
        entite = e;
        direction = d;
    }

    public void annuler() {
        entite.avancerDirectionChoisie(direction.opposee());
    }

    public void retablir() {
        entite.avancerDirectionChoisie(direction);
    }
}
