---
title: "Examen type · Intermédiaire"
lang: fr
---

::: entete
Modélisation de Données · HEIG-VD / COMEM+

# Examen type · Intermédiaire
:::

::: identite
Nom : ........................................ Prénom : ........................................
:::

| Élément | Détail |
|---|---|
| Programme | Cours 01 à 04 |
| Support | Papier, sans machine |
| Durée | 2 heures |
| Documents | Formulaire A4 recto-verso, manuscrit |

| Partie | Sujet | Points |
|---|---|---|
| 1 | Modèle conceptuel (MCD) | 15 |
| 2 | Modèle logique (MLD) et normalisation | 20 |
| 3 | Modèle physique (MPD) | 30 |
| 4 | QCM | 15 |
|   | **Total** | **80** |

## Partie 1 : Modèle conceptuel (MCD) · 15 points {.nouvelle-page}

### Besoins

> - Notre service gère les forêts du canton.
> - Chaque forêt a un nom, propre à elle seule, et une surface en hectares, toujours renseignée.
> - Certaines forêts font partie d'une zone protégée, d'autres non.
> - Une zone protégée a un nom et une date de classement, et regroupe au moins une forêt.
> - Dans chaque forêt, on recense des arbres remarquables.
> - On dit « l'arbre 12 de la forêt des Combes » : le numéro repart à 1 dans chaque forêt.
> - On note la hauteur de chaque arbre et, quand on la connaît, son année de plantation.
> - Chaque arbre appartient à une essence (chêne, hêtre, épicéa), et on tient la liste des essences à part.
> - Nos agent·e·s ont un nom, un prénom, une adresse e-mail jamais partagée et, parfois, un téléphone.
> - Une intervention est menée par une seule personne.
> - Un·e agent·e qui vient d'arriver n'en a encore mené aucune.
> - Pour chaque intervention, on note sa date et si elle est terminée.
> - Une intervention concerne au moins une forêt, souvent plusieurs.
> - Certaines forêts n'ont jamais connu d'intervention.
> - Pour chaque forêt concernée, on note le nombre d'heures passées.
> - On veut afficher le nombre d'arbres recensés dans chaque forêt.

### Question 1.1 · 12 points

Dessiner le MCD en notation UML vue en cours.

Dessiner sur la page suivante.

::: {.zone .zone-pleine .nouvelle-page}
:::

### Question 1.2 · 3 points {.nouvelle-page}

Répondre en une phrase par point.

a) Quel type d'entité est `arbres` ? À quoi le voit-on dans le besoin ?

::: {.zone .zone-s}
:::

b) Quel type d'entité faut-il entre `forets` et `interventions` ? À quoi le voit-on dans le besoin ?

::: {.zone .zone-s}
:::

c) Le nombre d'arbres par forêt devient-il un attribut de `forets` ? Justifier.

::: {.zone .zone-s}
:::

## Partie 2 : Modèle logique (MLD) et normalisation · 20 points {.nouvelle-page}

### Question 2.1 · 11 points

Traduire le MCD de la partie 1 en MLD avec la notation vue en cours. 

::: {.zone .zone-grande}
:::

### Question 2.2 · 9 points {.nouvelle-page}

Ces trois tables ne font pas partie du modèle précédent. Chacune viole une forme normale différente. Pour chaque table : nommer la forme normale violée, dire en une phrase de quoi dépend la colonne fautive (ou ce qui pose problème), puis écrire la ou les tables corrigées, avec leurs lignes. 3 points par table.

:::: tables
**Table A**

`agents`

| id | nom | secteur_id | chef_secteur |
|---|---|---|---|
| 1 | Martin | 2 | Keller |
| 2 | Rossi | 2 | Keller |
| 3 | Weber | 5 | Dubois |

Clé primaire : `id`

::: {.zone .zone-t}
:::
::::

:::: tables
**Table B**

`sentiers`

| id | nom | communes |
|---|---|---|
| 1 | Crêtes | Vallorbe, Ballaigues |
| 2 | Source | Orbe |

Clé primaire : `id`

::: {.zone .zone-t}
:::
::::

:::: tables
**Table C**

`outils_interventions`

| outil_id | intervention_id | quantite | nom_outil |
|---|---|---|---|
| 1 | 10 | 2 | Tronçonneuse |
| 1 | 11 | 1 | Tronçonneuse |
| 2 | 10 | 3 | Hache |

Clé primaire : le couple `outil_id`, `intervention_id`

::: {.zone .zone-t}
:::
::::

## Partie 3 : Modèle physique (MPD) · 30 points {.nouvelle-page}

### Besoins

> - La surface d'une forêt est strictement positive.
> - Une zone supprimée libère ses forêts, qui restent en base sans zone.
> - Une intervention est considérée comme non terminée tant qu'on n'indique rien d'autre.
> - Un·e agent·e qui a encore des interventions ne peut pas être supprimé·e.
> - Les heures, quand elles sont notées, sont strictement positives.
> - Une intervention supprimée emporte le détail de ses forêts.
> - Une forêt déjà concernée par une intervention ne peut pas être supprimée.

### Question 3.1 · 20 points {.nouvelle-page}

Écrire le `CREATE TABLE` de ces trois tables seulement, sans les quatre autres : `forets` (6 points), `interventions` (6 points), `forets_interventions` (8 points). Traduire les types pour SQLite et donner un mode de suppression à chaque clé étrangère.

::: {.zone .zone-grande}
:::

### Question 3.2 · 6 points {.nouvelle-page}

Le script complet doit pouvoir se relancer sans erreur, et le SGBD doit contrôler les clés étrangères.

a) Écrire tout ce qui précède le premier `CREATE TABLE`, pour les sept tables. (3 points)

::: {.zone .zone-m}
:::

b) Donner un ordre de création valide pour les sept tables sous forme de liste numerotée (2 points)

::: {.zone .zone-s}
:::

c) Quelle commande du terminal SQLite exécute le fichier `forets.sql` ? (1 point)

::: {.zone .zone-xs}
:::

### Question 3.3 · 4 points

Écrire une instruction par changement, sans recréer les tables. 1 point par instruction.

a) Le téléphone des agent·e·s ne sert plus.

b) On veut noter la date d'engagement de chaque agent·e.

c) Dans `arbres`, `hauteur` s'appelle désormais `hauteur_m`.

d) La table `essences` s'appelle désormais `especes`.

::: {.zone .zone-m}
:::

## Partie 4 : QCM · 15 points {.nouvelle-page}

Une seule bonne réponse par question. 1 point par bonne réponse, aucun point retiré en cas d'erreur.

::: question
**1.** Lequel de ces énoncés est une connaissance ?

- [ ] a) `14`
- [ ] b) 14 arbres malades recensés dans la forêt des Combes
- [ ] c) La maladie gagne la lisière : concentrer les inspections sur cette bande
- [ ] d) Une colonne `nb_arbres_malades` de type `INTEGER`
:::

::: question
**2.** Qu'est-ce qui caractérise une entité faible ?

- [ ] a) Elle naît d'une relation entre deux entités et porte les attributs de ce lien
- [ ] b) Elle n'existe pas sans son parent, et son identifiant emprunte celui du parent
- [ ] c) Elle n'a aucun identifiant
- [ ] d) Elle porte son propre identifiant et existe seule
:::

::: question
**3.** Dans la table `refuges`, la colonne `adresse` contient la rue, le code postal et la commune. Quel est le diagnostic ?

- [ ] a) Attribut dérivé : il se calcule à partir des autres
- [ ] b) Il empêche la création de clés étrangères
- [ ] c) Il devient une clé composite
- [ ] d) Attribut composé : il se décompose en colonnes
:::

::: question
**4.** La table `chantiers` contient `date_debut`, `date_fin` et `duree_jours`. Que faire de `duree_jours` ?

- [ ] a) Ne pas la stocker : elle se calcule à partir des deux dates
- [ ] b) En faire la clé primaire
- [ ] c) Lui ajouter la contrainte `UNIQUE`
- [ ] d) La déplacer dans une table de liaison
:::

::: question
**5.** Un réseau regroupe plusieurs sentiers. Un sentier peut n'appartenir à aucun réseau, et jamais à plus d'un. Quelle multiplicité écrire au bout du trait, collée à `reseaux` ?

- [ ] a) `1`
- [ ] b) `0..*`
- [ ] c) `0..1`
- [ ] d) `1..*`
:::

::: question
**6.** Un sentier compte plusieurs panneaux. Un panneau est posé sur un seul sentier. Quelle est la bonne traduction dans le MLD ?

- [ ] a) Une table de liaison `sentiers_panneaux`
- [ ] b) Une clé étrangère `panneau_id` dans `sentiers`
- [ ] c) Une contrainte `UNIQUE` sur `sentier_id`
- [ ] d) Une clé étrangère `sentier_id` dans `panneaux`
:::

::: question
**7.** Toujours pour les réseaux de la question 5 : la table `sentiers` reçoit `reseau_id`. Quelle est la règle pour cette colonne ?

- [ ] a) Elle porte `NOT NULL`
- [ ] b) Elle peut rester vide
- [ ] c) Elle porte `UNIQUE`
- [ ] d) Elle devient la clé primaire de `sentiers`
:::

::: question
**8.** Un outil sert à plusieurs interventions. Une intervention utilise plusieurs outils. Quelle est la bonne traduction dans le MLD ?

- [ ] a) Une table de liaison portant deux clés étrangères
- [ ] b) Une clé étrangère `outil_id` dans `interventions`
- [ ] c) Une clé étrangère dans chacune des deux tables
- [ ] d) Une colonne `outils` qui liste les outils dans `interventions`
:::

::: question
**9.** Un arbre est lié à une forêt. Un·e étudiant·e ajoute une colonne `nom_foret` dans `arbres`, au lieu d'une clé étrangère. Quel est le problème ?

- [ ] a) Une table de liaison devient nécessaire
- [ ] b) La table `forets` perd sa clé primaire
- [ ] c) Le nom se répète et le SGBD ne contrôle plus le lien
- [ ] d) La relation devient N:M
:::
Best,

::: question
**10.** En passant du MCD au MLD, un·e étudiant·e oublie de définir les clés primaires. Quelle est la conséquence ?

- [ ] a) Les cardinalités deviennent inutiles
- [ ] b) Les types de données deviennent automatiques
- [ ] c) Les doublons sont refusés d'office
- [ ] d) Aucune clé étrangère ne peut désigner une ligne précise
:::

::: question
**11.** Dans la table `outils`, la colonne `etat` contient « Bon », « bon », « OK » et « En panne ». Quelle est la meilleure amélioration ?

- [ ] a) Supprimer la colonne
- [ ] b) Créer une table de référence et une clé étrangère vers elle
- [ ] c) Ajouter `NOT NULL` à la colonne
- [ ] d) Convertir l'état en booléen
:::

::: question
**12.** La longueur d'un sentier est toujours renseignée et strictement positive. Quelles contraintes combiner ?

- [ ] a) `NOT NULL` et `CHECK (longueur > 0)`
- [ ] b) `NOT NULL` et `DEFAULT 0`
- [ ] c) `UNIQUE` et `DEFAULT 1`
- [ ] d) `REFERENCES` et `CHECK (longueur > 0)`
:::

::: question
**13.** Le service quitte SQLite pour PostgreSQL. Quel modèle faut-il réécrire ?

- [ ] a) Le MCD
- [ ] b) Le MLD
- [ ] c) Le MPD
- [ ] d) Les trois
:::

::: question
**14.** Quel est le problème de cette colonne ?

```sql
sentier_id INTEGER NOT NULL
  REFERENCES sentiers(id)
  ON DELETE SET NULL
```

- [ ] a) Il manque `UNIQUE`
- [ ] b) `SET NULL` exige une colonne sans `NOT NULL`
- [ ] c) `REFERENCES` se déclare après la liste des colonnes
- [ ] d) Une clé étrangère n'accepte pas `ON DELETE`
:::

::: question
**15.** Dans SQLite, comment ajouter `NOT NULL` à une colonne existante avec `ALTER TABLE` ?

- [ ] a) `ADD CONSTRAINT`
- [ ] b) `ADD COLUMN`, avec le même nom de colonne
- [ ] c) `RENAME COLUMN`
- [ ] d) C'est impossible : les contraintes ne sont pas modifiables
:::
