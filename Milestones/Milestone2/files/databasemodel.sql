-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BloodDonationSystemDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BloodDonationSystemDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BloodDonationSystemDB` DEFAULT CHARACTER SET utf8 ;
USE `BloodDonationSystemDB` ;

-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Address` (
  `address_id` VARCHAR(60) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`BloodBank`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`BloodBank` (
  `blood_bank_id` INT(5) NOT NULL,
  `monitoring_process` INT(5) NOT NULL,
  `manager` INT(5) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `donor_record` INT(5) NULL,
  `donor` INT(5) NULL,
  `hospital` INT(5) NULL,
  `name` VARCHAR(60) NOT NULL,
  `total_donations` INT NULL,
  PRIMARY KEY (`blood_bank_id`),
  UNIQUE INDEX `monitoring_process_UNIQUE` (`monitoring_process` ASC) VISIBLE,
  UNIQUE INDEX `manager_UNIQUE` (`manager` ASC) VISIBLE,
  UNIQUE INDEX `donor_record_UNIQUE` (`donor_record` ASC) VISIBLE,
  UNIQUE INDEX `donor_UNIQUE` (`donor` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`BloodType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`BloodType` (
  `blood_type_id` INT NOT NULL,
  `o_positive_type_blood_type` TINYINT(1) NULL,
  `o_negative_type_blood_type` TINYINT(1) NULL,
  `a_positive_type_blood_type` TINYINT(1) NULL,
  `a_negative_type_blood_type` TINYINT(1) NULL,
  `b_positive_type_blood_type` TINYINT(1) NULL,
  `b_negative_type_blood_type` TINYINT(1) NULL,
  `ab_positive_type_blood_type` TINYINT(1) NULL,
  `ab_negative_type_blood_type` TINYINT(1) NULL,
  PRIMARY KEY (`blood_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Patient` (
  `patient_id` INT(5) NOT NULL,
  `patient_record` INT(5) NULL,
  `blood_transfusion` INT(5) NULL,
  `doctor` INT(5) NULL,
  PRIMARY KEY (`patient_id`),
  UNIQUE INDEX `patient_record_UNIQUE` (`patient_record` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`BloodTransfusion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`BloodTransfusion` (
  `blood_transfusion_id` INT(5) NOT NULL,
  `doctor` INT(5) NULL,
  `hospital` INT(5) NULL,
  `patient` INT(5) NULL,
  PRIMARY KEY (`blood_transfusion_id`),
  UNIQUE INDEX `patient_UNIQUE` (`patient` ASC) VISIBLE,
  CONSTRAINT `BLOOD_TRANSFUSION_BP_FK`
    FOREIGN KEY (`patient`)
    REFERENCES `BloodDonationSystemDB`.`Patient` (`patient_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`BloodResult`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`BloodResult` (
  `blood_result_id` INT(5) NOT NULL,
  `positive_result` INT(5) NULL,
  `negative_result` INT(5) NULL,
  `doctor` INT(5) NULL,
  `laboratory` INT(5) NULL,
  PRIMARY KEY (`blood_result_id`),
  UNIQUE INDEX `positive_result_UNIQUE` (`positive_result` ASC) VISIBLE,
  UNIQUE INDEX `negative_result_UNIQUE` (`negative_result` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Hospital`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Hospital` (
  `hospital_id` INT(5) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `laboratory` INT(5) NULL,
  `donor_record` INT(5) NULL,
  `doctor` INT(5) NULL,
  `patient_record` INT(5) NULL,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`hospital_id`),
  UNIQUE INDEX `donor_record_UNIQUE` (`donor_record` ASC) VISIBLE,
  UNIQUE INDEX `patient_UNIQUE` (`patient_record` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Doctor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Doctor` (
  `doctor_id` INT(5) NOT NULL,
  `hospital` INT(5) NULL,
  `patient_record` INT(5) NULL,
  `donor_record` INT(5) NULL,
  `blood_transfusion` INT(5) NULL,
  `blood_result` INT(5) NULL,
  `full_name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`doctor_id`),
  UNIQUE INDEX `full_name_UNIQUE` (`full_name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`PatientRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`PatientRecord` (
  `Patient_record_id` INT(5) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `blood_type` INT(5) NOT NULL,
  `patient` INT(5) NOT NULL,
  `full_name` VARCHAR(60) NOT NULL,
  `blood_result` INT(5) NULL,
  `hospital` INT(5) NULL,
  `doctor` INT NULL,
  PRIMARY KEY (`Patient_record_id`),
  UNIQUE INDEX `blood_type_UNIQUE` (`blood_type` ASC) VISIBLE,
  UNIQUE INDEX `patient_UNIQUE` (`patient` ASC) VISIBLE,
  UNIQUE INDEX `full_name_UNIQUE` (`full_name` ASC) VISIBLE,
  UNIQUE INDEX `blood_result_UNIQUE` (`blood_result` ASC) VISIBLE,
  INDEX `PATIENT_RECORD_ADDRESS_FK_idx` (`address` ASC) VISIBLE,
  INDEX `PATIENT_RECORD_HOSPITAL_FK_idx` (`hospital` ASC) VISIBLE,
  INDEX `PATIENT_RECORD_DOCTOR_FK_idx` (`doctor` ASC) VISIBLE,
  CONSTRAINT `PATIENT_RECORD_ADDRESS_FK`
    FOREIGN KEY (`address`)
    REFERENCES `BloodDonationSystemDB`.`Address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PATIENT_RECORD_BLOOT_TYPE_FK`
    FOREIGN KEY (`blood_type`)
    REFERENCES `BloodDonationSystemDB`.`BloodType` (`blood_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PATIENT_RECORD_BLOOD_RESULT_FK`
    FOREIGN KEY (`blood_result`)
    REFERENCES `BloodDonationSystemDB`.`BloodResult` (`blood_result_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `PATIENT_RECORD_BP_FK`
    FOREIGN KEY (`patient`)
    REFERENCES `BloodDonationSystemDB`.`Patient` (`patient_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `PATIENT_RECORD_HOSPITAL_FK`
    FOREIGN KEY (`hospital`)
    REFERENCES `BloodDonationSystemDB`.`Hospital` (`hospital_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `PATIENT_RECORD_DOCTOR_FK`
    FOREIGN KEY (`doctor`)
    REFERENCES `BloodDonationSystemDB`.`Doctor` (`doctor_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Laboratory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Laboratory` (
  `laboratory_id` INT(5) NOT NULL,
  `donor_record` INT(5) NULL,
  `blood_bank_message` INT(5) NULL,
  `address` VARCHAR(60) NOT NULL,
  `hospital` INT(5) NULL,
  `disease_check` INT(5) NOT NULL,
  `message_sent` INT(5) NULL,
  `message_received` INT(5) NULL,
  `name` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`laboratory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Donor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Donor` (
  `donor_id` INT(5) NOT NULL,
  `blood_bank` INT(5) NULL,
  `message_blood_bank` INT(5) NULL,
  `blood_result` INT(5) NOT NULL,
  `donor_record` INT(5) NULL,
  PRIMARY KEY (`donor_id`),
  UNIQUE INDEX `blood_result_UNIQUE` (`blood_result` ASC) VISIBLE,
  UNIQUE INDEX `donor_record_UNIQUE` (`donor_record` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`DiseaseCheck`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`DiseaseCheck` (
  `disease_check_id` INT(5) NOT NULL,
  `laboratory` INT(5) NOT NULL,
  `donor_record` INT(5) NULL,
  `disease_description` VARCHAR(60) NOT NULL,
  `disease_result` INT NULL,
  PRIMARY KEY (`disease_check_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`DonorRecord`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`DonorRecord` (
  `donor_record_id` INT(5) NOT NULL,
  `donor` INT(5) NOT NULL,
  `blood_type` INT(5) NOT NULL,
  `blood_bank` INT(5) NOT NULL,
  `blood_result` INT(5) NULL,
  `disease_check` INT(5) NOT NULL,
  `address` VARCHAR(60) NULL,
  `full_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`donor_record_id`, `blood_type`, `blood_bank`),
  UNIQUE INDEX `donor_UNIQUE` (`donor` ASC) VISIBLE,
  UNIQUE INDEX `blood_result_UNIQUE` (`blood_result` ASC) VISIBLE,
  UNIQUE INDEX `disease_check_UNIQUE` (`disease_check` ASC) VISIBLE,
  UNIQUE INDEX `full_name_UNIQUE` (`full_name` ASC) VISIBLE,
  INDEX `DONOR_RECORD_BLOOD_TYPE_PK_FK_idx` (`blood_type` ASC) VISIBLE,
  INDEX `DONOR_RECORD_ADDRESS_FK_idx` (`address` ASC) VISIBLE,
  INDEX `DONOR_RECORD_BLOOD_BANK_PK_FK_idx` (`blood_bank` ASC) VISIBLE,
  CONSTRAINT `DONOR_RECORD_BLOOD_TYPE_PK_FK`
    FOREIGN KEY (`blood_type`)
    REFERENCES `BloodDonationSystemDB`.`BloodType` (`blood_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `DONOR_DONOR_RECORD_FK`
    FOREIGN KEY (`donor`)
    REFERENCES `BloodDonationSystemDB`.`Donor` (`donor_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `DONOR_RECORD_ADDRESS_FK`
    FOREIGN KEY (`address`)
    REFERENCES `BloodDonationSystemDB`.`Address` (`address_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `DONOR_RECORD_BLOOD_RESULT_FK`
    FOREIGN KEY (`blood_result`)
    REFERENCES `BloodDonationSystemDB`.`BloodResult` (`blood_result_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `DONOR_RECORD_DISEASE_CHECK_FK`
    FOREIGN KEY (`disease_check`)
    REFERENCES `BloodDonationSystemDB`.`DiseaseCheck` (`disease_check_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `DONOR_RECORD_BLOOD_BANK_PK_FK`
    FOREIGN KEY (`blood_bank`)
    REFERENCES `BloodDonationSystemDB`.`BloodBank` (`blood_bank_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`PositiveResult`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`PositiveResult` (
  `positive_result_id` INT(5) NOT NULL,
  `positive_result` TINYINT(1) NULL,
  `blood_result` INT(5) NULL,
  PRIMARY KEY (`positive_result_id`),
  INDEX `BR_POSITIVE_FK_idx` (`blood_result` ASC) VISIBLE,
  CONSTRAINT `BR_POSITIVE_FK`
    FOREIGN KEY (`blood_result`)
    REFERENCES `BloodDonationSystemDB`.`BloodResult` (`blood_result_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Messages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Messages` (
  `message_id` INT NOT NULL,
  `messages_blood_bank_id` INT(5) NULL,
  `messages_hospital_id` INT(5) NULL,
  `messages_donor_id` INT(5) NULL,
  `messages_laboratory_id` INT(5) NULL,
  `disease_check_description` VARCHAR(60) NULL,
  `sent_description` VARCHAR(60) NULL,
  `received_description` VARCHAR(60) NULL,
  PRIMARY KEY (`message_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`NegativeResult`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`NegativeResult` (
  `negative_result_id` INT(5) NOT NULL,
  `negative_result` TINYINT(1) NULL,
  `blood_result` INT(5) NULL,
  PRIMARY KEY (`negative_result_id`),
  INDEX `BR_NEGATIVE_FK_idx` (`blood_result` ASC) VISIBLE,
  CONSTRAINT `BR_NEGATIVE_FK`
    FOREIGN KEY (`blood_result`)
    REFERENCES `BloodDonationSystemDB`.`BloodResult` (`blood_result_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`MonitoringProcess`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`MonitoringProcess` (
  `monitoring_process_id` INT(5) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`monitoring_process_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BloodDonationSystemDB`.`Manager`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BloodDonationSystemDB`.`Manager` (
  `manager_id` INT NOT NULL,
  `blood_bank` INT(5) NOT NULL,
  `monitoring_process` INT(5) NOT NULL,
  `address` VARCHAR(60) NOT NULL,
  `donor_record` INT(5) NULL,
  `full_name` VARCHAR(60) NOT NULL,
  `total_messages_received` INT NULL,
  `laboratory_messages` INT(5) NULL DEFAULT 0,
  `messages_received` INT NULL DEFAULT 0,
  `messages_sent` INT NULL DEFAULT 0,
  PRIMARY KEY (`manager_id`, `blood_bank`, `monitoring_process`),
  UNIQUE INDEX `donor_record_UNIQUE` (`donor_record` ASC) VISIBLE,
  UNIQUE INDEX `full_name_UNIQUE` (`full_name` ASC) VISIBLE,
  INDEX `MANAGER_BLOOD_BANK_PK_FK_idx` (`blood_bank` ASC) VISIBLE,
  INDEX `MANAGER_MONITORING_PROCESS_PK_FK_idx` (`monitoring_process` ASC) VISIBLE,
  INDEX `MANAGER_ADDRESS_FK_idx` (`address` ASC) VISIBLE,
  INDEX `MANAGER_MESSAGE_SENT_FK_idx` (`messages_sent` ASC) VISIBLE,
  INDEX `MANAGER_MESSAGE_RECEIVED_FK_idx` (`messages_received` ASC) VISIBLE,
  INDEX `MANAGER_MESSAGE_LAB_FK_idx` (`laboratory_messages` ASC) VISIBLE,
  CONSTRAINT `MANAGER_BLOOD_BANK_PK_FK`
    FOREIGN KEY (`blood_bank`)
    REFERENCES `BloodDonationSystemDB`.`BloodBank` (`blood_bank_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MANAGER_DONOR_RECORD_FK`
    FOREIGN KEY (`donor_record`)
    REFERENCES `BloodDonationSystemDB`.`DonorRecord` (`donor_record_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `MANAGER_MONITORING_PROCESS_PK_FK`
    FOREIGN KEY (`monitoring_process`)
    REFERENCES `BloodDonationSystemDB`.`MonitoringProcess` (`monitoring_process_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MANAGER_ADDRESS_FK`
    FOREIGN KEY (`address`)
    REFERENCES `BloodDonationSystemDB`.`Address` (`address_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `MANAGER_MESSAGE_SENT_FK`
    FOREIGN KEY (`messages_sent`)
    REFERENCES `BloodDonationSystemDB`.`Messages` (`message_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `MANAGER_MESSAGE_RECEIVED_FK`
    FOREIGN KEY (`messages_received`)
    REFERENCES `BloodDonationSystemDB`.`Messages` (`message_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `MANAGER_MESSAGE_LAB_FK`
    FOREIGN KEY (`laboratory_messages`)
    REFERENCES `BloodDonationSystemDB`.`Messages` (`message_id`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
