DELIMITER $$

CREATE PROCEDURE create_appointment(
    IN p_patient_id INT,
    IN p_requested_datetime DATETIME,
    IN p_patient_concern VARCHAR(255),
    IN p_appointment_type_id INT,
    IN p_hospital_id INT,
    IN p_doctor_id INT
)
BEGIN
    DECLARE v_current_time DATETIME;
    DECLARE v_max_advance_time DATETIME;
    DECLARE v_available_slot DATETIME;
    DECLARE v_doctor_hospital_match BOOLEAN;
    DECLARE v_patient_exists INT;
    DECLARE v_status_id INT DEFAULT 1; -- assuming 1 = Scheduled or similar status

    SET v_current_time = NOW(3);
    SET v_max_advance_time = DATE_ADD(v_current_time, INTERVAL 3 MONTH);

    -- Check if patient exists
    SELECT COUNT(*) INTO v_patient_exists FROM patient WHERE patient_id = p_patient_id;
    IF v_patient_exists = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Please register with the hospital network before booking appointments.';
    END IF;

    -- Check appointment time business rules
    IF p_requested_datetime < DATE_ADD(v_current_time, INTERVAL 1 HOUR) THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointments cannot be made less than 1 hour in advance.';
    END IF;

    IF p_requested_datetime > v_max_advance_time THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Appointments cannot be made more than 3 months in advance.';
    END IF;

    -- Check if doctor works at the hospital using user-defined function from question 4
    SET v_doctor_hospital_match = is_doctor_at_hospital(p_doctor_id, p_hospital_id);
    IF v_doctor_hospital_match = 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'The doctor is not associated with the selected hospital.';
    END IF;

    -- Find next available time slot using user-defined function from question 5
    SET v_available_slot = next_available_slot(p_doctor_id, p_requested_datetime);
    IF v_available_slot IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Time slot not available. Please select another time.';
    END IF;

    -- If the available slot is different from requested, notify user (optional, or just book the slot)
    -- For simplicity, book the returned slot

    -- Insert appointment with NULL vitals and lab IDs
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
    ) VALUES (
        p_appointment_type_id,
        p_hospital_id,
        v_current_time,
        v_available_slot,
        p_patient_concern,
        NULL,
        p_patient_id,
        p_doctor_id,
        NULL,
        v_status_id
    );

END$$

DELIMITER ;

-- Setup handlers to capture errors and continue
DELIMITER $$

-- Test 1: Valid appointment (should succeed)
CALL create_appointment(
    696970,                       -- patient_id (your patient record)
    '2025-08-07 10:00:00',       -- requested datetime (assumed available)
    'Annual check-up',            -- patient concern
    1,                           -- appointment_type_id
    21,                          -- hospital_id (valid hospital linked to doctor)
    1                            -- doctor_id
);
SELECT 'Test 1: Valid appointment - Completed' AS Test_Result;


-- Test 2: Patient does not exist (should error)
CALL create_appointment(
    999999,                      -- invalid patient_id
    '2025-08-05 11:00:00',
    'New patient test',
    1,
    21,
    1
);
SELECT 'Test 2: Patient does not exist - Should error' AS Test_Result;


-- Test 3: Doctor-hospital mismatch (should error)
CALL create_appointment(
    696970,
    '2025-08-16 12:00:00',
    'Doctor-hospital mismatch test',
    1,
    99,                          -- invalid hospital for doctor 1
    1
);
SELECT 'Test 3: Doctor-hospital mismatch - Should error' AS Test_Result;


-- Test 4: Appointment less than 1 hour in advance (should error)
CALL create_appointment(
    696969,
    DATE_ADD(NOW(3), INTERVAL 30 MINUTE), -- too soon
    'Too soon appointment test',
    1,
    21,
    1
);
SELECT 'Test 4: Appointment less than 1 hour ahead - Should error' AS Test_Result;


-- Test 5: Appointment more than 3 months ahead (should error)
CALL create_appointment(
    696969,
    DATE_ADD(NOW(3), INTERVAL 4 MONTH), -- too far in future
    'Too far appointment test',
    1,
    21,
    1
);
SELECT 'Test 5: Appointment more than 3 months ahead - Should error' AS Test_Result;


-- Test 6: Requested time slot taken (should error)
-- Insert a blocking appointment for the slot 2 PM on Aug 6, 2025 if it does not exist
INSERT IGNORE INTO appointment (
    appointment_type_id, hospital_id, created_at, scheduled_for,
    patient_concern, patient_vitals_id, patient_id, doctor_id, lab_id, appointment_status_id
) VALUES (
    1, 21, NOW(3), '2025-08-06 14:00:00',
    'Blocking appointment',
    NULL, 696970, 1, NULL, 1
);

CALL create_appointment(
    696970,
    '2025-08-06 14:00:00',  -- time slot already taken
    'Overlapping appointment test',
    1,
    21,
    1
);
SELECT 'Test 6: Requested time slot taken - Should error' AS Test_Result;


-- Test 7: Verify appointment created for patient 696970
SELECT a.appointment_id, a.scheduled_for, p.patient_id, per.first_name, per.last_name
FROM appointment a
JOIN patient p ON a.patient_id = p.patient_id
JOIN person per ON p.person_id = per.person_id
WHERE p.patient_id = 696970
ORDER BY a.created_at DESC
LIMIT 5;
