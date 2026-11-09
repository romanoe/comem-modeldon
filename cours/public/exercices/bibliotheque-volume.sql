-- Bibliothèque · un million de livres
-- Modélisation de Données · HEIG-VD / COMEM+
--
-- À exécuter après bibliotheque.sql et bibliotheque-donnees.sql,
-- dans une base à part pour garder la petite base intacte :
--   sqlite3 volume.db
--   sqlite> .read bibliotheque.sql
--   sqlite> .read bibliotheque-donnees.sql
--   sqlite> .read bibliotheque-volume.sql
--
-- Les titres sont fictifs : 'Livre 1', 'Livre 2', etc.
-- Les valeurs sont calculées, donc identiques sur toutes les machines.

PRAGMA foreign_keys = ON;

WITH RECURSIVE n(i) AS (
  SELECT 1
  UNION ALL
  SELECT i + 1 FROM n WHERE i < 1000000
)
INSERT INTO livres (titre, annee, nb_pages, auteur_id, rayon_id)
SELECT 'Livre ' || i,
       1800 + (i * 7919) % 226,
       50 + (i * 104729) % 1000,
       1 + i % 11,
       1 + i % 6
FROM n;
