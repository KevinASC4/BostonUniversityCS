DELIMITER $$

CREATE FUNCTION next_available_slot(doctor_id INT, desired_datetime DATETIME)
RETURNS DATETIME
DETERMINISTIC
BEGIN
    DECLARE next_slot DATETIME;
    DECLARE desired_time TIME;
    DECLARE desired_date DATE;

    SET desired_date = DATE(desired_datetime);
    SET desired_time = TIME(desired_datetime);

    -- If desired time is not within 9 AM to 5 PM, adjust to 9 AM
    IF desired_time < '09:00:00' OR desired_time >= '17:00:00' THEN
        SET desired_time = '09:00:00';
        SET desired_datetime = TIMESTAMP(desired_date, desired_time);
    END IF;

    -- Move to the next weekday if it's a weekend
    WHILE DAYOFWEEK(desired_datetime) IN (1, 7) DO
        SET desired_datetime = DATE_ADD(desired_datetime, INTERVAL 1 DAY);
        SET desired_datetime = TIMESTAMP(DATE(desired_datetime), '09:00:00');
    END WHILE;

    -- Find the next 15-minute slot that's not taken
    REPEAT
        SET next_slot = desired_datetime;
        SET desired_datetime = DATE_ADD(desired_datetime, INTERVAL 15 MINUTE);
    UNTIL NOT EXISTS (
        SELECT 1
        FROM appointment
        WHERE doctor_id = doctor_id
        AND scheduled_for = next_slot
    ) END REPEAT;

    RETURN next_slot;
END$$

DELIMITER ;

select * from appointment;

SELECT appointment_id, doctor_id, scheduled_for, patient_id
FROM appointment
WHERE doctor_id = 1 AND DATE(scheduled_for) = '2025-08-05';

-- Suppose 10:15 AM is free on 2025-08-05
SELECT next_available_slot(1, '2025-08-05 10:00:00') AS next_slot;
-- Expected output: '2025-08-05 10:00:00'

-- Insert appointment for 10 AM to simulate taken slot for doctor 1
INSERT INTO appointment (
    appointment_type_id, hospital_id, created_at, scheduled_for,
    patient_concern, patient_vitals_id, patient_id, doctor_id, lab_id, appointment_status_id
) VALUES (
    1, 21, NOW(3), '2025-08-05 10:00:00',
    'Check-up for Kevin Lopez Sepulveda',
    1, 696970, 1, 1, 1
);

-- Now test requesting 10 AM slot (taken), should return 10:15 AM
SELECT next_available_slot(1, '2025-08-05 10:00:00') AS next_slot;
-- Expected output: '2025-08-05 10:15:00'

SELECT next_available_slot(1, '2025-08-09 10:00:00') AS next_slot;  -- Saturday
-- Expected output: NULL
