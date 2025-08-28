-- FIND FK
SELECT
  TABLE_NAME, CONSTRAINT_NAME
FROM
  information_schema.KEY_COLUMN_USAGE
WHERE
  REFERENCED_TABLE_NAME = 'appointment'
  AND REFERENCED_COLUMN_NAME = 'appointment_id';

--DROP FK
ALTER TABLE appointment_diagnosis DROP FOREIGN KEY appointment_diagnosis_ibfk_1;
ALTER TABLE appointment_prescription DROP foreign key appointment_prescription_ibfk_1;

--ADD AUTO INCREMENT
ALTER TABLE appointment 
MODIFY COLUMN appointment_id INT NOT NULL AUTO_INCREMENT;

SELECT MAX(appointment_id) FROM appointment;
ALTER TABLE appointment AUTO_INCREMENT = 602;

-- ADD BACK CONSTRAINTS
ALTER TABLE appointment_diagnosis
ADD CONSTRAINT appointment_diagnosis_ibfk_1 FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id);
ALTER TABLE appointment_prescription
ADD CONSTRAINT appointment_diagnosis_ibfk_1 FOREIGN KEY (appointment_id) REFERENCES appointment(appointment_id);



