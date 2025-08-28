use terrier_hospital_network;
-- MAIN QUESTION 
CREATE TABLE appointment_history (
    history_id INT PRIMARY KEY AUTO_INCREMENT,
    appointment_id INT,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    appointment_status_id INT,
    appointment_status_desc VARCHAR(100),
    appointment_type_id INT,
    appointment_type_desc VARCHAR(100),
    diagnosis_code VARCHAR(50),      -- pulled from appointment_diagnosis
    notes TEXT,                      -- optional free text
    operation_type ENUM('INSERT', 'UPDATE', 'DELETE'),
    recorded_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    modified_by VARCHAR(100)         
);
drop table appointment_history;