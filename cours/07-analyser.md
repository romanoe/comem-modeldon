---
theme: pixel
number: "07"
title: "Analyser les données"
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

- `INNER JOIN` : lignes présentes des deux côtés
- `LEFT JOIN`, `RIGHT JOIN`, `FULL OUTER JOIN` : lignes sans correspondance
- Alias de table et plusieurs jointures
- Sous-requêtes, `IN` et `NOT IN`
- CTE : `WITH`, requêtes intermédiaires nommées

<br>

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-chart /></template>
Résumer les lignes en indicateurs : <code>COUNT</code>, <code>SUM</code>, <code>AVG</code>, <code>GROUP BY</code>, <code>HAVING</code>. Puis enregistrer les plus utiles en vues.
</Card>

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Où on en est

<Card title="Connecter" footer="cours 06 · fait">
<template #icon><pixelarticons-git-merge /></template>
<strong>Plusieurs tables</strong> · les recoller par leurs clés étrangères.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Analyser" color="#e92528" footer="cours 07 · ce cours">
<template #icon><pixelarticons-chart /></template>
<strong>Des indicateurs</strong> · compter, sommer, regrouper les lignes.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Optimiser" footer="cours 08 · Indexer et optimiser">
<template #icon><pixelarticons-zap /></template>
<strong>Des requêtes rapides</strong> · index et plan d'exécution.
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

# De la donnée brute aux indicateurs

---
layout: two-cols
class: compact split
---

::title::
# Indicateur

::left::

### Besoins

> « Combien de livres sortent ? Combien ne sont pas revenus ? »

- Une valeur qui résume plusieurs lignes
- Calculé au moment de la question
- Jamais stocké : attribut dérivé, cours 02

::right::

### Calcul

`emprunts`

| livre_id | rendu |
|---|---|
| 1 | 1 |
| 6 | 1 |
| 18 | 0 |
| 9 | 1 |
| 10 | 1 |
| 8 | 0 |

`indicateurs`

| emprunts | non_rendus |
|---|---|
| 6 | 2 |

---
layout: section
---

# Fonctions d'agrégation

---
layout: two-cols
---

::title::
# Fonctions d'agrégation

::left::

- Plusieurs lignes, une seule valeur
- `COUNT` : nombre de lignes
- `SUM`, `AVG` : somme, moyenne
- `MIN`, `MAX` : plus petite, plus grande valeur
- `ROUND(valeur, n)` : arrondi à `n` décimales

::right::

```sql
SELECT COUNT(*),
       SUM(colonne),
       AVG(colonne),
       MIN(colonne),
       MAX(colonne)
FROM nom_table
WHERE condition;
```

---
layout: two-cols
---

::title::
# Exemple : *livres*

::left::

### Besoins

> « Pour le rapport annuel : le nombre de livres, le total des pages, et le livre le plus long. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT COUNT(*) AS nb_livres,
       SUM(nb_pages) AS total_pages,
       MAX(nb_pages) AS plus_long
FROM livres;
```

</v-click>

<v-click>

- Une seule ligne de résultat
- 22 livres, 9380 pages, 1900 au maximum
- `AS` : nomme la colonne calculée

</v-click>

---
layout: two-cols
---

::title::
# Exemple : *livres* en moyenne

::left::

### Besoins

> « Combien de pages compte un livre, en moyenne ? Un nombre rond suffit. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT ROUND(AVG(nb_pages), 0) AS moyenne
FROM livres;
```

</v-click>

<v-click>

- *Les Années* : `nb_pages` vide
- `NULL` ignoré : 21 livres comptés
- Résultat : 447 pages

</v-click>

---
layout: two-cols
---

::title::
# Variantes de COUNT

::left::

- `COUNT(*)` : toutes les lignes
- `COUNT(colonne)` : valeurs non vides
- `COUNT(DISTINCT colonne)` : valeurs différentes

::right::

```sql
SELECT COUNT(*),
       COUNT(colonne),
       COUNT(DISTINCT colonne)
FROM nom_table;
```

---
layout: two-cols
---

::title::
# Exemple : *lecteurs*

::left::

### Besoins

> « Combien de lecteur·rice·s sont inscrit·e·s, et combien nous ont laissé un téléphone ? »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT COUNT(*) AS inscrits,
       COUNT(telephone) AS avec_telephone
FROM lecteurs;
```

</v-click>

<v-click>

- `COUNT(*)` : 10 personnes
- `COUNT(telephone)` : 6, les `NULL` exclus

</v-click>

---
layout: two-cols
---

::title::
# Exemple : *emprunts*

::left::

### Besoins

> « Combien d'emprunts ce trimestre, et par combien de personnes différentes ? »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT
  COUNT(*) AS emprunts,
  COUNT(DISTINCT lecteur_id) AS personnes
FROM emprunts;
```

</v-click>

<v-click>

- 22 emprunts, 9 personnes
- Une personne comptée une seule fois
- Golay : aucun emprunt

</v-click>

---
layout: section
---

# Regroupement

---
layout: two-cols-bottom
class: compact
---

::title::
# GROUP BY

::left::

- Une ligne par valeur de la colonne
- Agrégat calculé dans chaque groupe
- `SELECT` : colonnes du `GROUP BY`, ou agrégats
- Plusieurs colonnes : séparées par une virgule

::right::

```sql
SELECT colonne, COUNT(*)
FROM nom_table
GROUP BY colonne;
```

::bottom::

`emprunts`

| <span class="groupe-a">lecteur_id</span> | livre_id |
|---|---|
| <span class="groupe-a">1</span> | 1 |
| <span class="groupe-a">1</span> | 6 |
| <span class="groupe-a">1</span> | 18 |
| <span class="groupe-b">3</span> | 15 |
| <span class="groupe-b">3</span> | 14 |

<pixelarticons-arrow-right class="fleche text-3xl" />

`GROUP BY lecteur_id`

| lecteur_id | COUNT(*) |
|---|---|
| <span class="groupe-a">1</span> | 3 |
| <span class="groupe-b">3</span> | 2 |

<style>
.groupe-a { color: #e92528; font-weight: 700; }
.groupe-b { color: #6b7280; font-weight: 700; }
:deep(.slide-cell:last-child) {
  display: grid;
  grid-template-columns: 1fr auto 1fr;
  column-gap: 2rem;
  align-items: start;
}
p { grid-row: 1; }
table { grid-row: 2; }
.fleche { grid-column: 2; grid-row: 2; align-self: center; }
p:nth-of-type(2), table:nth-of-type(2) { grid-column: 3; }
</style>

---
layout: two-cols
---

::title::
# Exemple : *emprunts* par personne

::left::

### Besoins

> « Qui sont nos plus grand·e·s lecteur·rice·s ? On veut le nombre d'emprunts de chaque personne, du plus grand au plus petit. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT lec.nom, COUNT(*) AS nb_emprunts
FROM emprunts AS e
INNER JOIN lecteurs AS lec
  ON e.lecteur_id = lec.id
GROUP BY lec.id, lec.nom
ORDER BY nb_emprunts DESC;
```

</v-click>

<v-click>

- Jointure d'abord, regroupement ensuite
- `lec.id` : deux homonymes restent séparés
- Cinq personnes à trois emprunts

</v-click>

---
layout: two-cols
---

::title::
# Exemple : *livres* par auteur·rice

::left::

### Besoins

> « Combien de livres possède-t-on de chaque auteur·rice ? »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT a.nom, COUNT(*) AS nb_livres
FROM livres AS l
INNER JOIN auteurs AS a
  ON l.auteur_id = a.id
GROUP BY a.id, a.nom;
```

</v-click>

<v-click>

- `nb_livres` : l'attribut dérivé du cours 02
- Calculé à la question, jamais faux
- 10 auteur·rice·s, Hugo, Verne et Zola à trois

</v-click>

---
layout: two-cols
---

::title::
# Oubli de GROUP BY

::left::

### À éviter

```sql
SELECT auteur_id, COUNT(*)
FROM livres;
```

- Une seule ligne : 22
- `auteur_id` : une valeur au hasard
- Aucune erreur dans SQLite

::right::

### À faire

```sql
SELECT auteur_id, COUNT(*)
FROM livres
GROUP BY auteur_id;
```

- Une ligne par auteur·rice
- Somme des comptes : 22
- Colonne non agrégée : dans le `GROUP BY`

---
layout: two-cols
---

::title::
# COUNT et LEFT JOIN

::left::

### À éviter

```sql
SELECT a.nom, COUNT(*) AS nb_livres
FROM auteurs AS a
LEFT JOIN livres AS l
  ON l.auteur_id = a.id
GROUP BY a.id, a.nom;
```

- Nicolas Bouvier : 1 livre
- `COUNT(*)` compte la ligne remplie de `NULL`

::right::

### À faire

```sql
SELECT a.nom, COUNT(l.id) AS nb_livres
FROM auteurs AS a
LEFT JOIN livres AS l
  ON l.auteur_id = a.id
GROUP BY a.id, a.nom;
```

- Nicolas Bouvier : 0 livre
- `COUNT(l.id)` ignore le `NULL`

---
layout: two-cols
---

::title::
# HAVING

::left::

- Filtre les groupes, après le calcul
- Condition sur un agrégat
- `WHERE` : filtre les lignes, avant
- Toujours après `GROUP BY`

::right::

```sql
SELECT colonne, COUNT(*)
FROM nom_table
GROUP BY colonne
HAVING COUNT(*) >= n;
```

---
layout: two-cols
---

::title::
# Exemple : *genres*

::left::

### Besoins

> « Quels genres comptent au moins trois livres ? Ils auront chacun leur présentoir. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT g.nom, COUNT(*) AS nb_livres
FROM livres_genres AS lg
INNER JOIN genres AS g
  ON lg.genre_id = g.id
GROUP BY g.id, g.nom
HAVING COUNT(*) >= 3;
```

</v-click>

<v-click>

- Table de liaison : un genre par ligne
- Résultat : roman, historique, aventure

</v-click>

---
layout: two-cols
---

::title::
# WHERE et HAVING

::left::

### À éviter

```sql
SELECT g.nom, COUNT(*)
FROM livres_genres AS lg
INNER JOIN genres AS g
  ON lg.genre_id = g.id
WHERE COUNT(*) >= 3
GROUP BY g.id, g.nom;
```

- `WHERE` : avant tout regroupement
- Erreur : `misuse of aggregate`

::right::

### À faire

```sql
SELECT g.nom, COUNT(*)
FROM livres_genres AS lg
INNER JOIN genres AS g
  ON lg.genre_id = g.id
GROUP BY g.id, g.nom
HAVING COUNT(*) >= 3;
```

- `HAVING` : une fois les groupes calculés
- Trois genres

---
layout: two-cols
---

::title::
# Ordre des clauses

::left::

- Ordre d'écriture imposé
- `WHERE` : avant le regroupement
- `HAVING` : après le regroupement
- Clause absente : on la saute

::right::

```sql
SELECT colonnes
FROM table_a
INNER JOIN table_b
  ON condition
WHERE condition
GROUP BY colonnes
HAVING condition
ORDER BY colonnes
LIMIT n;
```

---
layout: two-cols
---

::title::
# Exemple : *emprunts* rendus

::left::

### Besoins

> « Qui a déjà rendu au moins deux livres ? On leur offre une carte de fidélité. »

### Question

Quelle requête ?

::right::

<v-click>

```sql
SELECT lec.nom, COUNT(*) AS nb_rendus
FROM emprunts AS e
INNER JOIN lecteurs AS lec
  ON e.lecteur_id = lec.id
WHERE e.rendu = 1
GROUP BY lec.id, lec.nom
HAVING COUNT(*) >= 2;
```

</v-click>

<v-click>

- `WHERE` : garde les emprunts rendus
- `HAVING` : garde les personnes à deux ou plus
- Résultat : cinq personnes

</v-click>

---
layout: section
---

# Vues

---
layout: two-cols
---

::title::
# Vue

::left::

- Requête enregistrée dans la base, sous un nom
- Se lit comme une table
- Aucune donnée copiée
- Recalculée à chaque lecture
- `DROP VIEW` : supprime la requête, pas les données

::right::

```sql
CREATE VIEW nom_vue AS
SELECT colonne, COUNT(*) AS nb
FROM nom_table
GROUP BY colonne;

SELECT *
FROM nom_vue;

DROP VIEW IF EXISTS nom_vue;
```

---
layout: two-cols
---

::title::
# Exemple : vue *emprunts_par_lecteur*

::left::

### Besoins

> « Chaque matin, l'accueil consulte le nombre d'emprunts de chaque personne, sans réécrire la requête. »

### Question

Quelle vue, puis quelle lecture ?

::right::

<v-click>

```sql
CREATE VIEW emprunts_par_lecteur AS
SELECT lec.nom, COUNT(*) AS nb_emprunts
FROM emprunts AS e
INNER JOIN lecteurs AS lec
  ON e.lecteur_id = lec.id
GROUP BY lec.id, lec.nom;

SELECT *
FROM emprunts_par_lecteur
WHERE nb_emprunts >= 3;
```

</v-click>

<v-click>

- Écrite une fois, lue chaque matin
- Nouvel emprunt : vue à jour
- Résultat : cinq personnes

</v-click>

---
layout: two-cols
---

::title::
# Vue et table

::left::

### À éviter

```sql
CREATE TABLE stats_emprunts AS
SELECT lecteur_id, COUNT(*) AS nb
FROM emprunts
GROUP BY lecteur_id;
```

- Copie figée des résultats
- Prochain emprunt : chiffres faux
- Attribut dérivé stocké

::right::

### À faire

```sql
CREATE VIEW stats_emprunts AS
SELECT lecteur_id, COUNT(*) AS nb
FROM emprunts
GROUP BY lecteur_id;
```

- Seule la requête est enregistrée
- Chiffres recalculés à chaque lecture
- Toujours à jour

---
layout: default
---

# Vue et CTE

| | CTE | Vue |
|---|---|---|
| Écriture | `WITH` | `CREATE VIEW` |
| Durée de vie | Une requête | Enregistrée dans la base |
| Réutilisation | Dans sa requête seulement | Par toutes les requêtes |
| Usage | Étape intermédiaire | Indicateur consulté souvent |

---
layout: default
---

# Résumé

| Outil | Usage |
|---|---|
| `COUNT`, `SUM`, `AVG`, `MIN`, `MAX` | Plusieurs lignes, une valeur |
| `COUNT(colonne)`, `COUNT(DISTINCT colonne)` | Valeurs non vides, valeurs différentes |
| `GROUP BY` | Une ligne par groupe |
| `WHERE` | Filtre les lignes, avant le regroupement |
| `HAVING` | Filtre les groupes, après le regroupement |
| `CREATE VIEW` | Requête enregistrée, toujours à jour |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: tp
---

::title::
# TP · Semaine 7

::left::

1. Ouvrir `musee.db` dans l'environnement de TP

2. Écrire `musee-indicateurs.sql`, avec `PRAGMA foreign_keys = ON;` en tête

3. Une requête commentée par question

4. Vérifier un total à la main sur quelques lignes

5. Enregistrer les deux indicateurs les plus utiles en vues

::right::

```sql
-- Billets vendus par exposition
SELECT e.titre, COUNT(*) AS nb_billets
FROM billets AS b
INNER JOIN expositions AS e
  ON b.exposition_id = e.id
GROUP BY e.id, e.titre;
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

1. Nombre total d'œuvres, puis d'œuvres exposées

2. Nombre d'œuvres par statut

3. Nombre d'œuvres par artiste, du plus grand au plus petit

4. Artistes ayant au moins deux œuvres

5. Prix moyen d'un billet, arrondi à deux décimales

::right::

6. Chiffre d'affaires par exposition, billets sans tarif compris

7. Fréquentation par salle, Atelier compris

8. Total des financements, payés et non payés

9. Nombre de financements sans montant connu

10. Vue `chiffre_affaires`, puis la lire triée
