ALTER TABLE doctor
ADD COLUMN building_code CHAR(1);

UPDATE doctor
SET building_code = RIGHT(office, 1)
WHERE doctor_id AND employee_id IS NOT NULL;