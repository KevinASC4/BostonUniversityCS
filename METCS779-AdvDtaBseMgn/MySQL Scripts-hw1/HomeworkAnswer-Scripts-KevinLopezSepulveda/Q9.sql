INSERT INTO appointment 
(hospital_id, patient_id, doctor_id, created_at, scheduled_for, patient_concern, patient_vitals_id, lab_id, appointment_status_id, appointment_type_id)
VALUES
(21, 696970, 1, NOW(), '2025-02-10 09:00:00', 'I can see the future!', 1, NULL, 4, 1),
(21, 696970, 1, NOW(), '2025-02-20 14:00:00', 'My tummy hurts.', 1, NULL, 4, 1),
(21, 696970, 2, NOW(), '2025-03-15 11:00:00', 'Blah.', 2, NULL, 4, 2),
(21, 1, 2, NOW(), '2025-04-10 10:30:00', 'Bleh.', 3, NULL, 4, 2),
(21, 2, 3, NOW(), '2025-05-05 13:00:00', 'GG!', 4, NULL, 4, 3),
(21, 3, 1, NOW(), '2025-06-25 15:00:00', 'OMG Its ali a.', 1, NULL, 4, 1),
(21, 4, 3, NOW(), '2025-07-10 09:30:00', 'Mi so angry.', 2, NULL, 4, 3);


SELECT
  CONCAT(doc_person.last_name, ', ', doc_person.first_name) AS doctor_name,
  apt_type.description AS appointment_type,
  MONTHNAME(a.scheduled_for) AS appointment_month,
  MONTH(a.scheduled_for) AS appointment_month_num,
  COUNT(*) AS total_appointments
FROM appointment a
JOIN doctor d ON a.doctor_id = d.doctor_id
JOIN employee e ON d.doctor_id = e.employee_id
JOIN person doc_person ON e.person_id = doc_person.person_id
JOIN appointment_type apt_type ON a.appointment_type_id = apt_type.appointment_type_id
WHERE YEAR(a.scheduled_for) = 2025
GROUP BY
  doctor_name,
  appointment_type,
  appointment_month,
  appointment_month_num
ORDER BY
  doctor_name,
  appointment_type,
  appointment_month_num;
