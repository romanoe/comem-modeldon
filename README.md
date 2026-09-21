# Modélisation de Données

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)

Cours d'introduction aux bases de données relationnelles pour la filière Ingénierie des Médias, HEIG-VD.

Ce document est mis à jour au fur et à mesure du semestre avec les informations du cours, le déroulé des TP et les ressources.

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
| [dbdiagram.io](https://dbdiagram.io/) | Dessiner le diagramme E-R dans le navigateur, l'exporter en image et en fichier source |
| VS Code | Éditeur du cours : écrire et exécuter le SQL |
| SQLite CLI | Exécuter des requêtes dans le terminal |
| SQLite Viewer (extension VS Code) | Visualiser les fichiers `.db` directement dans l'éditeur |

### Démarrage rapide

Ce dépôt contient les slides. Les étudiant·e·s ne le clonent pas : elles et ils installent leur environnement une fois pour toutes.

1. Créer un compte gratuit sur [dbdiagram.io](https://dbdiagram.io/)
2. Installer [SQLite](https://www.sqlite.org/download.html) et vérifier l'installation

```bash
sqlite3 --version
```

---

## Cours

| # | Module | Contenu |
|---|---|---|
| 01 | Introduction | Donnée · Information · Connaissance · Du tableur à la base · SGBD · Diagramme E-R |
| 02 | Modèle entité-association | Entités · Types d'entités · Types d'attributs · Nommage · Normalisation (1NF) · dbdiagram.io |
| 03 | Clés et relations | Relations · Cardinalités · Clé primaire · Clé étrangère · 1:N et N:M |
| 04 | Normalisation | Dépendances fonctionnelles · 1NF · 2NF · 3NF · Dénormalisation |
| 05 | Stockage local | SQLite · CREATE TABLE · Types · Intégrité référentielle · Modes de suppression |
| 06 | Interroger les données | SELECT · FROM · WHERE · ORDER BY · INSERT · UPDATE · DELETE |
| 07 | Connecter les données | Donnée morcelée · INNER JOIN · LEFT JOIN |
| 08 | Analyser les données | Agrégation · COUNT · SUM · AVG · GROUP BY · HAVING · CREATE VIEW |
| 09 | La donnée semi-structurée | JSON · Syntaxe · Comparaison avec le modèle relationnel |

---

## Évaluation

| Composante | Poids | Période |
|---|---|---|
| Examen intermédiaire | 50% | Mi-semestre · Format papier · Questions ouvertes · QCM |
| Examen final | 50% | Jan-fev · Format papier · Questions ouvertes · QCM |

L'examen intermédiaire porte sur la partie modélisation, cours 01 à 05. L'examen final porte sur l'ensemble du semestre.

### Travaux pratiques

Les TP ne sont pas notés. Ils servent d'entraînement aux deux examens : rien n'est rendu, rien n'est corrigé formellement. Les questions soulevées en séance sont reprises au début de la séance suivante.

---

## Fil rouge des TP : le musée

### Contexte

Tout au long du semestre, cours et TP portent sur le même musée fictif : modélisation, création des tables, insertion des données, interrogation et analyse. Chaque séance applique au musée la notion qu'elle vient d'introduire, si bien que le modèle grossit semaine après semaine. Rien n'est noté : le fil rouge sert à construire le sujet pas à pas et à préparer les examens.

La première séance de TP part d'une seule question, sans outil : **quelles données un musée doit-il gérer pour fonctionner ?**

### Étapes

| Étape | Thème | Production |
|---|---|---|
| 1 | Modélisation | Diagramme E-R du musée, exporté de dbdiagram.io en image et en fichier source |
| 2 | SQLite | Base `.db` avec tables et données de test |
| 3 | SQL | Ensemble de requêtes commentées |

---

## Ressources

- [dbdiagram.io](https://dbdiagram.io/)
- [SQLite documentation officielle](https://www.sqlite.org/docs.html)
- [SQLite Tutorial](https://www.sqlitetutorial.net)

---

## Licence

Ce matériel est mis à disposition sous licence [Creative Commons Attribution 4.0 International (CC BY 4.0)](https://creativecommons.org/licenses/by/4.0/).

Vous êtes libre de partager et adapter ce contenu, à condition de créditer l'autrice.

---

*Slides construits avec [comem-cours-template](https://github.com/romanoe/comem-cours-template) · [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)*
