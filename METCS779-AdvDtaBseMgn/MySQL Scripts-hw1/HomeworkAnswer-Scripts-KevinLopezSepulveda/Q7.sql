SELECT
  DATE(a.scheduled_for) AS appointment_date,
  CONCAT(pat_person.first_name, ' ', pat_person.last_name) AS patient_full_name,
  doc.office AS office_name,
  h.name AS hospital_name,
  dgn.diagnosis
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN person pat_person ON p.person_id = pat_person.person_id
JOIN doctor doc ON a.doctor_id = doc.doctor_id
JOIN hospital h ON a.hospital_id = h.hospital_id
LEFT JOIN appointment_prescription ap ON a.appointment_id = ap.appointment_id
LEFT JOIN appointment_diagnosis adgn ON a.appointment_id = adgn.appointment_id
LEFT JOIN diagnosis dgn ON adgn.diagnosis_code = dgn.diagnosis_code
WHERE ap.appointment_id IS NULL
ORDER BY appointment_date, patient_full_name;
