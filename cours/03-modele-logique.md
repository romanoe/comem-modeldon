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

# Cours précédent

- Le modèle relationnel, et les trois niveaux de modèle

- Entité forte, entité faible, entité associative
- Attribut simple, composé, dérivé, et son type
- Contraintes `PK`, `NOT NULL`, `UNIQUE`
- Relations nommées et cardinalités `0..1`, `1`, `0..*`, `1..*`

<br> 

<Card title="Aujourd'hui" color="#e92528">
<template #icon><pixelarticons-git-branch /></template>
Traduire le diagramme conceptuel en <strong>tables</strong>, puis vérifier le découpage par la <strong>normalisation</strong>.
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
<Card title="Logique" color="#e92528" footer="cours 03 · ce cours">
<template #icon><pixelarticons-layout /></template>
<strong>MLD</strong> · la traduction en tables, avec clés étrangères, vérifiée par la normalisation.
</Card>
<pixelarticons-arrow-right class="text-3xl self-center" />
<Card title="Physique" footer="cours 04 · Modèle physique">
<template #icon><pixelarticons-database /></template>
<strong>MPD</strong> · l'implémentation dans un SGBD précis : types SQLite, contraintes, clés étrangères.
</Card>

---
layout: section
---

# Modèle logique

---
layout: two-cols
---

::title::
# Modèle logique

::left::

- Traduit le diagramme **conceptuel** en **tables**

- Reste indépendant du SGBD
- Garantit la **cohérence** des liens
- Sert de **langue commune** au développement
- Prépare le modèle physique (MPD - cours 04)

::right::

### Traduction

| Conceptuel | Logique |
|---|---|
| Entité | Table |
| Attribut | Colonne |
| Identifiant | Clé primaire `PK` |
| Relation | Clé étrangère `FK` ou table de liaison |



---
layout: section
---

# Clés

---
layout: two-cols
---

::title::
# Clé primaire

::left::

- Identifie une ligne et une seule (**identifiant**)

- Jamais vide (`NOT NULL`), jamais répétée (`UNIQUE`)

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/03/cle-primaire.svg"
  alt="La table auteurs et sa clé primaire"
/>

---
layout: two-cols
---

::title::
# Clé étrangère

::left::

- Colonne qui porte la clé primaire d'une autre table
- Elle matérialise le lien entre deux tables
- Nom suffixé en `_id`

::right::

<Figure
  class="w-full mx-auto"
  src="/images/03/cle-etrangere.svg"
  alt="La table livres et sa clé étrangère auteur_id"
/>

---
layout: section
---

# Traduire les relations

---
layout: two-cols
---

::title::
# Relation 1:N

::left::

- Un bout `1`, l'autre `0..*` ou `1..*`
- La table du côté `0..*` reçoit la clé


::right::

<Figure
  class="w-full mx-auto"
  src="/images/03/relation-1n.svg"
  alt="Un auteur écrit des livres, la clé auteur_id descend dans livres"
/>

---
layout: two-cols
---

::title::
# Exemple : boutique en ligne

::left::

### Besoins

> « Un client peut passer plusieurs commandes. Une commande n'est passée que par un seul client. »

### La question

Quelle table reçoit la clé étrangère ?

::right::


<Figure
  class="w-full mx-auto"
  src="/images/03/exemple-boutique.svg"
  alt="La table commandes et sa clé étrangère client_id"
/>

- Le bout `0..*` est du côté des commandes
- `client_id` y pointe vers `clients`

 

---
layout: two-cols
---

::title::
# Relation N:M

::left::

- `0..*` ou `1..*` aux **deux** bouts
- Aucune des deux tables ne peut porter la clé
- Une **table de liaison** naît entre elles
- Elle porte une `FK` vers chacune

::right::

<Figure
  class="w-full mx-auto"
  src="/images/03/relation-nm.svg"
  alt="Livres et lecteurs reliés par la table de liaison emprunts"
/>

---
layout: two-cols
---

::title::
# Table de liaison

::left::

- Une ligne par couple de colonne relié
- Deux `FK`, une vers chaque table
- Le couple de colonnes ne se répète pas (**clé composite**)

<Card color="#6b7280" tag="note" title="Entité associative">
<template #icon><pixelarticons-arrow-down /></template>
Même notion à deux niveaux : l'<strong>entité associative</strong> du conceptuel devient cette table au logique. L'inverse n'est pas vrai : une relation N:M sans attribut donne une table de liaison sans entité associative.
</Card>

::right::

<Figure
  class="w-full mx-auto"
  src="/images/03/table-liaison.svg"
  alt="La table de liaison emprunts et ses deux clés étrangères"
/>


---
layout: two-cols
---

::title::
# Exemple : gestion d'une école

::left::

### Besoins

> « Un étudiant suit plusieurs cours. Un cours est suivi par plusieurs étudiants. »

### La question

Combien de tables pour ces deux entités ?

::right::


<Figure
  class="w-full mx-auto"
  src="/images/03/exemple-ecole.svg"
  alt="La table de liaison inscriptions"
/>

- Trois tables : `etudiants`, `cours`, `inscriptions`
- La note ou la date tiennent dans la liaison



---
layout: two-cols
class: compact
---

::title::
# Contraintes des clés étrangères

Le type de (1:N, N:M) fixe la contrainte

::left::

| Relation | Bout côté parent | `FK` |
|---|---|---|
| 1:N | `1` | `NOT NULL` |
| 1:N | `0..1` | peut rester vide |
| N:M | `1` des deux côtés | deux `FK NOT NULL`, couple en `PK` |


::right::

### Exemple

> « Un livre a toujours un.e auteur.e. Un livre neuf n'est pas encore rangé. »

`livres`

| id | titre | auteur_id | rayon_id |
|---|---|---|---|
| 1 | Germinal | 3 | 4 |
| 2 | Cosmos | 5 | NULL |

- `auteur_id` : bout `1`, toujours rempli
- `rayon_id` : bout `0..1`, vide permis

---
layout: section
---

# Normalisation

---
layout: two-cols
---

::title::
# Normalisation

::left::

- Éliminer les **redondances**
- Garantir la **cohérence** des données
- Éviter les **anomalies** d'insertion, modification, suppression
- Assurer la **pérennité** du modèle

::right::

### Principe

<Card title="Décomposer" color="#e92528">
<template #icon><pixelarticons-scissors /></template>
Plusieurs tables, <strong>un seul concept</strong> par table. Chaque attribut dépend de la clé, de toute la clé, et de rien d'autre.
</Card>


---
layout: two-cols
class: compact
---

::title::
# Première forme normale (1NF)

- Une seule valeur par case : ni liste, ni colonnes numérotées

::left::

### À éviter

`livres`

| id | titre | genres |
|---|---|---|
| 1 | Germinal | roman, social |
| 2 | La Peste | roman |

- Deux valeurs dans une case
<pixelarticons-arrow-right class="text-1xl self-center" />Compter les romans : impossible

::right::

### À faire

`livres`

| id | titre | genre |
|---|---|---|
| 1 | Germinal | roman |
| 1 | Germinal | social |
| 2 | La Peste | roman |

- Une valeur par ligne
- Clé composite : le couple `id`, `genre`
- `titre` se répète : 2NF

---
layout: two-cols
class: compact
---

::title::
# Exercice : *etudiants* (1NF)

::left::

### À éviter

`etudiants`

| id | nom | cours |
|---|---|---|
| 1 | Martin | maths, anglais |
| 2 | Rossi | maths |

<v-click>

- Une liste de cours dans une case
 <pixelarticons-arrow-right class="text-1xl self-center" />Retirer un cours : réécrire la case

</v-click>

::right::

<v-click>

### À faire

`etudiants`

| id | nom | cours |
|---|---|---|
| 1 | Martin | maths |
| 1 | Martin | anglais |
| 2 | Rossi | maths |

- Une valeur par ligne
- `nom` se répète : 2NF

</v-click>

---
layout: two-cols
class: compact split
---

::title::
# Deuxième forme normale (2NF)

- Chaque colonne dépend de **toute** la clé : clé simple, 2NF acquise

::left::

### À éviter

`livres`

| id | genre | titre |
|---|---|---|
| 1 | roman | Germinal |
| 1 | social | Germinal |
| 2 | roman | La Peste |

- Clé : le couple `id`, `genre`
- `titre` ne dépend que de `id`

::right::

### À faire

`livres`

| id | titre |
|---|---|
| 1 | Germinal |
| 2 | La Peste |

`livre_genres`

| livre_id | genre |
|---|---|
| 1 | roman |
| 1 | social |
| 2 | roman |

- `titre` écrit une fois par livre
- `livre_genres` garde le couple

---
layout: two-cols
class: compact
---

::title::
# Exercice : *inscriptions* (2NF)

::left::

### À éviter

`inscriptions`

| etudiant_id | cours_id | note | enseignant |
|---|---|---|---|
| 1 | 1 | 5.0 | Dubois |
| 2 | 1 | 4.5 | Dubois |
| 1 | 2 | 5.5 | Keller |

<v-click>

- Clé : le couple de colonnes `etudiant_id`, `cours_id`
- `enseignant` ne dépend que de `cours_id`

</v-click>

::right::

<v-click>

### À faire

`inscriptions`

| etudiant_id | cours_id | note |
|---|---|---|
| 1 | 1 | 5.0 |
| 2 | 1 | 4.5 |
| 1 | 2 | 5.5 |

`cours`

| id | nom | enseignant |
|---|---|---|
| 1 | maths | Dubois |
| 2 | anglais | Keller |

- `enseignant` rejoint `cours`
- `inscriptions` garde la note du couple

</v-click>

---
layout: two-cols
class: compact split
---

::title::
# Troisième forme normale (3NF)

Chaque colonne dépend **seulement** de la clé, d'aucune autre colonne

::left::

### À éviter

`livres`

| id | titre | rayon_id | etage |
|---|---|---|---|
| 1 | Germinal | 4 | 1 |
| 2 | La Peste | 4 | 1 |
| 3 | Cosmos | 6 | 2 |

- `etage` dépend de `rayon_id`
- Rayon déplacé : chaque livre à corriger

::right::

### À faire

`livres`

| id | titre | rayon_id |
|---|---|---|
| 1 | Germinal | 4 |
| 2 | La Peste | 4 |
| 3 | Cosmos | 6 |

`rayons`

| id | nom | etage |
|---|---|---|
| 4 | Romans | 1 |
| 6 | Sciences | 2 |

- `etage` rejoint `rayons`
- Écrit une seule fois par rayon

---
layout: two-cols
class: compact
---

::title::
# Exercice : *etudiants* (3NF)

::left::

### À éviter

`etudiants`

| id | nom | npa | ville |
|---|---|---|---|
| 1 | Martin | 1400 | Yverdon |
| 2 | Rossi | 1003 | Lausanne |
| 3 | Weber | 1400 | Yverdon |

<v-click>

- `ville` dépend de `npa`
- Une faute de frappe : deux villes

</v-click>

::right::

<v-click>

### À faire

`etudiants`

| id | nom | localite_id |
|---|---|---|
| 1 | Martin | 1 |
| 2 | Rossi | 2 |
| 3 | Weber | 1 |

`localites`

| id | npa | ville |
|---|---|---|
| 1 | 1400 | Yverdon |
| 2 | 1003 | Lausanne |

- `localite_id` : clé étrangère vers `localites`
- `npa` et `ville` écrits une seule fois

</v-click>

---
layout: default
---

# 2NF et 3NF

| | 2NF | 3NF |
|---|---|---|
| La colonne dépend de | une **partie** de la clé | une colonne **hors** clé |
| Concerne | les clés composées seulement | toutes les tables |
| Exemple | `titre` dépend de `id`, pas de `genre` | `etage` dépend de `rayon_id` |
| Correction | une table pour cette partie | une table pour cette colonne |

<Card title="Diagnostic" color="#e92528">
<template #icon><pixelarticons-search /></template>
Pour chaque colonne : de quoi dépend-elle vraiment ?
</Card>

---
layout: two-cols
class: compact split
---

::title::
# Champs à texte libre

::left::

### À éviter

`livres`

| id | titre | etat |
|---|---|---|
| 1 | Germinal | Bon |
| 2 | La Peste | bon état |
| 3 | Cosmos | À réparer |
| 4 | Nana | Bon état |

- Un même état, quatre orthographes
<pixelarticons-arrow-right class="text-1xl self-center" />
Compter les livres en bon état : impossible

::right::

### À faire

`livres`

| id | titre | etat_id |
|---|---|---|
| 1 | Germinal | 1 |
| 2 | La Peste | 1 |
| 3 | Cosmos | 2 |
| 4 | Nana | 1 |

`etats`

| id | nom |
|---|---|
| 1 | bon |
| 2 | à réparer |

- Une table de référence
- Chaque valeur saisie une seule fois

---
layout: default
---

# Trois formes normales

| Forme | Exigence | Erreur détectée |
|---|---|---|
| 1NF | Une seule valeur par case | Une liste : relation N:M oubliée |
| 2NF | Chaque colonne dépend de **toute** la clé | Une colonne liée à une partie de la clé |
| 3NF | Chaque colonne dépend **seulement** de la clé | Une colonne liée à une colonne hors clé |

<Card title="Formule" color="#e92528">
<template #icon><pixelarticons-bookmark /></template>
La clé, toute la clé, rien que la clé.
</Card>

---
layout: section
---

# Le modèle logique complet

---
layout: grid
cols: 1fr 1fr
align: center
content: center
---

# MCD et MLD de la bibliothèque

<Figure
  class="w-full my-4"
  src="/images/03/mcd-complet.svg"
  alt="Le MCD complet de la bibliothèque"
  caption="MCD · cours 02"
/>
<Figure
  class="w-2/3 mx-auto my-4"
  src="/images/03/mld-complet.svg"
  alt="Le MLD complet de la bibliothèque"
  caption="MLD · cours 03"
/>

---
layout: default
---

# Résumé

| Conceptuel | Logique |
|---|---|
| Entité | Table |
| Attribut | Colonne |
| Identifiant | `PK`, `UNIQUE` et `NOT NULL` |
| Relation 1:N | `FK` dans la table du côté `0..*` |
| Relation N:M | Table de liaison portant deux `FK` |

---
layout: section
---

# Travaux pratiques

---
layout: two-cols
---

::title::
# TP · Semaine 3

::left::

1. Nouveaux besoins

2. Mettre à jour MCD, puis création MLD

3. Repérer les valeurs répétées dans chaque table

4. Vérifier 1NF, 2NF, 3NF, dans l'ordre, et corriger

5. Exporter l'image et garder le fichier `.drawio`

::right::

<Figure
  class="w-2/3 mx-auto"
  src="/images/03/02-mcd-musee.svg"
  alt="Le MCD du musée, corrigé du TP de la semaine 2"
  href="https://drive.google.com/file/d/16kFrXVQ47jkS6C3mpQ9_FIE25oYGJ2dF/view?usp=sharing"
  caption="<a href='https://drive.google.com/file/d/16kFrXVQ47jkS6C3mpQ9_FIE25oYGJ2dF/view?usp=sharing' target='_blank' rel='noopener'>Corrigé · MCD du musée, semaine 2</a>"
/>
