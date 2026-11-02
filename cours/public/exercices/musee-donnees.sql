-- Musée · données
-- Modélisation de Données · HEIG-VD / COMEM+
--
-- À exécuter après musee.sql, dans la même base :
--   sqlite3 musee.db
--   sqlite> .read musee.sql
--   sqlite> .read musee-donnees.sql
--
-- Les artistes et leurs œuvres existent, les dimensions sont arrondies.
-- Le musée, ses salles, ses expositions, ses billets et ses partenaires sont fictifs.

PRAGMA foreign_keys = ON;

INSERT INTO artistes (id, nom, prenom, date_naissance, date_deces) VALUES
  (1, 'Monet', 'Claude', '1840-11-14', '1926-12-05'),
  (2, 'Morisot', 'Berthe', '1841-01-14', '1895-03-02'),
  (3, 'van Gogh', 'Vincent', '1853-03-30', '1890-07-29'),
  (4, 'Claudel', 'Camille', '1864-12-08', '1943-10-19'),
  (5, 'Vallotton', 'Félix', '1865-12-28', '1925-12-29'),
  (6, 'Klee', 'Paul', '1879-12-18', '1940-06-29'),
  (7, 'Taeuber-Arp', 'Sophie', '1889-01-19', '1943-01-13'),
  (8, 'Giacometti', 'Alberto', '1901-10-10', '1966-01-11'),
  (9, 'Kahlo', 'Frida', '1907-07-06', '1954-07-13'),
  (10, 'Rist', 'Pipilotti', '1962-06-21', NULL),
  (11, 'Banksy', NULL, NULL, NULL);

INSERT INTO techniques (id, nom) VALUES
  (1, 'huile sur toile'),
  (2, 'huile sur bois'),
  (3, 'bronze'),
  (4, 'bois peint'),
  (5, 'vidéo'),
  (6, 'pochoir');

INSERT INTO courants (id, nom) VALUES
  (1, 'impressionnisme'),
  (2, 'postimpressionnisme'),
  (3, 'nabis'),
  (4, 'dadaïsme'),
  (5, 'art contemporain'),
  (6, 'art urbain');

INSERT INTO oeuvres (id, titre, annee, dimensions, statut, technique_id, courant_id, artiste_id) VALUES
  (1, 'Impression, soleil levant', 1872, '48 x 63 cm', 'en réserve', 1, 1, 1),
  (2, 'La Gare Saint-Lazare', 1877, '75 x 104 cm', 'en réserve', 1, 1, 1),
  (3, 'Le Bassin aux nymphéas', 1899, '88 x 93 cm', 'en réserve', 1, 1, 1),
  (4, 'Le Berceau', 1872, '56 x 46 cm', 'exposée', 1, 1, 2),
  (5, 'Les Tournesols', 1888, '92 x 73 cm', 'en prêt', 1, 2, 3),
  (6, 'La Nuit étoilée', 1889, '74 x 92 cm', 'exposée', 1, 2, 3),
  (7, 'La Valse', 1893, NULL, 'exposée', 3, NULL, 4),
  (8, 'L''Âge mûr', 1899, NULL, 'en restauration', 3, NULL, 4),
  (9, 'Le Ballon', 1899, '48 x 61 cm', 'exposée', 2, 3, 5),
  (10, 'La Blanche et la Noire', 1913, '114 x 147 cm', 'en réserve', 1, NULL, 5),
  (11, 'Senecio', 1922, '41 x 38 cm', 'en réserve', NULL, NULL, 6),
  (12, 'Ad Parnassum', 1932, '100 x 126 cm', 'en réserve', NULL, NULL, 6),
  (13, 'Tête Dada', 1920, NULL, 'exposée', 4, 4, 7),
  (14, 'L''Homme qui marche I', 1960, '183 x 26 x 95 cm', 'exposée', 3, NULL, 8),
  (15, 'Les Deux Frida', 1939, '173 x 173 cm', 'exposée', 1, NULL, 9),
  (16, 'Autoportrait au collier d''épines', 1940, '62 x 48 cm', 'exposée', 1, NULL, 9),
  (17, 'Ever Is Over All', 1997, NULL, 'en réserve', 5, 5, 10),
  (18, 'Girl with Balloon', 2002, NULL, 'en réserve', 6, 6, 11);

INSERT INTO conservations (id, date_intervention, commentaire, oeuvre_id) VALUES
  (1, '2024-05-13', 'Nettoyage du vernis', 1),
  (2, '2025-02-04', 'Contrôle de la toile', 6),
  (3, '2025-11-20', 'Reprise de la patine', 8),
  (4, '2026-06-09', NULL, 8),
  (5, '2026-09-15', 'Contrôle du cadre', 9);

INSERT INTO expositions (id, titre, date_debut, date_fin) VALUES
  (1, 'Collection permanente', '2020-01-15', NULL),
  (2, 'Lumières impressionnistes', '2026-03-14', '2026-08-30'),
  (3, 'Femmes artistes', '2026-10-03', '2027-01-31'),
  (4, 'Regards suisses', '2027-02-20', '2027-06-13'),
  (5, 'L''art dans la rue', '2027-09-04', '2028-01-16');

INSERT INTO salles (id, nom, niveau) VALUES
  (1, 'Salle des Lumières', 0),
  (2, 'Salle du Lac', 0),
  (3, 'Galerie Nord', 1),
  (4, 'Galerie Sud', 1),
  (5, 'Atelier', NULL);

INSERT INTO partenaires (id, nom, contact) VALUES
  (1, 'Fondation des Arts du Léman', 'contact@arts-leman.example'),
  (2, 'Caisse d''Épargne du Lac', 'mecenat@epargne-lac.example'),
  (3, 'Association des Ami·e·s du Musée', NULL),
  (4, 'Imprimerie du Vallon', 'info@imprimerie-vallon.example');

INSERT INTO type_tarif (id, nom, prix) VALUES
  (1, 'plein', 18.0),
  (2, 'groupe', 14.0),
  (3, 'réduit', 12.0),
  (4, 'étudiant·e', 10.0),
  (5, 'enfant', 6.0),
  (6, 'membre', 0.0);

INSERT INTO billets (id, date_visite, type_tarif_id, exposition_id) VALUES
  (1, '2026-03-14', 1, 2),
  (2, '2026-03-14', 3, 2),
  (3, '2026-04-02', 4, 2),
  (4, '2026-05-17', 1, 2),
  (5, '2026-05-17', 5, 2),
  (6, '2026-07-05', 2, 2),
  (7, '2026-08-30', NULL, 2),
  (8, '2026-09-12', 1, 1),
  (9, '2026-09-12', 6, 1),
  (10, '2026-09-20', 4, 1),
  (11, '2026-10-03', 1, 3),
  (12, '2026-10-03', 3, 3),
  (13, '2026-10-11', 4, 3),
  (14, '2026-10-18', 1, 3),
  (15, '2026-10-18', 5, 3),
  (16, '2026-10-25', 6, 3),
  (17, '2026-10-25', 2, 1),
  (18, '2027-02-20', 1, 4);

INSERT INTO financement (partenaire_id, exposition_id, montant, paye) VALUES
  (1, 2, 20000.0, 1),
  (2, 2, 15000.0, 1),
  (1, 3, 12000.0, 1),
  (3, 3, 2500.0, 0),
  (2, 4, 18000.0, 0),
  (4, 4, NULL, 0),
  (1, 5, 10000.0, 0);

INSERT INTO expositions_salles (salle_id, exposition_id) VALUES
  (1, 1),
  (2, 2),
  (3, 2),
  (2, 3),
  (4, 3),
  (3, 4),
  (5, 5);

INSERT INTO expositions_oeuvres (oeuvre_id, exposition_id) VALUES
  (6, 1), (9, 1), (14, 1), (16, 1),
  (1, 2), (2, 2), (3, 2), (4, 2),
  (4, 3), (7, 3), (13, 3), (15, 3), (16, 3),
  (9, 4), (10, 4), (11, 4), (13, 4), (14, 4), (17, 4),
  (17, 5), (18, 5);
