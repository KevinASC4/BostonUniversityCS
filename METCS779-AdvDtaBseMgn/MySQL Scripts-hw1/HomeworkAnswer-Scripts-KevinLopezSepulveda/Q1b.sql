ALTER TABLE doctor
ADD COLUMN room_number INT;
UPDATE doctor
SET room_number = CAST(SUBSTRING(office, 1, 3) AS UNSIGNED)
WHERE doctor_id AND employee_ID IS NOT NULL;