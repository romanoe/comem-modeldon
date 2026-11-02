---
theme: pixel
number: "05"
title: "Interroger les données"
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

- Types SQLite : `INTEGER`, `REAL`, `TEXT`
- `CREATE TABLE` et contraintes de colonne
- Clé étrangère et modes de suppression
- Clé primaire composite de la table de liaison
- `DROP TABLE` et `ALTER TABLE` : modifier la structure

<br>

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-search /></template>
Lire, filtrer et trier les lignes d'une table avec <code>SELECT</code>. Puis les insérer, les modifier, les supprimer : <code>INSERT</code>, <code>UPDATE</code>, <code>DELETE</code>.
</Card>

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Où on en est

<Card title="Structure" footer="cours 02 à 04 · fait">
<template #icon><pixelarticons-database /></template>
<strong>MCD, MLD, MPD</strong> · des tables vides, typées et contraintes.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Interroger" color="#e92528" footer="cours 05 · ce cours">
<template #icon><pixelarticons-search /></template>
<strong>Une table</strong> · lire, filtrer, trier, modifier ses lignes.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Connecter" footer="cours 06 · Connecter les données">
<template #icon><pixelarticons-git-merge /></template>
<strong>Plusieurs tables</strong> · les recoller par leurs clés étrangères.
</Card>

---
layout: default
---

# Examen intermédiaire

| Élément | Détail |
|---|---|
| Date | 10 novembre, 13h-15h |
| Programme | Cours 01 à 04 |
| Format | Questions ouvertes et QCM |
| Support | Papier, sans machine |
| Documents | Une feuille A4 recto-verso manuscrite |
| Poids | 50% de la note finale |

<Card title="Examen type" color="#e92528">
<template #icon><pixelarticons-edit-box /></template>
Pour s'entraîner : <a href="https://comem-modeldon.onrender.com/revisions/examen-type.pdf" download>examen-type.pdf</a>, aussi disponible sur la page d'accueil du cours.
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

# Lire les données

---
layout: two-cols
---

::title::
# SELECT

::left::

- `SELECT` : les colonnes à afficher
- `FROM` : la table interrogée
- `*` : toutes les colonnes
- Résultat : une nouvelle table, jamais stockée
- La table interrogée reste intacte

::right::

```sql
SELECT colonne_1, colonne_2
FROM nom_table;

SELECT *
FROM nom_table;
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « Pour préparer l'inventaire, il nous faut la liste des titres avec leur année de parution. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT titre, annee
FROM livres;
```

</v-click>

<v-click>

- Deux colonnes, dans l'ordre demandé
- Toutes les lignes : aucun filtre
- Ordre des lignes : non garanti

</v-click>

---
layout: two-cols
---

::title::
# AS et DISTINCT

::left::

- `AS` : renomme une colonne du résultat
- Nom d'origine inchangé dans la table
- `DISTINCT` : élimine les lignes dupliquées (doublons) dans les résultats d'une requête
- Plusieurs colonnes : la combinaison doit être identique

::right::

```sql
SELECT colonne AS nouveau_nom
FROM nom_table;

-- Chaque valeur une seule fois
SELECT DISTINCT colonne_1
FROM nom_table;

-- Chaque combinaison une seule fois
SELECT DISTINCT colonne_1, colonne_2
FROM nom_table;
```

---
layout: two-cols
class: compact split
---

::title::
# DISTINCT sur plusieurs colonnes

::left::

`livres`

| auteur_id | rayon_id |
|---|---|
| 1 | 1 |
| 1 | 1 |
| 1 | 5 |
| 2 | 1 |
| 2 | 2 |

- S'applique à toutes les colonnes du `SELECT`
- Doublon : mêmes valeurs dans toutes ces colonnes

::right::

### Résultats

`DISTINCT auteur_id`

| auteur_id |
|---|
| 1 |
| 2 |

`DISTINCT auteur_id, rayon_id`

| auteur_id | rayon_id |
|---|---|
| 1 | 1 |
| 1 | 5 |
| 2 | 1 |
| 2 | 2 |

---
layout: two-cols
---

::title::
# Exemple : *emprunts*

::left::

### Besoins

> « Quel·le·s lecteur·rice·s ont emprunté au moins un livre ? On veut chaque numéro une seule fois. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT DISTINCT lecteur_id AS lecteur
FROM emprunts;
```

</v-click>

<v-click>

- Sans `DISTINCT` : un numéro par emprunt
- `AS` : en-tête `lecteur` dans le résultat
- Les noms sont dans `lecteurs` : cours 06

</v-click>

---
layout: section
---

# Filtrer

---
layout: two-cols
---

::title::
# WHERE

::left::

- Garde les lignes où la condition est vraie
- Comparaison : `=`, `<>`, `<`, `>`, `<=`, `>=`
- Combinaison : `AND`, `OR`, `NOT`
- Texte entre apostrophes : `'roman'`
- Parenthèses pour mêler `AND` et `OR`

::right::

```sql
SELECT colonne_1, colonne_2
FROM nom_table
WHERE condition_1
  AND condition_2;
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « On cherche les gros romans anciens : publiés avant 1900, et de plus de 500 pages. »

### Question

Quelle condition ?

::right::

<v-click>

```sql
SELECT titre, annee, nb_pages
FROM livres
WHERE annee < 1900
  AND nb_pages > 500;
```

</v-click>

<v-click>

- `AND` : les deux conditions à la fois
- Nombre sans apostrophes
- `OR` élargirait le résultat

</v-click>

---
layout: two-cols
---

::title::
# BETWEEN, IN et LIKE

::left::

- `BETWEEN` : intervalle, bornes comprises
- `IN` : une valeur parmi une liste
- `LIKE` : motif de texte
- `%` : n'importe quelle suite de caractères
- `_` : exactement un caractère

::right::

```sql
WHERE colonne BETWEEN min AND max

WHERE colonne IN (valeur_1, valeur_2)

WHERE colonne LIKE 'debut%'
WHERE colonne LIKE '%milieu%'
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « Pour une vitrine sur le Second Empire, on veut les livres parus entre 1852 et 1870. Et, à part, tous les titres qui contiennent le mot "Terre". »

### Question

Quelles deux requêtes ?

::right::

<v-click>

```sql
SELECT titre, annee
FROM livres
WHERE annee BETWEEN 1852 AND 1870;

SELECT titre
FROM livres
WHERE titre LIKE '%Terre%';
```

</v-click>

<v-click>

- 1852 et 1870 inclus
- `%` des deux côtés : le mot n'importe où

</v-click>

---
layout: two-cols
---

::title::
# Valeur vide

::left::

### À éviter

```sql
SELECT titre
FROM livres
WHERE rayon_id = NULL;
```

- `NULL` : absence de valeur
- Comparaison avec `NULL` : jamais vraie
- Résultat toujours vide

::right::

### À faire

```sql
SELECT titre
FROM livres
WHERE rayon_id IS NULL;
```

- `IS NULL` : la valeur manque
- `IS NOT NULL` : la valeur existe
- Ici : les livres pas encore rangés

---
layout: section
---

# Trier

---
layout: two-cols
---

::title::
# ORDER BY

::left::

- `ASC` : ordre croissant, par défaut
- `DESC` : ordre décroissant
- Plusieurs colonnes : départage des ex aequo
- `LIMIT` : nombre maximal de lignes
- `ORDER BY` et `LIMIT` en fin de requête

::right::

```sql
SELECT colonne_1, colonne_2
FROM nom_table
ORDER BY colonne_1 DESC, colonne_2 ASC
LIMIT n;
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « Sur la page d'accueil, on affiche les trois livres les plus épais du catalogue. »

### Question

Quel tri, quelle limite ?

::right::

<v-click>

```sql
SELECT titre, nb_pages
FROM livres
ORDER BY nb_pages DESC
LIMIT 3;
```

</v-click>

<v-click>

- `DESC` : le plus grand en premier
- `LIMIT` sans `ORDER BY` : trois lignes au hasard
- Ex aequo à 600 pages : un seul retenu

</v-click>

---
layout: two-cols
---

::title::
# Ordre des clauses

::left::

- Ordre d'écriture imposé
- Seules `SELECT` et `FROM` sont obligatoires
- Une clause absente se saute

::right::

```sql
SELECT colonnes
FROM table
WHERE condition
ORDER BY colonnes
LIMIT n;
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts*

::left::

### Besoins

> « Chaque lundi, on relance les livres non rendus, en commençant par les plus anciens emprunts. »

### Question

Quelle requête complète ?

::right::

<v-click>

```sql
SELECT livre_id, lecteur_id, date_emprunt
FROM emprunts
WHERE rendu = 0
ORDER BY date_emprunt ASC;
```

</v-click>

<v-click>

- `rendu = 0` : `BOOLEAN` stocké en entier
- Date `AAAA-MM-JJ` : ordre alphabétique égal à l'ordre chronologique

</v-click>

---
layout: section
---

# Modifier les données

---
layout: two-cols
---

::title::
# INSERT

::left::

- Liste des colonnes, puis liste des valeurs
- Même ordre dans les deux listes
- Colonne omise : `NULL` ou `DEFAULT`
- `id` omis : numéro attribué automatiquement
- Plusieurs lignes : séparées par une virgule

::right::

```sql
INSERT INTO nom_table (colonne_1, colonne_2)
VALUES (valeur_1, valeur_2);

INSERT INTO nom_table (colonne_1, colonne_2)
VALUES
  (valeur_1, valeur_2),
  (valeur_3, valeur_4);
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « Nous venons de recevoir *Le Premier Homme* d'Albert Camus, paru en 1994. Il n'est pas encore rangé. »

### Question

Quel `INSERT` ?

::right::

<v-click>

```sql
INSERT INTO livres (titre, annee, auteur_id)
VALUES ('Le Premier Homme', 1994, 8);
```

</v-click>

<v-click>

- `auteur_id` 8 : Albert Camus, dans `auteurs`
- `rayon_id` omis : `NULL`, livre non rangé
- `auteur_id` 99 : refusé par la clé étrangère

</v-click>

---
layout: two-cols
---

::title::
# UPDATE

::left::

- `SET` : nouvelle valeur de chaque colonne
- `WHERE` : les lignes concernées
- Sans `WHERE` : toutes les lignes modifiées
- Les contraintes restent vérifiées

::right::

```sql
UPDATE nom_table
SET colonne_1 = valeur_1,
    colonne_2 = valeur_2
WHERE condition;
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts*

::left::

### Besoins

> « Zoé Chappuis (lectrice 7) vient de rendre *La Peste* (livre 19). »

### Question

Quel `UPDATE` ?

::right::

<v-click>

```sql
UPDATE emprunts
SET rendu = 1
WHERE livre_id = 19
  AND lecteur_id = 7;
```

</v-click>

<v-click>

- Clé composite : les deux colonnes dans `WHERE`
- `livre_id` seul : tous les emprunts du livre

</v-click>

---
layout: two-cols
---

::title::
# DELETE

::left::

- Supprime des lignes entières
- `WHERE` : les lignes concernées
- Sans `WHERE` : table vidée, structure conservée
- Mode de suppression appliqué aux enfants
- Irréversible

::right::

```sql
DELETE FROM nom_table
WHERE condition;
```

---
layout: two-cols
---

::title::
# Exemple : *lecteurs*

::left::

### Besoins

> « Alix Rey (lectrice 9) se désinscrit de la bibliothèque. »

### Question

Quel `DELETE`, et que deviennent ses emprunts ?

::right::

<v-click>

```sql
DELETE FROM lecteurs
WHERE id = 9;
```

</v-click>

<v-click>

- `ON DELETE CASCADE` : ses emprunts disparaissent aussi
- `DELETE` sur `auteurs` 5 : refusé, `RESTRICT`
- `id` dans `WHERE` : une seule ligne visée

</v-click>

---
layout: two-cols
---

::title::
# Vérification avant modification

::left::

### À éviter

```sql
DELETE FROM emprunts
WHERE rendu = 1;
```

- Lignes visées inconnues
- Condition fausse : données perdues

::right::

### À faire

```sql
SELECT *
FROM emprunts
WHERE rendu = 1;

DELETE FROM emprunts
WHERE rendu = 1;
```

- `SELECT` d'abord, même `WHERE`
- Résultat vérifié, puis `DELETE` ou `UPDATE`

---
layout: default
---

# Résumé

| Clause | Rôle |
|---|---|
| `SELECT`, `FROM` | Colonnes et table lues |
| `WHERE` | Filtre des lignes |
| `IS NULL` | Valeur manquante |
| `ORDER BY`, `LIMIT` | Tri et nombre de lignes |
| `INSERT INTO` | Ajout de lignes |
| `UPDATE`, `DELETE` | Modification, suppression, toujours avec `WHERE` |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# TP · Semaine 5

::left::

1. Comparer son `musee.sql` au <a href="https://comem-modeldon.onrender.com/exercices/musee.sql" download>corrigé</a>, le corriger

2. Télécharger <a href="https://comem-modeldon.onrender.com/exercices/musee-donnees.sql" download>musee-donnees.sql</a>, exécuter les deux scripts avec `.read`

3. Écrire `musee-requetes.sql`, avec `PRAGMA foreign_keys = ON;` en tête

4. Une requête commentée par question

5. Modifier, supprimer : `SELECT` d'abord

::right::

```sql
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

1. Œuvres d'un·e artiste, de la plus ancienne à la plus récente

2. Œuvres sans technique renseignée

3. Expositions qui commencent en 2027

4. Artistes dont le nom commence par une lettre choisie

5. Les trois tarifs les plus chers

::right::

6. Billets d'une exposition, triés par date de visite

7. Ajouter une œuvre, puis corriger son année

8. Marquer un financement comme payé

9. Supprimer un billet, puis une exposition qui a des billets

10. Provoquer un refus par contrainte : `NOT NULL`, `UNIQUE`, `CHECK`, `REFERENCES`

