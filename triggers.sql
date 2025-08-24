--Triigers

--MAJ les scores pour les taches finies
CREATE OR REPLACE TRIGGER update_score_trigger_tache_fini
BEFORE INSERT OR UPDATE ON Tache_fini
FOR EACH ROW
DECLARE
    v_score INT;
    rf_userID INT;
BEGIN
    BEGIN
        -- Trouver l'utilisateur assigne à la tache teminee
        SELECT es.ref_utilisateur 
        INTO rf_userID 
        FROM Tache_fini tf
        INNER JOIN Est_assigne es ON es.ref_tache = tf.ref_tache
        WHERE tf.ref_tache = :NEW.ref_tache ;     
        EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Gérer le cas où aucune donnée n'est trouvée
            rf_userID := null; -- ou une autre valeur par défaut
   
    END;

    -- calculer le point de l'utilisateur
    SELECT SUM(sc.score) INTO v_score
    FROM Tache_fini tf
    INNER JOIN Score_categorie_tache sc ON sc.ref_score_categorie_tache = tf.ref_tache
    INNER JOIN Est_assigne es ON es.ref_tache = tf.ref_tache
    WHERE es.ref_utilisateur = rf_userID;

    -- MAJ le score de l'utilisateur
    IF rf_userID IS NOT NULL THEN
        UPDATE Utilisateur 
        SET score = score + v_score
        WHERE ref_utilisateur = rf_userID;
    END IF;

    -- Mettre à jour le score de la tache (en mettant temine = 1, cela dire que le score de cette tache n'est plus utilise)
    UPDATE Score_categorie_tache
    SET termine = '1'
    WHERE ref_score_categorie_tache = :NEW.ref_tache;

END;
/
SHOW ERRORS trigger update_score_trigger_tache_fini;

--test
INSERT INTO Tache (ref_tache) VALUES (30);
INSERT INTO Est_assigne (ref_utilisateur, ref_tache) VALUES (3, 30);
INSERT INTO Tache_appartenant_a_liste (ref_liste, ref_tache) VALUES (3, 30);
INSERT INTO Score_categorie_tache (ref_score_categorie_tache, termine, score, nom_categorie)
VALUES (30, '0', 60, 'Liste_France_3');
INSERT INTO Tache_fini (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (30, 'Tâche 5', 'Description de la tâche 5', 4, 'https://exemple.com/tache5', SYSTIMESTAMP, 'complet', 'Liste_France_1', 1, 1, SYSTIMESTAMP);


select * from Tache_fini where ref_tache=30;
select * from Score_categorie_tache where ref_score_categorie_tache=30;

--supprimer
ALTER TRIGGER update_score_trigger_tache_fini DISABLE;

----MAJ les scores pour les taches archivees
CREATE OR REPLACE TRIGGER update_score_trigger_tache_archive
AFTER INSERT ON Tache_archivee
FOR EACH ROW
DECLARE
    v_score_gangne INT;
    v_score_perdu INT;
    rf_userID INT;
BEGIN
    -- Récupérer ref_utilisateur avec gestion d'exception
    BEGIN
        SELECT es.ref_utilisateur 
        INTO rf_userID 
        FROM Est_assigne es
        WHERE es.ref_tache = :NEW.ref_tache AND ROWNUM = 1 ; 
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            -- Gérer le cas où aucune donnée n'est trouvée
            rf_userID := null; -- ou une autre valeur par défaut
    END;

    -- Calculer le score
    SELECT SUM(sc.score) INTO v_score_gangne
    FROM Score_categorie_tache sc
    WHERE sc.ref_score_categorie_tache = :NEW.ref_tache ;

    SELECT SUM(sc.score) INTO v_score_perdu
    FROM Tache_en_cours tec
    INNER JOIN Est_assigne es ON tec.ref_tache = es.ref_tache
    INNER JOIN Score_categorie_tache sc ON tec.ref_tache = sc.ref_score_categorie_tache
    WHERE es.ref_utilisateur = rf_userID;

    -- Mettre à jour l'utilisateur
    IF rf_userID IS NOT NULL THEN
        UPDATE Utilisateur 
        SET score = score + (v_score_gangne - v_score_perdu)
        WHERE ref_utilisateur = rf_userID;
    END IF;

    -- Mettre à jour Score_categorie_tache
    UPDATE Score_categorie_tache
    SET termine = '1'
    WHERE ref_score_categorie_tache = :NEW.ref_tache;

END;
/


SHOW ERRORS trigger update_score_trigger_tache_archive;

--exec
INSERT INTO Tache_archivee (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
VALUES (30, 'Tâche 5', 'Description de la tâche 5', 4, 'https://exemple.com/tache5', SYSTIMESTAMP, 'complet', 'Liste_France_1', 1, 1, SYSTIMESTAMP);

select * from Tache_archivee where ref_tache=30;
select * from Score_categorie_tache where ref_score_categorie_tache=30;


--supprimer
ALTER TRIGGER update_score_trigger_tache_archive DISABLE;




--trigger 2
CREATE OR REPLACE TRIGGER create_associated_tasks
AFTER INSERT OR UPDATE ON Periodicite
FOR EACH ROW
WHEN (NEW.date_fin IS NOT NULL)
DECLARE
    v_start_date TIMESTAMP;
    v_end_date TIMESTAMP;
    inc_ref_tache INT;
    heure_deb INT;
    v_interval INTERVAL DAY TO SECOND;
BEGIN
    --ajouter un jours de plus afin d'inserer tous les jour
    v_end_date:=TRUNC(:NEW.date_fin)+1;
    
    -- Calculer le nombre de jours
    v_interval := v_end_date - :NEW.date_debut ;
        -- Calculer heure de debut
    heure_deb := EXTRACT(hour FROM :NEW.date_debut)-2;
    
    -- Utiliser une boucle pour creer des tâches associees pour chaque jour
    FOR i IN 0..EXTRACT(DAY FROM v_interval)
    LOOP
        -- Calculer la nouvelle date de début pour chaque jour
        v_start_date := TRUNC(:NEW.date_debut) + i+ NUMTODSINTERVAL(heure_deb, 'HOUR');

        -- Calculer la nouvelle date de fin pour chaque jour
        v_end_date := v_start_date + :NEW.periode;

        -- Utiliser la séquence pour obtenir la nouvelle valeur de ref_tache
        SELECT idTache_seq.NEXTVAL INTO inc_ref_tache FROM DUAL;
        
        -- Insérer la tâche associée dans la table Tache_en_cours
        INSERT INTO Tache (ref_tache) VALUES (inc_ref_tache);        
        INSERT INTO Tache_en_cours (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
        VALUES (inc_ref_tache, 'Tache associée' , 'Description de la tâche ' , 1, '', v_start_date, 'Encours', 'Liste_France_1', :NEW.ref_periodicite, 1, NULL);
    END LOOP;
END;
/

SHOW ERRORS trigger create_associated_tasks;

--execute
INSERT INTO Periodicite (ref_periodicite, date_debut, date_fin, periode)
VALUES (3, TO_TIMESTAMP('2024-01-01 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), TO_TIMESTAMP('2024-01-08 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), INTERVAL '1' DAY);

SELECT * FROM Periodicite WHERE ref_periodicite = 3;
SELECT * FROM  Tache_en_cours WHERE ref_periodicite = 3;

--supprimer
ALTER TRIGGER create_associated_tasks DISABLE;


