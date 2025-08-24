📌 Projet Base de Données – To-Do List
🎯 Objectif

  Conception d’une base de données Oracle pour une application de gestion de listes de tâches (to-do list). Elle permet aux utilisateurs d’organiser, suivre et accomplir leurs tâches dans différents projets.

⚙️ Fonctionnalités

  Gestion des utilisateurs (infos personnelles, login unique, mot de passe).
  
  Gestion des tâches (intitulé, description, échéance, priorité, catégorie, lien externe).
  
  Dépendances entre tâches et tâches périodiques.
  
  Suivi de la régularité et attribution d’un score/niveau (gamification).
  
  Multi-utilisateurs sur une même tâche.
  
  Séparation entre tâches en cours et passées.
  
📂 Contenu du dépôt

  create_tables.sql
  Script SQL pour la création des tables principales de la base (utilisateurs, projets, tâches, dépendances, etc.) avec leurs contraintes d’intégrité.
  
  drop_tables.sql
  Script permettant de supprimer toutes les tables de la base (utilisé pour réinitialiser la BD).
  
  insert_data.sql
  Script d’insertion de données de test (utilisateurs, projets, tâches, relations…).
  
  procedures_queries_index.sql
  Contient :
  
    Les requêtes SQL demandées (ex. listes de tâches ≥ 5, top utilisateurs par score, etc.).
    
    Les définitions des index pour optimiser les performances.
    
    Les procédures/fonctions PL/SQL (calcul de score, archivage des tâches, etc.).
    
  sequences_create_drop.sql
  Scripts pour créer et supprimer les séquences Oracle utilisées pour générer automatiquement des identifiants uniques.
  
  suggestionPL.sql
  Contient le code PL/SQL permettant de générer des suggestions de tâches pour un utilisateur, en fonction de la similarité avec d’autres utilisateurs.
  
  test.sql
  Script regroupant des cas de test pour vérifier le bon fonctionnement des procédures, fonctions, déclencheurs et contraintes.
  
  triggers.sql
  Définit les déclencheurs PL/SQL, par exemple :
  
  Mise à jour automatique du score lorsqu’une tâche est terminée ou archivée.
  
  Génération automatique de tâches périodiques à partir de leur définition.
Modèle E/A
<img width="1031" height="769" alt="Capture d'écran 2025-08-24 120144" src="https://github.com/user-attachments/assets/8ffa97a8-bd1b-4ae8-ad47-3e3fc9388490" />

