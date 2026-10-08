-- Bibliothèque · structure
-- Modélisation de Données · HEIG-VD / COMEM+
--
-- Exécution, depuis le terminal :
--   sqlite3 bibliotheque.db
--   sqlite> .read bibliotheque.sql
--
-- Le script se relance autant de fois que nécessaire :
-- il supprime les tables avant de les recréer.

PRAGMA foreign_keys = ON;

-- Suppression, dans l'ordre inverse de la création

DROP TABLE IF EXISTS livres_genres;
DROP TABLE IF EXISTS emprunts;
DROP TABLE IF EXISTS livres;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS lecteurs;
DROP TABLE IF EXISTS rayons;
DROP TABLE IF EXISTS auteurs;

-- Tables sans clé étrangère

CREATE TABLE auteurs (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  date_naissance TEXT,
  date_deces TEXT
);

CREATE TABLE rayons (
  id INTEGER PRIMARY KEY,
  no_rayon INTEGER NOT NULL,
  no_etagere INTEGER NOT NULL,
  UNIQUE (no_rayon, no_etagere)
);

CREATE TABLE lecteurs (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  prenom TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  telephone TEXT
);

CREATE TABLE genres (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL UNIQUE
);

-- Tables qui les référencent

CREATE TABLE livres (
  id INTEGER PRIMARY KEY,
  titre TEXT NOT NULL,
  annee INTEGER,
  nb_pages INTEGER CHECK (nb_pages > 0),
  auteur_id INTEGER NOT NULL
    REFERENCES auteurs(id)
    ON DELETE RESTRICT,
  rayon_id INTEGER
    REFERENCES rayons(id)
    ON DELETE SET NULL
);

-- Tables de liaison

CREATE TABLE emprunts (
  livre_id INTEGER NOT NULL
    REFERENCES livres(id),
  lecteur_id INTEGER NOT NULL
    REFERENCES lecteurs(id)
    ON DELETE CASCADE,
  date_emprunt TEXT NOT NULL,
  rendu INTEGER NOT NULL DEFAULT 0
    CHECK (rendu IN (0, 1)),
  PRIMARY KEY (livre_id, lecteur_id)
);

CREATE TABLE livres_genres (
  livre_id INTEGER NOT NULL
    REFERENCES livres(id)
    ON DELETE CASCADE,
  genre_id INTEGER NOT NULL
    REFERENCES genres(id)
    ON DELETE CASCADE,
  PRIMARY KEY (livre_id, genre_id)
);
