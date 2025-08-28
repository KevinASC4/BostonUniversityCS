CREATE TABLE doctor_review (
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    review_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    rating CHAR(1) NOT NULL,
    patient_review TEXT,
    PRIMARY KEY (patient_id, doctor_id),
    CONSTRAINT fk_review_patient FOREIGN KEY (patient_id) REFERENCES patient(patient_id),
    CONSTRAINT fk_review_doctor FOREIGN KEY (doctor_id) REFERENCES doctor(doctor_id),
    CONSTRAINT chk_rating CHECK (rating IN ('A', 'B', 'C', 'D', 'F'))
);
