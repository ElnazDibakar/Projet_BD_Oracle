-- PL/SQL scripts (functions, procedures, triggers).

-- Functions
CREATE OR REPLACE FUNCTION calculate_weekly_points(ref_user_id INT)
RETURN INT
IS
  point_gagne INT;
  point_perdu INT:=0;  
  point_cacule INT:=0;

BEGIN
  -- Calculate points for completed tasks
    SELECT COUNT(tf.ref_tache)*sum(sc.score)
    INTO point_gagne
    FROM Comporte c
    INNER JOIN Score_categorie_tache sc ON sc.ref_score_categorie_tache  = c.ref_score_categorie_tache
    INNER JOIN Tache_fini tf ON  tf.ref_tache = sc.ref_score_categorie_tache
    INNER JOIN Est_assigne ea ON  ea.ref_tache = tf.ref_tache
    INNER JOIN Utilisateur u ON u.ref_utilisateur = ea.ref_utilisateur
    WHERE u.ref_utilisateur = ref_user_id AND TO_CHAR(tf.date_realisation, 'IYYY-IW') = TO_CHAR(SYSDATE, 'IYYY-IW');    
  

  -- Subtract points for uncompleted tasks
  
    SELECT COUNT(tc.ref_tache)*sum(sc.score)
    INTO point_perdu
    FROM Comporte c
    INNER JOIN Score_categorie_tache sc ON sc.ref_score_categorie_tache  = c.ref_score_categorie_tache
    INNER JOIN Tache_en_cours tc ON  tc.ref_tache = sc.ref_score_categorie_tache
    INNER JOIN Est_assigne ea ON  ea.ref_tache = tc.ref_tache
    INNER JOIN Utilisateur u ON u.ref_utilisateur = ea.ref_utilisateur
    WHERE u.ref_utilisateur = ref_user_id AND TO_CHAR(tc.date_d_echeance, 'IYYY-IW') = TO_CHAR(SYSDATE, 'IYYY-IW');
   
  
  point_cacule := point_gagne - point_perdu;

  RETURN point_cacule;
END calculate_weekly_points;
/

SELECT ref_utilisateur, calculate_weekly_points(ref_utilisateur) FROM Utilisateur;

-- Procedure
CREATE OR REPLACE PROCEDURE Archive_Past_Tasks AS
BEGIN
        -- Archiver les taches en cours passées (date d'echeance depassée)
        INSERT INTO  Tache_archivee (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
        SELECT ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation
        FROM Tache_en_cours
        WHERE date_d_echeance < SYSTIMESTAMP; 
    
        DELETE FROM Tache_en_cours
        WHERE date_d_echeance < SYSTIMESTAMP;
  
  -- Archiver les taches finies  (date de réalisation depassée)
    INSERT INTO Tache_archivee (ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation)
    SELECT ref_tache, intitule, description, priorite, url, date_d_echeance, statut, nom_categorie, ref_periodicite, ref_utilisateur, date_realisation
    FROM Tache_fini
    WHERE date_realisation < SYSTIMESTAMP;
    
     DELETE FROM Tache_fini
     WHERE date_realisation < SYSTIMESTAMP;

  COMMIT;
END Archive_Past_Tasks;
/
exec Archive_Past_Tasks;


