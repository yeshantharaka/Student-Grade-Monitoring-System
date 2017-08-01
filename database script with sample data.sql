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


INSERT INTO teacher (id, `name`, address) VALUES(1, 'Sumithra', 'Peradeniya');
INSERT INTO teacher (id, `name`, address) VALUES(2, 'Kamala', 'Kandy');
INSERT INTO teacher (id, `name`, address) VALUES(3, 'Nuwan', 'Gampola');

-- Classes
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(1, 6, 'A', 2010, 1);
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(2, 6, 'B', 2010, 2);

INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(3, 7, 'A', 2011, 1);
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(4, 7, 'B', 2011, 2);

INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(5, 8, 'A', 2012, 1);
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(6, 8, 'B', 2012, 2);

INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(7, 9, 'A', 2013, 1);
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(8, 9, 'B', 2013, 2);

INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(9, 10, 'A', 2014, 1);
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(10, 10, 'B', 2014, 2);

INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(11, 11, 'A', 2015, 1);
INSERT INTO class (id, grade, `name`, `year`, Teacher_incharge) VALUES(12, 11, 'B', 2015, 2);

INSERT INTO student (`index`, fname, lname, address, tel) VALUES(13840, 'Sandaruwan', 'Gunawardhana', 'Ampara', '0710312437');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(13850, 'Kamal', 'Perera', 'Panadura', '0710312437');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(13860, 'Nimal', 'Sumudu', 'Kandy', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(15422, 'Sunimal', 'Malaka', 'Colombo', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(58623, 'Alec', 'Paul', 'Newzeeland', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(24823, 'Foz', 'Mulder', 'England', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(35465, 'Recker', 'Brinston', 'Somaliya', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(65123, 'Khona', 'Yomal', 'Japan', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(23542, 'Sean', 'Paul', 'America', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(21354, 'Malik', 'Subran', 'Iraq', '0112224448');
INSERT INTO student (`index`, fname, lname, address, tel) VALUES(54620, 'Mekalu', 'Komale', 'Jaffna', '0112224448');

INSERT INTO student_class (id, Student_index, Class_id) VALUES(1,13840,1);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(2,13860,1);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(3,13850,1);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(4,15422,1);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(5,35465,1);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(6,23542,1);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(7,54620,1);

INSERT INTO student_class (id, Student_index, Class_id) VALUES(8,13840,3);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(9,13860,3);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(10,13850,3);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(11,15422,3);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(12,35465,3);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(13,23542,3);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(14,54620,3);

INSERT INTO student_class (id, Student_index, Class_id) VALUES(15,13840,5);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(16,13860,5);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(17,13850,5);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(18,15422,5);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(19,35465,5);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(20,23542,5);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(21,54620,5);

INSERT INTO student_class (id, Student_index, Class_id) VALUES(22,13840,7);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(23,13860,7);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(24,13850,7);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(25,15422,7);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(26,35465,7);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(27,23542,7);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(28,54620,7);

INSERT INTO student_class (id, Student_index, Class_id) VALUES(29,13840,9);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(30,13850,9);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(31,15422,9);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(32,35465,9);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(33,23542,9);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(34,54620,9);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(35,13860,9);

INSERT INTO student_class (id, Student_index, Class_id) VALUES(36,13840,11);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(37,13860,11);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(38,13850,11);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(39,15422,11);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(40,35465,11);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(41,23542,11);
INSERT INTO student_class (id, Student_index, Class_id) VALUES(42,54620,11);

INSERT INTO `subject` (`code`, `name`, `type`) VALUES(1, 'Sinhala', 'core');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(2, 'Maths', 'core');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(3, 'Science', 'core');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(4, 'History', 'core');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(5, 'Buddhism', 'core');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(6, 'English', 'core');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(7, 'IT', 'elective');
INSERT INTO `subject` (`code`, `name`, `type`) VALUES(8, 'Commerce', 'elective');




INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '1', '1', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '1', '2', '65', 'B');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '1', '3', '80', 'A');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '2', '1', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '2', '2', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '2', '3', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '3', '1', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '3', '2', '30', 'F');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '3', '3', '80', 'A');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '4', '1', '65', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '4', '2', '45', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '4', '3', '35', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '5', '1', '89', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '5', '2', '24', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '5', '3', '98', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '6', '1', '75', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '6', '2', '98', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '6', '3', '48', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '7', '1', '67', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '7', '2', '69', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '7', '3', '85', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '8', '1', '78', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '8', '2', '84', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '1', '8', '3', '66', 'X');


INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '1', '1', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '1', '2', '65', 'B');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '1', '3', '80', 'A');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '2', '1', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '2', '2', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '2', '3', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '3', '1', '55', 'C');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '3', '2', '30', 'F');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '3', '3', '80', 'A');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '4', '1', '65', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '4', '2', '45', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '4', '3', '35', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '5', '1', '89', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '5', '2', '24', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '5', '3', '98', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '6', '1', '75', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '6', '2', '98', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '6', '3', '48', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '7', '1', '67', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '7', '2', '69', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '7', '3', '85', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '8', '1', '78', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '8', '2', '84', 'X');
INSERT INTO `marks` ( `Student_Class_id`, `Subject_code`, `term`, `value`, `grade`) VALUES ( '2', '8', '3', '66', 'X');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 1, '1', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 1, '2', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 1, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 2, '1', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 2, '2', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 2, '3', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 3, '1', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 3, '2', 77, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 3, '3', 37, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 4, '1', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 4, '2', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 4, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 5, '1', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 5, '2', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 5, '3', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 6, '1', 73, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 6, '2', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 6, '3', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 7, '1', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 7, '2', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 7, '3', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 8, '1', 37, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 8, '2', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 3, 8, '3', 51, 'C');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 1, '1', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 1, '2', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 1, '3', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 2, '1', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 2, '2', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 2, '3', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 3, '1', 13, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 3, '2', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 3, '3', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 4, '1', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 4, '2', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 4, '3', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 5, '1', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 5, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 5, '3', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 6, '1', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 6, '2', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 6, '3', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 7, '1', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 7, '2', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 7, '3', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 8, '1', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 8, '2', 37, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 4, 8, '3', 53, 'C');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 1, '1', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 1, '2', 94, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 1, '3', 13, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 2, '1', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 2, '2', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 2, '3', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 3, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 3, '2', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 3, '3', 81, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 4, '1', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 4, '2', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 4, '3', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 5, '1', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 5, '2', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 5, '3', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 6, '1', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 6, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 6, '3', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 7, '1', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 7, '2', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 7, '3', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 8, '1', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 8, '2', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 5, 8, '3', 88, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 1, '1', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 1, '2', 77, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 1, '3', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 2, '1', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 2, '2', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 2, '3', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 3, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 3, '2', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 3, '3', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 4, '1', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 4, '2', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 4, '3', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 5, '1', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 5, '2', 91, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 5, '3', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 6, '1', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 6, '2', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 6, '3', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 7, '1', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 7, '2', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 7, '3', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 8, '1', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 8, '2', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 6, 8, '3', 54, 'C');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 1, '1', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 1, '2', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 1, '3', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 2, '1', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 2, '2', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 2, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 3, '1', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 3, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 3, '3', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 4, '1', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 4, '2', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 4, '3', 77, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 5, '1', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 5, '2', 63, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 5, '3', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 6, '1', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 6, '2', 58, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 6, '3', 34, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 7, '1', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 7, '2', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 7, '3', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 8, '1', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 8, '2', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 7, 8, '3', 8, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 1, '1', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 1, '2', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 1, '3', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 2, '1', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 2, '2', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 2, '3', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 3, '1', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 3, '2', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 3, '3', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 4, '1', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 4, '2', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 4, '3', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 5, '1', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 5, '2', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 5, '3', 50, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 6, '1', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 6, '2', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 6, '3', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 7, '1', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 7, '2', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 7, '3', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 8, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 8, '2', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 8, 8, '3', 22, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 1, '1', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 1, '2', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 1, '3', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 2, '1', 52, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 2, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 2, '3', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 3, '1', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 3, '2', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 3, '3', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 4, '1', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 4, '2', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 4, '3', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 5, '1', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 5, '2', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 5, '3', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 6, '1', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 6, '2', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 6, '3', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 7, '1', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 7, '2', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 7, '3', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 8, '1', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 8, '2', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 9, 8, '3', 20, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 1, '1', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 1, '2', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 1, '3', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 2, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 2, '2', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 2, '3', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 3, '1', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 3, '2', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 3, '3', 22, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 4, '1', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 4, '2', 94, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 4, '3', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 5, '1', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 5, '2', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 5, '3', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 6, '1', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 6, '2', 24, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 6, '3', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 7, '1', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 7, '2', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 7, '3', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 8, '1', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 8, '2', 48, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 10, 8, '3', 25, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 1, '1', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 1, '2', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 1, '3', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 2, '1', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 2, '2', 48, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 2, '3', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 3, '1', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 3, '2', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 3, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 4, '1', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 4, '2', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 4, '3', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 5, '1', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 5, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 5, '3', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 6, '1', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 6, '2', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 6, '3', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 7, '1', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 7, '2', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 7, '3', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 8, '1', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 8, '2', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 11, 8, '3', 52, 'C');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 1, '1', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 1, '2', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 1, '3', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 2, '1', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 2, '2', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 2, '3', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 3, '1', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 3, '2', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 3, '3', 77, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 4, '1', 81, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 4, '2', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 4, '3', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 5, '1', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 5, '2', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 5, '3', 52, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 6, '1', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 6, '2', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 6, '3', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 7, '1', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 7, '2', 17, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 7, '3', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 8, '1', 22, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 8, '2', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 12, 8, '3', 86, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 1, '1', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 1, '2', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 1, '3', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 2, '1', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 2, '2', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 2, '3', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 3, '1', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 3, '2', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 3, '3', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 4, '1', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 4, '2', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 4, '3', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 5, '1', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 5, '2', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 5, '3', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 6, '1', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 6, '2', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 6, '3', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 7, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 7, '2', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 7, '3', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 8, '1', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 8, '2', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 13, 8, '3', 2, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 1, '1', 58, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 1, '2', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 1, '3', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 2, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 2, '2', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 2, '3', 73, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 3, '1', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 3, '2', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 3, '3', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 4, '1', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 4, '2', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 4, '3', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 5, '1', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 5, '2', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 5, '3', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 6, '1', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 6, '2', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 6, '3', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 7, '1', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 7, '2', 17, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 7, '3', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 8, '1', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 8, '2', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 14, 8, '3', 22, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 1, '1', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 1, '2', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 1, '3', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 2, '1', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 2, '2', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 2, '3', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 3, '1', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 3, '2', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 3, '3', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 4, '1', 58, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 4, '2', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 4, '3', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 5, '1', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 5, '2', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 5, '3', 34, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 6, '1', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 6, '2', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 6, '3', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 7, '1', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 7, '2', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 7, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 8, '1', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 8, '2', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 15, 8, '3', 8, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 1, '1', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 1, '2', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 1, '3', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 2, '1', 91, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 2, '2', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 2, '3', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 3, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 3, '2', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 3, '3', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 4, '1', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 4, '2', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 4, '3', 75, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 5, '1', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 5, '2', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 5, '3', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 6, '1', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 6, '2', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 6, '3', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 7, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 7, '2', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 7, '3', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 8, '1', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 8, '2', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 16, 8, '3', 91, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 1, '1', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 1, '2', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 1, '3', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 2, '1', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 2, '2', 68, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 2, '3', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 3, '1', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 3, '2', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 3, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 4, '1', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 4, '2', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 4, '3', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 5, '1', 22, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 5, '2', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 5, '3', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 6, '1', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 6, '2', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 6, '3', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 7, '1', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 7, '2', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 7, '3', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 8, '1', 52, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 8, '2', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 17, 8, '3', 67, 'B');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 1, '1', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 1, '2', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 1, '3', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 2, '1', 34, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 2, '2', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 2, '3', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 3, '1', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 3, '2', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 3, '3', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 4, '1', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 4, '2', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 4, '3', 13, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 5, '1', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 5, '2', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 5, '3', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 6, '1', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 6, '2', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 6, '3', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 7, '1', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 7, '2', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 7, '3', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 8, '1', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 8, '2', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 18, 8, '3', 81, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 1, '1', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 1, '2', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 1, '3', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 2, '1', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 2, '2', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 2, '3', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 3, '1', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 3, '2', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 3, '3', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 4, '1', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 4, '2', 80, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 4, '3', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 5, '1', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 5, '2', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 5, '3', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 6, '1', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 6, '2', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 6, '3', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 7, '1', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 7, '2', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 7, '3', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 8, '1', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 8, '2', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 19, 8, '3', 65, 'B');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 1, '1', 94, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 1, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 1, '3', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 2, '1', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 2, '2', 94, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 2, '3', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 3, '1', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 3, '2', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 3, '3', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 4, '1', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 4, '2', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 4, '3', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 5, '1', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 5, '2', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 5, '3', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 6, '1', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 6, '2', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 6, '3', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 7, '1', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 7, '2', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 7, '3', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 8, '1', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 8, '2', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 20, 8, '3', 47, 'S');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 1, '1', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 1, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 1, '3', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 2, '1', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 2, '2', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 2, '3', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 3, '1', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 3, '2', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 3, '3', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 4, '1', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 4, '2', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 4, '3', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 5, '1', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 5, '2', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 5, '3', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 6, '1', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 6, '2', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 6, '3', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 7, '1', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 7, '2', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 7, '3', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 8, '1', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 8, '2', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 21, 8, '3', 23, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 1, '1', 91, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 1, '2', 94, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 1, '3', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 2, '1', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 2, '2', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 2, '3', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 3, '1', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 3, '2', 80, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 3, '3', 24, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 4, '1', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 4, '2', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 4, '3', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 5, '1', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 5, '2', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 5, '3', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 6, '1', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 6, '2', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 6, '3', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 7, '1', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 7, '2', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 7, '3', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 8, '1', 17, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 8, '2', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 22, 8, '3', 9, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 1, '1', 23, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 1, '2', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 1, '3', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 2, '1', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 2, '2', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 2, '3', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 3, '1', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 3, '2', 80, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 3, '3', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 4, '1', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 4, '2', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 4, '3', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 5, '1', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 5, '2', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 5, '3', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 6, '1', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 6, '2', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 6, '3', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 7, '1', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 7, '2', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 7, '3', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 8, '1', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 8, '2', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 23, 8, '3', 55, 'C');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 1, '1', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 1, '2', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 1, '3', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 2, '1', 58, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 2, '2', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 2, '3', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 3, '1', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 3, '2', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 3, '3', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 4, '1', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 4, '2', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 4, '3', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 5, '1', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 5, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 5, '3', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 6, '1', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 6, '2', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 6, '3', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 7, '1', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 7, '2', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 7, '3', 52, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 8, '1', 58, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 8, '2', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 24, 8, '3', 15, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 1, '1', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 1, '2', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 1, '3', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 2, '1', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 2, '2', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 2, '3', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 3, '1', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 3, '2', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 3, '3', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 4, '1', 23, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 4, '2', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 4, '3', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 5, '1', 22, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 5, '2', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 5, '3', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 6, '1', 68, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 6, '2', 68, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 6, '3', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 7, '1', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 7, '2', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 7, '3', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 8, '1', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 8, '2', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 25, 8, '3', 66, 'B');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 1, '1', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 1, '2', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 1, '3', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 2, '1', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 2, '2', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 2, '3', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 3, '1', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 3, '2', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 3, '3', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 4, '1', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 4, '2', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 4, '3', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 5, '1', 68, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 5, '2', 24, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 5, '3', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 6, '1', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 6, '2', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 6, '3', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 7, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 7, '2', 17, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 7, '3', 58, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 8, '1', 50, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 8, '2', 75, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 26, 8, '3', 80, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 1, '1', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 1, '2', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 1, '3', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 2, '1', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 2, '2', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 2, '3', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 3, '1', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 3, '2', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 3, '3', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 4, '1', 22, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 4, '2', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 4, '3', 48, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 5, '1', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 5, '2', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 5, '3', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 6, '1', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 6, '2', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 6, '3', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 7, '1', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 7, '2', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 7, '3', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 8, '1', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 8, '2', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 27, 8, '3', 77, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 1, '1', 48, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 1, '2', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 1, '3', 77, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 2, '1', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 2, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 2, '3', 34, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 3, '1', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 3, '2', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 3, '3', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 4, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 4, '2', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 4, '3', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 5, '1', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 5, '2', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 5, '3', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 6, '1', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 6, '2', 68, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 6, '3', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 7, '1', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 7, '2', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 7, '3', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 8, '1', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 8, '2', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 28, 8, '3', 86, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 1, '1', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 1, '2', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 1, '3', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 2, '1', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 2, '2', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 2, '3', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 3, '1', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 3, '2', 23, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 3, '3', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 4, '1', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 4, '2', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 4, '3', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 5, '1', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 5, '2', 91, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 5, '3', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 6, '1', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 6, '2', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 6, '3', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 7, '1', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 7, '2', 37, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 7, '3', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 8, '1', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 8, '2', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 29, 8, '3', 31, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 1, '1', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 1, '2', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 1, '3', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 2, '1', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 2, '2', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 2, '3', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 3, '1', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 3, '2', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 3, '3', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 4, '1', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 4, '2', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 4, '3', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 5, '1', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 5, '2', 24, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 5, '3', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 6, '1', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 6, '2', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 6, '3', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 7, '1', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 7, '2', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 7, '3', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 8, '1', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 8, '2', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 30, 8, '3', 88, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 1, '1', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 1, '2', 14, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 1, '3', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 2, '1', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 2, '2', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 2, '3', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 3, '1', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 3, '2', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 3, '3', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 4, '1', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 4, '2', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 4, '3', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 5, '1', 81, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 5, '2', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 5, '3', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 6, '1', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 6, '2', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 6, '3', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 7, '1', 63, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 7, '2', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 7, '3', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 8, '1', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 8, '2', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 31, 8, '3', 97, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 1, '1', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 1, '2', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 1, '3', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 2, '1', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 2, '2', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 2, '3', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 3, '1', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 3, '2', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 3, '3', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 4, '1', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 4, '2', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 4, '3', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 5, '1', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 5, '2', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 5, '3', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 6, '1', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 6, '2', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 6, '3', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 7, '1', 37, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 7, '2', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 7, '3', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 8, '1', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 8, '2', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 32, 8, '3', 38, 'S');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 1, '1', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 1, '2', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 1, '3', 23, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 2, '1', 25, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 2, '2', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 2, '3', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 3, '1', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 3, '2', 36, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 3, '3', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 4, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 4, '2', 39, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 4, '3', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 5, '1', 57, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 5, '2', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 5, '3', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 6, '1', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 6, '2', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 6, '3', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 7, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 7, '2', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 7, '3', 34, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 8, '1', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 8, '2', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 33, 8, '3', 3, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 1, '1', 34, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 1, '2', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 1, '3', 46, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 2, '1', 48, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 2, '2', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 2, '3', 21, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 3, '1', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 3, '2', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 3, '3', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 4, '1', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 4, '2', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 4, '3', 37, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 5, '1', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 5, '2', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 5, '3', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 6, '1', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 6, '2', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 6, '3', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 7, '1', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 7, '2', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 7, '3', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 8, '1', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 8, '2', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 34, 8, '3', 77, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 1, '1', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 1, '2', 48, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 1, '3', 66, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 2, '1', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 2, '2', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 2, '3', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 3, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 3, '2', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 3, '3', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 4, '1', 100, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 4, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 4, '3', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 5, '1', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 5, '2', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 5, '3', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 6, '1', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 6, '2', 50, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 6, '3', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 7, '1', 86, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 7, '2', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 7, '3', 63, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 8, '1', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 8, '2', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 35, 8, '3', 85, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 1, '1', 98, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 1, '2', 7, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 1, '3', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 2, '1', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 2, '2', 10, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 2, '3', 89, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 3, '1', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 3, '2', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 3, '3', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 4, '1', 59, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 4, '2', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 4, '3', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 5, '1', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 5, '2', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 5, '3', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 6, '1', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 6, '2', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 6, '3', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 7, '1', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 7, '2', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 7, '3', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 8, '1', 91, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 8, '2', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 36, 8, '3', 1, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 1, '1', 92, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 1, '2', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 1, '3', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 2, '1', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 2, '2', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 2, '3', 90, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 3, '1', 56, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 3, '2', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 3, '3', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 4, '1', 40, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 4, '2', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 4, '3', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 5, '1', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 5, '2', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 5, '3', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 6, '1', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 6, '2', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 6, '3', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 7, '1', 99, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 7, '2', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 7, '3', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 8, '1', 70, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 8, '2', 28, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 37, 8, '3', 70, 'B');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 1, '1', 47, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 1, '2', 88, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 1, '3', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 2, '1', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 2, '2', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 2, '3', 76, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 3, '1', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 3, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 3, '3', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 4, '1', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 4, '2', 61, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 4, '3', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 5, '1', 95, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 5, '2', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 5, '3', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 6, '1', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 6, '2', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 6, '3', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 7, '1', 55, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 7, '2', 93, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 7, '3', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 8, '1', 83, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 8, '2', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 38, 8, '3', 29, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 1, '1', 65, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 1, '2', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 1, '3', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 2, '1', 42, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 2, '2', 33, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 2, '3', 6, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 3, '1', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 3, '2', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 3, '3', 23, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 4, '1', 38, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 4, '2', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 4, '3', 22, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 5, '1', 50, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 5, '2', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 5, '3', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 6, '1', 45, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 6, '2', 63, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 6, '3', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 7, '1', 30, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 7, '2', 87, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 7, '3', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 8, '1', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 8, '2', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 39, 8, '3', 38, 'S');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 1, '1', 5, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 1, '2', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 1, '3', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 2, '1', 53, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 2, '2', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 2, '3', 54, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 3, '1', 51, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 3, '2', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 3, '3', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 4, '1', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 4, '2', 13, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 4, '3', 69, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 5, '1', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 5, '2', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 5, '3', 20, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 6, '1', 4, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 6, '2', 63, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 6, '3', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 7, '1', 96, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 7, '2', 19, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 7, '3', 43, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 8, '1', 31, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 8, '2', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 40, 8, '3', 76, 'A');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 1, '1', 13, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 1, '2', 49, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 1, '3', 85, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 2, '1', 71, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 2, '2', 73, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 2, '3', 29, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 3, '1', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 3, '2', 32, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 3, '3', 72, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 4, '1', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 4, '2', 75, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 4, '3', 3, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 5, '1', 62, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 5, '2', 78, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 5, '3', 68, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 6, '1', 12, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 6, '2', 84, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 6, '3', 44, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 7, '1', 18, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 7, '2', 74, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 7, '3', 52, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 8, '1', 60, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 8, '2', 15, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 41, 8, '3', 4, 'F');

INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 1, '1', 67, 'B');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 1, '2', 97, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 1, '3', 50, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 2, '1', 82, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 2, '2', 24, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 2, '3', 79, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 3, '1', 75, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 3, '2', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 3, '3', 27, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 4, '1', 16, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 4, '2', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 4, '3', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 5, '1', 35, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 5, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 5, '3', 9, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 6, '1', 64, 'C');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 6, '2', 1, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 6, '3', 8, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 7, '1', 26, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 7, '2', 41, 'S');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 7, '3', 11, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 8, '1', 2, 'F');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 8, '2', 75, 'A');
INSERT INTO marks ( Student_Class_id, Subject_code, term, value, grade) VALUES ( 42, 8, '3', 18, 'F');


