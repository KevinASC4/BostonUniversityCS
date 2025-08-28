SELECT
  COALESCE(ms.marital_status, 'ALL MARITAL STATUS') AS marital_status,
  COALESCE(e.ethnicity, 'ALL ETHNICITIES') AS ethnicity,
  COUNT(a.appointment_id) AS num_appointments
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN person per ON p.person_id = per.person_id
JOIN marital_status ms ON per.marital_status_id = ms.marital_status_id
JOIN ethnicity e ON per.ethnicity_id = e.ethnicity_id
GROUP BY
  ms.marital_status,
  e.ethnicity WITH ROLLUP
ORDER BY
  ms.marital_status,
  e.ethnicity;
