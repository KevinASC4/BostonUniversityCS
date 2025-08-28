SELECT
  DATE(a.scheduled_for) AS scheduled_date,
  TIME(a.scheduled_for) AS scheduled_time,
  CONCAT(pat_person.last_name, ', ', pat_person.first_name) AS patient_name,
  h.name AS hospital_name,
  CONCAT(doc_person.last_name, ', ', doc_person.first_name) AS doctor_name,
  bt.mcv AS MCV,
  a.patient_concern
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN person pat_person ON p.person_id = pat_person.person_id
JOIN hospital h ON a.hospital_id = h.hospital_id
JOIN doctor d ON a.doctor_id = d.doctor_id
JOIN employee e ON d.doctor_id = e.employee_id
JOIN person doc_person ON e.person_id = doc_person.person_id
JOIN appointment_status ats ON a.appointment_status_id = ats.appointment_status_id
LEFT JOIN lab l ON a.lab_id = l.lab_id
LEFT JOIN blood_test bt ON l.blood_test_id = bt.blood_test_id
WHERE ats.appointment_status_id = 4
ORDER BY DATE(a.scheduled_for), TIME(a.scheduled_for), patient_name;
