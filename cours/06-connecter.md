---
theme: pixel
number: "06"
title: "Connecter les données"
subtitle: "Modélisation de Données"
author: "Noemi Romano"
email: "noemi.romano@heig-vd.ch"
github: "https://github.com/romanoe/comem-modeldon"
breadcrumb: "Modélisation de Données"
logos:
  - src: /images/logo-heig-vd.svg
    height: 60px
  - src: /images/logo-hes-so.png
    height: 79px

download: true
mdc: true
layout: cover
---
---
layout: default
---

# Cours précédent

- `SELECT`, `FROM`, `AS` et `DISTINCT`
- `WHERE`, `BETWEEN`, `IN`, `LIKE`, `IS NULL`
- `ORDER BY` et `LIMIT`
- `INSERT`, `UPDATE`, `DELETE`, avec `WHERE`
- Une seule table à la fois

<br>

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-git-merge /></template>
Recoller les tables séparées par le modèle : <code>INNER JOIN</code>, <code>LEFT JOIN</code>, <code>RIGHT JOIN</code>, <code>FULL OUTER JOIN</code>. Puis imbriquer et nommer les requêtes : sous-requêtes et CTE.
</Card>

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Où on en est

<Card title="Interroger" footer="cours 05 · fait">
<template #icon><pixelarticons-search /></template>
<strong>Une table</strong> · lire, filtrer, trier, modifier ses lignes.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Connecter" color="#e92528" footer="cours 06 · ce cours">
<template #icon><pixelarticons-git-merge /></template>
<strong>Plusieurs tables</strong> · les recoller par leurs clés étrangères.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Analyser" footer="cours 07 · Analyser les données">
<template #icon><pixelarticons-chart /></template>
<strong>Des indicateurs</strong> · compter, sommer, regrouper les lignes.
</Card>

---
layout: two-cols
---

::title::
# Base de la bibliothèque

::left::

- Ouvrir <a href="https://github.com/romanoe/comem-modeldon-tp">comem-modeldon-tp</a> dans VS Code
- Rouvrir dans le container : **Reopen in Container**
- <a href="https://comem-modeldon.onrender.com/exercices/bibliotheque.sql" download>bibliotheque.sql</a> : structure
- <a href="https://comem-modeldon.onrender.com/exercices/bibliotheque-donnees.sql" download>bibliotheque-donnees.sql</a> : données
- Base absente : la recréer avec `.read`

::right::

```bash
sqlite3 bibliotheque.db

sqlite> .read bibliotheque.sql
sqlite> .read bibliotheque-donnees.sql
sqlite> .tables
```

---
layout: section
---

# Donnée morcelée

---
layout: two-cols
class: compact split
---

::title::
# Donnée morcelée

::left::

### Besoins

> « Qui a emprunté quoi ? On veut des noms, pas des numéros. »

- Une table par entité : le modèle sépare
- `emprunts` : des numéros
- `lecteurs` : les noms

::right::

### Tables

`emprunts`

| livre_id | lecteur_id |
|---|---|
| 1 | 1 |
| 9 | 2 |
| 15 | 3 |

`lecteurs`

| id | nom |
|---|---|
| 1 | Bovet |
| 2 | Rochat |
| 3 | Favre |

---
layout: two-cols
class: compact
---

::title::
# Jointure

::left::

- Recolle deux tables en une seule
- Lien : clé étrangère et clé primaire
- `lecteur_id` d'un côté, `id` de l'autre
- Résultat : une nouvelle table, jamais stockée
- Tables d'origine intactes

::right::

`emprunts + lecteurs`

| livre_id | lecteur_id | id | nom |
|---|---|---|---|
| 1 | 1 | 1 | Bovet |
| 9 | 2 | 2 | Rochat |
| 15 | 3 | 3 | Favre |

---
layout: section
---

# INNER JOIN

---
layout: two-cols
---

::title::
# INNER JOIN

::left::

- Garde les lignes présentes des deux côtés
- `ON` : condition de correspondance
- Clé étrangère égale à la clé primaire
- `table.colonne` : précise la table
- Sans correspondance : ligne absente du résultat

::right::

```sql
SELECT table_a.colonne, table_b.colonne
FROM table_a
INNER JOIN table_b
  ON table_a.cle_etrangere = table_b.id;
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts* et *lecteurs*

::left::

### Besoins

> « Pour relancer les retards, il nous faut chaque emprunt avec le nom de la personne et sa date. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT lecteurs.nom, emprunts.date_emprunt
FROM emprunts
INNER JOIN lecteurs
  ON emprunts.lecteur_id = lecteurs.id;
```

</v-click>

<v-click>

- Une ligne par emprunt
- Plusieurs emprunts : le nom se répète
- Golay, sans emprunt : absent·e

</v-click>

---
layout: two-cols
---

::title::
# Alias de table

::left::

- `AS` : nom court d'une table
- Valable dans cette requête seulement
- Nom de la table inchangé
- `id`, `nom` : présents dans plusieurs tables
- Sans préfixe : `ambiguous column name`

::right::

```sql
SELECT a.colonne, b.colonne
FROM table_a AS a
INNER JOIN table_b AS b
  ON a.cle_etrangere = b.id;
```

---
layout: two-cols
---

::title::
# Exemple : *livres* et *auteurs*

::left::

### Besoins

> « Pour le catalogue, on veut chaque titre avec le nom de son auteur·rice. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT l.titre, a.nom
FROM livres AS l
INNER JOIN auteurs AS a
  ON l.auteur_id = a.id;
```

</v-click>

<v-click>

- `l` et `a` : requête plus courte
- `a.nom` : le nom de l'auteur·rice
- 22 livres, 22 lignes

</v-click>

---
layout: two-cols
---

::title::
# Plusieurs jointures

::left::

- Un `INNER JOIN` par table ajoutée
- Un `ON` par jointure
- Table de liaison : point de départ
- Relation N:M : deux jointures

::right::

```sql
SELECT a.colonne, b.colonne
FROM table_liaison AS l
INNER JOIN table_a AS a
  ON l.a_id = a.id
INNER JOIN table_b AS b
  ON l.b_id = b.id;
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts*, *livres* et *lecteurs*

::left::

### Besoins

> « Qui a emprunté quel livre ? On veut le nom et le titre sur la même ligne. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT lec.nom, liv.titre
FROM emprunts AS e
INNER JOIN lecteurs AS lec
  ON e.lecteur_id = lec.id
INNER JOIN livres AS liv
  ON e.livre_id = liv.id;
```

</v-click>

<v-click>

- `emprunts` relie les deux autres tables
- Aucune colonne de `emprunts` affichée : autorisé

</v-click>

---
layout: two-cols
---

::title::
# Oubli de ON

::left::

### À éviter

```sql
SELECT l.titre, a.nom
FROM livres AS l
INNER JOIN auteurs AS a;
```

- Chaque livre avec chaque auteur·rice
- 22 × 11 : 242 lignes
- Aucune erreur dans SQLite

::right::

### À faire

```sql
SELECT l.titre, a.nom
FROM livres AS l
INNER JOIN auteurs AS a
  ON l.auteur_id = a.id;
```

- Chaque livre avec son auteur·rice
- 22 lignes
- Nombre de lignes : à vérifier

---
layout: section
---

# LEFT JOIN

---
layout: two-cols
---

::title::
# LEFT JOIN

::left::

- Garde toutes les lignes de la table de gauche
- Table de gauche : celle du `FROM`
- Sans correspondance : `NULL` à droite
- Ordre des tables : il compte

::right::

```sql
SELECT a.colonne, b.colonne
FROM table_a AS a
LEFT JOIN table_b AS b
  ON b.cle_etrangere = a.id;
```

---
layout: two-cols
---

::title::
# Exemple : *auteurs* et *livres*

::left::

### Besoins

> « On veut tous les auteur·rice·s du fichier avec leurs titres, même celles et ceux dont on n'a aucun livre. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT a.nom, l.titre
FROM auteurs AS a
LEFT JOIN livres AS l
  ON l.auteur_id = a.id;
```

</v-click>

<v-click>

- `auteurs` à gauche : tous conservés
- Nicolas Bouvier : `titre` à `NULL`

</v-click>

---
layout: two-cols
class: compact
---

::title::
# INNER JOIN et LEFT JOIN

::left::

### INNER JOIN

`resultat`

| nom | titre |
|---|---|
| Agota Kristof | Le Grand Cahier |
| Annie Ernaux | La Place |
| Annie Ernaux | Les Années |

- Auteur·rice·s 9 à 11, trois lignes
- Nicolas Bouvier : absent

::right::

### LEFT JOIN

`resultat`

| nom | titre |
|---|---|
| Agota Kristof | Le Grand Cahier |
| Annie Ernaux | La Place |
| Annie Ernaux | Les Années |
| Nicolas Bouvier | `NULL` |

- Mêmes auteur·rice·s, quatre lignes
- Nicolas Bouvier : conservé

---
layout: two-cols
---

::title::
# Lignes sans correspondance

::left::

- `LEFT JOIN`, puis filtre sur le `NULL`
- Colonne testée : celle de la table de droite
- Colonne obligatoire : `NULL` signifie « aucune ligne »
- `= NULL` ne marche pas : `IS NULL`

::right::

```sql
SELECT a.colonne
FROM table_a AS a
LEFT JOIN table_b AS b
  ON b.cle_etrangere = a.id
WHERE b.cle_etrangere IS NULL;
```

---
layout: two-cols
---

::title::
# Exemple : *lecteurs* sans emprunt

::left::

### Besoins

> « Quels abonnements dorment ? On veut écrire aux personnes qui n'ont encore rien emprunté. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT lec.nom, lec.prenom
FROM lecteurs AS lec
LEFT JOIN emprunts AS e
  ON e.lecteur_id = lec.id
WHERE e.lecteur_id IS NULL;
```

</v-click>

<v-click>

- `lecteurs` à gauche : tout le monde gardé
- Une seule ligne : Maé Golay

</v-click>

---
layout: section
---

# RIGHT JOIN et FULL OUTER JOIN

---
layout: two-cols
---

::title::
# RIGHT JOIN

::left::

- Garde toutes les lignes de la table de droite
- Table de droite : celle du `JOIN`
- Sans correspondance : `NULL` à gauche
- `WHERE a.id IS NULL` : droite sans correspondance

::right::

```sql
-- Toute la table de droite
SELECT a.colonne, b.colonne
FROM table_a AS a
RIGHT JOIN table_b AS b
  ON a.cle_etrangere = b.id;

-- Seulement les lignes sans correspondance
SELECT b.colonne
FROM table_a AS a
RIGHT JOIN table_b AS b
  ON a.cle_etrangere = b.id
WHERE a.id IS NULL;
```

---
layout: two-cols
---

::title::
# Exemple : *rayons* vides

::left::

### Besoins

> « Quels emplacements sont vides ? On veut y ranger les nouveautés. »

### Question

Quelle requête, en partant de `livres` ?

::right::

<v-click>

```sql
SELECT r.no_rayon, r.no_etagere
FROM livres AS l
RIGHT JOIN rayons AS r
  ON l.rayon_id = r.id
WHERE l.id IS NULL;
```

</v-click>

<v-click>

- `rayons` à droite : tous conservés
- `l.id` à `NULL` : aucun livre
- Résultat : rayon 4, étagère 1

</v-click>

---
layout: two-cols
---

::title::
# FULL OUTER JOIN

::left::

- Garde toutes les lignes des deux tables
- Sans correspondance : `NULL` de l'autre côté
- `OR` : sans correspondance d'un côté ou de l'autre

::right::

```sql
-- Toutes les lignes des deux tables
SELECT a.colonne, b.colonne
FROM table_a AS a
FULL OUTER JOIN table_b AS b
  ON a.cle_etrangere = b.id;

-- Seulement les lignes sans correspondance
SELECT a.colonne, b.colonne
FROM table_a AS a
FULL OUTER JOIN table_b AS b
  ON a.cle_etrangere = b.id
WHERE a.id IS NULL
   OR b.id IS NULL;
```

---
layout: two-cols
---

::title::
# Exemple : *livres* et *rayons* sans correspondance

::left::

### Besoins

> « Avant l'inventaire, on veut d'un coup les livres sans emplacement et les emplacements vides. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT l.titre, r.no_rayon, r.no_etagere
FROM livres AS l
FULL OUTER JOIN rayons AS r
  ON l.rayon_id = r.id
WHERE l.id IS NULL
   OR r.id IS NULL;
```

</v-click>

<v-click>

- Trois livres sans rayon
- Un rayon sans livre
- Résultat : quatre lignes

</v-click>

---
layout: default
class: compact
---

# Types de jointures

| Jointure | Résultat |
|---|---|
| `INNER JOIN` | Lignes présentes des deux côtés |
| `LEFT JOIN` | Toute la table de gauche |
| `LEFT JOIN` + `WHERE b.id IS NULL` | Gauche sans correspondance |
| `RIGHT JOIN` | Toute la table de droite |
| `RIGHT JOIN` + `WHERE a.id IS NULL` | Droite sans correspondance |
| `FULL OUTER JOIN` | Toutes les lignes des deux tables |
| `FULL OUTER JOIN` + `WHERE a.id IS NULL OR b.id IS NULL` | Sans correspondance, des deux côtés |
| `CROSS JOIN` | Chaque ligne avec chaque ligne |

---
layout: section
---

# Sous-requêtes

---
layout: two-cols
---

::title::
# Sous-requête

::left::

- Requête imbriquée dans une autre requête
- Toujours entre parenthèses
- Clauses possibles : `SELECT`, `FROM`, `WHERE`
- Une seule valeur : comparaison avec `=`, `>`, `<`

::right::

```sql
-- Une seule valeur
SELECT colonne
FROM nom_table
WHERE colonne > (SELECT colonne
                 FROM nom_table
                 WHERE condition);

-- Dans la clause FROM
SELECT colonne
FROM (SELECT colonne
      FROM nom_table);
```

---
layout: two-cols
---

::title::
# Exemple : *livres* plus longs

::left::

### Besoins

> « Quels livres sont plus longs que Germinal ? Ils iront sur l'étagère renforcée. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT titre, nb_pages
FROM livres
WHERE nb_pages > (SELECT nb_pages
                  FROM livres
                  WHERE titre = 'Germinal');
```

</v-click>

<v-click>

- Le nombre de pages n'est pas donné
- Sous-requête : 600
- Résultat : deux livres

</v-click>

---
layout: two-cols
---

::title::
# IN et NOT IN

::left::

- `IN` : la valeur est dans la liste
- `NOT IN` : la valeur n'est pas dans la liste
- Liste écrite à la main, ou sous-requête
- Une seule colonne dans la sous-requête

::right::

```sql
SELECT colonne
FROM table_a
WHERE id IN (SELECT a_id
             FROM table_b);

SELECT colonne
FROM table_a
WHERE id NOT IN (SELECT a_id
                 FROM table_b);
```

---
layout: two-cols
---

::title::
# Exemple : *livres* jamais empruntés

::left::

### Besoins

> « Quels livres n'ont jamais été empruntés ? On pense les mettre en avant à l'entrée. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT titre
FROM livres
WHERE id NOT IN (SELECT livre_id
                 FROM emprunts);
```

</v-click>

<v-click>

- Sous-requête : les livres empruntés
- `NOT IN` : tous les autres
- Résultat : cinq livres

</v-click>

---
layout: section
---

# CTE

---
layout: two-cols
---

::title::
# CTE (Common Table Expressions)

::left::

- Table temporaire nommée, utilisable dans une requête
- Meilleure lisibilité du code
- Évite la répétition de sous-requêtes
- Peut être référencée plusieurs fois
- Plusieurs CTE : un seul `WITH`, une virgule

::right::

```sql
-- CTE avec une table
WITH nom_cte AS (
  SELECT ...
)
SELECT *
FROM nom_cte;

-- CTE avec plusieurs tables
WITH cte_a AS (
  SELECT ...
),
cte_b AS (
  SELECT ...
)
SELECT *
FROM cte_a
INNER JOIN cte_b
  ON cte_a.b_id = cte_b.id;
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts* en cours

::left::

### Besoins

> « Quels livres sont sortis en ce moment, et chez qui ? »

### Question

Quelle requête ?

::right::

<v-click>

```sql
WITH en_cours AS (
  SELECT livre_id, lecteur_id
  FROM emprunts
  WHERE rendu = 0
)
SELECT l.titre, lec.nom
FROM en_cours AS e
INNER JOIN livres AS l
  ON e.livre_id = l.id
INNER JOIN lecteurs AS lec
  ON e.lecteur_id = lec.id;
```

</v-click>

<v-click>

- `en_cours` : un nom pour une étape
- La suite se lit comme une table

</v-click>

---
layout: two-cols
---

::title::
# Exemple : *livres* longs empruntés

::left::

### Besoins

> « Parmi les livres d'au moins 500 pages, lesquels sont sortis en ce moment ? »

### Question

Quelle requête ?

::right::

<v-click>

```sql
WITH en_cours AS (
  SELECT livre_id
  FROM emprunts
  WHERE rendu = 0
),
longs AS (
  SELECT id, titre
  FROM livres
  WHERE nb_pages >= 500
)
SELECT longs.titre
FROM longs
INNER JOIN en_cours
  ON en_cours.livre_id = longs.id;
```

</v-click>

<v-click>

- Deux étapes nommées, puis une jointure
- Résultat : deux livres

</v-click>

---
layout: default
---

# Résumé

| Outil | Usage |
|---|---|
| `INNER JOIN` | Lignes présentes des deux côtés |
| `LEFT JOIN` | Toutes les lignes de gauche, `NULL` à droite |
| `RIGHT JOIN` | Toutes les lignes de droite, `NULL` à gauche |
| `FULL OUTER JOIN` | Toutes les lignes des deux tables |
| `IS NULL` après la jointure | Lignes sans correspondance |
| Sous-requête | Résultat d'une requête utilisé par une autre |
| `IN`, `NOT IN` | Valeur présente ou absente d'une liste |
| CTE, `WITH` | Requête intermédiaire nommée |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# TP · Semaine 6

::left::

1. Ouvrir `musee.db` dans l'environnement de TP

2. Écrire `musee-jointures.sql`, avec `PRAGMA foreign_keys = ON;` en tête

3. Une requête commentée par question

4. Comparer `INNER JOIN` et `LEFT JOIN` sur un même cas

5. Vérifier le nombre de lignes de chaque résultat

::right::

```sql
-- Œuvres et artistes
SELECT o.titre, a.nom
FROM oeuvres AS o
INNER JOIN artistes AS a
  ON o.artiste_id = a.id;
```

---
layout: section
---

# Cheff·es de projet: réunion

---
layout: two-cols
hide: true
---

::title::
# Questions du musée

::left::

1. Chaque œuvre avec le nom de son artiste

2. Œuvres d'une exposition choisie, avec son titre

3. Billets avec leur tarif, y compris sans tarif

4. Toutes les œuvres avec leur technique, même inconnue

5. Œuvres jamais exposées, avec `LEFT JOIN` puis `RIGHT JOIN`

::right::

6. Œuvres plus anciennes que *La Nuit étoilée*

7. Expositions sans aucun financement

8. Artistes présent·e·s dans *Femmes artistes*

9. Financements non payés, avec partenaire et exposition, par une CTE

10. Refaire une sous-requête avec une jointure, comparer les résultats
