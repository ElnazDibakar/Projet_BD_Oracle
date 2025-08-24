-- Indexes
--DROP INDEX idx_tache_appartenant_a_liste_ref_list;
--DROP INDEX idx_liste_tache_ref_utilisateur;
--DROP INDEX idx_comporte_nom_programme;
--DROP INDEX idx_est_assigne_ref_tache;
--DROP INDEX idx_est_assigne_ref_utilisateur;
--DROP INDEX idx_tache_en_cours_ref_utilisateur;
--DROP INDEX idx_tache_fini_ref_utilisateur;


CREATE INDEX idx_tache_appartenant_a_liste_ref_list ON Tache_appartenant_a_liste (ref_liste);
CREATE INDEX idx_liste_tache_ref_utilisateur ON Liste_tache (ref_utilisateur);
CREATE INDEX idx_comporte_nom_programme ON Comporte (nom_programme);
CREATE INDEX idx_est_assigne_ref_tache ON Est_assigne (ref_tache);
CREATE INDEX idx_est_assigne_ref_utilisateur ON Est_assigne (ref_utilisateur);
CREATE INDEX idx_tache_en_cours_ref_utilisateur ON Tache_en_cours (ref_utilisateur);
CREATE INDEX idx_tache_fini_ref_utilisateur ON Tache_fini (ref_utilisateur);


-- SQL Queries

-- Query 1
SELECT DISTINCT lt.ref_liste, lt.nom_categorie, lt.ref_utilisateur
FROM Liste_tache lt JOIN Utilisateur u ON lt.ref_utilisateur = u.ref_utilisateur
JOIN Tache_appartenant_a_liste tal ON lt.ref_liste = tal.ref_liste WHERE u.pays = 'France'
GROUP BY lt.ref_liste, lt.nom_categorie, lt.ref_utilisateur HAVING COUNT(tal.ref_tache) >= 5;

-- Query 2
SELECT nom_programme, SUM(score) AS somme_points
FROM Comporte c
JOIN Score_categorie_tache s ON c.ref_score_categorie_tache = s.ref_score_categorie_tache
JOIN Tache_fini tf ON tf.ref_tache = s.ref_score_categorie_tache
GROUP BY nom_programme
HAVING SUM(score) = (SELECT MAX(somme_points) FROM (SELECT nom_programme, SUM(score) AS somme_points
                                                    FROM Comporte c
                                                    JOIN Score_categorie_tache s ON c.ref_score_categorie_tache = s.ref_score_categorie_tache
                                                    JOIN Tache_fini tf ON tf.ref_tache = s.ref_score_categorie_tache
                                                    GROUP BY nom_programme));
-- Query 3
SELECT u.login, u.nom, u.prenom, u.adresse, COUNT(DISTINCT ea.ref_tache) AS NbTotal , (COUNT( DISTINCT tf.ref_tache) + COUNT(DISTINCT te.ref_tache)) AS NbTotalPeriodique
FROM utilisateur u
INNER JOIN Est_assigne ea ON u.ref_utilisateur = ea.ref_utilisateur
LEFT JOIN Tache_en_cours te ON te.ref_utilisateur = u.ref_utilisateur
LEFT JOIN Tache_fini tf ON tf.ref_utilisateur = u.ref_utilisateur
GROUP BY u.login, u.nom, u.prenom, u.adresse;

-- Query 4
SELECT t.ref_tache,COUNT(dd.ref_tache_1) AS dependencies_count
FROM Tache t 
LEFT JOIN Depend_de dd ON t.ref_tache = dd.ref_tache_2
GROUP BY t.ref_tache;

-- Query 5
SELECT u.login, SUM(sc.score)as TOTPoint FROM Score_categorie_tache sc
INNER JOIN Tache_fini tf ON tf.ref_tache = sc.ref_score_categorie_tache
INNER JOIN Utilisateur u ON u.ref_utilisateur = tf.ref_utilisateur
WHERE TO_CHAR(tf.date_realisation, 'IYYY-IW') = TO_CHAR(SYSDATE, 'IYYY-IW')
GROUP BY u.login
ORDER BY TOTPoint DESC
FETCH FIRST 10 ROWS ONLY;