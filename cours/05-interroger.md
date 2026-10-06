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

- Types SQLite : `INTEGER`, `REAL`, `TEXT`
- `CREATE TABLE` et contraintes de colonne
- Clé étrangère : `REFERENCES`, `PRAGMA foreign_keys`
- Modes de suppression : `RESTRICT`, `CASCADE`, `SET NULL`
- Clé primaire composite de la table de liaison

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-search /></template>
Lire, filtrer et trier les données. Insérer, modifier, supprimer des lignes.
</Card>

---
layout: section
hide: true
---

# Lire les données

---
layout: section
hide: true
---

# Filtrer et trier

---
layout: section
hide: true
---

# Modifier les données

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

### TP · Semaine 5

1. Écrire les requêtes qui répondent aux questions du musée
2. Filtrer et trier les résultats
3. Insérer, modifier et supprimer quelques lignes
4. Garder chaque requête dans un fichier `.sql` commenté

::right::

<Card color="#6b7280" tag="note" title="Un modèle qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance reprend le musée là où la précédente l'a laissé. On ne recommence jamais de zéro.
</Card>
