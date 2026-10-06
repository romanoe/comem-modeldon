---
theme: pixel
number: "04"
title: "Modèle Physique de Données (MPD)"
subtitle: "Modélisation de Données"
author: "Noemi Romano"
email: "noemi.romano@heig-vd.ch"
github: "https://github.com/romanoe/comem-modeldon"
breadcrumb: "Modélisation de Données"
logos:
  - /images/logo-heig-vd.png
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

- Entité en table, identifiant en clé primaire `PK`
- Relation 1:N : `FK` dans la table du côté `0..*`
- Relation N:M : table de liaison, clé primaire composite
- Normalisation : 1NF, 2NF, 3NF
- Champs à texte libre : la table de référence

<br>

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-database /></template>
Traduire le modèle logique en <code>CREATE TABLE</code> : types SQLite, contraintes, clés étrangères, modes de suppression.
</Card>

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Où on en est

<Card title="Conceptuel" footer="cours 02 · fait">
<template #icon><pixelarticons-lightbulb /></template>
<strong>MCD</strong> · ce que dit le métier : entités, attributs, relations.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Logique" footer="cours 03 · fait">
<template #icon><pixelarticons-layout /></template>
<strong>MLD</strong> · la traduction en tables, avec clés étrangères, vérifiée par la normalisation.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Physique" color="#e92528" footer="cours 04 · ce cours">
<template #icon><pixelarticons-database /></template>
<strong>MPD</strong> · l'implémentation dans un SGBD précis : types SQLite, contraintes, clés étrangères.
</Card>

---
layout: section
---

# Modèle physique

---
layout: two-cols
---

::title::
# Modèle physique

::left::

- Implémente le modèle **logique** dans un SGBD précis
- S'écrit en SQL : un `CREATE TABLE` par table
- Types et contraintes propres au SGBD
- Un script `.sql` rejouable à volonté

::right::

### Traduction

| Logique | Physique |
|---|---|
| Table | `CREATE TABLE` |
| Colonne et type | Colonne et type SQLite |
| `PK` | `PRIMARY KEY` |
| `NOT NULL`, `UNIQUE` | `NOT NULL`, `UNIQUE` |
| `FK` | `REFERENCES` |

---
layout: grid
cols: 1
content: center
---

# MLD de la bibliothèque

<Figure
  class="w-1/3 mx-auto framed"
  src="/images/03/mld-complet.svg"
  alt="Le MLD complet de la bibliothèque"
  caption="MLD · cours 03"
/>

---
layout: section
---

# Types SQLite

---
layout: grid
cols: 4
align: stretch
content: center
---

# Types SQLite

<Card title="Entier">
<template #icon><pixelarticons-hash /></template>
<code>INTEGER</code> · identifiants, années, quantités.
</Card>
<Card title="Réel">
<template #icon><pixelarticons-calculator /></template>
<code>REAL</code> · mesures, moyennes, nombres à virgule.
</Card>
<Card title="Texte">
<template #icon><pixelarticons-text-align-left /></template>
<code>TEXT</code> · titres, noms, e-mails, dates.
</Card>
<Card title="Binaire">
<template #icon><pixelarticons-file /></template>
<code>BLOB</code> · fichiers bruts, rarement utilisé.
</Card>

---
layout: default
class: compact
---

# Du type logique au type SQLite

| Type logique | Type SQLite | Valeur |
|---|---|---|
| `INTEGER` | `INTEGER` | `1885` |
| `DECIMAL` | `REAL` | `12.50` |
| `VARCHAR` | `TEXT` | `'Germinal'` |
| `DATE` | `TEXT`, format `AAAA-MM-JJ` | `'1840-04-02'` |
| `BOOLEAN` | `INTEGER`, `0` ou `1` | `1` |

<Card color="#d97706" tag="warning" title="Typage souple">
<template #icon><pixelarticons-alert /></template>
SQLite accepte du texte dans une colonne <code>INTEGER</code>. Le type annonce l'intention, les contraintes la font respecter.
</Card>

---
layout: section
---

# CREATE TABLE

---
layout: two-cols
---

::title::
# CREATE TABLE

::left::

- Une instruction par table
- Une ligne par colonne : nom, type, contraintes
- Virgule entre les colonnes
- Point-virgule à la fin

::right::

```sql
CREATE TABLE nom_table (
  colonne_1 TYPE CONTRAINTES,
  colonne_2 TYPE CONTRAINTES,
  colonne_3 TYPE CONTRAINTES
);
```

---
layout: two-cols
---

::title::
# Exemple : *auteurs*

::left::

### Besoins

> « Pour chaque auteur·rice, on note son nom, sa date de naissance et, le cas échéant, sa date de décès. »

### La question

Quel `CREATE TABLE` pour cette table ?

::right::

<v-click>

```sql
CREATE TABLE auteurs (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  date_naissance TEXT,
  date_deces TEXT
);
```

</v-click>

<v-click>

- `INTEGER PRIMARY KEY` : numéro attribué automatiquement
- `DATE` devient `TEXT`
- `date_deces` sans contrainte : vide permis

</v-click>

---
layout: two-cols
---

::title::
# Contraintes de colonne

::left::

- `PRIMARY KEY` : identifiant de la ligne
- `NOT NULL` : valeur obligatoire
- `UNIQUE` : aucun doublon dans la colonne
- `DEFAULT` : valeur posée si rien n'est saisi
- `CHECK` : condition à respecter

::right::

```sql
CREATE TABLE nom_table (
  id INTEGER PRIMARY KEY,
  colonne_1 TYPE NOT NULL,
  colonne_2 TYPE UNIQUE,
  colonne_3 TYPE DEFAULT valeur,
  colonne_4 TYPE CHECK (condition)
);
```

---
layout: two-cols
---

::title::
# Exemple : *lecteurs*

::left::

### Besoins

> « Chaque lecteur·rice donne son nom, son prénom et son adresse e-mail. Deux personnes ne partagent jamais la même adresse. Le téléphone est facultatif. »

### La question

Quelles contraintes sur chaque colonne ?

::right::

<v-click>

```sql
CREATE TABLE lecteurs (
  id INTEGER PRIMARY KEY,
  nom TEXT NOT NULL,
  prenom TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  telephone TEXT
);
```

</v-click>

<v-click>

- `email` cumule deux contraintes
- `telephone` sans contrainte : facultatif

</v-click>

---
layout: section
---

# Intégrité référentielle

---
layout: two-cols
class: compact
---

::title::
# Intégrité référentielle

- Toute clé étrangère pointe vers une ligne existante, ou reste vide

::left::

- Le SGBD refuse une ligne orpheline
- Il refuse aussi de supprimer un parent référencé
- Garantie posée une fois, dans le schéma

::right::

### Exemple

`auteurs`

| id | nom |
|---|---|
| 3 | Zola |
| 5 | Sagan |

`livres`

| id | titre | auteur_id |
|---|---|---|
| 1 | Germinal | 3 |
| 2 | Cosmos | 9 |

- `auteur_id` 9 : aucun auteur, livre orphelin

---
layout: two-cols
---

::title::
# Clé étrangère en SQL

::left::

- `REFERENCES table(colonne)` après le type
- Pointe vers la clé primaire du parent
- `NOT NULL` si le bout parent vaut `1`
- Le parent se crée avant l'enfant
- SQLite : contrôle à activer à chaque connexion

::right::

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE enfant (
  id INTEGER PRIMARY KEY,
  parent_id INTEGER NOT NULL
    REFERENCES parent(id)
);
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « Un livre a toujours un·e auteur·rice. Un livre neuf n'est pas encore rangé. Le nombre de pages est positif. »

### La question

Quelles contraintes sur `auteur_id`, `rayon_id` et `nb_pages` ?

::right::

<v-click>

```sql
CREATE TABLE livres (
  id INTEGER PRIMARY KEY,
  titre TEXT NOT NULL,
  annee INTEGER,
  nb_pages INTEGER CHECK (nb_pages > 0),
  auteur_id INTEGER NOT NULL
    REFERENCES auteurs(id),
  rayon_id INTEGER
    REFERENCES rayons(id)
);
```

</v-click>

<v-click>

- `auteur_id` : bout `1`, donc `NOT NULL`
- `rayon_id` : bout `0..1`, vide permis
- `auteurs` et `rayons` créées avant `livres`

</v-click>

---
layout: section
---

# Modes de suppression

---
layout: two-cols
---

::title::
# Modes de suppression

::left::

- `RESTRICT` : suppression du parent refusée
- `CASCADE` : enfants supprimés avec le parent
- `SET NULL` : clé étrangère des enfants vidée
- Sans clause : refus, comme `RESTRICT`

::right::

```sql
CREATE TABLE enfant (
  id INTEGER PRIMARY KEY,
  parent_id INTEGER
    REFERENCES parent(id)
    ON DELETE CASCADE
);
```

---
layout: two-cols
---

::title::
# Exemple : suppression dans *livres*

::left::

### Besoins

> « Un rayon démonté libère ses livres, qui attendent un nouveau rangement. Un·e auteur·rice qui a encore des livres au catalogue ne peut pas être supprimé·e. »

### La question

Quel mode pour `rayon_id`, lequel pour `auteur_id` ?

::right::

<v-click>

```sql
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
```

</v-click>

<v-click>

- `SET NULL` exige une colonne sans `NOT NULL`
- `RESTRICT` protège le catalogue

</v-click>

---
layout: section
---

# Table de liaison

---
layout: two-cols
---

::title::
# Clé primaire composite

::left::

- Clé formée de plusieurs colonnes
- Déclarée après la liste des colonnes
- Le couple ne se répète pas
- Chaque colonne garde sa `REFERENCES`
- SQLite : `NOT NULL` explicite sur chaque colonne

::right::

```sql
CREATE TABLE liaison (
  a_id INTEGER NOT NULL
    REFERENCES a(id),
  b_id INTEGER NOT NULL
    REFERENCES b(id),
  PRIMARY KEY (a_id, b_id)
);
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts*

::left::

### Besoins

> « On note la date de chaque emprunt et si le livre est rendu. Un·e lecteur·rice qui se désinscrit disparaît avec ses emprunts. »

### La question

Quelle clé, quels modes de suppression ?

::right::

<v-click>

```sql
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
```

</v-click>

<v-click>

- Le couple `livre_id`, `lecteur_id` identifie l'emprunt
- `rendu` : `BOOLEAN` traduit en `0` ou `1`
- Livre emprunté : suppression refusée

</v-click>

---
layout: section
---

# Le modèle physique complet

---
layout: two-cols
---

::title::
# Ordre de création

::left::

- Activer les clés étrangères en premier
- Tables sans clé étrangère d'abord
- Puis les tables qui les référencent
- Tables de liaison en dernier

::right::

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE auteurs (...);
CREATE TABLE rayons (...);
CREATE TABLE lecteurs (...);
CREATE TABLE genre (...);

CREATE TABLE livres (...);

CREATE TABLE emprunts (...);
CREATE TABLE livres_genres (...);
```

---
layout: two-cols
---

::title::
# Terminal SQLite

::left::

- `sqlite3` ouvre la base, ou la crée
- `.read` exécute un script `.sql`
- `.tables` liste les tables
- `.schema` affiche un `CREATE TABLE`
- `.quit` ferme la base

::right::

```bash
sqlite3 bibliotheque.db

sqlite> .read bibliotheque.sql
sqlite> .tables
sqlite> .schema livres
sqlite> .quit
```

---
layout: default
---

# Résumé

| Logique | SQLite |
|---|---|
| Table | `CREATE TABLE` |
| `VARCHAR`, `DATE` | `TEXT` |
| `BOOLEAN` | `INTEGER`, `0` ou `1` |
| `PK` | `PRIMARY KEY` |
| `PK` composite | `PRIMARY KEY (a_id, b_id)` |
| `FK` | `REFERENCES`, plus `ON DELETE` |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
---

::title::
# TP · Semaine 4

::left::

1. Partir du MLD du musée de la semaine 3

2. Écrire `musee.sql` : un `CREATE TABLE` par table

3. Typer chaque colonne, poser les contraintes

4. Choisir un mode de suppression par clé étrangère

5. Exécuter avec `.read`, vérifier avec `.schema`

::right::

<Figure
  class="w-3/4 mx-auto framed"
  src="/images/04/03-mld-musee.svg"
  alt="Le MLD du musée, corrigé du TP de la semaine 3"
  caption="Corrigé · MLD du musée, semaine 3"
/>
