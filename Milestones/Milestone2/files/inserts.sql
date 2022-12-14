-- Script name: inserts.sql
-- Author:   Youssef Hammoud
-- Purpose:  insert sample data to test the integrity of this database system

-- the database used to insert the data into.
USE BloodDonationSystemDB;

-- Address table inserts
INSERT INTO `blooddonationsystemdb`.`address`
(`address_id`, `street`, `zip_code`, `state`,`city`)
VALUES
("P_55121", "121 Winchester Blvd", "95008", "CA", "Campbell"), 
("P_55122", "122 Winchester Blvd", "95008", "CA", "Campbell"), 
("P_55123", "123 Winchester Blvd", "95008", "CA", "CampbellF"),
("DR_10001", "131 Grant Rd", "94040", "CA", "Mountain View"),
("DR_10002", "132 Grant Rd", "94040", "CA", "Mountain View"),
("DR_10003", "133 Grant Rd", "94040", "CA", "Mountain View"),
("H_92221", "46 Holly St", "94112", "CA", "SF"),
("H_92222", "47 Holly St", "94112", "CA", "SF"),
("H_92223", "48 Holly St", "94112", "CA", "SF"),
("M_13587", "1411 Homestead Rd", "94087", "CA", "Cupertino"),
("M_13588", "1412 Homestead Rd", "94087", "CA", "Cupertino"),
("M_13589", "1413 Homestead Rd", "94087", "CA", "Cupertino");

 -- Blood Bank table inserts
INSERT INTO `blooddonationsystemdb`.`bloodbank`
(`blood_bank_id`, `monitoring_process`, `manager`, `address`, `donor_record`, `donor`, `hospital`,  `name`, `total_donations`)
VALUES
(15878, 12585, 13587,"Blood_Bank_15878", "10001", "11001", "90005", "Best Blood Bank", 0), 
(15879, 12586, 13588,"Blood_Bank_15879", "10002", "11002", "90003", "Cleanest Blood Bank", 0),
(15880, 12587, 13589,"Blood_Bank_15880", "10003", "11003", "90002", "Blood for All", 0);

-- Blood Result table insert
-- negative results
INSERT INTO `blooddonationsystemdb`.`bloodresult`
(`blood_result_id`, `negative_result`, `doctor`, `laboratory`)
VALUES
(21221, 31001, 72144,16652), 
(21223, 31002, 72146,16654),
(21224, 31004, 72146,16654);
-- positive results
INSERT INTO `blooddonationsystemdb`.`bloodresult`
(`blood_result_id`, `positive_result`, `doctor`, `laboratory`)
VALUES
(21222, 30101, 72145,16653), 
(21226, 30102, 72145,16653),
(21227, 30103, 72145,16653);

-- Blood type table insert
-- o
INSERT INTO `blooddonationsystemdb`.`bloodtype`
(`blood_type_id`,`o_positive_type_blood_type`) 
VALUES
(20510, 1);
-- a
INSERT INTO `blooddonationsystemdb`.`bloodtype`
(`blood_type_id`,`a_positive_type_blood_type`) 
VALUES
(20511, 1);
-- b
INSERT INTO `blooddonationsystemdb`.`bloodtype`
(`blood_type_id`,`b_positive_type_blood_type`) 
VALUES
(20512, 1);

-- Patient table insert
INSERT INTO `blooddonationsystemdb`.`patient`
(`patient_id`, `patient_record`, `blood_transfusion`, `doctor`)
VALUES
(81215, 55121, 66125, 72141), 
(81216, 55122, 66126, 72142), 
(81217, 55123, 66127, 72143);

-- Patient Record table insert
INSERT INTO `blooddonationsystemdb`.`patientrecord`
(`patient_record_id`, `address`, `blood_type`, `patient`, `full_name`, `blood_result`)
VALUES
(55121, "P_55121", "20510", 81215, "Josh Peck", 21221),
(55122, "P_55122", "20511", 81216, "Lionel Messi", 21222),
(55123, "P_55123", "20512", 81217, "Lebron James", 21223);

-- Disease Check table insert
INSERT INTO `blooddonationsystemdb`.`diseasecheck`
(`disease_check_id`, `laboratory`, `donor_record`,`disease_description`, `disease_result`)
VALUES
(32221, 16652, 10001, "STD", 1), 
(32222, 16653, 10002, "Hepatitis A", 1),  
(32223, 16654, 10003, "Hepatitis B", 1);

-- Doctor table insert
INSERT INTO `blooddonationsystemdb`.`doctor`
(`doctor_id`, `hospital`, `patient_record`, `donor_record`, `blood_transfusion`, `blood_result`, `full_name`)
VALUES
(72144, 92221, 55121, 10001, 66125, 21221,"Jerry Duncan"), 
(72145, 92222, 55122, 10002, 66126, 21222,"Chris Tucker"), 
(72146, 92223, 55123, 10003, 66127, 21223,"James Town");

-- Donor table insert
INSERT INTO `blooddonationsystemdb`.`donor`
(`donor_id`, `blood_bank`, `message_blood_bank`, `blood_result`, `donor_record`)
VALUES
(11001, 15878, 15878, 21221,10001),
(11002, 15879, 15879, 21222,10002),
(11003, 15878, 15878, 21223,10003);

-- Donor Record table insert
INSERT INTO `blooddonationsystemdb`.`donorrecord`
(`donor_record_id`, `donor`, `blood_type`, `blood_bank`, `address`,`disease_check`, `full_name`,`blood_result`)
VALUES
(10001, 11001, 20510, 15878, "DR_10001", 32221, "Cristiano Ronaldo", 21221), 
(10002, 11002, 20510, 15878, "DR_10002", 32222, "Kevin Hart", 21222), 
(10003, 11003, 20512, 15878, "DR_10003", 32223, "Jackie Chan", 21223);

-- Hospital table insert
INSERT INTO `blooddonationsystemdb`.`hospital`
(`hospital_id`, `address`, `laboratory`, `donor_record`, `doctor`, `patient_record`, `name`)
VALUES
(92221,"H_92221", 16653,10001, 72144, 55121, "Stanford"), 
(92222,"H_92222", 16654,10002, 72145, 55122, "Kaiser"),  
(92223,"H_92221", 16653,10003, 72146, 55123, "CVS");

-- Messages table inserts
INSERT INTO `blooddonationsystemdb`.`messages`
(`message_id`,`messages_blood_bank_id`, `messages_hospital_id`, `messages_donor_id`, `messages_laboratory_id`,
`disease_check_description`,`sent_description`,`received_description`)
VALUES
(50001, 15878, 92221, 11001, 16653, "STD","disease results", ""), 
(50002, 15879, 92222, 11002, 16654, "none","", ""),
(50003, 15879, 92223, 11002, 16652, "none","", "");

-- Monitoring Process table inserts
INSERT INTO `blooddonationsystemdb`.`monitoringprocess`
(`monitoring_process_id`, `description`)
VALUES 
(12585, "Monitor 24 hours."), 
(12586, "Patient slept all night."), 
(12587, "Slight dizziness according to patient.");

-- Negative Result table insert
INSERT INTO `blooddonationsystemdb`.`negativeresult`
(`negative_result_id`, `negative_result`, `blood_result`)
VALUES
(31001, 1, 21221), 
(31002, 1, 21222), 
(31004, 1, 21224);

-- Blood transfusion table insert 
INSERT INTO `blooddonationsystemdb`.`bloodtransfusion`
(`blood_transfusion_id`, `doctor`, `hospital`, `patient`)
VALUES
(66125, 72144, 92221, 81215), 
(66126, 72145, 92222, 81216), 
(66127, 72146, 92223, 81217);

-- Laboratory table insert
INSERT INTO `blooddonationsystemdb`.`laboratory`
(`laboratory_id`, `donor_record`, `blood_bank_message`, `address`, `hospital`, `disease_check`, `message_sent`, `message_received`, `name`)
VALUES
(16653, 10001, 50001,"H_92221", 92221, 32221, 50001, 50001,"StarLab"), 
(16654, 10002, 50002,"H_92222", 92222, 32221, 50002, 50002,"LabTests"), 
(16652, 10003, 50003,"H_92223", 92223, 32221, 50003, 50003,"SienceLab");

-- Positive  Result table insert
INSERT INTO `blooddonationsystemdb`.`positiveresult`
(`positive_result_id`,`positive_result`, `blood_result`)
VALUES
(30101, 1, 21222), 
(30102, 1, 21226), 
(30103, 1, 21227);

-- Manager table insert
INSERT INTO `blooddonationsystemdb`.`manager`
(`manager_id`, `blood_bank`, `monitoring_process`, `address`, `donor_record`, `full_name`, `total_messages_received`,
`laboratory_messages`, `messages_received`,`messages_sent`)
VALUES
(13587, 15878, 12585, "M_13587",10001, "Trance James", 0, 50001, 50001,50001),
(13588, 15879, 12586, "M_13588",10002, "Nueton Few", 1, 50002, 50002,50002),
(13589, 15880, 12587, "M_13589",10003, "Berry Allen", 1, 50003, 50003,50003);




