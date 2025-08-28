DELIMITER $$

CREATE FUNCTION is_doctor_at_hospital(input_doctor_id INT, input_hospital_id INT)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    DECLARE result BOOLEAN;

    SELECT 
        COUNT(*) > 0 INTO result
    FROM doctor d
    JOIN employee e ON d.employee_id = e.employee_id
    JOIN department dept ON e.department_id = dept.department_id
    JOIN hospital h ON dept.hospital_id = h.hospital_id
    WHERE d.doctor_id = input_doctor_id
      AND h.hospital_id = input_hospital_id;

    RETURN result;
END $$


DELIMITER ;
-- Test 1
SELECT d.doctor_id, h.hospital_id, h.name AS hospital_name
FROM doctor d
JOIN employee e ON d.employee_id = e.employee_id
JOIN department dept ON e.department_id = dept.department_id
JOIN hospital h ON dept.hospital_id = h.hospital_id;

-- Test 2
SELECT is_doctor_at_hospital(1, 21) AS result;  -- should return 1 (TRUE)

-- Test 3
SELECT is_doctor_at_hospital(1, 20) AS result;  -- should return 0 (FALSE)

SELECT * FROM doctor_hospital WHERE doctor_id = 1;


