-- 1. Review with explicit today's date
INSERT INTO doctor_review
(patient_id, doctor_id, review_date, rating, patient_review)
VALUES
(696970, 1, NOW(), 'A', 'Very Attractive and cool guy.');
-- Test Default Values
INSERT INTO doctor_review
(patient_id, doctor_id, rating, patient_review)
VALUES
(1, 2, 'B', 'Asked me about my sex life in front of parents, not cool.');

-- First Day of class
INSERT INTO doctor_review
(patient_id, doctor_id, review_date, rating, patient_review)
VALUES
(3, 2, '2025-06-01', 'C', 'Asked me too many questions and forgot exact time we started class ');

INSERT INTO doctor_review
(patient_id, doctor_id, review_date, rating, patient_review)
VALUES
(3, 2, '2025-07-01', 'C', 'Asked me too many questions and forgot exact time we started class ');
Select * from doctor_review;
