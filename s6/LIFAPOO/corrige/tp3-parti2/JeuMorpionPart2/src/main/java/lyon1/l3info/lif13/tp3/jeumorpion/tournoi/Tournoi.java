/*
 * Tournoi.java                                                       30/10/2019
 */
package lyon1.l3info.lif13.tp3.jeumorpion.tournoi;


import lyon1.l3info.lif13.tp3.jeumorpion.jeu.Jeu;
import lyon1.l3info.lif13.tp3.jeumorpion.tournoi.Builder;
import lyon1.l3info.lif13.tp3.jeumorpion.joueur.Joueur;

import java.util.ArrayList;
import java.util.List;


/**
 * Représente un Tournoi d'un certain type de jeux, contenant plusieurs joueurs.
 * Les joueurs s'affrontent deux par deux jusqu'à ce qu'il ne reste qu'un
 * vainqueur.
 * Une instance de Tournoi contient un Builder pour créer des instances du Jeu
 * spécifié.
 * 
 * @author remy.chaput
 * @version 1.0
 */
public class Tournoi {

    /**
     * Protected afin que ce membre de classe soit accessible aux instances de
     * Tournoi, ainsi qu'aux (éventuelles) classes filles. Cela permet de
     * faire des classes spécialisées. Le membre n'est pas disponible aux
     * autres classes (ainsi, on ne peut pas changer le Builder depuis le Main,
     * par exemple, ce qui est plus sécurisé).
     * Note : on utilise ici le mot-clé `final`, qui indique que cette
     * référence ne peut pas changer ; c'est une bonne idée en terme de
     * performance, mais ce n'est pas obligatoire.
     * Cela augmente également la lisibilité du code, en affirmant que
     * cette référence ne peut pas changer.
     */
    protected final Builder builder;

    /**
     * La liste des joueurs participant au tournoi.
     */
    public List<Joueur> joueurs;
    /**
     * Constructeur de Tournoi.
     * On spécifie un Builder qui détermine le type de Jeu
     * (Morpion, Puissance 4, ...)
     */
    public Tournoi(Builder builder) {
        this.builder = builder;
        this.joueurs = new ArrayList<>();
    }

    /**
     * On ajoute un joueur au Tournoi.
     */
    public void addJoueur(Joueur joueur) {
        // Il vaut mieux vérifier les cas limites
        if (joueur == null) {
            throw new NullPointerException("Le joueur ne doit pas être null !");
        }
        if (this.joueurs.contains(joueur)) {
            // Ici, on décide de soulever une exception.
            // On pourrait aussi ignorer silencieusement le joueur
            // (par exemple `return;`)
            throw new IllegalArgumentException("Le joueur est déjà inscrit dans le tournoi !");
        }
        this.joueurs.add(joueur);
    }

    /**
     * On lance le Tournoi, et on retourne le joueur gagnant.
     * @return Le nom du Joueur gagnant.
     */
    public String jouerTournoi() {
        final int nbJoueurs = this.joueurs.size();
        if (nbJoueurs == 0) {
            return "";
        }
        // À partir de là, on sait qu'il y a au moins 1 Joueur.
        Joueur gagnant = this.joueurs.get(0);
        for (int i = 1; i < nbJoueurs; ++i) {
            Joueur concurrent = this.joueurs.get(i);
            // On utilise une méthode privée pour séparer les responsabilités
            // On détermine le joueur qui gagne la partie
            gagnant = this.jouerPartie(gagnant, concurrent);
        }

        // gagnant ne devrait pas être `null`, mais c'est une bonne idée
        // d'éviter les NullPointerException le plus possible.
        // La formule suivante s'appelle une condition ternaire
        return (gagnant != null) ? String.valueOf(gagnant.getId()) : "";
    }

    /**
     * Petite méthode servant à lancer une partie entre 2 joueurs, et
     * retourne le joueur gagnant.
     * On aurait pu mettre ce code dans la boucle for, mais il est
     * (généralement) préférable de séparer les responsabilités.
     * Une méthode doit faire une chose et une seule (et le faire bien).
     *
     * @param j1 Le premier joueur (le "champion actuel")
     * @param j2 Le deuxième joueur (le "challenger")
     * @return le joueur ayant remporté le match
     */
    private Joueur jouerPartie(Joueur j1, Joueur j2) {
        Jeu jeu = this.builder.getPartie(j1, j2);
        Joueur gagnant = jeu.jouerPartie();
        if (gagnant == null) {
            // Match nul, on décide que j1 est gagnant
            // (on aurait pu tirer au hasard ou recommencer le match)
            gagnant = j1;
        }
        return gagnant;
    }
    
}
