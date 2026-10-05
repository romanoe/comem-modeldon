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

- `SELECT` et projection des colonnes
- Filtrer avec `WHERE`, trier avec `ORDER BY`
- `INSERT`, `UPDATE`, `DELETE`
- Une seule table à la fois

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-git-merge /></template>
Recoller les tables séparées par le modèle : <code>INNER JOIN</code>, <code>LEFT JOIN</code>.
</Card>

---
layout: section
hide: true
---

# Pourquoi la donnée est morcelée

---
layout: section
hide: true
---

# INNER JOIN

---
layout: section
hide: true
---

# LEFT JOIN

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

### TP · Semaine 6

1. Repérer les questions qui traversent plusieurs tables
2. Écrire les jointures correspondantes
3. Comparer `INNER JOIN` et `LEFT JOIN` sur un même cas
4. Commenter ce que change chaque variante

::right::

<Card color="#6b7280" tag="note" title="Un modèle qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance reprend le musée là où la précédente l'a laissé. On ne recommence jamais de zéro.
</Card>
