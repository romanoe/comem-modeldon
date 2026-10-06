---
theme: pixel
number: "02"
title: "Modèle Conceptuel de Données (MCD)"
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

- Donnée, information, connaissance
- Les limites du tableur
- Base de données et SGBD
- Entités, attributs et relations dans un besoin

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-layout /></template>
Le modèle relationnel, puis le diagramme : entités, attributs, types, contraintes, et les relations nommées.
</Card>

---
layout: grid
cols: 2
content: center
---

# Les deux domaines

<Card title="En classe" color="#e92528">
<template #icon><pixelarticons-book-open /></template>
Une <strong>bibliothèque</strong> : livres, auteurs, rayons, lecteur·rice·s, emprunts. Tous les exemples du cours.
</Card>
<Card title="En TP">
<template #icon><pixelarticons-edit-box /></template>
Votre <strong>musée</strong>. Chaque séance y applique, sur votre diagramme, ce qui vient d'être montré sur la bibliothèque.
</Card>

---
layout: section
---

# Modèle relationnel

---
layout: two-cols
---

::title::
# Base de données relationnelle

::left::

- Les données vivent dans des **tables**
- Une ligne par objet, une colonne par information
- Chaque ligne s'identifie par une **clé**
- Les tables se relient par des **valeurs**

::right::

### La table `livres`

| id | titre | annee |
|---|---|---|
| 1 | Germinal | 1885 |
| 2 | La Peste | 1947 |
| 3 | Les Misérables | 1862 |

---
layout: grid
cols: 4fr 1fr 4fr 1fr 4fr
align: stretch
content: center
---

# Abstrait <pixelarticons-arrow-right /> Concret

<Card title="Conceptuel" color="#e92528" footer="cours 02 · ce cours">
<template #icon><pixelarticons-lightbulb /></template>
<strong>MCD</strong> · ce que dit le métier : entités, attributs, relations. 
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Logique" footer="cours 03 · Modèle logique">
<template #icon><pixelarticons-layout /></template>
<strong>MLD</strong> · la traduction en tables, avec clés primaires et clés étrangères.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Physique" footer="cours 04 · Modèle physique">
<template #icon><pixelarticons-database /></template>
<strong>MPD</strong> · l'implémentation dans un SGBD précis : types SQLite, contraintes, index.
</Card>




---
layout: grid
cols: 2
content: center
---

# Autres modèles

<Card title="Hiérarchique" footer="InfraDon · semestre 2">
<template #icon><pixelarticons-git-branch /></template>
Un arbre : chaque enregistrement a un seul parent. Les systèmes bancaires historiques.
</Card>
<Card title="Document" footer="cours 09 · un aperçu">
<template #icon><pixelarticons-braces /></template>
Des documents JSON autonomes, au schéma libre. MongoDB, CouchDB.
</Card>
<Card title="Graphe" footer="InfraDon · semestre 2">
<template #icon><pixelarticons-git-merge /></template>
Des nœuds et des liens de premier plan. Réseaux sociaux, recommandations.
</Card>
<Card title="Clé-valeur" footer="InfraDon · semestre 2">
<template #icon><pixelarticons-list /></template>
Une valeur par clé, rien de plus. Caches et sessions web.
</Card>


---
layout: two-cols
class: compact
---

::title::
# Du besoin au diagramme

::left::

| Notation | Origine | Signe distinctif |
|---|---|---|
| Chen | 1976, académique | Losanges et ellipses |
| Merise | France, 1979 | MCD, MLD, MPD |
| Patte de corbeau | Everest, 1976 | Pattes au bout des traits |
| <span style="color: #e92528">**UML**</span> | <span style="color: #e92528">Génie logiciel</span> | <span style="color: #e92528">Multiplicités `0..1`, `1..*` · MCD et MLD</span> |

::right::

<Figure
  class="w-full mx-auto"
  src="/images/02/mcd-complet.svg"
  alt="Le diagramme complet de la bibliothèque"
  caption="Le MCD complet de la bibliothèque"
/>

<Card title="draw.io" footer="app.diagrams.net · aucun compte">
<template #icon><pixelarticons-edit-box /></template>
L'éditeur du cours, dans le navigateur. Le diagramme s'exporte en image et se garde en <code>.drawio</code>.
</Card>

---
layout: section
---

# Entité

---
layout: two-cols
class: compact
---

::title::
# Entité

::left::

- Objet **concret** ou **abstrait**, important pour le système
- On collecte des **données** à son sujet
- Elle regroupe des **attributs**
- Représentation : un rectangle portant son nom


<br>

### Besoins

> « On gère quelques milliers de livres, écrits par des auteurs. Ils sont rangés dans des rayons et empruntés par des lecteur·rice·s. »

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/entite.svg"
  alt="L'entité livres, ses lignes d'attributs encore vides"
/>

---
layout: two-cols
---

::title::
# Faux candidats

::left::

### Besoins

> « On gère quelques milliers de livres, écrits par des auteurs. Ils sont rangés dans des rayons et empruntés par des lecteur·rice·s. »

Une entité apparaît dès qu'on veut **décrire** un lien. Un emprunt a une date et une durée : il devient une entité.

::right::

### Le cas limite


| Candidat | Verdict | Motif |
|---|---|---|
| `bibliotheque` | Non | Exemplaire unique |
| `titre` | Non | Attribut |
| `emprunt` | Peut-être | Si daté |

---
layout: two-cols
---

::title::
# Entité forte

::left::

- Elle porte son **propre** identifiant
- Elle existe sans dépendre d'une autre
- La plupart des entités d'un modèle

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/entite-forte.svg"
  alt="La boîte livres avec sa clé propre"
/>

---
layout: two-cols
---

::title::
# Entité faible

::left::

### Besoins

> « On dit l'étagère 3 du rayon Romans. Le numéro repart à 1 dans chaque rayon. »

- Elle n'existe pas sans son **parent**
- Son identifiant emprunte celui du parent
- Il faut le rayon **et** le numéro

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/entite-faible.svg"
  alt="La boîte etageres, identifiée par son rayon et son numéro"
/>

---
layout: two-cols
---

::title::
# Entité associative

::left::

### Besoins

> « Un livre part et revient plusieurs fois, avec des lecteur·rice·s différent·e·s. On veut savoir qui a quoi, et depuis quand. »

- Elle naît d'une **relation** entre deux entités
- Elle porte les attributs de ce lien
- La date ne tient ni dans l'une, ni dans l'autre

::right::


<Figure
  src="/images/02/entite-associative.svg"
  alt="Livre et Lecteur reliés, la date d'emprunt posée sur le trait"
/>


---
layout: section
---

# Attribut

---
layout: two-cols
---

::title::
# Attribut

::left::

- **Propriété** ou **caractéristique** de l'entité
- Type de données : `VARCHAR`, `INTEGER`, `DATE`, `BOOLEAN`

| Type | Valeur | Permet |
|---|---|---|
| `VARCHAR` | `'Germinal'` | Tri alphabétique |
| `INTEGER` | `352` | Somme, moyenne |
| `DECIMAL` | `19.90` | Calcul exact |
| `DATE` | `'2019-03-14'` | Intervalles |
| `BOOLEAN` | `true` | Filtrage direct |


::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/attribut.svg"
  alt="La boîte livres et ses attributs"
/>

---
layout: two-cols
---

::title::
# Attribut simple

::left::

- Une seule valeur par occurrence
- Une ligne dans la boîte
- Le cas le plus fréquent

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/attribut-simple.svg"
  alt="Deux attributs simples sur livres"
/>

---
layout: two-cols
---

::title::
# Attribut composé

::left::

- Il contient plusieurs informations
- Chacune mérite sa ligne (sinon la recherche par domaine est impossible ! )

<Card color="#e92528" tag="danger" title="À éviter">
<template #icon><pixelarticons-alert /></template>
Un seul <code>contact</code> qui mélange l'adresse et le numéro.
</Card>

::right::


<Figure
  class="w-full mx-auto"
  src="/images/02/attribut-compose.svg"
  alt="Le contact décomposé en email et téléphone"
/>

---
layout: two-cols
---

::title::
# Attribut dérivé

::left::

- Il se **calcule** à partir des autres
- Il ne se stocke pas
- Sinon il devient faux dès la prochaine saisie

<Card color="#e92528" tag="danger" title="À éviter" footer="cours 07 · Analyser les données">
<template #icon><pixelarticons-calculator /></template>
Un <code>nb_livres</code> figé sur l'auteur, que chaque acquisition périme. Il se calculera en <strong>SQL</strong> au moment de la question.
</Card>

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/attribut-derive.svg"
  alt="Le nombre de livres d'un auteur, à ne pas stocker"
/>


---
layout: section
---

# Contraintes

---
layout: two-cols
---

::title::
# Contraintes

::left::

| Contrainte | Sens |
|---|---|
| `PK` | **P**rimary **K**ey, Identifie la ligne, jamais vide, jamais répétée |
| `NOT NULL` | La valeur est exigée à la saisie |
| `UNIQUE` | Deux lignes ne peuvent pas la partager |

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/contraintes.svg"
  alt="La boîte livres avec ses contraintes"
/>

---
layout: two-cols
---

::title::
# Clé primaire

::left::

| Type | Exemple |
|---|---|
| Technique | `id`, entier attribué par la base |
| Naturelle | `isbn`, valeur du métier |

### Recommandation

- Sans signification métier
- Stable dans le temps

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/cle-primaire.svg"
  alt="Clé technique et clé naturelle sur livres"
/>

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

<Figure
  class="w-2/3 mx-auto"
  src="/images/02/cle-composite.svg"
  alt="La clé composite de etageres"
/>

---
layout: section
---

# Relations

---
layout: two-cols
---

::title::
# Relations

::left::

- **Association** entre deux entités
- Une ligne entre les deux entités
- Un **verbe à l'infinitif** posé au milieu de la ligne : p. ex. `emprunter`, `écrire`

::right::

<Figure
  src="/images/02/relation.svg"
  alt="Lecteur et Livre reliés par le verbe emprunter"
/>

---
layout: two-cols
---

::title::
# Exemple : les liens du catalogue

::left::

### Besoins

> « Un auteur écrit des livres. Un rayon les range. Un adhérent les emprunte. »

### La question

Quels verbes reliant deux boîtes se cachent dans cette phrase ?

::right::

<v-click>

<Figure
  class="w-full mx-auto"
  src="/images/02/relations-catalogue.svg"
  alt="Les trois verbes qui relient le catalogue"
/>





- Trois verbes, trois relations
- Aucune n'est une entité

</v-click>

---
layout: two-cols
---

::title::
# Cardinalités

::left::

Nombre d'occurrences d'une entité liées à **une** occurrence de l'autre

<br>

| Notation | Sens |
|---|---|
| `0..1` | Facultatif, au plus un |
| `1` | Exactement un |
| `0..*` | Facultatif, plusieurs possibles |
| `1..*` | Au moins un, plusieurs possibles |

::right::

<Figure
  class="w-full mx-auto"
  src="/images/02/cardinalite.svg"
  alt="Un auteur écrit un à plusieurs livres"
/>

- Un auteur écrit `0..*` livres
- Un livre est écrit par `1` auteur

---
layout: two-cols
---

::title::
# Exemple : boutique en ligne

::left::

### Besoins

> « Un client peut passer plusieurs commandes. Une commande n'est passée que par un seul client. »

### La question

Quelle cardinalité à chaque bout du trait ?

::right::

<v-click>

<Figure
  class="w-full mx-auto"
  src="/images/02/exemple-boutique.svg"
  alt="Un client passe zéro à plusieurs commandes"
/>



- Un client passe `0..*` commandes
- Une commande est passée par `1` client

</v-click>

---
layout: two-cols
---

::title::
# Exemple : gestion d'une école

::left::

### Besoins

> « Un étudiant suit plusieurs cours. Un cours est enseigné par un seul professeur. »

### La question

Où se cache la relation N:M ?

::right::

<v-click>

<Figure
  class="w-full mx-auto"
  src="/images/02/exemple-ecole.svg"
  alt="Un étudiant suit plusieurs cours"
/>



- Un étudiant suit `1..*` cours
- Un cours est suivi par `1..*` étudiants
- `1..*` des deux côtés : une relation N:M

</v-click>
---
layout: section
---

# Nommage

---
layout: default
---

# Conventions de nommage

| Convention | Exemple |
|---|---|
| Nom d'entité au pluriel | `livres`, pas `livre` |
| `snake_case` : minuscules et tirets bas | `date_emprunt`, pas `dateEmprunt` |
| Ni accents ni espaces | `duree`, pas `durée` |
| Référence suffixée en `_id` | `livre_id` |

---
layout: section
---

# Le diagramme complet

---
layout: image-full
image: /images/02/mcd-complet.svg
backgroundSize: contain
caption: "Le <strong>MCD complet</strong> de la bibliothèque"
---
---
layout: default
---

# Résumé

| Notion | Sur le diagramme |
|---|---|
| Entité | Un rectangle qui porte son nom |
| Attribut | Une ligne dans la boîte, avec son type |
| Identifiant | `PK` devant l'attribut qui distingue les occurrences |
| Contrainte | `NOT NULL`, `UNIQUE`, dans la colonne de gauche |
| Relation | Un trait entre deux boîtes, un verbe au milieu |
| Cardinalité | `0..1`, `1`, `0..*`, `1..*` au bout de chaque trait |

Le **modèle logique** traduit ce diagramme au cours 03 : clés étrangères, tables de liaison, tables.

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
routeAlias: corrige-semaine-1
---

::title::
# TP · Semaine 1 : Entités du musée

::left::

### La collection

- `artistes`
- `oeuvres`
- `interventions`

::right::

### L'exploitation

- `salles`
- `expositions`
- `billets`
- `partenaires`

---
layout: two-cols
routeAlias: tp
---

::title::
# TP · Semaine 2


::left::


1. Reprendre la liste du musée de la semaine 1, en tirer les entités
2. Les dessiner dans draw.io, une boîte par entité
3. Remplir les attributs, puis les contraintes
4. Relier les boîtes : un verbe à l'infinitif, les cardinalités aux deux bouts
5. Exporter l'image et garder le fichier `.drawio`

::right::

<Card color="#16a34a" tag="tip" title="Pas encore de clés étrangères">
<template #icon><pixelarticons-git-branch /></template>
Le diagramme reste conceptuel. La traduction des cardinalités en <code>FK</code> et en tables de liaison est au cours 03.
</Card>

<Card color="#6b7280" tag="note" title="Un diagramme qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance ajoute au même diagramme ce qu'elle vient d'introduire. On ne recommence jamais de zéro.
</Card>
