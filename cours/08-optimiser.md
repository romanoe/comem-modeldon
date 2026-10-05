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

- Fonctions d'agrégation
- Regrouper les résultats avec `GROUP BY`
- Vues enregistrées comme requêtes réutilisables

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-zap /></template>
Accélérer les requêtes : index, plan d'exécution, coût d'un index, dénormalisation raisonnée.
</Card>

---
layout: section
hide: true
---

# Parcours complet d'une table

---
layout: section
hide: true
---

# Index

---
layout: section
hide: true
---

# Plan d'exécution

---
layout: section
hide: true
---

# Coût d'un index

---
layout: section
hide: true
---

# Dénormalisation

---
layout: default
hide: true
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
hide: true
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

### TP · Semaine 8

1. Repérer les requêtes du musée les plus fréquentes
2. Lire leur plan avec `EXPLAIN QUERY PLAN`
3. Poser un index sur les colonnes filtrées ou jointes
4. Comparer le plan avant et après l'index

::right::

<Card color="#6b7280" tag="note" title="Un modèle qui grossit">
<template #icon><pixelarticons-trending-up /></template>
Chaque séance reprend le musée là où la précédente l'a laissé. On ne recommence jamais de zéro.
</Card>
