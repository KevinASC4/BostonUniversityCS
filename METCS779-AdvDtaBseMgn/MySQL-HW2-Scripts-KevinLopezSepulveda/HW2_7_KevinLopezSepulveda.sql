DELIMITER //

CREATE PROCEDURE insert_appointment_simple (
    IN in_appointment_type_id INT,
    IN in_hospital_id INT,
    IN in_scheduled_for DATETIME,
    IN in_patient_concern VARCHAR(255),
    IN in_patient_vitals_id INT,
    IN in_patient_id INT,
    IN in_doctor_id INT,
    IN in_lab_id INT
)
BEGIN
    INSERT INTO appointment (
        appointment_type_id,
        hospital_id,
        created_at,
        scheduled_for,
        patient_concern,
        patient_vitals_id,
        patient_id,
        doctor_id,
        lab_id
    )
    VALUES (
        in_appointment_type_id,
        in_hospital_id,
        NOW(),
        in_scheduled_for,
        in_patient_concern,
        in_patient_vitals_id,
        in_patient_id,
        in_doctor_id,
        in_lab_id
    );
END //

DELIMITER ;

CALL insert_appointment_simple(
    1,               -- appointment_type_id
    21,               -- hospital_id
    '2025-08-07 10:00:00',  -- scheduled_for
    'Annual check-up with Dr. Smith',  -- patient_concern
    1,               -- patient_vitals_id
    21,              -- patient_id (Kevin Lopez)
    1,               -- doctor_id
    100              -- lab_id
);

SELECT * FROM appointment WHERE patient_id = 696970 ORDER BY created_at DESC;



