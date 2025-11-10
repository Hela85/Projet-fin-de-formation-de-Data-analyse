USE OULAD_DB;

/* Création d'une table générale*/
CREATE TABLE student_consolidated;

/* Selection des colonnes de chaque table avec un allias au début*/
SELECT 
    si.id_student,
    si.gender,
    si.region,
    si.highest_education,
    si.age_band,
    si.num_of_prev_attempts,
    si.studied_credits,
    si.disability,
    si.final_result,
    sr.date_registration,
    sr.date_unregistration,
    
    /* Calcul de la moyenne de chaque etudient*/
    AVG(sa.score) AS avg_score,
    
    /* Clacul de nombre de cliques dans la plateforme de chaque étudients*/
    SUM(sv.sum_click) AS total_clicks,
    
    /*Comptage du nombre de sources utilisées pour chaque étudient*/
    COUNT(DISTINCT sv.id_site) AS nb_resources
      
    /* Jointure des tables */
FROM studentInfo as si
LEFT JOIN studentRegistration as sr
    ON si.id_student = sr.id_student
   AND si.code_module = sr.code_module
   AND si.code_presentation = sr.code_presentation
LEFT JOIN studentAssessment as sa
    ON si.id_student = sa.id_student
LEFT JOIN assessments as a
    ON sa.id_assessment = a.id_assessment
LEFT JOIN studentVle as sv
    ON si.id_student = sv.id_student
LEFT JOIN vle as v
    ON sv.id_site = v.id_site
LEFT JOIN courses as c
    ON si.code_module = c.code_module
   AND si.code_presentation = c.code_presentation
   
   /* Aggregation par étudient et par cours*/
GROUP BY si.id_student, si.gender, si.region, si.highest_education,
         si.age_band, si.num_of_prev_attempts, si.studied_credits,
         si.disability, si.final_result, sr.date_registration,
         sr.date_unregistration;