PRAGMA foreign_keys = ON;

CREATE TABLE Mitglieder (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname TEXT NOT NULL,
    nachname TEXT NOT NULL,
    geburtsdatum DATE NOT NULL,
    geschlecht TEXT NOT NULL CHECK (geschlecht IN ('m', 'w')),
    beitrittsdatum DATE NOT NULL CHECK (beitrittsdatum > geburtsdatum) 
);

INSERT INTO Mitglieder(id, vorname, nachname, geburtsdatum, geschlecht, beitrittsdatum)
VALUES (1, 'Anna', 'Muster', '1990-05-10', 'w', '2022-01-15'),
       (2, 'Benjamin', 'Sorger', '1985-07-23', 'm', '2021-09-10'),
       (3, 'Julia', 'Jelinek', '1992-02-18', 'w', '2023-03-05');

CREATE TABLE Qualifikationen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL
);

INSERT INTO Qualifikationen(id, name)
VALUES (1, 'Fitness-Trainer'),
       (2, 'Yoga-Instructor'),
       (3, 'Personal Trainer'),
       (4, 'Ernährungsberater');
      
CREATE TABLE Trainer (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    vorname TEXT NOT NULL,
    nachname TEXT NOT NULL
);

INSERT INTO Trainer(id, vorname, nachname)
VALUES (1, 'Johannes', 'Hausner'),
       (2, 'Maria', 'Schmidt'),
       (3, 'Peter', 'Müller');
       
CREATE TABLE Trainer_Qualifikationen (
    trainer_id INTEGER NOT NULL,
    qualifikation_id INTEGER NOT NULL,
    PRIMARY KEY (trainer_id, qualifikation_id),
    FOREIGN KEY (trainer_id) REFERENCES Trainer(id),
    FOREIGN KEY (qualifikation_id) REFERENCES Qualifikationen(id)
);

INSERT INTO Trainer_Qualifikationen(trainer_id, qualifikation_id)
VALUES (1, 1),  -- Johannes Hausner ist Fitness-Trainer
       (1, 3),  -- Johannes Hausner ist auch Personal Trainer
       (2, 2),  -- Maria Schmidt ist Yoga-Instructor
       (3, 3),  -- Peter Müller ist Personal Trainer
       (3, 4);  -- Peter Müller ist auch Ernährungsberater
       
CREATE TABLE Kurse (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    trainer_id INTEGER NOT NULL,
    zeit TIME NOT NULL,
    FOREIGN KEY (trainer_id) REFERENCES Trainer(id)
);

INSERT INTO Kurse(id, name, trainer_id, zeit)
VALUES (1, 'Seniorenyoga', 2, '10:00'),
       (2, 'Babyyoga', 2, '08:00'),
       (3, 'Krafttraining', 1, '14:00'),
       (4, 'HIIT', 3, '18:00');
      
CREATE TABLE Teilnahmen (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    mitglied_id INTEGER NOT NULL,
    kurs_id INTEGER NOT NULL,
    datum DATE NOT NULL,
    FOREIGN KEY (mitglied_id) REFERENCES Mitglieder(id),
    FOREIGN KEY (kurs_id) REFERENCES Kurse(id)
);

INSERT INTO Teilnahmen(mitglied_id, kurs_id, datum)
VALUES (1, 1, '2024-09-12'),
       (2, 2, '2024-09-13'),
       (3, 3, '2024-09-14'),
       (1, 3, '2024-09-15');