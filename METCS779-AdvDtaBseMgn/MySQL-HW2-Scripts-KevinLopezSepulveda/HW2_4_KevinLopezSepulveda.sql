select * from patient;
DESCRIBE lab;
select * from appointment;

DESCRIBE medicine;

INSERT INTO lab (lab_id, blood_test_id, urinalysis_id)
VALUES (1, NULL, NULL);


INSERT INTO appointment (
    appointment_type_id,
    hospital_id,
    created_at,
    scheduled_for,
    patient_concern,
    patient_vitals_id,
    patient_id,
    doctor_id,
    lab_id,
    appointment_status_id
)
VALUES (
    1, 21, NOW(3), NOW(3),
    'Test case for Kevin Lopez Sepulveda',
    1, 696970,
    1, 1, 2
);

select * from appointment_history;

UPDATE appointment
SET
    patient_concern = 'Updated concern for Kevin Lopez Sepulveda, stanky leg,lala',
    appointment_type_id = 2   -- Assuming 2 is a valid status ID like "Confirmed"
WHERE patient_id = 696970 and appointment_id = 628
ORDER BY created_at DESC
LIMIT 1;  -- Update the most recent appointment for your patient ID

DELETE FROM appointment
WHERE patient_id = 696970;


