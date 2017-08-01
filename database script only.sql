SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema sgm
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `sgm` ;
CREATE SCHEMA IF NOT EXISTS `sgm` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `sgm` ;

-- -----------------------------------------------------
-- Table `sgm`.`Student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Student` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Student` (
  `index` INT NOT NULL,
  `fname` VARCHAR(45) NOT NULL,
  `lname` VARCHAR(45) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  `tel` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`index`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Teacher`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Teacher` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Teacher` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(60) NOT NULL,
  `address` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Class` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Class` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `grade` INT NOT NULL,
  `name` CHAR NOT NULL,
  `year` INT NOT NULL,
  `Teacher_incharge` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Class_Teacher1_idx` (`Teacher_incharge` ASC),
  CONSTRAINT `fk_Class_Teacher1`
    FOREIGN KEY (`Teacher_incharge`)
    REFERENCES `sgm`.`Teacher` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Student_Class`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Student_Class` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Student_Class` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Student_index` INT NOT NULL,
  `Class_id` INT NOT NULL,
  INDEX `fk_Student_has_Class_Class1_idx` (`Class_id` ASC),
  INDEX `fk_Student_has_Class_Student_idx` (`Student_index` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Student_has_Class_Student`
    FOREIGN KEY (`Student_index`)
    REFERENCES `sgm`.`Student` (`index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_has_Class_Class1`
    FOREIGN KEY (`Class_id`)
    REFERENCES `sgm`.`Class` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Subject` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Subject` (
  `code` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`code`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Marks`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Marks` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Marks` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Student_Class_id` INT NOT NULL,
  `Subject_code` INT NOT NULL,
  `term` INT NOT NULL,
  `value` INT NOT NULL,
  `grade` CHAR NOT NULL,
  INDEX `fk_Student_Class_has_Subject_Subject1_idx` (`Subject_code` ASC),
  INDEX `fk_Student_Class_has_Subject_Student_Class1_idx` (`Student_Class_id` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_Student_Class_has_Subject_Student_Class1`
    FOREIGN KEY (`Student_Class_id`)
    REFERENCES `sgm`.`Student_Class` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Student_Class_has_Subject_Subject1`
    FOREIGN KEY (`Subject_code`)
    REFERENCES `sgm`.`Subject` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Student_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Student_user` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Student_user` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `Student_index` INT NOT NULL,
  PRIMARY KEY (`username`, `password`, `Student_index`),
  INDEX `fk_Student_user_Student1_idx` (`Student_index` ASC),
  CONSTRAINT `fk_Student_user_Student1`
    FOREIGN KEY (`Student_index`)
    REFERENCES `sgm`.`Student` (`index`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Teacher_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Teacher_user` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Teacher_user` (
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `Teacher_id` INT NOT NULL,
  PRIMARY KEY (`username`, `password`, `Teacher_id`),
  INDEX `fk_Teacher_user_Teacher1_idx` (`Teacher_id` ASC),
  CONSTRAINT `fk_Teacher_user_Teacher1`
    FOREIGN KEY (`Teacher_id`)
    REFERENCES `sgm`.`Teacher` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sgm`.`Teacher_Subject`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sgm`.`Teacher_Subject` ;

CREATE TABLE IF NOT EXISTS `sgm`.`Teacher_Subject` (
  `Teacher_id` INT NOT NULL,
  `Subject_code` INT NOT NULL,
  PRIMARY KEY (`Teacher_id`, `Subject_code`),
  INDEX `fk_Teacher_has_Subject_Subject1_idx` (`Subject_code` ASC),
  INDEX `fk_Teacher_has_Subject_Teacher1_idx` (`Teacher_id` ASC),
  CONSTRAINT `fk_Teacher_has_Subject_Teacher1`
    FOREIGN KEY (`Teacher_id`)
    REFERENCES `sgm`.`Teacher` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Teacher_has_Subject_Subject1`
    FOREIGN KEY (`Subject_code`)
    REFERENCES `sgm`.`Subject` (`code`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
