-- Gestion des forêts · corrigé de l'examen type, partie 3
-- Modélisation de Données · HEIG-VD / COMEM+
--
-- Exécution, depuis le terminal :
--   sqlite3 forets.db
--   sqlite> .read corrige-forets.sql
--
-- L'examen ne demande que forets, interventions et forets_interventions.
-- Les quatre autres tables sont là pour que le script s'exécute en entier.

PRAGMA foreign_keys = ON;

-- Suppression, dans l'ordre inverse de la création

DROP TABLE IF EXISTS forets_interventions;
DROP TABLE IF EXISTS interventions;
DROP TABLE IF EXISTS arbres;
DROP TABLE IF EXISTS forets;
DROP TABLE IF EXISTS agents;
DROP TABLE IF EXISTS essences;
DROP TABLE IF EXISTS zones;

-- Tables sans clé étrangère

CREATE TABLE zones (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  date_classement TEXT
);

CREATE TABLE essences (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE
);

CREATE TABLE agents (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  prenom TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  telephone TEXT
);

-- Tables qui les référencent

CREATE TABLE forets (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE,
  surface REAL NOT NULL CHECK (surface > 0),
  zone_id INTEGER
    REFERENCES zones(id)
    ON DELETE SET NULL
);

CREATE TABLE arbres (
  foret_id INTEGER NOT NULL
    REFERENCES forets(id),
  numero INTEGER NOT NULL,
  hauteur REAL NOT NULL,
  annee_plantation INTEGER,
  essence_id INTEGER NOT NULL
    REFERENCES essences(id),
  PRIMARY KEY (foret_id, numero)
);

CREATE TABLE interventions (
  id INTEGER PRIMARY KEY,
  date_intervention TEXT NOT NULL,
  terminee INTEGER NOT NULL DEFAULT 0
    CHECK (terminee IN (0, 1)),
  agent_id INTEGER NOT NULL
    REFERENCES agents(id)
    ON DELETE RESTRICT
);

-- Table de liaison

CREATE TABLE forets_interventions (
  foret_id INTEGER NOT NULL
    REFERENCES forets(id)
    ON DELETE RESTRICT,
  intervention_id INTEGER NOT NULL
    REFERENCES interventions(id)
    ON DELETE CASCADE,
  heures REAL CHECK (heures > 0),
  PRIMARY KEY (foret_id, intervention_id)
);
