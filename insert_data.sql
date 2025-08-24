-- Utilisateurs en France
INSERT INTO Utilisateur (ref_utilisateur, login, mot_de_passe, score, nom, prenom, adresse, pays, date_de_naissance, date_d_inscription, nom_programme)
VALUES (1, 'user1', 'motdepasse1', 0, 'Nom1', 'Prenom1', 'Adresse1', 'France', TO_DATE('1990-01-01', 'YYYY-MM-DD'), SYSDATE, 'Programme1');

INSERT INTO Utilisateur (ref_utilisateur, login, mot_de_passe, score, nom, prenom, adresse, pays, date_de_naissance, date_d_inscription, nom_programme)
VALUES (2, 'user2', 'motdepasse2', 0, 'Nom2', 'Prenom2', 'Adresse2', 'France', TO_DATE('1985-05-15', 'YYYY-MM-DD'), SYSDATE, 'Programme2');

INSERT INTO Utilisateur (ref_utilisateur, login, mot_de_passe, score, nom, prenom, adresse, pays, date_de_naissance, date_d_inscription, nom_programme)
VALUES (3, 'user3', 'motdepasse3', 0, 'Nom3', 'Prenom3', 'Adresse3', 'France', TO_DATE('1995-08-20', 'YYYY-MM-DD'), SYSDATE, 'Programme3');

INSERT INTO Utilisateur (ref_utilisateur, login, mot_de_passe, score, nom, prenom, adresse, pays, date_de_naissance, date_d_inscription, nom_programme)
VALUES (4, 'user4', 'motdepasse4', 80, 'Nom4', 'Prenom4', 'Adresse4', 'Australie', TO_DATE('1988-12-10', 'YYYY-MM-DD'), SYSDATE, 'Programme4');

INSERT INTO Utilisateur (ref_utilisateur, login, mot_de_passe, score, nom, prenom, adresse, pays, date_de_naissance, date_d_inscription, nom_programme)
VALUES (5, 'user5', 'motdepasse5', 200, 'Nom5', 'Prenom5', 'Adresse5', 'États-Unis', TO_DATE('1980-07-25', 'YYYY-MM-DD'), SYSDATE, 'Programme5');

INSERT INTO Utilisateur (ref_utilisateur, login, mot_de_passe, score, nom, prenom, adresse, pays, date_de_naissance, date_d_inscription, nom_programme)
VALUES (6, 'user6', 'motdepasse6', 90, 'Nom6', 'Prenom6', 'Adresse6', 'Australie', TO_DATE('1992-03-05', 'YYYY-MM-DD'), SYSDATE, 'Programme6');


INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (1, 'Liste_France_1', 1);
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (2, 'Liste_France_2', 2);

-- Liste de tâches pour l'utilisateur 2 (France)
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (3, 'Liste_France_3', 3);
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (4, 'Liste_France_4', 3);

-- Liste de tâches pour l'utilisateur 4 (Australie)
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (5, 'Liste_Australie_1', 4);
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (6, 'Liste_Australie_2', 4);

-- Liste de tâches pour l'utilisateur 5 (États-Unis)
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (7, 'Liste_EtatsUnis_1', 5);
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (8, 'Liste_EtatsUnis_2', 5);
INSERT INTO Liste_tache (ref_liste, nom_categorie, ref_utilisateur) VALUES (9, 'Liste_EtatsUnis_3', 5);


-- Insérer la première périodicité
INSERT INTO Periodicite (ref_periodicite, date_debut, date_fin, periode)
VALUES (1, TO_TIMESTAMP('2023-10-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-10-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), INTERVAL '7' DAY);

INSERT INTO Periodicite (ref_periodicite, date_debut, date_fin, periode)
VALUES (2, TO_TIMESTAMP('2023-12-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2023-12-15 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), INTERVAL '14' DAY);


-- creer les taches
INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Creer la base de donnees', 'Description de la BDD', 2, 'https://exemple.com/BDD', TO_TIMESTAMP('2024-01-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_1', 1, 1, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 15, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));


INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Optimiser la base de donnees', 'Optimiser la base de donnees sql plus', 3, 'https://exemple.com/opti', TO_TIMESTAMP('2024-01-05 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_1', 2, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 25, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Conception UI', 'Design et conception UI', 3, 'https://exemple.com/UI', TO_TIMESTAMP('2024-01-10 22:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_1', 2, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 20, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Fonction de la base donnees', 'Description fonction a avoir', 2, 'https://exemple.com/BDD1', TO_TIMESTAMP('2024-01-04 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_1', 1, 1, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 2, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Service backend', 'Creer service', 3, 'https://exemple.com/service', TO_TIMESTAMP('2024-01-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_1', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 5, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));


INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'API', 'Creer API', 2, 'https://exemple.com/service', SYSTIMESTAMP, 'Encours', 'Liste_France_1', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 50, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));
INSERT INTO Depend_de (ref_tache_1, ref_tache_2) VALUES (4, 5);

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (1, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Design UI', 'Expliquer le design', 2, 'https://exemple.com/design', TO_TIMESTAMP('2024-01-08 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_1', 1, 1, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 35, 'Liste_France_1');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme1', TO_CHAR(idTache_seq.currval));



INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Design LOGO', 'Dessiner le logo de application', 2, 'https://exemple.com/design', TO_TIMESTAMP('2024-01-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_3', 1, 1, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 45, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Conception des layout', 'Creer des layouts', 3, 'https://exemple.com/layout', TO_TIMESTAMP('2024-01-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_3', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 10, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));



INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'IHM HTML', 'IHM user interface', 3, 'https://exemple.com/layout', TO_TIMESTAMP('2024-01-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_3', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 60, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));
INSERT INTO Depend_de (ref_tache_1, ref_tache_2) VALUES (8, 9);


INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Creation du site', 'Creer le site de application', 2, 'https://exemple.com/site', TO_TIMESTAMP('2024-01-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_3', 2, 1, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 110, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));


INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Preparer les installation des pre requis', 'Preparer les pre requis necessaire', 2, 'https://exemple.com/site', TO_TIMESTAMP('2024-01-05 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_3', 2, 1, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 20, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));



INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Design LOGO', 'Dessiner le logo de application', 2, 'https://exemple.com/design', TO_TIMESTAMP('2024-01-07 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_3', 1, 3, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 45, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Conception des layout', 'Creer des layouts', 3, 'https://exemple.com/layout', TO_TIMESTAMP('2024-01-06 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_3', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 10, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));

INSERT INTO Depend_de (ref_tache_1, ref_tache_2) VALUES (12, 13);

INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'IHM HTML', 'IHM user interface', 3, 'https://exemple.com/layout', TO_TIMESTAMP('2024-01-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_3', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 60, 'Liste_France_3');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));



INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (2, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (2, idTache_seq.currval);
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Calculer les estimation des UI', 'Calculer les estimation user interface', 2, 'https://exemple.com/site', TO_TIMESTAMP('2024-01-02 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'complet', 'Liste_France_2', 2, 3, SYSTIMESTAMP);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 15, 'Liste_France_2');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));


INSERT INTO Tache (ref_tache) VALUES (idTache_seq.nextval);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (2, idTache_seq.currval);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (2, idTache_seq.currval);
INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (idTache_seq.currval, 'Mettre en place Agile', 'Agile', 3, 'https://exemple.com/agile', TO_TIMESTAMP('2024-01-16 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Encours', 'Liste_France_2', 1, 1, NULL);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (idTache_seq.currval, '0', 10, 'Liste_France_2');
INSERT INTO Comporte (nom_programme, ref_score_categorie_tache) VALUES ('programme2', TO_CHAR(idTache_seq.currval));
