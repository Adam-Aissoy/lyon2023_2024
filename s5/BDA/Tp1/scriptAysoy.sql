/* BDA 
 TP1
 Exercie 1  
*/ 
/* Q1  */
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

/*
mise a jour year_movie date en year_movie int 
*/

-- Étape 1 : Ajouter une nouvelle colonne year_movie_int
ALTER TABLE movies ADD COLUMN year_movie_int int;

-- Étape 2 : Mettre à jour la nouvelle colonne year_movie_int avec les années
UPDATE movies SET year_movie_int = EXTRACT(YEAR FROM year_movie);

-- Étape 3 : Supprimer l'ancienne colonne year_movie (si nécessaire)
-- ALTER TABLE movies DROP COLUMN year_movie;

/*
comment renommer le nom de la  colunne stars_ratings en stars_rating dans la table rating
*/

ALTER TABLE rating RENAME COLUMN stars_ratings TO stars_rating;
/* comment afficher les numeros des lignes sur DBeaver Postgres  */

-- Remplacez 123 par la valeur entière que vous souhaitez insérer.

/*

-- test Aysoy 
/* drop table movies; */ 
create table ratings (
    id_movie integer,
    id_reviewer integer,
    date_rating integer , 
    Foreign Key (id_reviewer) References reviewer(id_reviewer) , 
    Foreign key ( id_movie) References movies(id_movie), 
    stars_ratings varchar(30), 
    primary key (id_movie,id_reviewer,date_rating)
); 
/* je veux modifier la colonne date_rating int en date_rating varchar de la table ratings*/

ALTER TABLE ratings ALTER COLUMN date_rating TYPE varchar(30);

/* Q2  */

/*
Adam Aysoy  Home 
*/
-- 1.Création des tables :
CREATE TABLE movies (
    id_movie INT PRIMARY KEY,
    title_movie TEXT NOT NULL,
    year_movie INT,
    director_movie TEXT
);

CREATE TABLE reviewers (
    id_reviewer INT PRIMARY KEY,
    name_reviewer TEXT NOT NULL
);

CREATE TABLE ratings (
    id_reviewer INT,
    id_movie INT,
    date_rating DATE,
    stars_rating INT NOT NULL,
    PRIMARY KEY (id_reviewer, id_movie),
    FOREIGN KEY (id_reviewer) REFERENCES reviewers (id_reviewer),
    FOREIGN KEY (id_movie) REFERENCES movies (id_movie)
);

/*
Exercice 2 
*/
-- 1 Contrainte pour éviter les doublons de titre et d'année :
ALTER TABLE movies
ADD CONSTRAINT unique_movie_title_year UNIQUE (title_movie, year_movie);
-- 2.1 
SELECT name_reviewer
FROM reviewers
WHERE id_reviewer = 205;

SELECT title_movie
FROM movies;


SELECT title_movie
FROM movies
ORDER BY title_movie;

SELECT title_movie
FROM movies
WHERE director_movie = 'Steven Spielberg';


SELECT title_movie
FROM movies
WHERE director_movie IS NULL;


CREATE VIEW v_detail_evaluations AS
SELECT r.name_reviewer, m.title_movie, ra.stars_rating
FROM reviewers r
JOIN ratings ra ON r.id_reviewer = ra.id_reviewer
JOIN movies m ON ra.id_movie = m.id_movie;


SELECT DISTINCT m.year_movie
FROM movies m
JOIN ratings ra ON m.id_movie = ra.id_movie
WHERE ra.stars_rating IN (4, 5)
ORDER BY m.year_movie;
