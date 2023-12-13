TABLE elections_brut (
    id_election integer,
    id_circonscription integer,
    id_candidat integer,
    voix integer
);

/* exemple une ligne donnees elecy=tions  */
/*
Code du département;Libellé du département;Code de la circonscription;Libellé de la circonscription;Code de la commune;Libellé de la Commune;Code du b.vote;Inscrits;Abstentions;% Abs/Ins;Votants;% Vot/Ins;Blancs;% Blancs/Ins;% Blancs/Vot;Nuls;% Nuls/Ins;% Nuls/Vot;Exprimés;% Exp/Ins;% Exp/Vot;N°Panneau;Sexe;Nom;Prénom;Voix;% Voix/Ins;% Voix/Exp;Code Officiel EPCI;Nom Officiel EPCI;Code Officiel Région;Nom Officiel Région;scrutin_code;location;lib_du_b_vote
01;Ain;04;4ème circonscription;01001;L'Abergement-Clémenciat;1;645;108;16.74;537;83.26;16;2.48;2.98;1;0.16;0.19;520;80.62;96.83;1;F;ARTHAUD;Nathalie;3;0.47;0,58;200069193;CC de la Dombes;84;Auvergne-Rhône-Alpes;PR2022;46.14943, 4.924647;BUREAU 1
*/
COPY elections_brut FROM '/chemin/vers/votre/fichier.csv' DELIMITER ';' CSV HEADER;
C:\Users\etulyon1\Documents\lyon2023_2024\BDA\elections_2022_clean.csv
COPY elections_brut FROM 'C:\Users\etulyon1\Documents\lyon2023_2024\BDA\elections_2022_clean.csv' DELIMITER ';' CSV HEADER;
```
