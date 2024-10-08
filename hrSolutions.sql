-- Creation d'une base de donnees pour l'utilisateur "steph"
CREATE DATABASE hrSolutions WITH
OWNER steph;

-- Connexion a la base de donnees hrSolutions
\c hrSolutions;

-- Creation d'un schema de base de donnees pour l'utilisateur "steph"
CREATE SCHEMA IF NOT EXISTS hrSol
AUTHORIZATION steph;

-- Remplacement du schema courant par le schema hrSol
SET search_path TO hrSol;


-- Creation des differentes tables de la base de donnees

CREATE TABLE IF NOT EXISTS Departements(
    id SERIAL,
    nom VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255),
    CONSTRAINT pk_Departements PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS Postes(
    id SERIAL,
    idDepartement INT NOT NULL,
    titre VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    CONSTRAINT pk_Postes PRIMARY KEY(id),
    CONSTRAINT fk_Postes_idDepartement FOREIGN KEY(idDepartement) REFERENCES Departements(id)
);

CREATE TABLE IF NOT EXISTS Employe(
    id SERIAL,
    idPoste INT NOT NULL,
    nom VARCHAR(60) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    sexe CHAR(1) NOT NULL,
    tel VARCHAR(20) NOT NULL,
    email VARCHAR(255) NOT NULL,
    dateNaissance DATE NOT NULL,
    dateEmbauche DATE DEFAULT CURRENT_DATE,
    CONSTRAINT pk_Employe PRIMARY KEY(id),
    CONSTRAINT fk_Employe_idPoste FOREIGN KEY(idPoste) REFERENCES Postes(id),
    CONSTRAINT chk_sexe CHECK(sexe IN('M','F')),
    CONSTRAINT un_email UNIQUE(email)
);

CREATE TABLE IF NOT EXISTS Salaire(
    id SERIAL,
    idEmploye INT NOT NULL,
    montant DECIMAL(10,2),
    dateDebut DATE DEFAULT CURRENT_DATE,
    dateFin DATE NOT NULL,
    CONSTRAINT pk_Salaire PRIMARY KEY(id),
    CONSTRAINT fk_Salaire_idEmploye FOREIGN KEY(idEmploye) REFERENCES Employe(id)
);


-- Insérer des lignes dans les differentes tables

INSERT INTO Departements (nom, description, location) VALUES
('IT', 'Information Technology Department', 'Building A'),
('HR', 'Human Resources Department', 'Building B'),
('Finance', 'Finance Department', 'Building C'),
('Marketing', 'Marketing Department', 'Building D'),
('Sales', 'Sales Department', 'Building E'),
('Logistics', 'Logistics Department', 'Building F'),
('Legal', 'Legal Department', 'Building G'),
('R&D', 'Research and Development Department', 'Building H'),
('Support', 'Customer Support Department', 'Building I'),
('Admin', 'Administration Department', 'Building J');

INSERT INTO Postes (idDepartement, titre, description) VALUES
(1, 'Software Engineer', 'Responsible for developing software solutions'),
(1, 'System Administrator', 'Maintains the IT infrastructure'),
(2, 'HR Manager', 'Oversees HR operations'),
(2, 'Recruiter', 'Manages the recruitment process'),
(3, 'Accountant', 'Handles financial transactions'),
(3, 'Financial Analyst', 'Analyzes financial data'),
(4, 'Marketing Manager', 'Plans and executes marketing strategies'),
(4, 'Content Creator', 'Creates marketing content'),
(5, 'Sales Executive', 'Drives sales efforts'),
(5, 'Sales Manager', 'Manages the sales team');

INSERT INTO Employe (idPoste, nom, prenom, sexe, tel, email, dateNaissance, dateEmbauche) VALUES
(1, 'Smith', 'John', 'M', '4149-4349', 'john.smith@example.com', TO_DATE('1985-01-15', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD')),
(2, 'Doe', 'Jane', 'F', '4149-4350', 'jane.doe@example.com', TO_DATE('1987-02-20', 'YYYY-MM-DD'), TO_DATE('2023-07-01', 'YYYY-MM-DD')),
(3, 'Brown', 'James', 'M', '4149-4351', 'james.brown@example.com', TO_DATE('1990-03-25', 'YYYY-MM-DD'), TO_DATE('2022-03-08', 'YYYY-MM-DD')),
(4, 'Johnson', 'Emily', 'F', '4149-4352', 'emily.johnson@example.com', TO_DATE('1992-04-30', 'YYYY-MM-DD'), TO_DATE('2021-04-23', 'YYYY-MM-DD')),
(5, 'White', 'Michael', 'M', '4149-4353', 'michael.white@example.com', TO_DATE('1988-05-10', 'YYYY-MM-DD'), TO_DATE('2021-03-23', 'YYYY-MM-DD')),
(6, 'Williams', 'Sarah', 'F', '4149-4354', 'sarah.williams@example.com', TO_DATE('1991-06-15', 'YYYY-MM-DD'), TO_DATE('2020-11-12', 'YYYY-MM-DD')),
(7, 'Jones', 'Robert', 'M', '4149-4355', 'robert.jones@example.com', TO_DATE('1989-07-20', 'YYYY-MM-DD'), TO_DATE('2020-10-12', 'YYYY-MM-DD')),
(8, 'Taylor', 'Jessica', 'F', '4149-4356', 'jessica.taylor@example.com', TO_DATE('1993-08-25', 'YYYY-MM-DD'), TO_DATE('2019-05-21', 'YYYY-MM-DD')),
(9, 'Lee', 'Daniel', 'M', '4149-4357', 'daniel.lee@example.com', TO_DATE('1990-09-30', 'YYYY-MM-DD'), TO_DATE('2019-11-12', 'YYYY-MM-DD')),
(10, 'Martin', 'Sophia', 'F', '4149-4358', 'sophia.martin@example.com', TO_DATE('1987-10-15', 'YYYY-MM-DD'), TO_DATE('2018-02-22', 'YYYY-MM-DD'));

INSERT INTO Salaire (idEmploye, montant, dateDebut, dateFin ) VALUES
(1, 60000.00, TO_DATE('2023-02-28', 'YYYY-MM-DD'), TO_DATE('2024-02-28', 'YYYY-MM-DD')),
(2, 55000.00, TO_DATE('2023-08-28', 'YYYY-MM-DD'), TO_DATE('2024-08-28', 'YYYY-MM-DD')),
(3, 50000.00, TO_DATE('2022-04-28', 'YYYY-MM-DD'), TO_DATE('2023-04-28', 'YYYY-MM-DD')),
(4, 65000.00, TO_DATE('2021-05-28', 'YYYY-MM-DD'), TO_DATE('2022-05-28', 'YYYY-MM-DD')),
(5, 70000.00, TO_DATE('2021-04-28', 'YYYY-MM-DD'), TO_DATE('2022-04-28', 'YYYY-MM-DD')),
(6, 72000.00, TO_DATE('2020-12-28', 'YYYY-MM-DD'), TO_DATE('2021-12-28', 'YYYY-MM-DD')),
(7, 68000.00, TO_DATE('2020-11-28', 'YYYY-MM-DD'), TO_DATE('2021-11-28', 'YYYY-MM-DD')),
(8, 62000.00, TO_DATE('2019-06-28', 'YYYY-MM-DD'), TO_DATE('2020-06-28', 'YYYY-MM-DD')),
(9, 64000.00, TO_DATE('2019-12-28', 'YYYY-MM-DD'), TO_DATE('2020-12-28', 'YYYY-MM-DD')),
(10, 66000.00, TO_DATE('2018-03-28', 'YYYY-MM-DD'), TO_DATE('2019-03-28', 'YYYY-MM-DD'));


-- PARTIE 1

-- 1. Comptez le nombre d'employés dans chaque département.
SELECT
    d.id,
    d.nom AS Departement,
    d.description,
    COUNT(e.id) AS "Nombre d'employes"
FROM
    Departements d
JOIN Postes p
    ON p.idDepartement=d.id
JOIN Employe e
    ON e.idPoste=p.id
GROUP BY
    d.id,
    d.nom,
    d.description
ORDER BY
    d.id ASC;

-- 2. Affichez les départements qui ont plus de 5 employés.
SELECT
    d.id,
    d.nom,
    d.description,
    d.location
FROM
    Departements d
JOIN Postes p
    ON p.idDepartement=d.id
JOIN Employe e
    ON e.idPoste=p.id
WHERE e.idPoste = (
    SELECT
        COUNT(idPoste)
    FROM
        Employe
    WHERE idPoste>=5
);

-- 3. Sélectionnez les employés qui ont un salaire supérieur à la moyenne.
SELECT
    e.nom,
    e.prenom,
    s.montant
FROM
    Employe e
JOIN Salaire s
    ON s.idEmploye=e.id
WHERE s.montant > (
    SELECT
        AVG(montant)
    FROM
        Salaire)
GROUP BY
    e.nom,
    e.prenom,
    s.montant
ORDER BY
    s.montant ASC;

-- 4. Créez une vue qui affiche les employés et leurs départements.
CREATE OR REPLACE VIEW Emp_display AS SELECT * FROM Employe;

-- 5. Sélectionnez les noms complets (nom et prénom concaténés) des employés.
SELECT
    prenom || ' ' || nom AS "Nom complet des employes"
FROM Employe;

-- 6. Sélectionnez les employés dont l'anniversaire est ce mois-ci.
SELECT
    id,
    nom,
    prenom,
    dateNaissance
FROM
    Employe
WHERE EXTRACT(MONTH FROM dateNaissance) =
    EXTRACT(MONTH FROM CURRENT_DATE);

-- 7. Sélectionnez les employés avec une colonne supplémentaire indiquant s'ils sont embauchés depuis plus de 5 ans.
SELECT
    id,
    nom,
    prenom,
    dateNaissance,
    dateEmbauche,
    CASE
        WHEN
            EXTRACT(YEAR FROM CURRENT_DATE) -
            EXTRACT(YEAR FROM dateEmbauche) >= 5
        THEN 'Embauchés depuis plus de 5 ans'
        ELSE 'Embauchés depuis moins de 5 ans'
    END AS Anciennete
FROM Employe;

-- 8. Effectuez une transaction qui insère un nouvel employé et son salaire, puis la confirme ou l'annule.
BEGIN TRANSACTION;
    INSERT INTO Employe (idPoste, nom, prenom, sexe, tel, email, dateNaissance, dateEmbauche) VALUES
        (8, 'Derley', 'Juliana', 'F', '4149-4363', 'julianaderley@gmail.com', TO_DATE('1997-01-15', 'YYYY-MM-DD'), TO_DATE('2022-01-01', 'YYYY-MM-DD'));
    
    INSERT INTO Salaire (idEmploye, montant, dateDebut, dateFin ) VALUES
        (14, 60000.00, TO_DATE('2022-02-28', 'YYYY-MM-DD'), TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    ROLLBACK;
END;

-- 9. Ajoutez une contrainte pour que le numéro de téléphone soit unique.
ALTER TABLE Employe
ADD CONSTRAINT un_tel UNIQUE(tel);

-- 10. Créez un index sur la colonne nom de la table Employe pour améliorer les performances des requêtes.
CREATE UNIQUE INDEX IF NOT EXISTS idx_nom
ON Employe(nom);


-- PARTIE 2

/*
    1. Listez tous les employés avec leurs titres de poste et les noms des départements,
    en incluant les employés sans poste et les postes sans employés.
*/
SELECT
    e.id,
    e.nom,
    e.prenom,
    p.titre AS "Poste de l'employe",
    d.nom AS "Nom Departements"
FROM
    Departements d
FULL OUTER JOIN Postes p ON p.idDepartement=d.id
FULL OUTER JOIN Employe e ON e.idPoste=p.id
ORDER BY e.id;

-- 2. Affichez le nom des employés, leurs postes, les départements auxquels ils appartiennent et leurs salaires actuels.
SELECT DISTINCT
    e.id,
    e.nom,
    e.prenom,
    p.titre AS Postes,
    d.nom AS Departement,
    s.montant
FROM
    Departements d
RIGHT OUTER JOIN Postes p ON p.idDepartement=d.id
RIGHT OUTER JOIN Employe e ON e.idPoste=p.id
RIGHT OUTER JOIN Salaire s ON s.idEmploye=e.id
ORDER BY e.id;

-- 3. Trouvez les employés qui ont le salaire le plus élevé dans leur département.
SELECT DISTINCT 
    e.id,
    e.nom,
    e.prenom,
    d.nom AS "Nom de departement",
    s.montant
FROM Departements d
JOIN Postes p ON p.idDepartement = d.id
JOIN Employe e ON e.idPoste = p.id
JOIN Salaire s ON s.idEmploye = e.id
WHERE s.montant = (
    SELECT MAX(s1.montant)
        FROM Salaire s1
        JOIN Employe e1 ON s1.idEmploye = e1.id
        JOIN Postes p1 ON e1.idPoste = p1.id
    WHERE p1.idDepartement = p.idDepartement
);

-- 4. Pour chaque employé, affichez son nom, son poste, et le nombre d'employés dans le même département.
SELECT
    e.nom,
    e.prenom,
    e.idPoste,
    p.titre,
    d.nom, COUNT(d.nom)
    OVER (PARTITION BY d.nom) AS Nbr
FROM Departements d
JOIN Postes p ON p.idDepartement = d.id
JOIN Employe e ON e.idPoste = p.id
JOIN Employe e1 ON e1.idPoste = e.idPoste
GROUP BY
    e.nom,
    e.prenom,
    e.idPoste,
    p.titre,
    d.nom
ORDER BY e.idPoste ASC;

/*
    5. Calculez le salaire moyen par département et affichez les départements dont
    le salaire moyen est supérieur à la moyenne de tous les départements.
*/
-- Calculer le salaire moyen par département
SELECT d.nom AS departement,
       ROUND(AVG(s.montant),2) AS salaire_moyen
FROM Departements d
    JOIN Postes p ON p.idDepartement = d.id
    JOIN Employe e ON e.idPoste = p.id
    JOIN Salaire s ON s.idEmploye = e.id
GROUP BY d.nom
HAVING AVG(s.montant) > (
    -- Calculer la moyenne globale des salaires moyens des départements
    SELECT AVG(salaire_moyen)
    FROM (
        SELECT AVG(s.montant) AS salaire_moyen
        FROM Departements d
            JOIN Postes p ON p.idDepartement = d.id
            JOIN Employe e ON e.idPoste = p.id
            JOIN Salaire s ON s.idEmploye = e.id
        GROUP BY d.nom
    ) AS moyenne_departements
);

/*
    6. Utilisez une CTE pour calculer le nombre total d'employés dans chaque département,
    puis filtrez pour afficher uniquement les départements avec plus de 5 employés.
*/
WITH nEmploye AS (
    SELECT
        COUNT(e.id) AS Nbr,
        d.nom
    FROM
        Employe e
    JOIN Postes p ON p.id = e.idPoste
    JOIN Departements d ON d.id = p.idDepartement
    GROUP BY d.nom
)
SELECT * FROM nEmploye WHERE Nbr > 5;

/*
    Fenêtrage (Window Functions)
    7. Affichez les employés avec leur salaire, le salaire moyen de leur département, et
    la différence entre leur salaire et le salaire moyen du département.
*/
SELECT DISTINCT
    e.id,
    e.nom,
    e.prenom,
    s.montant,
    d.nom AS Departement,
    ROUND(AVG(s.montant) OVER dep, 2) AS salaire_moyen_dept,
    ROUND(ABS(s.montant - AVG(s.montant) OVER dep), 2) AS Difference_salaire
FROM Departements d
    JOIN Postes p ON p.idDepartement = d.id
    JOIN Employe e ON e.idPoste = p.id
    JOIN Salaire s ON s.idEmploye = e.id
WINDOW dep AS (PARTITION BY d.id)
ORDER BY e.id;

-- 8. Trouvez les employés qui ont été embauchés les 5 dernières années et calculez leur ancienneté en années.
SELECT
    id,
    nom,
    prenom,
    dateEmbauche,
    (EXTRACT(YEAR FROM CURRENT_DATE) -
    EXTRACT(YEAR FROM dateEmbauche)) AS Anciennete
FROM Employe
WHERE dateEmbauche BETWEEN TO_DATE('2019-01-01','YYYY-MM-DD') AND CURRENT_DATE;

/*
    9. Écrivez une transaction qui insère un nouveau poste, ajoute un employé à ce poste,
    et met à jour le salaire de l'employé. Si l'une des étapes échoue, annulez toute la transaction.
*/
BEGIN TRANSACTION;
    INSERT INTO Postes (id, idDepartement, titre, description) VALUES
        (11, 5, 'Super Manager', 'Manages the enterprise');

    INSERT INTO Employe (id, idPoste, nom, prenom, sexe, tel, email, dateNaissance, dateEmbauche) VALUES
        (15, 11, 'Decker', 'John', 'M', '4149-4364', 'johndecker@gmail.com', TO_DATE('1999-02-20', 'YYYY-MM-DD'), TO_DATE('2023-04-06', 'YYYY-MM-DD'));
    
    INSERT INTO Salaire (id, idEmploye, montant, dateDebut, dateFin) VALUES
        (21, 15, 55000.00, TO_DATE('2022-02-28', 'YYYY-MM-DD'), TO_DATE('2024-05-28', 'YYYY-MM-DD'));

    UPDATE Salaire
        SET montant = 58000.00
    WHERE idEmploye = 15;
    COMMIT;
END;

/*
    10. Créez un index sur les colonnes "nom" et "prenom" de la table "Employe" puis mesurez
    l'amélioration des performances pour une recherche par nom et prénom.
*/
CREATE INDEX IF NOT EXISTS idx_fullName
ON Employe (nom, prenom);
