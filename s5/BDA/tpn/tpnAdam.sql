

/* test */


/*  Exercice1 */
/*1) */
SELECT COUNT(*) AS count
FROM (
    SELECT nom_usager
    FROM emprunts_brut
    GROUP BY nom_usager
    HAVING COUNT(*) > 1
) AS duplicates;
/* other test */
SELECT 
    CASE 
        WHEN COUNT(DISTINCT nom_usager) = COUNT(nom_usager) THEN 'Chaque usager a un nom unique'
        ELSE 'Des doublons ont été trouvés'
    END
FROM emprunts_brut;
/*mais il affiche toujours qu'il a touver quelque chose*/
/* normalement non*/
/*2) */
SELECT 
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT num_usager) THEN 'Chaque emprunt est réalisé par un seul usager'
        ELSE 'Des emprunts ont été réalisés par plusieurs usagers'
    END
FROM emprunts_brut;
/*3) */

/*Exercice 2 */
/* on supprime la ligne suivante */
ALTER TABLE oeuvres ADD FOREIGN KEY (num_auteur) REFERENCES auteurs (num_auteur);
/*et on creer */
CREATE TABLE est_acteur (
  PRIMARY KEY (num_acteur, num_oeuvre),
  num_acteur integer NOT NULL,
  num_oeuvre   integer NOT NULL
);
/* exo 3*/

INSERT INTO auteurs (num_auteur, nom_auteur, prenom_auteur) COALESCE((SELECT num_auteur, nom_auteur, prenom_auteur FROM emprunts_brut), (SELECT num_auteur, nom_auteur, prenom_auteur FROM emprunts_brut));
INSERT INTO oeuvres (num_oeuvre, titre_oeuvre, annee_oeuvre) COALESCE((SELECT num_oeuvre, titre_oeuvre, annee_oeuvre FROM emprunts_brut), (SELECT num_oeuvre, titre_oeuvre, annee_oeuvre FROM emprunts_brut));


/*exo 4 */

SELECT titre_oeuvre, COUNT(*) AS nb_emprunts, RANK() OVER (ORDER BY COUNT(*) DESC) AS rang
FROM oeuvres
LEFT JOIN exemplaires ON oeuvres.num_oeuvre = exemplaires.num_oeuvre
LEFT JOIN emprunts ON exemplaires.num_oeuvre = emprunts.num_oeuvre AND exemplaires.num_exemplaire = emprunts.num_exemplaire
GROUP BY oeuvres.num_oeuvre, titre_oeuvre
ORDER BY nb_emprunts DESC;

/**/
SELECT titre_oeuvre, annee_oeuvre
FROM oeuvres
WHERE num_oeuvre NOT IN (
    SELECT DISTINCT num_oeuvre
    FROM emprunts
);
SELECT nom_usager, prenom_usager, COUNT(DISTINCT num_oeuvre) AS nb
FROM usagers
JOIN emprunts ON usagers.num_usager = emprunts.num_usager
GROUP BY usagers.num_usager
HAVING COUNT(DISTINCT num_oeuvre) = (
    SELECT MIN(cnt)
    FROM (
        SELECT COUNT(DISTINCT num_oeuvre) AS cnt
        FROM emprunts
        GROUP BY num_usager
    ) AS subquery
)
ORDER BY nom_usager, prenom_usager;