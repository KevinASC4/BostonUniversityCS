WITH PatientAppointments AS (
  SELECT
    p.patient_id,
    per.first_name,
    per.last_name,
    per.dob,
    per.email,
    a.scheduled_for,
    LAG(a.scheduled_for) OVER (PARTITION BY p.patient_id ORDER BY a.scheduled_for) AS prev_appointment
  FROM appointment a
  JOIN patient p ON a.patient_id = p.patient_id
  JOIN person per ON p.person_id = per.person_id
),
AppointmentDiffs AS (
  SELECT
    patient_id,
    first_name,
    last_name,
    dob,
    email,
    DATEDIFF(scheduled_for, prev_appointment) AS days_between
  FROM PatientAppointments
  WHERE prev_appointment IS NOT NULL
)
SELECT
  first_name,
  last_name,
  DATE_FORMAT(dob, '%m/%d/%Y') AS dob_us_format,
  email,
  AVG(days_between) AS avg_days_between_appointments,
  COUNT(*) + 1 AS total_appointments -- +1 because diffs are one less than appointments
FROM AppointmentDiffs
GROUP BY patient_id, first_name, last_name, dob, email
HAVING COUNT(*) > 0
ORDER BY avg_days_between_appointments DESC;
