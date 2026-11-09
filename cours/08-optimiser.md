---
theme: pixel
number: "08"
title: "Indexer et optimiser"
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

- `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`
- `COUNT(*)`, `COUNT(colonne)`, `COUNT(DISTINCT colonne)`
- `GROUP BY` : une ligne par groupe
- `WHERE` avant, `HAVING` après le regroupement
- `CREATE VIEW` : requête enregistrée, toujours à jour

<br>

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-zap /></template>
Accélérer les requêtes : index, plan d'exécution, coût d'un index, dénormalisation raisonnée.
</Card>

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Où on en est

<Card title="Analyser" footer="cours 07 · fait">
<template #icon><pixelarticons-chart /></template>
<strong>Des indicateurs</strong> · compter, sommer, regrouper les lignes.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Optimiser" color="#e92528" footer="cours 08 · ce cours">
<template #icon><pixelarticons-zap /></template>
<strong>Des requêtes rapides</strong> · index et plan d'exécution.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Semi-structuré" footer="cours 09 · La donnée semi-structurée">
<template #icon><pixelarticons-braces /></template>
<strong>Au-delà du tableau</strong> · lire et produire du JSON.
</Card>

---
layout: two-cols
---

::title::
# Base de la bibliothèque

::left::

- Ouvrir <a href="https://github.com/romanoe/comem-modeldon-tp">comem-modeldon-tp</a> dans VS Code
- <a href="https://comem-modeldon.onrender.com/exercices/bibliotheque.sql" download>bibliotheque.sql</a> : structure
- <a href="https://comem-modeldon.onrender.com/exercices/bibliotheque-donnees.sql" download>bibliotheque-donnees.sql</a> : données
- <a href="https://comem-modeldon.onrender.com/exercices/bibliotheque-volume.sql" download>bibliotheque-volume.sql</a> : un million de livres
- `.timer on` : durée de chaque requête

::right::

```bash
sqlite3 volume.db

sqlite> .read bibliotheque.sql
sqlite> .read bibliotheque-donnees.sql
sqlite> .read bibliotheque-volume.sql
sqlite> .timer on
```

---
layout: section
---

# Parcours complet d'une table

---
layout: two-cols
---

::title::
# Parcours complet

::left::

- Sans index : chaque ligne est lue
- Durée proportionnelle au nombre de lignes
- 22 livres : invisible
- Un million de livres : mesurable

::right::

```sql
SELECT colonne
FROM nom_table
WHERE condition;
```

---
layout: two-cols
---

::title::
# Exemple : recherche par titre

::left::

### Besoins

> « Le catalogue compte maintenant un million de livres. L'accueil cherche un titre plusieurs fois par minute. »

### Question

Combien de lignes lues pour trouver ce titre ?

::right::

<v-click>

```sql
SELECT id
FROM livres
WHERE titre = 'Livre 777777';
```

</v-click>

<v-click>

- Une ligne retournée, un million de lignes lues
- Environ 40 ms, selon la machine
- Durée multipliée par le nombre de recherches

</v-click>

---
layout: section
---

# Index

---
layout: two-cols
class: compact split
---

::title::
# Index

::left::

- Structure triée, séparée de la table
- Une valeur, puis le numéro de sa ligne
- Recherche directe, sans parcours
- Comme l'index à la fin d'un livre

::right::

### Exemple

`livres`

| id | annee |
|---|---|
| 1 | 1831 |
| 13 | 1885 |
| 18 | 1942 |
| 21 | 1983 |
| 22 | 2008 |

`idx_livres_annee`

| annee | id |
|---|---|
| 1831 | 1 |
| 1885 | 13 |
| 1942 | 18 |
| 1983 | 21 |
| 2008 | 22 |

---
layout: two-cols
---

::title::
# CREATE INDEX

::left::

- Nom, table, colonne
- Convention : `idx_table_colonne`
- Requêtes inchangées : le SGBD choisit seul
- `DROP INDEX` : supprime l'index, pas les données
- `.indexes` : liste les index

::right::

```sql
CREATE INDEX idx_table_colonne
ON nom_table (colonne);

DROP INDEX idx_table_colonne;
```

---
layout: two-cols
---

::title::
# Exemple : index sur *titre*

::left::

### Besoins

> « Le catalogue compte maintenant un million de livres. L'accueil cherche un titre plusieurs fois par minute. »

### Question

Quel index, et quelle requête ensuite ?

::right::

<v-click>

```sql
CREATE INDEX idx_livres_titre
ON livres (titre);

SELECT id
FROM livres
WHERE titre = 'Livre 777777';
```

</v-click>

<v-click>

- Requête identique à la précédente
- Moins d'une milliseconde
- Même résultat : `id` 777799

</v-click>

---
layout: two-cols
---

::title::
# Index automatiques

::left::

- `PRIMARY KEY` : accès direct, sans index à créer
- `UNIQUE` : index créé par SQLite
- Clé composite : index créé par SQLite
- `REFERENCES` : aucun index
- Clé étrangère : index à poser soi-même

::right::

```bash
sqlite> .indexes

sqlite_autoindex_emprunts_1
sqlite_autoindex_genres_1
sqlite_autoindex_lecteurs_1
sqlite_autoindex_livres_genres_1
sqlite_autoindex_rayons_1
```

---
layout: section
---

# Plan d'exécution

---
layout: two-cols
---

::title::
# EXPLAIN QUERY PLAN

::left::

- Placé devant la requête
- Affiche le plan, sans exécuter la requête
- `SCAN` : parcours complet
- `SEARCH` : accès direct
- `USE TEMP B-TREE` : tri sans index

::right::

```sql
EXPLAIN QUERY PLAN
SELECT colonne
FROM nom_table
WHERE condition;
```

---
layout: two-cols
---

::title::
# Exemple : recherche par *annee*

::left::

### Besoins

> « Filtrer les livres par année devient lent. On veut vérifier qu'un index change bien quelque chose. »

### Question

Quel plan avant, quel plan après ?

::right::

<v-click>

```sql
EXPLAIN QUERY PLAN
SELECT titre FROM livres WHERE annee = 1885;
-- SCAN livres

CREATE INDEX idx_livres_annee
ON livres (annee);

EXPLAIN QUERY PLAN
SELECT titre FROM livres WHERE annee = 1885;
-- SEARCH livres USING INDEX
--   idx_livres_annee (annee=?)
```

</v-click>

<v-click>

- Vérification sans mesurer de durée
- Fonctionne aussi sur une petite base

</v-click>

---
layout: two-cols
---

::title::
# Exemple : jointure *livres*, *auteurs*

::left::

### Besoins

> « La fiche d'un·e auteur·rice liste tous ses livres. »

### Question

Quelle colonne indexer ?

::right::

<v-click>

```sql
EXPLAIN QUERY PLAN
SELECT l.titre
FROM livres AS l
INNER JOIN auteurs AS a ON l.auteur_id = a.id
WHERE a.nom = 'Émile Zola';
-- SCAN l
-- SEARCH a USING INTEGER PRIMARY KEY

CREATE INDEX idx_livres_auteur
ON livres (auteur_id);
-- Même requête, nouveau plan :
-- SCAN a
-- SEARCH l USING INDEX idx_livres_auteur
```

</v-click>

<v-click>

- Avant : tous les livres parcourus
- Après : 11 auteur·rice·s parcouru·e·s

</v-click>

---
layout: section
---

# Index composite

---
layout: two-cols
---

::title::
# Index composite

::left::

- Plusieurs colonnes, dans un ordre choisi
- Trié par la première, puis par la suivante
- Utilisable dès la première colonne
- Deuxième colonne seule : `SCAN`

::right::

```sql
CREATE INDEX idx_table_a_b
ON nom_table (colonne_a, colonne_b);

-- Index utilisé
WHERE colonne_a = valeur
WHERE colonne_a = valeur
  AND colonne_b = valeur

-- Index inutilisable
WHERE colonne_b = valeur
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts*

::left::

### Besoins

> « On consulte les emprunts d'un livre, et aussi l'historique d'une personne. »

### Question

La clé `(livre_id, lecteur_id)` sert-elle les deux recherches ?

::right::

<v-click>

```sql
EXPLAIN QUERY PLAN
SELECT * FROM emprunts WHERE livre_id = 18;
-- SEARCH emprunts USING INDEX
--   sqlite_autoindex_emprunts_1 (livre_id=?)

EXPLAIN QUERY PLAN
SELECT * FROM emprunts WHERE lecteur_id = 1;
-- SCAN emprunts

CREATE INDEX idx_emprunts_lecteur
ON emprunts (lecteur_id);
```

</v-click>

<v-click>

- `livre_id` : première colonne de la clé
- `lecteur_id` : deuxième colonne, index à ajouter

</v-click>

---
layout: two-cols
---

::title::
# Index inutilisable

::left::

### À éviter

```sql
SELECT annee
FROM livres
WHERE titre LIKE '%min%';
-- SCAN livres
```

- Index trié par le début du texte
- Début inconnu : parcours complet

::right::

### À faire

```sql
SELECT annee
FROM livres
WHERE titre = 'Germinal';
-- SEARCH livres USING INDEX
--   idx_livres_titre (titre=?)
```

- Valeur exacte : accès direct
- Plan toujours vérifié

---
layout: section
---

# Coût d'un index

---
layout: two-cols
---

::title::
# Coût d'un index

::left::

- Lecture accélérée
- `INSERT`, `UPDATE`, `DELETE` : index aussi mis à jour
- Fichier plus lourd
- Chaque index ajoute ce coût

::right::

### Mesure

`mesures`

| un million de livres | sans index | avec index |
|---|---|---|
| Recherche par titre | 40 ms | < 1 ms |
| 100 000 `INSERT` | 30 ms | 110 ms |
| Taille du fichier | 31 Mo | 52 Mo |

- Ordre de grandeur, selon la machine

---
layout: default
---

# Choix d'un index

| Colonne | Index | Raison |
|---|---|---|
| Clé étrangère jointe | Oui | Jointures fréquentes |
| Colonne souvent filtrée ou triée | Oui | Lectures fréquentes |
| Clé primaire, colonne `UNIQUE` | Déjà là | Index automatique |
| Colonne à deux valeurs (`rendu`) | Non | Peu de lignes écartées |
| Table surtout écrite | À mesurer | Écritures ralenties |

---
layout: two-cols
---

::title::
# Exemple : index de la bibliothèque

::left::

### Besoins

> « Chaque jour : chercher un titre, afficher l'historique d'une personne, et lister les emprunts non rendus. »

### Question

Quels index créer, lesquels écarter ?

::right::

<v-click>

```sql
CREATE INDEX idx_livres_titre
ON livres (titre);

CREATE INDEX idx_emprunts_lecteur
ON emprunts (lecteur_id);
```

</v-click>

<v-click>

- `titre` : recherche fréquente
- `lecteur_id` : deuxième colonne de la clé
- `rendu` : deux valeurs, index écarté

</v-click>

---
layout: section
---

# Dénormalisation

---
layout: two-cols
class: compact
---

::title::
# Dénormalisation

::left::

- Redondance volontaire, après la normalisation
- But : des lectures plus rapides
- Prix : des copies à synchroniser
- Index d'abord, dénormalisation ensuite
- Toujours après une mesure

::right::

### Exemple

`livres`

| id | titre | nb_emprunts |
|---|---|---|
| 1 | Notre-Dame de Paris | 2 |
| 6 | Madame Bovary | 2 |
| 18 | L'Étranger | 2 |

- `nb_emprunts` : attribut dérivé stocké

---
layout: default
---

# Lecture et écriture

| | Modèle normalisé | Modèle dénormalisé |
|---|---|---|
| Écriture | Sûre, une seule ligne à changer | Risquée, plusieurs copies à synchroniser |
| Lecture | Plusieurs tables à relier | Tout est déjà rassemblé |
| Cohérence | Garantie par la structure | À la charge de l'application |

---
layout: grid
cols: 3
align: stretch
content: center
---

# Trois cas de dénormalisation

<Card title="Valeur historique" color="#16a34a">
<template #icon><pixelarticons-clock /></template>
La <strong>durée de prêt</strong> figée sur l'emprunt : la règle de ce jour-là. <strong>Légitime</strong>.
</Card>
<Card title="Agrégat précalculé" color="#d97706">
<template #icon><pixelarticons-calculator /></template>
Un compteur <code>nb_emprunts</code> sur le livre. <strong>Acceptable</strong> si mesuré et automatisé.
</Card>
<Card title="Copie de confort" color="#e92528">
<template #icon><pixelarticons-close /></template>
<code>titre</code> recopié dans <code>emprunts</code>. <strong>Non</strong> : l'erreur de 2NF du cours 03.
</Card>

---
layout: two-cols
---

::title::
# Exemple : compteur *nb_emprunts*

::left::

### Besoins

> « La fiche d'un livre affiche son nombre d'emprunts. Faut-il ajouter un compteur à la table `livres` ? »

### Question

Que dit le plan de la requête actuelle ?

::right::

<v-click>

```sql
EXPLAIN QUERY PLAN
SELECT COUNT(*)
FROM emprunts
WHERE livre_id = 18;
-- SEARCH emprunts USING COVERING INDEX
--   sqlite_autoindex_emprunts_1 (livre_id=?)
```

</v-click>

<v-click>

- Accès direct : index de la clé composite
- Compteur inutile
- Plan d'abord, dénormalisation seulement si mesure

</v-click>

---
layout: default
---

# Résumé

| Outil | Usage |
|---|---|
| `CREATE INDEX` | Accélère la recherche sur une colonne |
| `EXPLAIN QUERY PLAN` | Affiche `SCAN` ou `SEARCH` |
| Index composite | Utilisable dès la première colonne |
| Clé étrangère | Index à poser soi-même |
| Coût d'un index | Écritures plus lentes, fichier plus lourd |
| Dénormalisation | Après la mesure, jamais par confort |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# TP · Semaine 8

::left::

1. Ouvrir `musee.db` dans l'environnement de TP

2. Écrire `musee-index.sql` : une requête commentée par question

3. Lire chaque plan avec `EXPLAIN QUERY PLAN`

4. Poser un index sur les colonnes filtrées ou jointes

5. Comparer le plan avant et après l'index

::right::

```sql
-- Œuvres d'un·e artiste
EXPLAIN QUERY PLAN
SELECT titre
FROM oeuvres
WHERE artiste_id = 1;
-- SCAN oeuvres

CREATE INDEX idx_oeuvres_artiste
ON oeuvres (artiste_id);
```

---
layout: section
---

# Chef·fes de projet : réunion

---
layout: two-cols
hide: true
---

::title::
# Questions du musée

::left::

1. Lister les index existants, repérer ceux de SQLite

2. Plan des œuvres d'un·e artiste, avant et après index

3. Plan des billets d'une exposition, avant et après index

4. Plan de la jointure entre billets et expositions

5. Plan du tri des œuvres par année, avant et après index

::right::

6. Œuvres d'une exposition, expositions d'une œuvre : plan des deux

7. Index manquant sur `expositions_oeuvres`, à ajouter

8. Index sur `statut` : pour ou contre

9. Recherche d'un titre avec `LIKE '%...%'` : plan

10. Compteur de billets sur `expositions` : pour ou contre
