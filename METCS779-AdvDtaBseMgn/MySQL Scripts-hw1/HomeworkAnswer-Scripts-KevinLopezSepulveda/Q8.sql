SELECT
  e.employee_id,
  p.first_name,
  p.last_name,
  d.name AS department_name,
  h.name AS hospital_name,
  COUNT(bt.blood_test_id) AS num_blood_tests
FROM blood_test bt
JOIN employee e ON bt.employee_id = e.employee_id
JOIN person p ON e.person_id = p.person_id
JOIN department d ON e.department_id = d.department_id
JOIN hospital h ON d.hospital_id = h.hospital_id
GROUP BY
  e.employee_id,
  p.first_name,
  p.last_name,
  d.name,
  h.name
HAVING COUNT(bt.blood_test_id) >= 5
ORDER BY num_blood_tests DESC;
