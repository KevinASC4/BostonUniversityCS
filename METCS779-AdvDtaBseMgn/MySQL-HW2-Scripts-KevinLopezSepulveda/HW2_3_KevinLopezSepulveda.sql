DELIMITER $$
--                  Change name 'Below' to update, delete or insert
CREATE TRIGGER after_appointment_delete
-- Change 'here' below for delete and update and insert
AFTER delete ON appointment
FOR EACH ROW
BEGIN
    DECLARE status_desc VARCHAR(100);
    DECLARE type_desc VARCHAR(100);
    DECLARE diag_code VARCHAR(50);

    -- Get status description, FOR Delete SWITCH 'NEW' to 'OLD'
    SELECT description INTO status_desc
    FROM appointment_status
    WHERE appointment_status_id = old.appointment_status_id
    LIMIT 1;

    -- Get type description, FOR Delete SWITCH 'NEW' to 'OLD'
    SELECT description INTO type_desc
    FROM appointment_type
    WHERE appointment_type_id = old.appointment_type_id
    LIMIT 1;

    -- Get diagnosis code, FOR Delete SWITCH 'NEW' to 'OLD'
    SELECT diagnosis_code INTO diag_code
    FROM appointment_diagnosis
    WHERE appointment_id = old.appointment_id
    LIMIT 1;

    Insert into appointment_history (
        appointment_id, patient_id, doctor_id, appointment_date,
        appointment_status_id, appointment_status_desc,
        appointment_type_id, appointment_type_desc,
        diagnosis_code, operation_type
    )
--    FOR Delete SWITCH 'NEW' to 'OLD'
    VALUES (
        old.appointment_id, old.patient_id, old.doctor_id, old.scheduled_for,
        old.appointment_status_id, status_desc,
        old.appointment_type_id, type_desc,
        diag_code, 'Delete'
    );
END$$

DELIMITER ;

Drop trigger if exists after_appointment_delete;
Select * from appointment;