-- Insert Myself into database
INSERT INTO person (person_id, first_name, last_name, dob, phone, email, sex_id, marital_status_id, ethnicity_id, nationality_id)
VALUES (696969, 'Kevin', 'Lopez', '2000-08-06', '347-265-3479', 'lopezsepulvedakevinadrian@gmail.com', 1, 1, 1, 1);


INSERT INTO patient (patient_id, person_id, blood_type_id)
VALUES (696970, 696969, 3);

-- Create Appointments
INSERT INTO appointment 
(hospital_id, patient_id, doctor_id, created_at, scheduled_for, patient_concern, patient_vitals_id, lab_id, appointment_status_id)
VALUES
(21, 696970, 1, NOW(), '2025-10-15 21:00:00', 'explosive diahreah.', 1, NULL, 4);


INSERT INTO appointment 
(hospital_id, patient_id, doctor_id, created_at, scheduled_for, patient_concern, patient_vitals_id, lab_id, appointment_status_id)
VALUES
(21, 1, 14, NOW(), '2025-10-15 21:00:00', 'explosive diahreah.', 1, NULL, 4);

select * from appointment;


