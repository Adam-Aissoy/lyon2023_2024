package modele;

public class Mouvement {
    private Direction direction;
    private int ancienneX;
    private int ancienneY;
    private int nouvelleX;
    private int nouvelleY;

    public Mouvement(Direction direction, int ancienneX, int ancienneY, int nouvelleX, int nouvelleY) {
        this.direction = direction;
        this.ancienneX = ancienneX;
        this.ancienneY = ancienneY;
        this.nouvelleX = nouvelleX;
        this.nouvelleY = nouvelleY;
    }

    public Direction getDirection() {
        return direction;
    }

    public int getAncienneX() {
        return ancienneX;
    }

    public int getAncienneY() {
        return ancienneY;
    }

    public int getNouvelleX() {
        return nouvelleX;
    }

    public int getNouvelleY() {
        return nouvelleY;
    }
}
