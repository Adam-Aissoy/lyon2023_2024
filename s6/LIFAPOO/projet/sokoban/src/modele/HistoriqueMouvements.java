package modele;

import java.util.ArrayList;
import java.util.List;

public class HistoriqueMouvements {
    private List<Mouvement> historique;
    private int index;

    public HistoriqueMouvements() {
        historique = new ArrayList<>();
        index = -1;
    }

    public void ajouterMouvement(Mouvement mouvement) {
        // Ajouter un nouveau mouvement à l'historique
        // Effacer les mouvements suivants s'il y a eu un undo et un nouveau mouvement est ajouté
    }

    public boolean peutAnnuler() {
        return index >= 0;
    }

    public boolean peutRetablir() {
        return index < historique.size() - 1;
    }

    public void annuler() {
        // Annuler le dernier mouvement effectué
    }

    public void retablir() {
        // Rétablir le dernier mouvement annulé
    }
}
