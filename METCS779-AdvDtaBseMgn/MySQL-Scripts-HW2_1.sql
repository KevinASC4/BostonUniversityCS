-- Question 2
CREATE DATABASE HW2_1;
USE HW2_1;
CREATE TABLE Deadlocker1 (firstName varchar(50), lastName varchar(50));
CREATE TABLE Deadlocker2 (firstName varchar(50), lastName varchar(50));

-- Question 3
INSERT INTO Deadlocker1 (firstName, lastName) VALUES('Kevin', 'Lopez S');
INSERT INTO Deadlocker1 (firstName, lastName) VALUES('Diego', 'Lopez S'); -- this is a record of someone in your family
INSERT INTO Deadlocker2 (firstName, lastName) VALUES('Kevin', 'Lopez S');
INSERT INTO Deadlocker2 (firstName, lastName) VALUES('Diego', 'Lopez S'); -- this is a record of someone in your family
SELECT * FROM Deadlocker1;
SELECT * FROM Deadlocker2;

-- Question 4
SET autocommit = 0;
START TRANSACTION;
UPDATE Deadlocker1
SET firstName = 'Ronaldo'
WHERE lastName = 'Lopez S' AND firstName = 'Kevin';

-- Question 8
UPDATE Deadlocker2
SET lastName = 'Drogba'
WHERE firstName = 'Diego' AND lastName = 'Lopez S';
SELECT * FROM Deadlocker2;

-- Question 10
COMMIT;

SELECT * FROM Deadlocker1;
SELECT * FROM Deadlocker2;