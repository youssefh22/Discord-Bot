USE BloodDonationSystemDB;

-- Find all hospitals in city x.
-- (1)Implemented using inner queries:
SELECT Hospital.name
FROM Hospital
WHERE Hospital.address IN (
	SELECT Address.address_id
    FROM Address
    WHERE Address.city = 'SF'
);
-- Output:
-- 'Stanford'
-- 'Kaiser'
-- 'CVS'

-- For each manager, find the number of messages received.
-- (1)Implemented with logic that includes a "GROUP BY" and "HAVING" queries:
SELECT manager_id, total_messages_received FROM Manager
GROUP BY manager_id, total_messages_received
HAVING total_messages_received >= 0
ORDER BY total_messages_received DESC;
-- Output:
-- '13588', '1'
-- '13589', '1'
-- '13587', '0'

-- Find the matching donor blood type for blood type x.
-- (1)Implemented using stored functions:
DROP function IF EXISTS `matchingBloodType`;
DELIMITER $$
CREATE FUNCTION `matchingBloodType` (bloodTypeName CHAR(100))
RETURNS VARCHAR(100)
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE name VARCHAR(100);
IF bloodTypeName = 'o_positive_type_blood_type' THEN SET name = 'o_positive: o_positive OR o_negative';
ELSEIF bloodTypeName = 'o_negative_type_blood_type' THEN SET name = 'o_negative: o_negative';
ELSEIF bloodTypeName = 'a_positive_type_blood_type' THEN SET name = 'a_positive: a_positive OR a_negative OR o_positive OR o_negative';
ELSEIF bloodTypeName = 'a_negative_type_blood_type' THEN SET name = 'a_negative: a_negative OR o_negative';
ELSEIF bloodTypeName = 'b_positive_type_blood_type' THEN SET name = 'b_positive: b_positive OR b_negative OR o_positive: o_negative';
ELSEIF bloodTypeName = 'b_negative_type_blood_type' THEN SET name = 'b_negative: b_negative OR o_negative';
ELSEIF bloodTypeName = 'ab_positive_type_blood_type' THEN SET name = 'ab_positive: Compatible with all types';
ELSEIF bloodTypeName = 'ab_negative_type_blood_type' THEN SET name = 'ab_negative: ab_negative OR a_negative OR b_negative OR o_negative';
END IF;
RETURN name;
END$$
-- 13:56:40	CREATE FUNCTION `matchingBloodType` (bloodTypeName CHAR(100)) RETURNS VARCHAR(100) READS SQL DATA DETERMINISTIC BEGIN DECLARE name VARCHAR(100); IF bloodTypeName = 'o_positive_type_blood_type' THEN SET name = 'o_positive: o_positive OR o_negative'; ELSEIF bloodTypeName = 'o_negative_type_blood_type' THEN SET name = 'o_negative: o_negative'; ELSEIF bloodTypeName = 'a_positive_type_blood_type' THEN SET name = 'a_positive: a_positive OR a_negative OR o_positive OR o_negative'; ELSEIF bloodTypeName = 'a_negative_type_blood_type' THEN SET name = 'a_negative: a_negative OR o_negative'; ELSEIF bloodTypeName = 'b_positive_type_blood_type' THEN SET name = 'b_positive: b_positive OR b_negative OR o_positive: o_negative'; ELSEIF bloodTypeName = 'b_negative_type_blood_type' THEN SET name = 'b_negative: b_negative OR o_negative'; ELSEIF bloodTypeName = 'ab_positive_type_blood_type' THEN SET name = 'ab_positive: Compatible with all types'; ELSEIF bloodTypeName = 'ab_negative_type_blood_type' THEN SET name = 'ab_negative: ab_negative OR a_negative OR b_negative OR o_negative'; END IF; RETURN name; END	0 row(s) affected	0.0017 sec
SELECT matchingBloodType('a_positive_type_blood_type') AS Matching_Blood_Type;
-- Output:
-- 'a_positive: a_positive OR a_negative OR o_positive OR o_negative'

-- Create a function that returns the disease result for disease check in each laboratory.
-- (1)Implemented using updates that include "JOINS" in the same query:
SELECT Laboratory.name, DiseaseCheck.disease_result
FROM Laboratory
JOIN DiseaseCheck ON Laboratory.disease_check = DiseaseCheck.disease_check_id;
-- -- Output:
-- 'SienceLab', '1'
-- 'StarLab', '1'
-- 'LabTests', '1'
-- 'SienceLab', '1'

-- Create a function that takes in a doctor's name and returns the number of blood transfusion they performed.
-- (2)Implemented using inner queries:
SELECT count(BloodTransfusion.blood_transfusion_id)
FROM BloodTransfusion
WHERE BloodTransfusion.doctor IN (
	SELECT Doctor.doctor_id
    FROM Doctor
    WHERE Doctor.full_name = 'Chris Tucker'
);
-- Output:
-- '1'


-- For each blood bank, find the name of the manager working in the blood bank.
-- (2)Implemented using updates that include "JOINS" in the same query:
SELECT BloodBank.name, Manager.full_name
FROM BloodBank
JOIN Manager ON BloodBank.manager = Manager.manager_id;
-- Output:
-- 'Best Blood Bank', 'Trance James'
-- 'Cleanest Blood Bank', 'Nueton Few'
-- 'Blood for All', 'Berry Allen'

-- Show the rarity of a blood type in the US.
-- (2)Implemented using stored functions:
DROP FUNCTION `bloodTypeRarity`;
DELIMITER $$
CREATE FUNCTION `bloodTypeRarity` (bloodTypeName CHAR(100))
RETURNS VARCHAR(100)
READS SQL DATA
DETERMINISTIC
BEGIN
DECLARE result VARCHAR(100);
IF bloodTypeName = 'o_positive_type_blood_type' THEN SET result = '37.4% of the population';
ELSEIF bloodTypeName = 'o_negative_type_blood_type' THEN SET result = '6.6% of the population';
ELSEIF bloodTypeName = 'a_positive_type_blood_type' THEN SET result = '35.7% of the population';
ELSEIF bloodTypeName = 'a_negative_type_blood_type' THEN SET result = '	6.3% of the population';
ELSEIF bloodTypeName = 'b_positive_type_blood_type' THEN SET result = '8.5% of the population';
ELSEIF bloodTypeName = 'b_negative_type_blood_type' THEN SET result = '1.5% of the population';
ELSEIF bloodTypeName = 'ab_positive_type_blood_type' THEN SET result = '3.4% of the population';
ELSEIF bloodTypeName = 'ab_negative_type_blood_type' THEN SET result = '0.6% of the population';
END IF;
RETURN result;
END$$
-- 16:29:09	CREATE FUNCTION `bloodTypeRarity` (bloodTypeName CHAR(100)) RETURNS VARCHAR(100) READS SQL DATA DETERMINISTIC BEGIN DECLARE result VARCHAR(100); IF bloodTypeName = 'o_positive_type_blood_type' THEN SET result = '37.4% of the population'; ELSEIF bloodTypeName = 'o_negative_type_blood_type' THEN SET result = '6.6% of the population'; ELSEIF bloodTypeName = 'a_positive_type_blood_type' THEN SET result = ' 35.7% of the population'; ELSEIF bloodTypeName = 'a_negative_type_blood_type' THEN SET result = ' 6.3% of the population'; ELSEIF bloodTypeName = 'b_positive_type_blood_type' THEN SET result = '8.5% of the population'; ELSEIF bloodTypeName = 'b_negative_type_blood_type' THEN SET result = '1.5% of the population'; ELSEIF bloodTypeName = 'ab_positive_type_blood_type' THEN SET result = '3.4% of the population'; ELSEIF bloodTypeName = 'ab_negative_type_blood_type' THEN SET result = '0.6% of the population'; END IF; RETURN result; END	0 row(s) affected	0.0018 sec
SELECT bloodTypeRarity('a_positive_type_blood_type') AS Rarity;
-- Output:
-- '35.7% of the population'

-- If a monitoring process does not have a description, write 'N/A'.
-- (1)Implemented using data insertion with implemented triggers using "BEFORE INSERT" and "AFTER INSERT":
DROP TRIGGER before_insert_one;
DELIMITER //
CREATE TRIGGER before_insert_one BEFORE INSERT
ON MonitoringProcess FOR EACH ROW
BEGIN
IF new.description = '' THEN 
	SET new.description = 'N/A';
END IF;
END//
DELETE FROM MonitoringProcess WHERE monitoring_process_id = 12587;
INSERT INTO MonitoringProcess VALUES(12587, '');
-- 16:15:19	CREATE TRIGGER before_insert_one BEFORE INSERT ON MonitoringProcess FOR EACH ROW BEGIN IF new.description = '' THEN   SET new.description = 'N/A'; END IF; END	0 row(s) affected	0.0031 sec
-- Output:
-- '12587', 'N/A'

-- If doctor does not exist on file for blood transfusion, assign a random doctor from file.
-- (2)Implemented using data insertion with implemented triggers using "BEFORE INSERT" and "AFTER INSERT":
DROP TRIGGER before_insert_two;
DELIMITER //
CREATE TRIGGER before_insert_two BEFORE INSERT
ON BloodTransfusion FOR EACH ROW
BEGIN
IF new.doctor < 72000 THEN
	SET new.doctor = (SELECT doctor_id FROM Doctor ORDER BY RAND() LIMIT 1);
END IF;
END//
DELETE FROM BloodTransfusion WHERE blood_transfusion_id = 66127;
INSERT INTO BloodTransfusion VALUES(66127, 71000, 92223, 81217);
-- Output:
-- 16:56:51	DROP TRIGGER before_insert	0 row(s) affected	0.0038 sec
-- 16:56:51	CREATE TRIGGER before_insert BEFORE INSERT ON BloodTransfusion FOR EACH ROW BEGIN IF new.doctor < 72000 THEN   SET new.doctor = (SELECT doctor_id FROM Doctor ORDER BY RAND() LIMIT 1); END IF; END	0 row(s) affected	0.0032 sec
-- 16:56:51	DELETE FROM BloodTransfusion WHERE blood_transfusion_id = 66127; INSERT INTO BloodTransfusion VALUES(66127, 71000, 92223, 81217);	1 row(s) affected	0.0014 sec

-- Discard blood donation only if the disease result show that the blood is not clean.
-- (1)Implemented to delete data (ON CASCADE):
SET SQL_SAFE_UPDATES = 1;
DELETE FROM BloodResult WHERE positive_result > 0;
-- Output:
-- 16:06:13	DELETE FROM BloodResult WHERE positive_result > 0	3 row(s) affected	0.0015 sec
-- This also deleted the results from positiveresult table.


-- Find the number of disease checks a laboratory has performed. 
-- (2)Implemented with logic that includes a "GROUP BY" and "HAVING" queries: 
SELECT name, count(disease_check) 
FROM Laboratory 
GROUP BY name 
HAVING COUNT(disease_check) > 0 
ORDER BY COUNT(*) DESC; 
-- Output: 
-- 'SienceLab', '2' 
-- 'StarLab', '1' 
-- 'LabTests', '1'  

-- For each blood bank, find the number of donations. 
-- (3)Implemented with logic that includes a "GROUP BY" and "HAVING" queries: 
SELECT name, total_donations 
FROM BloodBank 
GROUP BY name, total_donations 
HAVING total_donations >= 0 
ORDER BY total_donations DESC; 
-- Output: 
-- 'Best Blood Bank', '0' 
-- 'Cleanest Blood Bank', '0' 
-- 'Blood for All', '0'  

-- Create a function that returns a disease description for disease check x.
-- (1)Implemented using stored procedures:
DROP PROCEDURE IF EXISTS `diseaseDesc`;
DELIMITER $$
USE `BloodDonationSystemDB`$$
CREATE PROCEDURE `diseaseDesc` (diseaseId INT)
BEGIN
SELECT disease_description
FROM diseaseCheck
WHERE disease_check_id = diseaseId;
END$$
DELIMITER ;
CALL diseaseDesc (32221);
-- 15:14:02	CREATE PROCEDURE `diseaseDesc` (diseaseId INT) BEGIN SELECT disease_description FROM diseaseCheck WHERE disease_check_id = diseaseId; END	0 row(s) affected	0.0013 sec
-- Output:
-- 'STD'

-- Delete donor because his blood was not clean.
-- (2)Implemented to delete data (ON CASCADE):
DELETE FROM donor  WHERE donor_id = 11001;
-- Output:
-- 15:02:56	DELETE FROM donor  WHERE donor_id = 11001	1 row(s) affected	0.0045 sec
-- This also deleted donor record for that donor.

-- For each laboratory, find the number of discarded bloods.
-- (4)Implemented with logic that includes a "GROUP BY" and "HAVING" queries: 
SELECT laboratory, count(positive_result) 
FROM BloodResult 
GROUP BY laboratory 
HAVING COUNT(positive_result) >= 0 
ORDER BY count(positive_result) DESC; 
-- Output: 
-- '16653', '3' 
-- '16652', '0' 
-- '16654', '0'  

-- Perform blood transfusion only if blood type matches the patient's needed blood type. Find patient that performed blood transfusion x.
-- (2)Implemented using stored procedures:
DROP procedure IF EXISTS `PerformedBloodTransfusion`;
DELIMITER $$
USE `BloodDonationSystemDB`$$
CREATE PROCEDURE `PerformedBloodTransfusion` (bloodTran INT)
BEGIN
SELECT PatientRecord.full_name
FROM PatientRecord
JOIN Patient ON PatientRecord.patient = Patient.patient_id
WHERE Patient.blood_transfusion = bloodTran;
END$$
DELIMITER ;
CALL PerformedBloodTransfusion (66125);
-- 12:08:36	CREATE PROCEDURE `PerformedBloodTransfusion` (bloodTran INT) BEGIN SELECT PatientRecord.full_name FROM PatientRecord JOIN Patient ON PatientRecord.patient = Patient.patient_id WHERE Patient.blood_transfusion = bloodTran; END	0 row(s) affected	0.0013 sec
-- Output:
-- 'Josh Peck'
