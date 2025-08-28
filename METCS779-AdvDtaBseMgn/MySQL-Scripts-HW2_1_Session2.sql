use HW2_1;
SET autocommit = 0;

-- Question 5
START TRANSACTION;
UPDATE Deadlocker2
SET lastName = 'Drogba'
WHERE firstName = 'Diego' AND lastName = 'Lopez S';
SELECT * FROM Deadlocker2;

-- Question 6
UPDATE Deadlocker1
SET firstName = 'Messi'
WHERE firstName = 'Kevin' AND lastName = 'Lopez S';

-- Question 10
COMMIT;

SELECT * FROM Deadlocker1;
SELECT * FROM Deadlocker2;