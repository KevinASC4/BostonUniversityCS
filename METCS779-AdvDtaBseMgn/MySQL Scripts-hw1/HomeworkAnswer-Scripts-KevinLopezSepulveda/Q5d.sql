UPDATE doctor_review
SET 
  rating = 'B',
  patient_review = 'Changed my mind — He isnt that good looking.'
WHERE 
  patient_id = 696970
  AND doctor_id = 1;
