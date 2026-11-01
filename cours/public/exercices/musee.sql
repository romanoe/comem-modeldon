-- Musée · structure · corrigé du TP de la semaine 4
-- Modélisation de Données · HEIG-VD / COMEM+
--
-- Exécution, depuis le terminal :
--   sqlite3 musee.db
--   sqlite> .read musee.sql
--
-- Le script se relance autant de fois que nécessaire :
-- il supprime les tables avant de les recréer.

PRAGMA foreign_keys = ON;

-- Suppression, dans l'ordre inverse de la création

DROP TABLE IF EXISTS expositions_oeuvres;
DROP TABLE IF EXISTS expositions_salles;
DROP TABLE IF EXISTS financement;
DROP TABLE IF EXISTS billets;
DROP TABLE IF EXISTS conservations;
DROP TABLE IF EXISTS oeuvres;
DROP TABLE IF EXISTS type_tarif;
DROP TABLE IF EXISTS techniques;
DROP TABLE IF EXISTS courants;
DROP TABLE IF EXISTS partenaires;
DROP TABLE IF EXISTS salles;
DROP TABLE IF EXISTS expositions;
DROP TABLE IF EXISTS artistes;

-- Tables sans clé étrangère

CREATE TABLE artistes (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  prenom TEXT,
  date_naissance TEXT,
  date_deces TEXT
);

CREATE TABLE expositions (
  id INTEGER PRIMARY KEY,
  titre TEXT NOT NULL,
  date_debut TEXT NOT NULL,
  date_fin TEXT,
  CHECK (date_fin IS NULL OR date_fin >= date_debut)
);

CREATE TABLE salles (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE,
  niveau INTEGER
);

CREATE TABLE partenaires (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  contact TEXT
);

CREATE TABLE courants (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE
);

CREATE TABLE techniques (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE
);

CREATE TABLE type_tarif (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE,
  prix REAL NOT NULL CHECK (prix >= 0)
);

-- Tables qui les référencent

CREATE TABLE oeuvres (
  id INTEGER PRIMARY KEY,
  titre TEXT NOT NULL,
  annee INTEGER,
  dimensions TEXT,
  statut TEXT,
  technique_id INTEGER
    REFERENCES techniques(id)
    ON DELETE SET NULL,
  courant_id INTEGER
    REFERENCES courants(id)
    ON DELETE SET NULL,
  artiste_id INTEGER NOT NULL
    REFERENCES artistes(id)
    ON DELETE RESTRICT
);

CREATE TABLE conservations (
  id INTEGER PRIMARY KEY,
  date_intervention TEXT NOT NULL,
  commentaire TEXT,
  oeuvre_id INTEGER NOT NULL
    REFERENCES oeuvres(id)
    ON DELETE CASCADE
);

CREATE TABLE billets (
  id INTEGER PRIMARY KEY,
  date_visite TEXT NOT NULL,
  type_tarif_id INTEGER
    REFERENCES type_tarif(id)
    ON DELETE SET NULL,
  exposition_id INTEGER NOT NULL
    REFERENCES expositions(id)
    ON DELETE RESTRICT
);

-- Tables de liaison

CREATE TABLE financement (
  partenaire_id INTEGER NOT NULL
    REFERENCES partenaires(id)
    ON DELETE CASCADE,
  exposition_id INTEGER NOT NULL
    REFERENCES expositions(id)
    ON DELETE CASCADE,
  montant REAL CHECK (montant > 0),
  paye INTEGER NOT NULL DEFAULT 0
    CHECK (paye IN (0, 1)),
  PRIMARY KEY (partenaire_id, exposition_id)
);

CREATE TABLE expositions_salles (
  salle_id INTEGER NOT NULL
    REFERENCES salles(id)
    ON DELETE CASCADE,
  exposition_id INTEGER NOT NULL
    REFERENCES expositions(id)
    ON DELETE CASCADE,
  PRIMARY KEY (salle_id, exposition_id)
);

CREATE TABLE expositions_oeuvres (
  oeuvre_id INTEGER NOT NULL
    REFERENCES oeuvres(id)
    ON DELETE CASCADE,
  exposition_id INTEGER NOT NULL
    REFERENCES expositions(id)
    ON DELETE CASCADE,
  PRIMARY KEY (oeuvre_id, exposition_id)
);
