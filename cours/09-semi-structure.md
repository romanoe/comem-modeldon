---
theme: pixel
number: "09"
title: "La donnée semi-structurée"
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

- `CREATE INDEX` : accélérer la recherche sur une colonne
- `EXPLAIN QUERY PLAN` : `SCAN` ou `SEARCH`
- Clé étrangère : index à poser soi-même
- Coût d'un index : écritures, taille du fichier
- Dénormalisation : après la mesure, jamais par confort

<br>

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-braces /></template>
Quand le tableau ne suffit plus : le format JSON, ce qu'il apporte et ce qu'il coûte face au relationnel. Puis le lire et le produire avec SQLite.
</Card>

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Où on en est

<Card title="Optimiser" footer="cours 08 · fait">
<template #icon><pixelarticons-zap /></template>
<strong>Des requêtes rapides</strong> · index et plan d'exécution.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Semi-structuré" color="#e92528" footer="cours 09 · ce cours">
<template #icon><pixelarticons-braces /></template>
<strong>Au-delà du tableau</strong> · lire et produire du JSON.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Examen final" footer="janvier-février">
<template #icon><pixelarticons-check /></template>
<strong>Tout le semestre</strong> · sur papier, cours 01 à 09.
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

# Quand le tableau ne suffit plus

---
layout: two-cols
---

::title::
# Donnée semi-structurée

::left::

- Structure portée par la donnée elle-même
- Champs variables d'une fiche à l'autre
- Aucun schéma imposé à l'avance
- Valeurs imbriquées possibles

::right::

```json
{
  "titre": "Germinal",
  "format": "audio",
  "duree_h": 21
}

{
  "titre": "La Peste",
  "format": "numerique",
  "taille_mo": 2
}
```

---
layout: two-cols
class: compact
---

::title::
# Exemple : fiches variables

::left::

### Besoins

> « La bibliothèque prête aussi des livres audio et numériques. L'audio a une durée, le numérique une taille de fichier. D'autres formats viendront. »

### Question

Combien de colonnes ajouter à `livres` ?

::right::

<v-click>

`livres`

| titre | format | duree_h | taille_mo |
|---|---|---|---|
| Germinal | audio | 21 | |
| La Peste | numerique | | 2 |
| Madame Bovary | papier | | |

</v-click>

<v-click>

- Une colonne par champ possible
- Beaucoup de cases vides
- Nouveau format : `ALTER TABLE`

</v-click>

---
layout: section
---

# Format JSON

---
layout: two-cols
---

::title::
# JSON

::left::

- **J**ava**S**cript **O**bject **N**otation : du texte
- Objet `{ }` : paires clé et valeur
- Tableau `[ ]` : liste ordonnée de valeurs
- Clé et texte entre guillemets doubles
- Valeur : texte, nombre, `true`, `false`, `null`, objet, tableau

::right::

```json
{
  "cle_texte": "valeur",
  "cle_nombre": 12.5,
  "cle_booleen": true,
  "cle_vide": null,
  "cle_objet": { "cle": "valeur" },
  "cle_tableau": ["a", "b", "c"]
}
```

---
layout: two-cols
---

::title::
# Exemple : *livres* en JSON

::left::

### Besoins

> « L'application mobile affiche la fiche de *Notre-Dame de Paris* : titre, année, auteur et genres. »

### Question

Quel document JSON ?

::right::

<v-click>

```json
{
  "titre": "Notre-Dame de Paris",
  "annee": 1831,
  "auteur": {
    "nom": "Victor Hugo",
    "date_naissance": "1802-02-26"
  },
  "genres": ["roman", "historique"]
}
```

</v-click>

<v-click>

- Relation 1:N : objet imbriqué
- Relation N:M : tableau
- Une fiche, un document, aucune jointure

</v-click>

---
layout: two-cols
---

::title::
# Erreurs de syntaxe

::left::

### À éviter

```json
{
  titre: 'Germinal',
  "annee": 1885,
}
```

- Clé sans guillemets
- Apostrophes autour du texte
- Virgule après la dernière valeur

::right::

### À faire

```json
{
  "titre": "Germinal",
  "annee": 1885
}
```

- Guillemets doubles partout
- Virgule entre les valeurs seulement
- `json_valid(texte)` : `1` si valide, sinon `0`

---
layout: section
---

# Modèle relationnel et JSON

---
layout: default
---

# Modèle relationnel et JSON

| | Modèle relationnel | Document JSON |
|---|---|---|
| Structure | Fixée par le schéma | Libre, propre à chaque document |
| Relations | Clés étrangères et jointures | Imbrication dans le document |
| Contraintes | Vérifiées par le SGBD | À la charge de l'application |
| Redondance | Évitée par la normalisation | Fréquente |
| Lecture d'une fiche | Plusieurs tables à relier | Un seul document |
| Indicateurs | `GROUP BY` sur toute la table | Chaque document à ouvrir |

---
layout: two-cols
---

::title::
# Imbrication et référence

::left::

### À éviter

```json
{ "titre": "L'Assommoir",
  "auteur": { "nom": "Émile Zola" } }

{ "titre": "Germinal",
  "auteur": { "nom": "E. Zola" } }
```

- Auteur copié dans chaque livre
- Deux orthographes : l'anomalie du cours 03

::right::

### À faire

```json
{ "titre": "L'Assommoir",
  "auteur_id": 5 }

{ "titre": "Germinal",
  "auteur_id": 5 }
```

- Une référence, un seul nom à corriger
- Prix : lecture en deux temps

---
layout: grid
cols: 3
align: stretch
content: center
---

# Choix d'un format

<Card title="Relationnel" color="#16a34a">
<template #icon><pixelarticons-database /></template>
Données liées, contraintes, indicateurs. <strong>Le choix par défaut</strong>.
</Card>
<Card title="JSON en échange" color="#16a34a">
<template #icon><pixelarticons-arrow-right /></template>
Envoi vers une application, export, configuration. <strong>Le bon usage</strong>.
</Card>
<Card title="Colonne JSON" color="#d97706">
<template #icon><pixelarticons-braces /></template>
Champs variables, rarement filtrés, dans une table. <strong>À réserver à ce cas</strong>.
</Card>

---
layout: section
---

# Lire du JSON avec SQLite

---
layout: two-cols
---

::title::
# Colonne JSON

::left::

- Type `TEXT` : SQLite stocke le texte
- `CHECK (json_valid(...))` : refuse un JSON invalide
- `->>` : extrait une valeur
- `$.cle` : chemin de la clé
- `$.cle[0]` : premier élément d'un tableau

::right::

```sql
ALTER TABLE nom_table
  ADD COLUMN colonne TEXT
  CHECK (json_valid(colonne));

SELECT colonne ->> '$.cle'
FROM nom_table;

SELECT colonne ->> '$.cle[0]'
FROM nom_table;
```

---
layout: two-cols
---

::title::
# Exemple : colonne *details*

::left::

### Besoins

> « La bibliothèque prête aussi des livres audio et numériques. L'audio a une durée, le numérique une taille de fichier. D'autres formats viendront. On cherche les livres audio. »

### Question

Quelle colonne, quelle requête ?

::right::

<v-click>

```sql
ALTER TABLE livres
  ADD COLUMN details TEXT
  CHECK (json_valid(details));

UPDATE livres
SET details =
  '{"format": "audio", "duree_h": 21}'
WHERE id = 13;

SELECT titre,
       details ->> '$.duree_h' AS duree
FROM livres
WHERE details ->> '$.format' = 'audio';
```

</v-click>

<v-click>

- Une seule colonne pour tous les formats
- Nouveau format : aucun `ALTER TABLE`

</v-click>

---
layout: two-cols
---

::title::
# Coût d'une colonne JSON

::left::

- Plan : `SCAN`, parcours complet
- Aucune `FK`, aucun `NOT NULL` dans le document
- Clé mal orthographiée : aucune erreur, résultat vide
- Champ souvent filtré : une vraie colonne

::right::

```sql
EXPLAIN QUERY PLAN
SELECT titre
FROM livres
WHERE details ->> '$.format' = 'audio';
-- SCAN livres

SELECT titre
FROM livres
WHERE details ->> '$.fromat' = 'audio';
-- Aucune ligne, aucune erreur
```

---
layout: section
---

# Produire du JSON avec SQLite

---
layout: two-cols
---

::title::
# Fonctions JSON

::left::

- `json_object` : clé, valeur, clé, valeur
- `json_group_array` : agrège les lignes en tableau
- `json_group_array` : avec `GROUP BY`
- Résultat : du texte JSON

::right::

```sql
SELECT json_object(
  'cle_1', colonne_1,
  'cle_2', colonne_2
)
FROM nom_table;

SELECT json_group_array(colonne)
FROM nom_table
GROUP BY autre_colonne;
```

---
layout: two-cols
---

::title::
# Exemple : fiche *livres*

::left::

### Besoins

> « L'application mobile reçoit chaque livre avec son année et le nom de son auteur·rice. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT json_object(
  'titre', l.titre,
  'annee', l.annee,
  'auteur', a.nom
) AS fiche
FROM livres AS l
INNER JOIN auteurs AS a
  ON l.auteur_id = a.id
WHERE l.id = 1;
```

</v-click>

<v-click>

- Jointure d'abord, comme au cours 06
- Une ligne, un objet
- `{"titre":"Notre-Dame de Paris","annee":1831,...}`

</v-click>

---
layout: two-cols
---

::title::
# Exemple : fiche *auteurs*

::left::

### Besoins

> « Sur la fiche d'un·e auteur·rice, l'application affiche la liste de ses livres. »

### Question

Quelle requête, pour un seul document ?

::right::

<v-click>

```sql
SELECT json_object(
  'auteur', a.nom,
  'livres', json_group_array(l.titre)
) AS fiche
FROM auteurs AS a
INNER JOIN livres AS l
  ON l.auteur_id = a.id
WHERE a.id = 5
GROUP BY a.id, a.nom;
```

</v-click>

<v-click>

- `GROUP BY` : une ligne par auteur·rice
- Tableau imbriqué dans l'objet
- `"livres":["L'Assommoir","Au Bonheur des Dames","Germinal"]`

</v-click>

---
layout: two-cols
---

::title::
# Export d'un fichier

::left::

- `.mode json` : résultat au format JSON
- `.once` : prochain résultat écrit dans un fichier
- Colonnes du `SELECT` : clés du document
- `.mode list` : retour à l'affichage par défaut

::right::

```bash
sqlite> .mode json
sqlite> .once catalogue.json
sqlite> SELECT titre, annee
   ...> FROM livres
   ...> WHERE auteur_id = 5;
```

```json
[{"titre":"L'Assommoir","annee":1877},
{"titre":"Au Bonheur des Dames","annee":1883},
{"titre":"Germinal","annee":1885}]
```

---
layout: default
---

# Résumé

| Outil | Usage |
|---|---|
| Objet `{ }`, tableau `[ ]` | Structure d'un document JSON |
| `json_valid` | Contrôle de la syntaxe |
| `->>` et `$.cle` | Lecture d'une valeur |
| `json_object` | Une ligne, un objet |
| `json_group_array` | Plusieurs lignes, un tableau |
| `.mode json`, `.once` | Export dans un fichier |

---
layout: two-cols
---

::title::
# Examen final

::left::

- 50 % de la note
- Janvier-février
- Format papier
- Questions ouvertes et QCM

::right::

### Matière

- Modélisation : cours 01 à 04
- SQL : cours 05 à 07
- Optimisation : cours 08
- JSON : cours 09

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# TP · Semaine 9

::left::

1. Ouvrir `musee.db` dans l'environnement de TP

2. Écrire `musee-json.sql` : une requête commentée par question

3. Produire les fiches avec `json_object` et `json_group_array`

4. Exporter `catalogue.json` pour l'application mobile

5. Noter ce que chaque forme facilite et complique

::right::

```sql
-- Fiche d'une œuvre
SELECT json_object(
  'titre', o.titre,
  'artiste', a.nom
) AS fiche
FROM oeuvres AS o
INNER JOIN artistes AS a
  ON o.artiste_id = a.id
WHERE o.id = 6;
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

1. Écrire à la main la fiche JSON d'une œuvre

2. Vérifier ce document avec `json_valid`

3. Fiche d'une œuvre : titre, année, artiste, technique

4. Fiche d'une œuvre sans technique : valeur obtenue

5. Fiche d'une exposition avec la liste de ses œuvres

::right::

6. Exporter le catalogue dans `catalogue.json`

7. Ajouter une colonne `details` à `oeuvres`, contrôlée par `json_valid`

8. Remplir `details` pour deux œuvres de formats différents

9. Lire une clé de `details`, regarder le plan

10. Relationnel ou JSON : quelles données du musée, et pourquoi
