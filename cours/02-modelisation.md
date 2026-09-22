---
theme: pixel
number: "02"
title: "Modèle entité-association"
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
layout: grid
cols: 2
content: center
---

# Le fil rouge : le musée

<Card title="En classe" color="#e92528">
<template #icon><pixelarticons-archive /></template>
Œuvres, artistes, salles, expositions. On construit le modèle ensemble, au tableau.
</Card>
<Card title="En TP">
<template #icon><pixelarticons-edit-box /></template>
Le même musée, dans votre diagramme. Chaque séance y ajoute ce qu'elle vient d'introduire.
</Card>

---
layout: section
---

# L'entité

---
layout: two-cols
---

::title::
# Entité

::left::

- Elle existe dans le métier
- Plusieurs exemplaires, pas un seul
- Des attributs à lui donner

> « On conserve quelques milliers d'**œuvres**, signées par des **artistes**. Elles sont accrochées dans des **salles**, au fil des **expositions**. »

::right::

<v-click>

### Retenues

`oeuvres` · `artistes` · `salles` · `expositions`

### Écartées

`cadre` non décrit · `musee` en exemplaire unique

</v-click>

---
layout: two-cols
---

::title::
# Faux candidats

::left::

* Une entité apparaît dès qu'on veut **décrire** un lien.

* Un accrochage a une date et un emplacement. Il devient une table.

::right::

### Le cas limite


| Candidat | Verdict | Motif |
|---|---|---|
| `musee` | Non | Exemplaire unique |
| `titre` | Non | Attribut |
| `accrochage` | Peut-être | Si daté |

---
layout: grid
cols: 3
content: center
---

# Forte, faible, associative

<Card title="Forte">
<template #icon><pixelarticons-archive /></template>
Identifiant propre. <code>oeuvres</code>, <code>artistes</code>.
</Card>
<Card title="Faible">
<template #icon><pixelarticons-link /></template>
Emprunte la clé de son parent.
</Card>
<Card title="Associative">
<template #icon><pixelarticons-git-branch /></template>
Naît d'une relation, porte ses attributs.
</Card>

---
layout: two-cols
---

::title::
# Voies de découverte

::left::

| Voie | Déclencheur |
|---|---|
| Nom métier | Le domaine a un mot |
| Cardinalité | La relation est N:M |
| Attribut orphelin | Il n'a pas de table |

::right::

### La plus sûre

L'attribut orphelin.

La **date d'accrochage** n'appartient ni à l'œuvre, ni à l'exposition.

---
layout: two-cols
---

::title::
# Exemple : `accrochages`

::left::

### Le besoin

> « Une œuvre peut figurer dans plusieurs expositions. On veut savoir laquelle était accrochée où, et depuis quand. »

### La question

Où ranger la date d'accrochage ?

::right::

<v-click>

| accrochages | |
|---|---|
|  | oeuvre_id INTEGER |
|  | exposition_id INTEGER |
|  | date_accrochage DATE |

</v-click>

<v-click>

- Ni sur l'œuvre, ni sur l'exposition
- Elle décrit la **relation**

</v-click>

---
layout: two-cols
---

::title::
# Liaison contre entité associative

::left::

### Table de liaison

- Deux clés, rien d'autre
- Besoin technique
- `oeuvre_techniques`

### Entité associative

- Porte ses attributs
- Fait du métier
- `accrochages`

::right::

### Le test

Ajoutez une colonne. Le métier a-t-il quoi y mettre ?

- Oui : entité associative
- Non : table technique

### Impact

- Le SQL : rien
- Le nom et la doc : tout

---
layout: two-cols
---

::title::
# L'entité dans le diagramme

::left::

- Une boîte par entité
- Le nom au pluriel, en tête
- Rien d'autre à ce stade

<div class="ref">draw.io · <a href="https://app.diagrams.net/">bibliothèque Entity Relation</a></div>

::right::

| <span style="color: #e92528">oeuvres</span> |
|---|

| <span style="color: #e92528">artistes</span> |
|---|

| <span style="color: #e92528">salles</span> |
|---|

---
layout: section
---

# Les attributs

---
layout: two-cols
---

::title::
# Attribut

::left::

- Il qualifie l'entité
- Une valeur par ligne
- Il porte un type
- L'un d'eux identifie : la clé

::right::

| oeuvres | |
|---|---|
|  | id INTEGER |
|  | titre VARCHAR |
|  | annee INTEGER |
|  | hauteur_cm INTEGER |

---
layout: grid
cols: 2
content: center
---

# Simple, composé, dérivé, multivalué

<Card title="Simple">
<template #icon><pixelarticons-label /></template>
Une valeur, une colonne.
</Card>
<Card title="Composé">
<template #icon><pixelarticons-scissors /></template>
Se décompose en colonnes.
</Card>
<Card title="Dérivé">
<template #icon><pixelarticons-calculator /></template>
Se calcule, ne se stocke pas.
</Card>
<Card title="Multivalué">
<template #icon><pixelarticons-list /></template>
Devient une table.
</Card>

---
layout: two-cols
---

::title::
# Types et usages

::left::

| Type | Valeur | Permet |
|---|---|---|
| `VARCHAR` | `'Matinale'` | Tri alphabétique |
| `INTEGER` | `52` | Somme, moyenne |
| `DECIMAL` | `24.5` | Calcul exact |
| `DATE` | `'2019-03-14'` | Intervalles |
| `BOOLEAN` | `true` | Filtrage direct |

::right::

### Le test

Qu'est-ce que je voudrai **faire** avec cette colonne ?

<Card color="#6b7280" tag="note" title="Et SQLite ?">
<template #icon><logos-sqlite /></template>
Cinq classes seulement : <code>TEXT</code>, <code>INTEGER</code>, <code>REAL</code>, <code>BLOB</code>, <code>NULL</code>. Traduction au cours 05.
</Card>

---
layout: two-cols
---

::title::
# Attribut composé

::left::

### À éviter

| visiteurs | |
|---|---|
|  | contact VARCHAR |

- Plusieurs valeurs en une
- Recherche par domaine impossible

::right::

### À faire

| visiteurs | |
|---|---|
|  | email VARCHAR |
|  | telephone VARCHAR |

- Chaque composant interrogeable
- Chacun son type et ses contraintes

---
layout: two-cols
---

::title::
# Attribut dérivé

::left::

### À éviter

| expositions | |
|---|---|
|  | titre VARCHAR |
|  | nb_oeuvres INTEGER |

- Faux dès le prochain accrochage
- Cohérence non garantie

::right::

### À faire

```sql
SELECT titre, COUNT(*) AS nb_oeuvres
FROM expositions
JOIN accrochages ON accrochages.exposition_id = expositions.id
GROUP BY titre;
```

- Une seule source : `accrochages`
- Toujours juste

---
layout: two-cols
---

::title::
# Les attributs dans la boîte

::left::

- Une ligne par attribut
- Le nom, puis le type en majuscules
- La colonne de gauche reste vide

<div class="ref">draw.io · <a href="https://app.diagrams.net/">bibliothèque Entity Relation</a></div>

::right::

| oeuvres | |
|---|---|
|  | <span style="color: #e92528">id INTEGER</span> |
|  | <span style="color: #e92528">titre VARCHAR</span> |
|  | <span style="color: #e92528">annee INTEGER</span> |
|  | <span style="color: #e92528">hauteur_cm INTEGER</span> |

---
layout: two-cols
---

::title::
# Exemple : `oeuvres`

::left::

### Le besoin

> « Chaque œuvre a un titre, une année de création, et des dimensions qu'on affiche sur le cartel. »

### La question

Quelles colonnes, et de quel type ?

::right::

<v-click>

| oeuvres | |
|---|---|
|  | titre VARCHAR |
|  | annee INTEGER |
|  | hauteur_cm INTEGER |

</v-click>

<v-click>

- `annee` en `INTEGER` : comparable
- `hauteur_cm` en `INTEGER` : l'unité est dans le nom

</v-click>

---
layout: section
---

# Les contraintes

---
layout: grid
cols: 2
content: center
---

# Clé, obligation, unicité

<Card title="Clé primaire">
<template #icon><pixelarticons-bookmark /></template>
<code>PK</code> · identifie la ligne, jamais vide, jamais répétée.
</Card>
<Card title="Obligatoire">
<template #icon><pixelarticons-alert /></template>
<code>NOT NULL</code> · la valeur est exigée à la saisie.
</Card>
<Card title="Unique">
<template #icon><pixelarticons-check-double /></template>
<code>UNIQUE</code> · deux lignes ne peuvent pas la partager.
</Card>
<Card title="Clé étrangère" footer="cours 03 · Clés et relations">
<template #icon><pixelarticons-link /></template>
<code>FK</code> · renvoie à la clé d'une autre entité.
</Card>

---
layout: two-cols
---

::title::
# Clé primaire

::left::

| Type | Exemple |
|---|---|
| Technique | `id`, entier attribué par la base |
| Naturelle | `code`, valeur du métier |

### Recommandation

- Sans signification métier
- Stable dans le temps

::right::

| oeuvres | |
|---|---|
| PK | id INTEGER |
|  | titre VARCHAR |

---
layout: two-cols
---

::title::
# Clé composite

::left::

- Identité portée par deux colonnes
- Le couple est unique
- Chaque colonne seule se répète
- Deux marques `PK` dans la boîte

::right::

| vitrines | |
|---|---|
| PK | salle_id INTEGER |
| PK | numero INTEGER |
|  | description VARCHAR |

---
layout: two-cols
---

::title::
# La boîte complète

::left::

| Marqueur | Sens |
|---|---|
| `PK` | Clé primaire |
| `FK` | Clé étrangère |
| `NOT NULL` | Jamais vide |
| `UNIQUE` | Non répétable |

<div class="ref">draw.io · <a href="https://app.diagrams.net/">bibliothèque Entity Relation</a></div>

::right::

| oeuvres | |
|---|---|
| <span style="color: #e92528">PK</span> | id INTEGER |
| <span style="color: #e92528">NOT NULL</span> | titre VARCHAR |
|  | annee INTEGER |
| <span style="color: #e92528">NOT NULL</span> | hauteur_cm INTEGER |

---
layout: two-cols
---

::title::
# Exemple : `vitrines`, entité faible

::left::

### Le besoin

> « On dit la vitrine 3 **de** telle salle. Le numéro repart à 1 dans chaque salle. »

### La question

Le numéro seul suffit-il à identifier une vitrine ?

::right::

<v-click>

| vitrines | |
|---|---|
| PK | salle_id INTEGER |
| PK | numero INTEGER |
|  | description VARCHAR |

</v-click>

<v-click>

- Non : deux salles ont une vitrine 3
- La vitrine n'existe pas sans sa salle

</v-click>

---
layout: two-cols
---

::title::
# Coût de l'entité faible

::left::

### Le constat

`vitrines` a une clé en deux colonnes. Toute table qui la référence hérite des deux.

Une table des emplacements aurait donc une clé en **trois** colonnes.

::right::

### Compromis

<v-click>

| vitrines | |
|---|---|
| PK | id INTEGER |
| UNIQUE | salle_id INTEGER |
| UNIQUE | numero INTEGER |

</v-click>

<v-click>

- Identifiant technique pour référencer
- `UNIQUE` conserve la règle métier

</v-click>

---
layout: section
---

# Nommage

---
layout: grid
cols: 2
content: center
---

# Conventions de nommage

<Card title="Pluriel">
<template #icon><pixelarticons-table /></template>
<code>oeuvres</code>, pas <code>oeuvre</code>.
</Card>
<Card title="Minuscules, underscore">
<template #icon><pixelarticons-edit-box /></template>
<code>accroche_le</code>.
</Card>
<Card title="Ni accents ni espaces">
<template #icon><pixelarticons-alert /></template>
<code>duree</code>, pas <code>durée</code>.
</Card>
<Card title="Clé étrangère suffixée">
<template #icon><pixelarticons-link /></template>
<code>oeuvre_id</code>.
</Card>

---
layout: two-cols
---

::title::
# Exemple : dictionnaire de données

::left::

### Le besoin

> « Une œuvre en réserve n'est pas exposée. Et la hauteur, c'est sans le cadre. »

### La question

Qu'est-ce qui mérite une note ?

::right::

<v-click>

| Colonne | Ce qu'il faut préciser |
|---|---|
| `hauteur_cm` | Centimètres, sans le cadre |
| `exposee` | `false` = en réserve |
| `oeuvres` | Une ligne par œuvre de la collection |

</v-click>

<v-click>

- Les unités et conventions
- Le sens de `false`

</v-click>

---
layout: section
---

# Normalisation

---
layout: grid
cols: 3
content: center
---

# Redondance et anomalies

<Card title="Insertion" color="#d97706">
<template #icon><pixelarticons-plus /></template>
Pas d'artiste sans œuvre.
</Card>
<Card title="Modification" color="#d97706">
<template #icon><pixelarticons-edit-box /></template>
Corriger partout, ou diverger.
</Card>
<Card title="Suppression" color="#e92528">
<template #icon><pixelarticons-trash /></template>
La dernière œuvre efface l'artiste.
</Card>

---
layout: two-cols
---

::title::
# Première forme normale

::left::

### La violation

| id | titre | techniques |
|---|---|---|
| 1 | Sans titre | huile, toile |
| 2 | Étude | crayon, papier |

::right::

### La règle

Une seule valeur par case.

- Recherche impossible sans découper
- Fautes de frappe indétectables
- Un attribut multivalué devient une table

<Card color="#6b7280" tag="note" title="La 1NF ne suffit pas" footer="Cours 04 · Normalisation">
<template #icon><pixelarticons-git-branch /></template>
La <strong>2NF</strong> traite les dépendances partielles, la <strong>3NF</strong> les dépendances transitives.
</Card>

---
layout: two-cols
---

::title::
# Exemple : les techniques

::left::

### Le besoin

> « On veut pouvoir lister toutes les œuvres à l'huile, sans se tromper d'orthographe. »

### La question

Une colonne suffit-elle ?

::right::

<v-click>

| techniques | |
|---|---|
| PK | id INTEGER |
| UNIQUE | nom VARCHAR |

| oeuvre_techniques | |
|---|---|
| PK | oeuvre_id INTEGER |
| PK | technique_id INTEGER |

</v-click>

<v-click>

- `UNIQUE` interdit les doublons
- La liste devient une jointure

</v-click>

---
layout: section
---

# Le diagramme complet

---
layout: two-cols
---

::title::
# Ordre de construction

::left::

1. Les entités fortes
2. Les entités faibles
3. Les entités associatives
4. Les relations, cours 03

### Repère

Une entité par boîte, du plus autonome au plus dépendant.

::right::

```mermaid
erDiagram
  oeuvres { integer id PK }
  artistes { integer id PK }
  salles { integer id PK }
  expositions { integer id PK }
  vitrines {
    integer salle_id PK
    integer numero PK
  }
  accrochages {
    integer oeuvre_id PK
    integer exposition_id PK
    date date_accrochage
  }
```

---
layout: grid
cols: 3
content: center
---

# Export du diagramme

<Card title="Aucun compte">
<template #icon><pixelarticons-user /></template>
L'éditeur s'ouvre dans le navigateur : le fichier se garde sur la machine ou dans un drive.
</Card>
<Card title="Image">
<template #icon><pixelarticons-image /></template>
Le diagramme exporté en <code>.png</code> ou <code>.svg</code> : la version qui se relit vite, pour réviser.
</Card>
<Card title="Fichier source">
<template #icon><pixelarticons-file /></template>
Le fichier <code>.drawio</code> de l'éditeur : de quoi rouvrir le diagramme et le compléter.
</Card>

---
layout: grid
cols: 3
content: center
---

# À retenir

<Card title="Le besoin précède le modèle">
<template #icon><pixelarticons-clipboard-note /></template>
On modélise ce que le client dit, pas ce qu'on imagine.
</Card>
<Card title="La boîte se remplit en trois temps">
<template #icon><pixelarticons-layout /></template>
Le nom, les attributs, les contraintes.
</Card>
<Card title="Trois attributs se traduisent">
<template #icon><pixelarticons-scissors /></template>
Colonnes, requête, table.
</Card>

---
layout: two-cols
---

::title::
# Pour la prochaine séance

::left::

### TP · Semaine 2

1. Reprendre la liste de la semaine 1, en tirer les entités fortes
2. Les dessiner dans draw.io, une boîte par entité
3. Remplir les attributs, puis les contraintes
4. Exporter l'image et garder le fichier `.drawio`

::right::

<Card color="#16a34a" tag="tip" title="Pas encore de relations">
<template #icon><pixelarticons-git-branch /></template>
Les liens entre entités sont au cours 03. Pour l'instant, <code>artiste_id</code> est un simple <code>INTEGER</code>.
</Card>

<Card color="#6b7280" tag="note" title="Un diagramme qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance ajoute au même diagramme ce qu'elle vient d'introduire. On ne recommence jamais de zéro.
</Card>
