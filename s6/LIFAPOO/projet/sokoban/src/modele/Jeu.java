/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modele;


import java.awt.Point;
import java.util.HashMap;
import java.util.Observable;
import VueControleur.HistoriqueMouvements;

public class Jeu extends Observable {

    public static final int SIZE_X = 20;
    public static final int SIZE_Y = 10;


    private HistoriqueMouvements historique;

    private Heros heros;

    private HashMap<Case, Point> map = new  HashMap<Case, Point>(); // permet de récupérer la position d'une case à partir de sa référence
    private Case[][] grilleEntites = new Case[SIZE_X][SIZE_Y]; // permet de récupérer une case à partir de ses coordonnées



    public Jeu() {

        /*initialisationNiveau();*/
        historique = new HistoriqueMouvements();
    }


    
    public Case[][] getGrille() {
        return grilleEntites;
    }
    
    public Heros getHeros() {
        return heros;
    }

    public void deplacerHeros(Direction d) {
        heros.avancerDirectionChoisie(d);
        setChanged();
        notifyObservers();
    }

    

    private void addCase(Case e, int x, int y) {
        grilleEntites[x][y] = e;
        map.put(e, new Point(x, y));
    }
    

    
    /** Si le déplacement de l'entité est autorisé (pas de mur ou autre entité), il est réalisé
     * Sinon, rien n'est fait.
     */
    public boolean deplacerEntite(Entite e, Direction d) {
        boolean retour = true;
        
        Point pCourant = map.get(e.getCase());
        
        Point pCible = calculerPointCible(pCourant, d);

        if (contenuDansGrille(pCible)) {
            Entite eCible = caseALaPosition(pCible).getEntite();
            if (eCible != null) {
                eCible.pousser(d);
            }

            // si la case est libérée
            if (caseALaPosition(pCible).peutEtreParcouru()) {
                e.getCase().quitterLaCase();
                caseALaPosition(pCible).entrerSurLaCase(e);

            } else {
                retour = false;
            }

        } else {
            retour = false;
        }

        return retour;
    }
    
    
    private Point calculerPointCible(Point pCourant, Direction d) {
        Point pCible = null;
        
        switch(d) {
            case haut: pCible = new Point(pCourant.x, pCourant.y - 1); break;
            case bas : pCible = new Point(pCourant.x, pCourant.y + 1); break;
            case gauche : pCible = new Point(pCourant.x - 1, pCourant.y); break;
            case droite : pCible = new Point(pCourant.x + 1, pCourant.y); break;     
            
        }
        
        return pCible;
    }
    /*Begin Adam Aysoy*/






    private void initialisationNiveau() {
        // Murs extérieurs horizontaux
        for (int x = 0; x < SIZE_X; x++) {
            addCase(new Mur(this), x, 0);
            addCase(new Mur(this), x, SIZE_Y - 1);
        }

        // Murs extérieurs verticaux
        for (int y = 1; y < SIZE_Y - 1; y++) {
            addCase(new Mur(this), 0, y);
            addCase(new Mur(this), SIZE_X - 1, y);
        }

        // Autres cases vides
        for (int x = 1; x < SIZE_X - 1; x++) {
            for (int y = 1; y < SIZE_Y - 1; y++) {
                addCase(new Vide(this), x, y);
            }
        }

        // Ajout du héros et du bloc
        heros = new Heros(this, grilleEntites[4][4]);
        Bloc b = new Bloc(this, grilleEntites[6][6]);
    }

    public void annuler() {
        if (historique.peutAnnuler()) {
            historique.annuler();
            // Annuler le mouvement dans le modèle
        }
    }

    public void retablir() {
        if (historique.peutRetablir()) {
            historique.retablir();
            // Rétablir le mouvement dans le modèle
        }
    }


    /*End Adam Aysoy*/


    /** Indique si p est contenu dans la grille
     */
    private boolean contenuDansGrille(Point p) {
        return p.x >= 0 && p.x < SIZE_X && p.y >= 0 && p.y < SIZE_Y;
    }
    
    private Case caseALaPosition(Point p) {
        Case retour = null;
        
        if (contenuDansGrille(p)) {
            retour = grilleEntites[p.x][p.y];
        }
        
        return retour;
    }
    /*this Adam*/


    public void chargerPuzzle(String filePath) {
        // Logique pour charger le puzzle à partir du fichier spécifié
        // Assurez-vous de mettre à jour la grille et les entités en conséquence

    }





}
