---
theme: pixel
title: "01 · Introduction"
subtitle: "Modélisation de Données"
author: "Noe Romano"
email: "noemi.romano@heig-vd.ch"
github: "https://github.com/romanoe/comem-modeldon"
breadcrumb: "Modélisation de Données"
logos:
  - src: /images/logo-heig-vd.svg
    height: 60px
    link: https://www.heig-vd.ch/
    alt: "HEIG-VD"
    title: "HEIG-VD"
    class: "logo-heig"
  - src: /images/logo-hes-so.png
    height: 79px
    link: https://www.hes-so.ch/
    alt: "HES-SO"
    title: "HES-SO"
    class: "logo-hesso"
    

mdc: true
layout: cover
---

---
layout: grid
cols: 3
---

# Ce cours dans la formation

A travers le cycle de vie de la donnée : 

<Card title="Modélisation" color="#000000" footer="modeldon · semestre 1">
<template #icon><pixelarticons-tree /></template>
Structurer et formaliser les données d'un domaine métier. <strong>Ce cours.</strong>
</Card>
<Card title="Infrastructure" color="#6b7280" footer="infradon · semestre 2">
<template #icon><pixelarticons-server /></template>
Stocker, gérer et exposer des données fiables et accessibles à grande échelle.
</Card>
<Card title="Visualisation" color="#6b7280" footer="visualdon · semestre 5">
<template #icon><pixelarticons-chart-bar /></template>
Représenter les données pour en tirer du sens et appuyer les décisions.
</Card>



---
layout: section
---

# Données et information

---
layout: grid
cols: 3fr 1fr 3fr 1fr 3fr
align: stretch
content: center
clicks: 2
---

# Qu'est-ce qu'une donnée ?

<Card title="Données brutes" :at="0">
<template #icon><pixelarticons-database /></template>
<ul>
  <li>24</li>
  <li>65</li>
  <li>180</li>
</ul>
</Card>
<pixelarticons-arrow-right v-click="1" class="text-3xl self-center" />
<Card title="Information" :at="1">
<template #icon><pixelarticons-article /></template>
24°C, 65% d'humidité relative, 180 visiteur·euse·s dans la salle
</Card>
<pixelarticons-arrow-right v-click="2" class="text-3xl self-center" />
<Card title="Connaissance" :at="2">
<template #icon><pixelarticons-lightbulb /></template>
Activer la déshumidification et limiter l'accès à la salle des œuvres sur papier
</Card>


---
layout: section
---

# Du tableur à la base de données

---
layout: two-cols
---

::title::
# Le tableur : point de départ naturel

::left::

- **Visibles** : toutes les données tiennent à l'écran
- **Immédiat** : aucun outil à installer
- **Sans formation** : tout le monde sait déjà s'en servir
- **Limité** : quelques centaines de lignes, sur un seul poste

::right::

<Card title="Propriétaire">
<template #icon><pixelarticons-lock /></template>
<strong>Microsoft Excel</strong> · <strong>Apple Numbers</strong><br>Licence payante, format contrôlé par l'éditeur.
</Card>
<Card title="Libre et open source">
<template #icon><logos-opensource /></template>
<strong>LibreOffice Calc</strong> · <strong>Gnumeric</strong><br>Gratuit, format ouvert (<code>.ods</code>).
</Card>
<Card title="En ligne et collaboratif">
<template #icon><pixelarticons-cloud /></template>
<strong>Google Sheets</strong> · <strong>Framacalc</strong><br>Édition à plusieurs, données hébergées par un tiers.
</Card>

---
layout: image-right
image: /images/01/excel-sheet.jpg
backgroundSize: contain
caption: "<em>I'm Sick of This Sheet</em>"
---

# Pourquoi (pas) Excel ?

- `v1`, `v2_final`, `v2_FINAL_ok.xlsx`
- "Noe Romano" vs "Noé romano" : deux entrées distinctes
- Deux personnes éditent en même temps : conflit
- Suppression accidentelle : irrécupérable

<Card color="#e92528" tag="danger" title="Pas de filet de sécurité">
<template #icon><pixelarticons-shield-off /></template>
Excel n'empêche rien. N'importe qui peut écrire n'importe quoi dans n'importe quelle cellule.
</Card>


---
layout: default
---

# Ce qui casse, ce qu'il faudrait

Chaque limite du tableur appelle une réponse précise. Ces réponses portent un nom : ce sont les fonctions d'une base de données.

| Dans le tableur | Ce qu'il faudrait |
|---|---|
| `v1`, `v2_final`, `v2_FINAL_ok.xlsx` | Une **seule** source de vérité |
| « Fritz lang » et « Fritz Lang » | Une valeur saisie **une seule fois** |
| N'importe quoi dans n'importe quelle cellule | Un **type** et des **contraintes** par colonne |
| Deux personnes éditent, conflit | Des **accès simultanés** gérés |
| Suppression irrécupérable | Des règles de **suppression** explicites |

---
layout: grid
cols: 3fr 1fr 3fr 1fr 3fr 1fr 3fr
align: stretch
content: center
clicks: 3
---

# Le passage, étape par étape

<Card title="1 · Séparer" :at="0">
<template #icon><pixelarticons-scissors /></template>
Une feuille mélange œuvres, artistes et salles. Chaque sujet devient une entité.
</Card>
<pixelarticons-arrow-right v-click="1" class="text-3xl self-center" />
<Card title="2 · Décrire" :at="1">
<template #icon><pixelarticons-git-branch /></template>
Entités, attributs et relations, écrits en DBML.
</Card>
<pixelarticons-arrow-right v-click="2" class="text-3xl self-center" />
<Card title="3 · Créer" :at="2">
<template #icon><pixelarticons-table /></template>
Le diagramme devient des <code>CREATE TABLE</code> typés.
</Card>
<pixelarticons-arrow-right v-click="3" class="text-3xl self-center" />
<Card title="4 · Interroger" :at="3">
<template #icon><pixelarticons-search /></template>
Les données entrent, les réponses sortent en SQL.
</Card>

Ces quatre étapes sont le plan du semestre : cours 02-03, puis 04, puis 05 à 07.

---
layout: grid
cols: 3
---

# Les langages du cours

Trois notations, trois rôles. Aucune n'est un langage de programmation : on décrit, on interroge, on échange.

<Card title="DBML" footer="Cours 02-03">
<template #icon><pixelarticons-git-branch /></template>
<strong>Décrire.</strong> Le diagramme entité-association s'écrit en texte, se versionne dans le dépôt et se prévisualise dans VS Code.
</Card>
<Card title="SQL" footer="Cours 04 à 07">
<template #icon><pixelarticons-database /></template>
<strong>Créer et interroger.</strong> Créer les tables, insérer les données, poser des questions et en tirer des indicateurs.
</Card>
<Card title="JSON" footer="Cours 08">
<template #icon><pixelarticons-braces /></template>
<strong>Échanger.</strong> Un format, pas un langage de requête : ce que la base expose à une application.
</Card>

---
layout: section
---

# Base de données et SGBD

---
layout: two-cols
---

::title::
# Qu'est-ce qu'une base de données ?

::left::

<Card title="Stocker">
<template #icon><pixelarticons-save /></template>
Les données survivent à l'arrêt du programme.
</Card>
<Card title="Organiser">
<template #icon><pixelarticons-layout /></template>
Selon un modèle cohérent, sans doublon ni ambiguïté.
</Card>
<Card title="Accéder">
<template #icon><pixelarticons-search /></template>
Rapidement, avec des critères précis.
</Card>

::right::

### Ce que c'est

- Données **structurées** et **persistantes**
- Gérée par un logiciel qui garantit la cohérence

<br>

### Ce qu'elle garantit

- Une **seule** source de vérité
- Des données qui **survivent** aux erreurs
- Des réponses obtenues par **requête**, pas à l'oeil

---
layout: two-cols
---

::title::
# Le SGBD : le logiciel qui gère les données

::left::

Un **Système de Gestion de Base de Données** stocke les données, garantit leur cohérence et répond aux requêtes de plusieurs utilisateur·rice·s. 

Deux **types** : 

* **OLTP** (`Online Transaction Processing`)  Écritures fréquentes et courtes : vendre un billet, enregistrer une visite.

* **OLAP** (`Online Analytical Processing`) : Lectures massives pour décider : chiffre d'affaires, fréquentation des salles.

::right::

### Quelques SGBD relationnels

<Card title="SQLite" color="#e92528" footer="Utilisé dans ce cours · contexte OLTP">
<template #icon><logos-sqlite /></template>
Embarqué : un seul fichier, aucun serveur.
</Card>
<Card title="PostgreSQL">
<template #icon><logos-postgresql /></template>
Client-serveur, riche et extensible.
</Card>
<Card title="MySQL">
<template #icon><logos-mysql /></template>
Client-serveur, très répandu sur le web.
</Card>


---
layout: section
---

# Pourquoi modéliser ?

---
layout: grid
cols: 2
---

# Objectifs de la modélisation

<Card title="Organiser l'information">
<template #icon><pixelarticons-list /></template>
Structurer les données pour qu'elles soient cohérentes, sans doublons, sans ambiguïté.
</Card>
<Card title="Définir les relations">
<template #icon><pixelarticons-git-branch /></template>
Exprimer les liens entre les entités du domaine : visiteur, exposition, œuvre.
</Card>
<Card title="Besoins métier">
<template #icon><pixelarticons-clipboard-note /></template>
Collecter les exigences du domaine d'application avant de concevoir quoi que ce soit.
</Card>
<Card title="Modèle optimal">
<template #icon><pixelarticons-check-double /></template>
Un bon modèle garantit que les données sont interrogeables, maintenables et évolutives.
</Card>

---
layout: section
---

# Le diagramme entité-association

---
layout: grid
cols: 3
---

# L'ERD : le plan de la base

Avant d'écrire la moindre ligne de SQL, on dessine la structure des données. Un diagramme entité-association répond à trois questions.

<Card title="Entités">
<template #icon><pixelarticons-archive /></template>
Quels sont les <strong>objets</strong> du domaine ? Une œuvre, un artiste, une salle.
</Card>
<Card title="Attributs">
<template #icon><pixelarticons-label /></template>
Que sait-on de chacun d'eux ? Un titre, une année, une technique.
</Card>
<Card title="Relations">
<template #icon><pixelarticons-git-branch /></template>
Comment sont-ils liés, et <strong>combien de fois</strong> ? Un artiste crée plusieurs œuvres.
</Card>

---
layout: default
---

# Du diagramme aux tables

Chaque élément du diagramme a une traduction directe dans la base.

| Dans le diagramme | Dans la base de données |
|---|---|
| Entité | Table |
| Attribut | Colonne |
| Attribut identifiant | Clé primaire |
| Relation 1:N | Clé étrangère |
| Relation N:M | Table de liaison |

Dessiner d'abord, implémenter ensuite : corriger un trait coûte moins cher que corriger une base déjà remplie.

---
layout: section
---

# Objectifs du cours

---
layout: two-cols
---

::title::
# Objectifs

::left::

- **Structurer** des données dans un **modèle relationnel** adapté à un domaine métier
- **Modéliser** un problème réel sous forme d'**entités**, d'**attributs** et de **relations**
- **Traduire** un diagramme entité-association en **schéma SQL** exploitable
- **Interroger** et **transformer** des données pour répondre à des besoins métier
- **Analyser** des données structurées pour produire des **indicateurs** et des **statistiques**

::right::

<Figure
  class="w-2/3 mx-auto framed"
  src="/images/01/fiche-de-cours.png"
  caption="<a href='https://gaps.heig-vd.ch/consultation/fiches/uv/uv.php?id=8125&amp;plan=941&amp;type=PDF' target='_blank' rel='noopener'>Fiche d'unité</a>"
  href="https://gaps.heig-vd.ch/consultation/fiches/uv/uv.php?id=8125&amp;plan=941&amp;type=PDF"
  alt="Fiche d'unité de cours Modélisation de données"
/>


---

# Ce que vous saurez faire

| # | Cours | Compétences |
|---|---|---|
| 01 | Introduction | Distinguer données, information et connaissance |
| 02 | Modélisation | Concevoir un modèle E-R à partir d'un besoin métier |
| 03 | Clés et relations | Définir des clés primaires, étrangères et des relations |
| 04 | Stockage | Créer et structurer une base SQLite |
| 05 | Interroger | Lire, filtrer et modifier des données |
| 06 | Connecter | Relier des tables avec des jointures |
| 07 | Analyser | Agréger des données et créer des vues |
| 08 | Semi-structuré | Lire et produire du JSON |

---
layout: section
---

# Évaluation

---
layout: two-cols
---

::title::
# Comment vous serez évalué·e·s

::left::

<Card title="Projet · 50%" footer="Noté sur grille de critères">
<template #icon><pixelarticons-briefcase /></template>
Fil rouge du semestre · noté sur une grille de critères (échelle 0/1/2).
</Card>

::right::

<Card title="Examen final · 50%" color="#16a34a">
<template #icon><pixelarticons-edit-box /></template>
Période jan-fev · Format papier · Questions ouvertes · QCM
</Card>

---
layout: section
---

# Travaux pratiques

---

# Le projet

- Groupes de **2-3 personnes**
- Un projet unique tout au long du semestre : **modéliser et implémenter la base de données d'un musée**
- Hébergé sur **GitHub** : un dépôt par groupe, partagé avec l'enseignant·e dès le début du semestre
- Le **diagramme E-R** est écrit en **DBML** et prévisualisé dans VS Code ; le fichier `.dbml` est versionné dans le repo
- Chaque séance fait avancer le même projet, du diagramme entité-association jusqu'aux requêtes SQL

---
layout: grid
cols: 2
---

# Prérequis & installation

À mettre en place **avant la première séance de TP**.

<Card title="Compte GitHub">
<template #icon><logos-github-icon /></template>
Compte gratuit sur <strong>github.com</strong> : indispensable pour héberger et partager votre projet.
</Card>
<Card title="VS Code + devcontainer">
<template #icon><logos-visual-studio-code /></template>
L'éditeur du cours. Le devcontainer (via Docker) installe tout : SQLite et l'extension <strong>DBML</strong>.
</Card>
<Card title="DBML" color="#e92528">
<template #icon><pixelarticons-table /></template>
Le langage de modélisation du cours : vous décrivez votre diagramme E-R en <strong>DBML</strong>, prévisualisé dans VS Code.
</Card>
<Card title="Template de projet" footer="github.com/romanoe/comem-model-template">
<template #icon><logos-github-icon /></template>
<strong>Use this template</strong> sur le dépôt du cours : votre dépôt de groupe part de cette base, avec un historique Git neuf.
</Card>

---

# Workflow GitHub

Chaque séance, le groupe pousse sur le dépôt :

| Livrable | Format |
|---|---|
| Diagramme E-R | Fichier `.dbml` (DBML) |
| Schéma SQL | Fichier `.sql` |
| Retour individuel | Fichier `retour-XX-prenom.md` par étudiant·e |

<Card color="#6b7280" tag="note" title="Versionné">
<template #icon><pixelarticons-git-commit /></template>
L'historique Git montre l'évolution du modèle séance après séance.
</Card>

---
layout: default
---

# Évaluation du projet

Chaque critère est noté **0** (non respecté), **1** (partiellement respecté) ou **2** (pleinement respecté).

| # | Critère | Rendu attendu |
|---|---|---|
| 1 | Workflow Git/GitHub : issues, branches, pull requests | Historique Git et PRs |
| 2 | README faisant office de rapport : journal et conclusion | `README.md` |
| 3 | Diagramme E-R : entités, attributs, relations, cardinalités | `modele/musee.dbml` |
| 4 | Schéma SQLite : types, contraintes, clés étrangères | `sql/schema.sql` |
| 5 | Données traitées et importées correctement | `sql/import.sql` |
| 6 | Requêtes SQL justes et lisibles : sélections, jointures, agrégats | `sql/requetes/` |
| 7 | Retours individuels rédigés après chaque séance | `retours/` |


[github.com/romanoe/comem-model-template](https://github.com/romanoe/comem-model-template)

---

# Contraintes

- Chaque membre de l'équipe contribue de manière **équitable**.
- La documentation permet à une personne externe de **reprendre** le projet.
- Le travail est **rendu dans les temps**.
- L'usage d'outils d'IA ou de code externe est autorisé, **s'il est justifié**.

<Card color="#e92528" tag="danger" title="Justification de l'IA" footer="Exemples : JUSTIFICATIONS_IA.md">
<template #icon><pixelarticons-robot /></template>
Indiquer <strong>quand</strong>, <strong>comment</strong> et <strong>pourquoi</strong>. Expliquer le code et son intégration. Une justification insuffisante ou un manque de transparence : note <strong>1</strong>.
</Card>

---

# Retours individuels

Après chaque cours, chaque étudiant·e rédige un court retour **individuel** :

- Ce que j'ai compris
- Ce qui reste flou
- Une question que je me pose

<Card title="En pratique">
<template #icon><pixelarticons-message-text /></template>
Un retour par séance, rendu via une pull request avec l'enseignante en reviewer. Pas de correction formelle : c'est un outil de réflexion et de suivi.
</Card>

---

# Pour cette première séance

Pas encore de modélisation : on met en place le workflow.

1. Créer un compte **GitHub**, puis créer le dépôt du groupe avec **Use this template**
2. Rédiger son **retour individuel** dans `retours/retour-01-prenom.md`
3. Ouvrir une **pull request** avec ce retour, en ajoutant l'enseignante comme **reviewer**

<Card color="#16a34a" tag="tip" title="Pourquoi une pull request ?">
<template #icon><pixelarticons-git-pull-request /></template>
C'est la brique du travail collaboratif : chaque contribution devient visible et relisable avant d'être fusionnée.
</Card>

---
layout: section
---

# Projet fil rouge : modéliser la base de données d'un musée

---
layout: two-cols
---

::title::
# Projet 

::left::

### 01 Donnée brute

```
1200
```

### 02 Information

1200 billets vendus pour le dimanche.

### 03 Connaissance

Le dimanche sature. Ouvrir un créneau de visite guidée supplémentaire et inciter à venir en semaine par un tarif réduit.

::right::

Les 8 cours s'appliquent à ce même musée.

| # | Application |
|---|---|
| 02-03 | Modéliser |
| 04 | Stocker le schéma dans la base de données |
| 05-06 | Parcours de visite : œuvre · artiste · salle |
| 07 | Chiffre d'affaires · fréquentation par salle |
| 08 | Catalogue JSON pour l'app mobile |
