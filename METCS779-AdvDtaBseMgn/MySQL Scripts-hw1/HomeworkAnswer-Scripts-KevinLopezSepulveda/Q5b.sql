CREATE OR REPLACE VIEW doctor_review_details AS
SELECT
  dr.patient_id,
  dr.doctor_id,
  CONCAT(pat_person.first_name, ' ', pat_person.last_name) AS patient_full_name,
  CONCAT(doc_person.first_name, ' ', doc_person.last_name) AS doctor_full_name,
  dr.rating,
  dr.review_date,
  dr.patient_review
FROM doctor_review dr
JOIN patient p ON dr.patient_id = p.patient_id
JOIN person pat_person ON p.person_id = pat_person.person_id
JOIN employee e ON dr.doctor_id = e.employee_id
JOIN person doc_person ON e.person_id = doc_person.person_id;

select * from doctor_review_details;
