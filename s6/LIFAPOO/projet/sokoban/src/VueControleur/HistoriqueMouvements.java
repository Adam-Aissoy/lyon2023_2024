package VueControleur;

import java.util.Stack;

public class HistoriqueMouvements {
    private Stack<Mouvement> undoStack;
    private Stack<Mouvement> redoStack;

    public HistoriqueMouvements() {
        undoStack = new Stack<>();
        redoStack = new Stack<>();
    }

    public void ajouterMouvement(Mouvement mouvement) {
        undoStack.push(mouvement);
        redoStack.clear(); // Clear redo stack when a new move is added
    }

    public boolean peutAnnuler() {
        return !undoStack.isEmpty();
    }

    public boolean peutRetablir() {
        return !redoStack.isEmpty();
    }

    public void annuler() {
        if (peutAnnuler()) {
            Mouvement mouvement = undoStack.pop();
            redoStack.push(mouvement);
            mouvement.annuler();
        }
    }

    public void retablir() {
        if (peutRetablir()) {
            Mouvement mouvement = redoStack.pop();
            undoStack.push(mouvement);
            mouvement.retablir();
        }
    }
}
