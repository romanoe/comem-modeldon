# Modélisation de Données

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

Cours d'introduction aux bases de données relationnelles pour la filière Ingénierie des Médias, HEIG-VD.

Ce document est mis à jour au fur et à mesure du semestre avec les informations du cours, le déroulé des TP et les ressources.

**Slides en ligne : [comem-modeldon.onrender.com](https://comem-modeldon.onrender.com)**

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
| [draw.io](https://app.diagrams.net/) | Dessiner le diagramme E-R dans le navigateur, l'exporter en image et en fichier `.drawio` |
| [Environnement de TP](https://github.com/romanoe/comem-modeldon-tp) | VS Code, SQLite et SQLite Viewer prêts, dans Codespaces ou en local avec Docker |
| VS Code | Éditeur du cours : écrire et exécuter le SQL |
| SQLite CLI | Exécuter des requêtes dans le terminal |
| SQLite Viewer (extension VS Code) | Visualiser les fichiers `.db` directement dans l'éditeur |

### Démarrage rapide

Ce dépôt contient les slides. Les étudiant·e·s ne le clonent pas : leur environnement de travail est le dépôt [comem-modeldon-tp](https://github.com/romanoe/comem-modeldon-tp), qui ne contient que VS Code et SQLite.

1. Ouvrir [draw.io](https://app.diagrams.net/) dans le navigateur, aucun compte à créer
2. Ouvrir l'environnement de TP : [dans Codespaces](https://codespaces.new/romanoe/comem-modeldon-tp), ou en local avec Docker et l'extension VS Code Dev Containers (**Reopen in Container**)
3. Vérifier SQLite dans le terminal

```bash
sqlite3 --version
```

Les fichiers d'exercice se téléchargent depuis les liens des slides, puis se glissent dans l'explorateur de VS Code. Git n'est pas nécessaire.

---

## Cours

Les trois niveaux de modèle structurent le semestre : **conceptuel** au cours 02, **logique** au cours 03, **physique** au cours 04. Les cours 05 et suivants sont en cours d'écriture et n'affichent pour l'instant qu'une page d'attente.

| # | Module | Contenu |
|---|---|---|
| 01 | [Introduction](https://comem-modeldon.onrender.com/01-introduction/) | Donnée · Information · Connaissance · Du tableur à la base · SGBD · Diagramme E-R |
| 02 | [Modèle conceptuel](https://comem-modeldon.onrender.com/02-modele-conceptuel/) | Modèle relationnel · Notation UML · Entité · Attribut · Identifiant · Contraintes · Relation · Cardinalités · Nommage |
| 03 | [Modèle logique](https://comem-modeldon.onrender.com/03-modele-logique/) | Entité en table · Clé primaire · Clé étrangère · Contraintes des clés · Relation 1:N · Relation N:M · Table de liaison · Clé primaire composite · Normalisation · 1NF · 2NF · 3NF · Champs à texte libre · Généralisation |
| 04 | [Modèle physique](https://comem-modeldon.onrender.com/04-modele-physique/) | SQLite · Types · CREATE TABLE · Contraintes de colonne · Clé étrangère · Intégrité référentielle · Modes de suppression · Clé primaire composite |
| 05 | [Interroger les données](https://comem-modeldon.onrender.com/05-interroger/) | SELECT · FROM · WHERE · ORDER BY · INSERT · UPDATE · DELETE |
| 06 | [Connecter les données](https://comem-modeldon.onrender.com/06-connecter/) | Donnée morcelée · INNER JOIN · LEFT JOIN |
| 07 | [Analyser les données](https://comem-modeldon.onrender.com/07-analyser/) | Agrégation · COUNT · SUM · AVG · GROUP BY · HAVING · CREATE VIEW |
| 08 | [Indexer et optimiser](https://comem-modeldon.onrender.com/08-optimiser/) | Parcours complet · Index · EXPLAIN QUERY PLAN · Coût d'un index · Dénormalisation |
| 09 | [La donnée semi-structurée](https://comem-modeldon.onrender.com/09-semi-structure/) | JSON · Syntaxe · Comparaison avec le modèle relationnel |

---

## Évaluation

| Composante | Poids | Période |
|---|---|---|
| Examen intermédiaire | 50% | Mi-semestre · Format papier · Questions ouvertes · QCM |
| Examen final | 50% | Jan-fev · Format papier · Questions ouvertes · QCM |

L'examen intermédiaire porte sur la modélisation et la création des tables, cours 01 à 04. L'examen final porte sur l'ensemble du semestre.

### Travaux pratiques

Les TP ne sont pas notés. Ils servent d'entraînement aux deux examens : rien n'est rendu, rien n'est corrigé formellement. Les questions soulevées en séance sont reprises au début de la séance suivante.

---

## Fil rouge des TP : le musée

### Deux domaines

Les exemples présentés en classe prennent une **bibliothèque** : livres, auteurs, rayons, lecteur·rice·s, emprunts. Le fil rouge des TP reste le **musée** : la classe voit la notion sur la bibliothèque, puis l'applique à son propre modèle.

### Contexte

Tout au long du semestre, les TP portent sur le même musée fictif : modélisation, création des tables, insertion des données, interrogation et analyse. Chaque séance applique au musée la notion qu'elle vient d'introduire, si bien que le modèle grossit semaine après semaine. Rien n'est noté : le fil rouge sert à construire le sujet pas à pas et à préparer les examens.

La première séance de TP part d'une seule question, sans outil : **quelles données un musée doit-il gérer pour fonctionner ?**

### Étapes

| Étape | Thème | Production |
|---|---|---|
| 1 | Modélisation | Diagramme E-R du musée, dessiné dans draw.io, exporté en image et gardé en `.drawio` |
| 2 | SQLite | Base `.db` avec tables et données de test |
| 3 | SQL | Ensemble de requêtes commentées |

---

## Ressources

- [Slides du cours](https://comem-modeldon.onrender.com)
- [Dépôt GitHub du cours](https://github.com/romanoe/comem-modeldon)
- [draw.io](https://app.diagrams.net/)
- [SQLite documentation officielle](https://www.sqlite.org/docs.html)
- [SQLite Tutorial](https://www.sqlitetutorial.net)

---

## Licence

Ce matériel est mis à disposition sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

Vous êtes libre de partager et adapter ce contenu, à condition de créditer l'autrice.

---

*Slides construits avec [comem-cours-template](https://github.com/romanoe/comem-cours-template) · [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)*
