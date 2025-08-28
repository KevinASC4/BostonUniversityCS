WITH AgeGroups AS (
  SELECT
    CASE 
      WHEN TIMESTAMPDIFF(YEAR, per.dob, CURDATE()) BETWEEN 0 AND 17 THEN 'Child'
      WHEN TIMESTAMPDIFF(YEAR, per.dob, CURDATE()) BETWEEN 18 AND 59 THEN 'Adult'
      ELSE 'Senior'
    END AS age_group,
    AVG(u.protein) AS avg_protein
  FROM appointment a
  JOIN lab l ON a.lab_id = l.lab_id
  JOIN urinalysis u ON l.urinalysis_id = u.urinalysis_id
  JOIN patient p ON a.patient_id = p.patient_id
  JOIN person per ON p.person_id = per.person_id
  GROUP BY age_group
)
SELECT
  age_group,
  avg_protein,
  RANK() OVER (ORDER BY avg_protein DESC) AS protein_rank
FROM AgeGroups;


WITH AgeGroups AS (
  SELECT
    CASE 
      WHEN TIMESTAMPDIFF(YEAR, per.dob, CURDATE()) BETWEEN 0 AND 17 THEN 'Child'
      WHEN TIMESTAMPDIFF(YEAR, per.dob, CURDATE()) BETWEEN 18 AND 59 THEN 'Adult'
      ELSE 'Senior'
    END AS age_group,
    AVG(u.protein) AS avg_protein
  FROM appointment a
  JOIN lab l ON a.lab_id = l.lab_id
  JOIN urinalysis u ON l.urinalysis_id = u.urinalysis_id
  JOIN patient p ON a.patient_id = p.patient_id
  JOIN person per ON p.person_id = per.person_id
  GROUP BY age_group
)
SELECT
  age_group,
  avg_protein,
  DENSE_RANK() OVER (ORDER BY avg_protein DESC) AS protein_dense_rank
FROM AgeGroups;

SELECT
  CASE 
    WHEN TIMESTAMPDIFF(YEAR, per.dob, CURDATE()) BETWEEN 0 AND 17 THEN 'Child'
    WHEN TIMESTAMPDIFF(YEAR, per.dob, CURDATE()) BETWEEN 18 AND 59 THEN 'Adult'
    ELSE 'Senior'
  END AS age_group,
  COUNT(DISTINCT p.patient_id) AS num_patients_with_urinalysis
FROM appointment a
JOIN lab l ON a.lab_id = l.lab_id
JOIN urinalysis u ON l.urinalysis_id = u.urinalysis_id
JOIN patient p ON a.patient_id = p.patient_id
JOIN person per ON p.person_id = per.person_id
GROUP BY age_group;

