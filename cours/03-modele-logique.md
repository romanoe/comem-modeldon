---
theme: pixel
number: "03"
title: "Modèle Logique de Données (MLD)"
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

- Le relationnel, et les trois niveaux de modèle
- Types d'entités : forte, faible, associative
- Types d'attributs, types de données, identifiant
- Contraintes `PK`, `NOT NULL`, `UNIQUE`
- Relations nommées et cardinalités `0..1`, `1`, `0..*`, `1..*`

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-git-branch /></template>
Traduire le conceptuel en <strong>tables</strong> : clé étrangère <code>FK</code>, table de liaison, relations identifiantes, 1:N et N:M.
</Card>

---
layout: section
hide: true
---

# De la relation à la table

---
layout: section
hide: true
---

# La clé primaire

---
layout: section
hide: true
---

# La clé étrangère

---
layout: section
hide: true
---

# Relation identifiante ou non identifiante

---
layout: section
hide: true
---

# Relation 1:N

---
layout: section
hide: true
---

# Relation N:M et entité associative

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

### TP · Semaine 3

1. Reprendre le MCD du musée et poser les cardinalités sur chaque relation
2. Traduire chaque entité en table, avec sa clé primaire
3. Poser les clés étrangères, créer les tables de liaison des relations N:M
4. Exporter le diagramme logique : image et fichier `.drawio`

::right::

<Card color="#6b7280" tag="note" title="Un modèle qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance reprend le musée là où la précédente l'a laissé. On ne recommence jamais de zéro.
</Card>
