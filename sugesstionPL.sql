SET ECHO OFF
SET VERIFY OFF
SET SERVEROUTPUT ON

ACCEPT ref_u NUMBER DEF '1' PROMPT 'ID_utilisateur: ';
ACCEPT nb_comm NUMBER DEF '1' PROMPT 'Les t�ches similaires avec au moins combien mots communs Y: ';
ACCEPT nb_tache_sim NUMBER DEF '1' PROMPT 'Les utilisateurs similaires avec au moins combien t�ches similaires X: ';


DECLARE
    commun INT;
    compte INT;
    CURSOR tach_uti IS
        SELECT DISTINCT ref_tache, intitule, description 
        FROM (
            SELECT tc.ref_tache, tc.intitule, tc.description
            FROM Tache_en_cours tc
            INNER JOIN Est_assigne ea ON  ea.ref_tache = tc.ref_tache
            WHERE  ea.ref_utilisateur = &ref_u
            UNION ALL
            SELECT tf.ref_tache, tf.intitule, tf.description
            FROM Tache_fini tf
            INNER JOIN Est_assigne ea ON  ea.ref_tache = tf.ref_tache
            WHERE  ea.ref_utilisateur = &ref_u
        );

    CURSOR tache_rec IS
        SELECT DISTINCT ref_tache, intitule, description 
        FROM (
            SELECT tc.ref_tache, tc.intitule, tc.description
            FROM Tache_en_cours tc
            INNER JOIN Est_assigne ea ON  ea.ref_tache = tc.ref_tache
            WHERE  ea.ref_utilisateur <> &ref_u
            UNION ALL
            SELECT tf.ref_tache, tf.intitule, tf.description
            FROM Tache_fini tf
            INNER JOIN Est_assigne ea ON  ea.ref_tache = tf.ref_tache
            WHERE ea.ref_utilisateur <> &ref_u
        );
      CURSOR uti_similaire IS
            SELECT ref_tache, COUNT(ref_tache) AS crt
            FROM Est_assigne ea
            WHERE ea.ref_utilisateur <> &ref_u
            GROUP BY ref_tache
            ORDER BY crt DESC;

BEGIN
    compte :=0;
    -- Tronquer la table temporaire contenant des ids des taches similaires
    EXECUTE IMMEDIATE 'TRUNCATE TABLE temp_noms';
    FOR x IN tach_uti LOOP
        -- R�initialiser le compteur de mots communs pour chaque t�che utilisateur     

        FOR y IN tache_rec LOOP
            commun := NombreMotsCommuns(x.intitule || ' ' || x.description, y.intitule || ' ' || y.description);
            
            -- Comparer le nombre de mots communs avec le seuil sp�cifi�
            IF commun >= &nb_comm THEN
                -- Stocker la t�che similaire dans la table temporaire
                EXECUTE IMMEDIATE 'INSERT INTO temp_noms (ref_tache) VALUES (:1)' USING y.ref_tache;
                --DBMS_OUTPUT.PUT_LINE('T�che: ' || y.ref_tache || ' est '|| to_char(commun) || ' mot comment avec la tache ' || x.ref_tache || ' de utilisateur : ' || &ref_u );
            END IF;
        END LOOP;
    END LOOP;
   
    FOR i IN uti_similaire 
    LOOP
        FOR  result IN (SELECT DISTINCT ref_tache FROM temp_noms) 
            LOOP
                IF result.ref_tache = i.ref_tache and i.crt>= &nb_tache_sim  THEN
                compte :=compte +1;
                    DBMS_OUTPUT.PUT_LINE('ID de t�che sugg�r�e : ' || result.ref_tache);
                    IF i.crt>1 THEN
                        DBMS_OUTPUT.PUT_LINE('     cette tache est utilitise par : ' || i.crt || ' utilisateurs.' );
                    ELSE
                        DBMS_OUTPUT.PUT_LINE('     cette tache est utilitise par : ' || i.crt || ' utilisateur.' );
                    END IF;
                 END IF;
             END LOOP;
    END LOOP;
    IF compte=0 THEN
    DBMS_OUTPUT.PUT_LINE('Aucune t�che correspondant trouv�e.' );
    END IF;

  
END;
/
