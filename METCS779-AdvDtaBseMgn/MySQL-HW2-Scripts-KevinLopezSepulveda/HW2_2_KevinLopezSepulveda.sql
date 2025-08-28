DELIMITER $$

CREATE TRIGGER prevent_delete_from_history
BEFORE DELETE ON appointment_history
FOR EACH ROW
BEGIN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Deletion from appointment_history is not allowed';
END$$

DELIMITER ;
Delete from appointment_history where history_id = 1;

