-- Bibliothèque · données
-- Modélisation de Données · HEIG-VD / COMEM+
--
-- À exécuter après bibliotheque.sql, dans la même base :
--   sqlite3 bibliotheque.db
--   sqlite> .read bibliotheque.sql
--   sqlite> .read bibliotheque-donnees.sql
--
-- Les lecteur·rice·s et les emprunts sont fictifs.

PRAGMA foreign_keys = ON;

INSERT INTO auteurs (id, nom, date_naissance, date_deces) VALUES
  (1, 'Victor Hugo', '1802-02-26', '1885-05-22'),
  (2, 'George Sand', '1804-07-01', '1876-06-08'),
  (3, 'Gustave Flaubert', '1821-12-12', '1880-05-08'),
  (4, 'Jules Verne', '1828-02-08', '1905-03-24'),
  (5, 'Émile Zola', '1840-04-02', '1902-09-29'),
  (6, 'Charles Ferdinand Ramuz', '1878-09-24', '1947-05-23'),
  (7, 'Marguerite Yourcenar', '1903-06-08', '1987-12-17'),
  (8, 'Albert Camus', '1913-11-07', '1960-01-04'),
  (9, 'Agota Kristof', '1935-10-30', '2011-07-27'),
  (10, 'Annie Ernaux', '1940-09-01', NULL),
  (11, 'Nicolas Bouvier', '1929-03-06', '1998-02-17');

INSERT INTO rayons (id, no_rayon, no_etagere) VALUES
  (1, 1, 1),
  (2, 1, 2),
  (3, 2, 1),
  (4, 2, 2),
  (5, 3, 1),
  (6, 4, 1);

INSERT INTO genres (id, nom) VALUES
  (1, 'roman'),
  (2, 'poésie'),
  (3, 'aventure'),
  (4, 'science-fiction'),
  (5, 'historique'),
  (6, 'autobiographie'),
  (7, 'récit de voyage');

INSERT INTO livres (id, titre, annee, nb_pages, auteur_id, rayon_id) VALUES
  (1, 'Notre-Dame de Paris', 1831, 640, 1, 1),
  (2, 'Les Misérables', 1862, 1900, 1, 1),
  (3, 'Les Contemplations', 1856, 480, 1, 5),
  (4, 'Indiana', 1832, 380, 2, 1),
  (5, 'La Mare au diable', 1846, 160, 2, 2),
  (6, 'Madame Bovary', 1857, 470, 3, 2),
  (7, 'Salammbô', 1862, 420, 3, 4),
  (8, 'De la Terre à la Lune', 1865, 250, 4, 3),
  (9, 'Vingt mille lieues sous les mers', 1870, 600, 4, 3),
  (10, 'Le Tour du monde en quatre-vingts jours', 1872, 320, 4, 3),
  (11, 'L''Assommoir', 1877, 570, 5, 2),
  (12, 'Au Bonheur des Dames', 1883, 520, 5, 2),
  (13, 'Germinal', 1885, 600, 5, NULL),
  (14, 'La Grande Peur dans la montagne', 1926, 210, 6, 1),
  (15, 'Derborence', 1934, 190, 6, 1),
  (16, 'Mémoires d''Hadrien', 1951, 360, 7, 4),
  (17, 'L''Œuvre au noir', 1968, 500, 7, 4),
  (18, 'L''Étranger', 1942, 190, 8, 2),
  (19, 'La Peste', 1947, 340, 8, NULL),
  (20, 'Le Grand Cahier', 1986, 170, 9, 2),
  (21, 'La Place', 1983, 110, 10, 5),
  (22, 'Les Années', 2008, NULL, 10, NULL);

INSERT INTO livres_genres (livre_id, genre_id) VALUES
  (1, 1), (1, 5),
  (2, 1), (2, 5),
  (3, 2),
  (4, 1),
  (5, 1),
  (6, 1),
  (7, 1), (7, 5),
  (8, 3), (8, 4),
  (9, 3), (9, 4),
  (10, 3),
  (11, 1),
  (12, 1),
  (13, 1),
  (14, 1),
  (15, 1),
  (16, 1), (16, 5),
  (17, 1), (17, 5),
  (18, 1),
  (19, 1),
  (20, 1),
  (21, 6),
  (22, 6);

INSERT INTO lecteurs (id, nom, prenom, email, telephone) VALUES
  (1, 'Bovet', 'Léa', 'lea.bovet@exemple.ch', '079 111 22 33'),
  (2, 'Rochat', 'Samuel', 'samuel.rochat@exemple.ch', NULL),
  (3, 'Favre', 'Inès', 'ines.favre@exemple.ch', '078 222 33 44'),
  (4, 'Morand', 'Noah', 'noah.morand@exemple.ch', '076 333 44 55'),
  (5, 'Perret', 'Camille', 'camille.perret@exemple.ch', NULL),
  (6, 'Jaquier', 'Yanis', 'yanis.jaquier@exemple.ch', '079 444 55 66'),
  (7, 'Chappuis', 'Zoé', 'zoe.chappuis@exemple.ch', '078 555 66 77'),
  (8, 'Monnier', 'Elias', 'elias.monnier@exemple.ch', NULL),
  (9, 'Rey', 'Alix', 'alix.rey@exemple.ch', '076 666 77 88'),
  (10, 'Golay', 'Maé', 'mae.golay@exemple.ch', NULL);

INSERT INTO emprunts (livre_id, lecteur_id, date_emprunt, rendu) VALUES
  (1, 1, '2026-09-02', 1),
  (6, 1, '2026-09-20', 1),
  (18, 1, '2026-10-01', 0),
  (9, 2, '2026-09-05', 1),
  (10, 2, '2026-09-19', 1),
  (8, 2, '2026-10-03', 0),
  (15, 3, '2026-09-08', 1),
  (14, 3, '2026-09-22', 0),
  (2, 4, '2026-09-10', 0),
  (18, 4, '2026-09-11', 1),
  (20, 5, '2026-09-12', 1),
  (21, 5, '2026-09-26', 1),
  (16, 5, '2026-10-02', 0),
  (11, 6, '2026-09-15', 1),
  (12, 6, '2026-09-29', 0),
  (9, 7, '2026-09-16', 1),
  (5, 7, '2026-09-24', 1),
  (19, 7, '2026-10-05', 0),
  (6, 8, '2026-09-18', 0),
  (1, 9, '2026-09-21', 1),
  (13, 9, '2026-09-30', 1),
  (20, 9, '2026-10-06', 0);
