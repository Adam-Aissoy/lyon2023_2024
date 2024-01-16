table {
    Clients(cle(numC),nomC,adresseC);
    Commandes(cle_faible(datecom),commentaire, cle_etranger(numC));
    livraisons(cle_faibles(dateLiv),prestataire, cle_etranger(datecom)));
    produits(cle (numP), nomP,descriptif);
    concerneds(cle(numP,datecom));
} 

CREATE TABLE Clients (
    numC SERIAL PRIMARY KEY,
    nomC VARCHAR(255),
    adresseC VARCHAR(255)
);

CREATE TABLE Commandes (
    numC INT,
    datecom DATE,
    commentaire VARCHAR(255),
    PRIMARY KEY (numC, datecom),
    FOREIGN KEY (numC) REFERENCES Clients(numC)
);

CREATE TABLE Livraisons (
    dateLiv DATE,
    numC INT,
    prestataire VARCHAR(255),
    datecom DATE,
    PRIMARY KEY (dateLiv, numC, datecom),
    FOREIGN KEY (numC, datecom) REFERENCES Commandes(numC, datecom)
);

CREATE TABLE Produits (
    numP SERIAL PRIMARY KEY,
    nomP VARCHAR(255),
    descriptif TEXT
);

CREATE TABLE Concerne (
    numP INT,
    datecom DATE,
    numC INT,
    PRIMARY KEY (numP, datecom),
    FOREIGN KEY (numP) REFERENCES Produits(numP),
    FOREIGN KEY (numC, datecom) REFERENCES Commandes(numC, datecom)
);
/* other notes end example  */

CREATE FUNCTION NomFonc(param1 type, etc.) RETURNS TYPE AS
$$ /* Truc ouvrant */
DECLARE
  /* Variables qu'on veut, définies comme des attributss */
  machin TYPE;
BEGIN
  /* Calculs machin truc */
  RETURN 69420;
END;
$$ /* Truc fermant */
LANGUAGE plpgsql gnurfijeigrhtbrjeikdfrugbyfujikerjuhgeftgb;
/*********************************************************************/
 CREATE OR REPLACE FUNCTION Checkresult(numvote integer) RETURNS BOOLEAN
AS $$
DECLARE
    total_votes INTEGER;
    total_votants INTEGER;
BEGIN
    SELECT SUM(voix + nuls + blancs) as somme
    INTO total_votes
    FROM bureaux
    JOIN obtient ON bureaux.code_bureau = obtient.code_bureau
    JOIN candidats ON obtient.id_candidat = candidats.id_candidat
    WHERE bureaux.code_bureau = numvote;

    SELECT SUM(votants)
    INTO total_votants
    FROM bureaux
    WHERE bureaux.code_bureau = numvote;

    RETURN total_votes = total_votants; 
END;
$$ LANGUAGE plpgsql;

alter table cours alter constraint fk_prof_intervient deferrable;
INSERT INTO club_de_danse.professeurs
(num_prof, nom_prof, prenom_prof, tel_prof)
VALUES(1, 'Pines', 'Mabel', '');
/*  //valeur exemple  */ 

begin;
set constraints  fk_prof_intervient deferred ;
INSERT INTO club_de_danse.cours
(code_cours, intitule_cours, numresponsable_cours, niveau_cours)
VALUES(1, 'rock', 1, 'Expert');/* //valeur exemple */ 

INSERT INTO club_de_danse.prof_intervient_cours
(num_prof, code_cours)
VALUES(1, 1);/*  // valeur exemple*/
commit;/* // la jouer si ca ne finit pas */
end;

/*tpn ******/

CREATE TABLE emprunts_brut (
    id SERIAL PRIMARY KEY,
    usager_id INT,
    livre_id INT,
    date_emprunt DATE,
    date_retour DATE,
    FOREIGN KEY (usager_id) REFERENCES usagers(id),
    FOREIGN KEY (livre_id) REFERENCES livres(id)
);

-- INSERT INTO emprunts_brut (usager_id, livre_id, date_emprunt, date_retour) VALUES (...);
-- ... (insertion des données brutes)

CREATE TABLE emprunts_brut (
    num_usager int4 NULL,
    num_auteur int4 NULL,
    num_oeuvre int4 NULL,
    num_exemplaire int4 NULL,
    date_emprunt date NULL,
    date_retour date NULL,
    date_exemplaire date NULL,
    titre_oeuvre varchar(32) NULL,
    annee_oeuvre int4 NULL,
    nom_auteur varchar(16) NULL,
    prenom_auteur varchar(16) NULL,
    nom_usager varchar(8) NULL,
    prenom_usager varchar(16) NULL,
/******* brouillon */
ALTER TABLE emprunts_brut
ADD CONSTRAINT unique_nom_usager UNIQUE (nom_usager);

comment verifier dans cette TABLE emprunts_brut (
	num_usager int4 NULL,
	num_auteur int4 NULL,
	num_oeuvre int4 NULL,
	num_exemplaire int4 NULL,
	date_emprunt date NULL,
	date_retour date NULL,
	date_exemplaire date NULL,
	titre_oeuvre varchar(32) NULL,
	annee_oeuvre int4 NULL,
	nom_auteur varchar(16) NULL,
	prenom_auteur varchar(16) NULL,
	nom_usager varchar(8) NULL,
	prenom_usager varchar(16) NULL
); 

TABLE emprunts_brut (
	num_usager int4 NULL,
	num_auteur int4 NULL,
	num_oeuvre int4 NULL,
	num_exemplaire int4 NULL,
	date_emprunt date NULL,
	date_retour date NULL,
	date_exemplaire date NULL,
	titre_oeuvre varchar(32) NULL,
	annee_oeuvre int4 NULL,
	nom_auteur varchar(16) NULL,
	prenom_auteur varchar(16) NULL,
	nom_usager varchar(8) NULL,
	prenom_usager varchar(16) NULL
); 
Vérifiez chacune des dépendances suivantes dans ces données brutes par une requête (une requête par question).
3)Une oeuvre a au plus un auteur
1)Chaque usager possède bien un nom unique


2)Chaque emprunt est réalisé par un seul usager.
3)Une oeuvre a au plus un auteur
SELECT COUNT(*) AS count
FROM (
    SELECT nom_usager
    FROM emprunts_brut
    GROUP BY nom_usager
    HAVING COUNT(*) > 1
) AS duplicates;

SELECT COUNT(*) AS count
FROM (
    SELECT num_exemplaire
    FROM emprunts_brut
    GROUP BY num_exemplaire
    HAVING COUNT(*) > 1
) AS duplicates;

/*exo 1.1*/
SELECT 
    CASE 
        WHEN COUNT(DISTINCT nom_usager) = COUNT(nom_usager) THEN 'Chaque usager a un nom unique'
        ELSE 'Des doublons ont été trouvés'
    END
FROM emprunts_brut;
SELECT 
    CASE 
        WHEN COUNT(*) = COUNT(DISTINCT num_usager) THEN 'Chaque emprunt est réalisé par un seul usager'
        ELSE 'Des emprunts ont été réalisés par plusieurs usagers'
    END
FROM emprunts_brut;

/*exo 2*/
/*
Exercice 2 (3 pts)
Vous avez constaté que la dernière dépendance fonctionnelle n'est pas satisfaite dans les données.

Le script suivant est la traduction fidèle du schéma conceptuel. Corrigez et exécutez ce script de façon à ce qu'il puisse intégrer toutes les données brutes ; c'est à dire en apportant les modifications nécessaires pour tenir compte du fait qu'une oeuvre peut avoir plusieurs auteurs. Vous serez amenés à créer une table "est_auteur".
*/

drop schema if exists bibliotheque_bda;
create schema bibliotheque_bda;
set search_path to bibliotheque_bda;

CREATE TABLE auteurs (
  PRIMARY KEY (num_auteur),
  num_auteur    integer NOT NULL,
  nom_auteur    text,
  prenom_auteur text
);

CREATE TABLE emprunts (
  PRIMARY KEY (num_oeuvre, num_exemplaire, date_emprunt),
  num_oeuvre     integer NOT NULL,
  num_exemplaire integer NOT NULL,
  date_emprunt   date NOT NULL,
  date_retour    date,
  num_usager     integer NOT NULL
);

CREATE TABLE exemplaires (
  PRIMARY KEY (num_oeuvre, num_exemplaire),
  num_oeuvre      integer NOT NULL,
  num_exemplaire  integer NOT NULL,
  date_exemplaire date
);

CREATE TABLE oeuvres (
  PRIMARY KEY (num_oeuvre),
  num_oeuvre   integer NOT NULL,
  titre_oeuvre text,
  annee_oeuvre integer,
  num_auteur   integer NULL
);

CREATE TABLE usagers (
  PRIMARY KEY (num_usager),
  num_usager    integer NOT NULL,
  nom_usager    text,
  prenom_usager text
);

ALTER TABLE emprunts ADD FOREIGN KEY (num_usager) REFERENCES usagers (num_usager);
ALTER TABLE emprunts ADD FOREIGN KEY (num_oeuvre, num_exemplaire) REFERENCES exemplaires (num_oeuvre, num_exemplaire);

ALTER TABLE exemplaires ADD FOREIGN KEY (num_oeuvre) REFERENCES oeuvres (num_oeuvre);


CREATE TABLE est_acteur (
  PRIMARY KEY (num_acteur, num_oeuvre),
  num_acteur integer NOT NULL,
  num_oeuvre   integer NOT NULL
);
/*
Faites les requêtes de migration des données brutes vers les relations 'auteurs' et 'oeuvres' de la base de données ainsi créée.
*/


INSERT INTO auteurs (num_auteur, nom_auteur, prenom_auteur) COALESCE((SELECT num_auteur, nom_auteur, prenom_auteur FROM emprunts_brut), (SELECT num_auteur, nom_auteur, prenom_auteur FROM emprunts_brut));
INSERT INTO oeuvres (num_oeuvre, titre_oeuvre, annee_oeuvre) COALESCE((SELECT num_oeuvre, titre_oeuvre, annee_oeuvre FROM emprunts_brut), (SELECT num_oeuvre, titre_oeuvre, annee_oeuvre FROM emprunts_brut));

INSERT INTO auteurs (num_auteur, nom_auteur, prenom_auteur)
SELECT DISTINCT num_auteur, nom_auteur, prenom_auteur
FROM emprunts_brut;

INSERT INTO oeuvres (num_oeuvre, titre_oeuvre, annee_oeuvre)
SELECT DISTINCT num_oeuvre, titre_oeuvre, annee_oeuvre
FROM emprunts_brut;

/*
Faites les requêtes de migration des données brutes vers les relations 'auteurs' et 'oeuvres' de la base de données ainsi créée.
*/
-- (3 pts) Donner dans l'ordre alphabétique le titre et l'année des oeuvres jamais empruntées. (titre, année)
SELECT titre_oeuvre, annee_oeuvre
FROM oeuvres
WHERE num_oeuvre NOT IN (
    SELECT DISTINCT num_oeuvre
    FROM emprunts
);

-- (3 pts) Donner dans l'ordre alphabétique le nom, le prénom et le nombre d'emprunts du (ou des)lecteur ou lectrice de la bibliothèque, ayant emprunté le moins d'oeuvres différentes (peu importe l'exemplaire). (nom, prénom, nombre d'oeuvres)
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
);

-- (3 pts) Classer les oeuvres par ordre décroissant du nombre d'emprunts en précisant leur rang dans cet ordre. (titre, nb emprunts, rang)
SELECT titre_oeuvre, COUNT(*) AS nb_emprunts, RANK() OVER (ORDER BY COUNT(*) DESC) AS rang
FROM oeuvres
LEFT JOIN exemplaires ON oeuvres.num_oeuvre = exemplaires.num_oeuvre
LEFT JOIN emprunts ON exemplaires.num_oeuvre = emprunts.num_oeuvre AND exemplaires.num_exemplaire = emprunts.num_exemplaire
GROUP BY oeuvres.num_oeuvre, titre_oeuvre
ORDER BY nb_emprunts DESC;

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


/*  test envoie et la aussi*/
