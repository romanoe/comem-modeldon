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

# Cours en construction

Cette séance est en cours d'écriture. Les slides arriveront avant le cours.

<Card color="#d97706" tag="warning" title="Contenu provisoire">
<template #icon><pixelarticons-edit-box /></template>
Le plan et les premières slides existent déjà dans le dépôt, mais ne sont pas encore présentables.
</Card>


---
layout: default
hide: true
---

# Cours précédent

- Entité en table, relation en clé étrangère `FK`
- Table de liaison et clé primaire composite
- Contraintes des clés étrangères selon la relation
- Première, deuxième et troisième formes normales
- Champs à texte libre : la table de référence

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-database /></template>
Traduire le diagramme en <code>CREATE TABLE</code> : types SQLite, intégrité référentielle, modes de suppression.
</Card>

---
layout: section
hide: true
---

# Pourquoi une base de données ?

---
layout: section
hide: true
---

# Du schéma au CREATE TABLE

---
layout: section
hide: true
---

# Choisir les bons types

---
layout: section
hide: true
---

# Intégrité référentielle

---
layout: section
hide: true
---

# Modes de suppression

---
layout: section
hide: true
---

# Travaux pratiques

---
layout: two-cols
hide: true
---

::title::
# Pour la prochaine séance

::left::

### TP · Semaine 4

1. Traduire le modèle logique du musée en `CREATE TABLE`
2. Choisir les types SQLite de chaque colonne
3. Poser les contraintes et les clés étrangères
4. Insérer quelques lignes de test dans chaque table

::right::

<Card color="#6b7280" tag="note" title="Un modèle qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance reprend le musée là où la précédente l'a laissé. On ne recommence jamais de zéro.
</Card>
