INSERT INTO appointment_history (
    appointment_id,
    patient_id,
    doctor_id,
    appointment_date,
    appointment_status_id,
    appointment_status_desc,
    appointment_type_id,
    appointment_type_desc,
    diagnosis_code,
    notes,
    operation_type,
    modified_by
)
SELECT
    a.appointment_id,
    a.patient_id,
    a.doctor_id,
    a.scheduled_for,
    a.appointment_status_id,
    s.description AS appointment_status_desc,
    a.appointment_type_id,
    t.description AS appointment_type_desc,
    d.diagnosis_code,
    NULL AS notes,
    'INSERT' AS operation_type,
    'SYSTEM_INIT' AS modified_by
FROM appointment a
LEFT JOIN appointment_status s ON a.appointment_status_id = s.appointment_status_id
LEFT JOIN appointment_type t ON a.appointment_type_id = t.appointment_type_id
LEFT JOIN appointment_diagnosis d ON a.appointment_id = d.appointment_id
LEFT JOIN appointment_prescription ap ON a.appointment_id = ap.appointment_id;
select * from appointment_history;