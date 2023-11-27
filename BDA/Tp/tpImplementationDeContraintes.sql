/* draf*/
CREATE TABLE reviewer(
    id_reviewer integer,
    name_reviewer varchar(30) NOT NULL,
    primary KEY(id_reviewer)
);
create table movies (
    id_movie integer , 
    title_movie varchar(30), 
    year_movie date, 
    director_movie varchar(30), 
    primary key (id_movie)
); 
/* end draf */
/*  ################################*/
 /* TP Implémentation de contraintes
 */

/*
1) Traduisez ce schéma en relationnel ; en ne tenant pas compte pour l'instant des contraintes XT et I

    . Créez les relations obtenues, ainsi que les clés et clés étrangères qui en découlent.

    indication 1 : Puisque qu'un cours a exactement un responsable, cette association se traduira par une clé étrangère dans la relation "Cours", ne pouvant prendre la valeur NULL.
    indication 2 : Les spécialisations et entités faibles induisent une contrainte d'existence ; par exemple, supprimer un professeur de la base induit de le supprimer également en tant que salarié ou vacataire. De même supprimer un vacataire, induit de supprimer les contrats qui s'y rapportent. Faites en sorte que toutes ces suppressions en cascade soient automatiques (option : ON DELETE CASCADE des clés étrangères).

*/
CREATE TABLE Cours(
    code INTEGER,
    num INTEGER,
    intitule VARCHAR(30),
    niveau INTEGER,
    FOREIGN key (num) REFERENCE Professeur,
    PRIMARY Key (code)
);
CREATE TABLE Intervient(
    code INTEGER,
    num INTEGER;
    PRIMARY Key (code) References cours,
    PRIMARY KEY (num) REFERENCEs Professeur
);
CREATE TABLE Professeur(
    num INTEGER,
    nom VARCHAR(30),
    prenom VARCHAR (30),
    telephone INTEGER(30),
    PRIMARY Key (num)
);
CREATE TABLE Vacataire(
    num INTEGER,
    statut VARCHAR(30),
    PRIMARY key (num) REFERENCE Professeur
);
CREATE TABLE Salarie(
    num INTEGER,
    date_embauche DATE,
    echelon INTEGER,
    salaire_mensuel INTEGER,
    PRIMARY key (num) REFERENCE Professeur
);
CREATE TABLE Contrat(
    num INTEGER,
    date_contrat date,
    status VARCHAR(30),
    PRIMARY key (num) REFERENCE Vacataire,
    primary key(num,date_contrat)
);

/* other question */
ALTER TABLE Cours
ADD CONSTRAINT FK_ResponsableIntervient
FOREIGN KEY (num_responsable, code)
REFERENCES Intervient(num_professeur, code_cours)
ON DELETE CASCADE;

-- Insérer le professeur Jean Wiejacka
INSERT INTO Professeur (num, nom, prenom, telephone)
VALUES (1, 'Wiejacka', 'Jean', '0123456789');

-- Insérer le cours de salsa débutant avec Jean Wiejacka comme responsable
INSERT INTO Cours (code, num_responsable, intitule, niveau)
VALUES (101, 1, 'Salsa Débutant', 'Débutant');

-- Insérer le professeur Jean Wiejacka
INSERT INTO Professeur (num, nom, prenom, telephone)
VALUES (1, 'Wiejacka', 'Jean', '0123456789');

-- Insérer le cours de salsa débutant avec Jean Wiejacka comme responsable
INSERT INTO Cours (code, num_responsable, intitule, niveau)
VALUES (101, 1, 'Salsa Débutant', 'Débutant');

BEGIN;

-- Insérer le professeur Jean Wiejacka
INSERT INTO Professeur (num, nom, prenom, telephone)
VALUES (1, 'Wiejacka', 'Jean', '0123456789');

-- Insérer le cours de salsa débutant avec Jean Wiejacka comme responsable
INSERT INTO Cours (code, num_responsable, intitule, niveau)
VALUES (101, 1, 'Salsa Débutant', 'Débutant');

-- Insérer l'intervention de Jean Wiejacka dans le cours de salsa
INSERT INTO Intervient (code_cours, num_professeur)
VALUES (101, 1);

COMMIT;

/*###########################*/
CREATE OR REPLACE FUNCTION est_professeur(un_num_prof integer) RETURNS boolean
AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM Professeur WHERE num = un_num_prof);
END;
$$ LANGUAGE plpgsql;

-- Ajouter la contrainte CHECK dans la déclaration des relations "salaries" et "vacataires"
ALTER TABLE Salarie
ADD CONSTRAINT chk_est_vacataire
CHECK (NOT est_vacataire(num));

ALTER TABLE Vacataire
ADD CONSTRAINT chk_est_vacataire
CHECK (est_vacataire(num));

BEGIN;

-- 1. Insertion d'un nouveau professeur
INSERT INTO Professeur (num, nom, prenom, telephone)
VALUES (2, 'Nouveau', 'Professeur', '9876543210');

-- 2. Insertion d'un nouveau vacataire
INSERT INTO Vacataire (num, statut)
VALUES (2, 'Vacataire');

COMMIT;


CREATE OR REPLACE FUNCTION est_professeur(un_num_prof integer) RETURNS boolean
AS $$
BEGIN
    RETURN EXISTS (SELECT 1 FROM Professeur WHERE num = un_num_prof);
END;
$$ LANGUAGE plpgsql;

-- Trigger sur "salaries"
DROP TRIGGER IF EXISTS prevent_delete_salaries ON Salaries;
CREATE CONSTRAINT TRIGGER prevent_delete_salaries
AFTER DELETE OR UPDATE ON Salaries
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION check_prof_vacataire();

-- Trigger sur "vacataires"
DROP TRIGGER IF EXISTS prevent_delete_vacataires ON Vacataires;
CREATE CONSTRAINT TRIGGER prevent_delete_vacataires
AFTER DELETE OR UPDATE ON Vacataires
DEFERRABLE INITIALLY DEFERRED
FOR EACH ROW
EXECUTE FUNCTION check_prof_vacataire();

-- Supprimer un professeur
DELETE FROM Professeur WHERE num = 1;

-- Passer un professeur de salarié à vacataire en utilisant une transaction à deux étapes
BEGIN;

-- Étape 1 : Mettre à jour la table "Salaries" (changer le statut à "Vacataire")
UPDATE Salaries SET statut = 'Vacataire' WHERE num_salarie = 2;

-- Étape 2 : Supprimer la ligne correspondante dans "Vacataires"
DELETE FROM Vacataires WHERE num = 2;

COMMIT;


/**/