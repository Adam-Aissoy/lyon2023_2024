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
