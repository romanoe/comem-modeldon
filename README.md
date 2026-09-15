# Modélisation de Données

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

Cours d'introduction aux bases de données relationnelles pour la filière Ingénierie des Médias, HEIG-VD.

Ce document est mis à jour au fur et à mesure du semestre avec les informations du cours, les jalons du projet et les ressources.

---

## Objectifs

- **Structurer** des données dans un **modèle relationnel** adapté à un domaine métier
- **Modéliser** un problème réel sous forme d'**entités**, d'**attributs** et de **relations**
- **Traduire** un diagramme entité-association en **schéma SQL** exploitable
- **Interroger** et **transformer** des données pour répondre à des besoins métier
- **Analyser** des données structurées pour produire des **indicateurs** et des **statistiques**

---

## Outils

| Outil | Usage |
|---|---|
| VS Code + Dev Containers | Environnement de travail unifié, fourni par le template du projet (SQLite pré-installé) |
| DBML | Décrire le diagramme E-R en DBML ; prévisualisé dans VS Code (extension du devcontainer) et versionné dans le repo |
| SQLite Viewer (extension VS Code) | Visualiser les fichiers `.db` directement dans l'éditeur |
| SQLite CLI | Exécuter des requêtes dans le terminal intégré |

### Démarrage rapide

Ce dépôt contient les slides. Les étudiant·e·s ne le clonent pas : elles et ils créent leur dépôt de groupe depuis le [template du projet](https://github.com/romanoe/comem-model-template) avec **Use this template**.

```bash
# 1. Cloner le dépôt de groupe créé depuis le template
git clone https://github.com/<compte>/<depot-du-groupe>.git

# 2. Ouvrir dans VS Code
code <depot-du-groupe>

# 3. Accepter d'ouvrir dans le devcontainer (notification VS Code)
# SQLite est prêt dans le terminal
sqlite3 --version
```

---

## Cours

| # | Module | Contenu |
|---|---|---|
| 01 | Introduction | Donnée · Information · Connaissance · Du tableur à la base · SGBD · Diagramme E-R |
| 02 | Modèle entité-association | Entités · Types d'entités · Types d'attributs · Normalisation · DBML |
| 03 | Clés et relations | Relations · Cardinalités · Clé primaire · Clé étrangère · 1:N et N:M |
| 04 | Stockage local | SQLite · CREATE TABLE · Types · Intégrité référentielle · Modes de suppression |
| 05 | Interroger les données | SELECT · FROM · WHERE · ORDER BY · INSERT · UPDATE · DELETE |
| 06 | Connecter les données | Donnée morcelée · INNER JOIN · LEFT JOIN |
| 07 | Analyser les données | Agrégation · COUNT · SUM · AVG · GROUP BY · HAVING · CREATE VIEW |
| 08 | La donnée semi-structurée | JSON · Syntaxe · Comparaison avec le modèle relationnel |

---

## Évaluation

| Composante | Poids | Période |
|---|---|---|
| Projet fil rouge (musée) | 50% | Fin de semestre |
| Examen final | 50% | Jan-fev · Format papier · Questions ouvertes · QCM |

### Échelle d'évaluation

Chaque critère du projet est noté sur l'échelle suivante :

- **0 point** : critère non respecté (production absente, hors sujet ou très incomplète)
- **1 point** : critère partiellement respecté (éléments essentiels manquants ou imprécis)
- **2 points** : critère pleinement respecté (attendu présent, précis et maîtrisé)

Note du projet : `(points obtenus / points totaux) × 5 + 1`.

### Critères d'évaluation du projet

| # | Critère | Rendu attendu |
|---|---|---|
| 1 | Workflow Git/GitHub professionnel : issues, branches, pull requests, gestion des conflits | Historique Git et pull requests |
| 2 | README clair faisant office de rapport : journal de travail et conclusion | `README.md` |
| 3 | Diagramme E-R cohérent avec le domaine : entités, attributs, relations, cardinalités | Diagramme E-R en DBML |
| 4 | Schéma physique SQLite : types, contraintes, clés étrangères | `sql/schema.sql` |
| 5 | Données traitées et importées correctement | `sql/import.sql` |
| 6 | Requêtes SQL justes et lisibles : sélections, jointures, agrégats | `sql/requetes/` |
| 7 | Retours individuels rédigés après chaque séance | `retours/retour-XX-prenom.md` |

### Contraintes

- Chaque membre de l'équipe contribue de manière équitable.
- La documentation permet à une personne externe de comprendre et reprendre le projet.
- Le travail est rendu dans les temps.
- L'usage d'outils d'intelligence artificielle ou de code copié de sources externes est autorisé **à condition d'être justifié** : indiquer **quand**, **comment** et **pourquoi**, et expliquer le code et son intégration. Une justification insuffisante ou un manque de transparence entraîne la note **1** pour le travail concerné. Voir [JUSTIFICATIONS_IA.md](https://github.com/romanoe/comem-model-template/blob/main/JUSTIFICATIONS_IA.md) dans le template.

---

## Projet fil rouge : le musée

### Contexte

Tout au long du cours, les étudiant·e·s construisent une base de données de gestion d'un musée fictif. Le projet couvre l'ensemble du parcours : modélisation, création des tables, insertion des données, interrogation et analyse.

### Entités principales

| Entité | Description |
|---|---|
| `artistes` | Créateur·rice·s des œuvres |
| `oeuvres` | Pièces de la collection (titre, année, technique) |
| `salles` | Salles et espaces d'exposition |
| `expositions` | Expositions permanentes et temporaires (dates, salle) |
| `billets` | Catégories de billets et tarifs |
| `visiteurs` | Acheteur·euse·s de billets |

### Dépôt template

Les groupes partent de [romanoe/comem-model-template](https://github.com/romanoe/comem-model-template) via **Use this template**. Le `README.md` de ce dépôt porte l'énoncé, le barème et la grille détaillée.

### Jalons

| Jalon | Thème | Livrable |
|---|---|---|
| J1 | Modélisation | Diagramme E-R DBML du musée |
| J2 | SQLite physique | Base `.db` avec tables et données de test |
| J3 | SQL | Ensemble de requêtes documentées |

---

## Ressources

- [SQLite documentation officielle](https://www.sqlite.org/docs.html)
- [SQLite Tutorial](https://www.sqlitetutorial.net)

---

## Licence

Ce matériel est mis à disposition sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

Vous êtes libre de partager et adapter ce contenu, à condition de créditer l'autrice.

---

*Slides construits avec [comem-cours-template](https://github.com/romanoe/comem-cours-template) · [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)*
