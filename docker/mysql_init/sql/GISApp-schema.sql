-- MySQL Script generated by MySQL Workbench
-- Thu Mar 17 20:33:05 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema GISApp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema GISApp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `GISApp` DEFAULT CHARACTER SET utf8 ;
USE `GISApp` ;

-- -----------------------------------------------------
-- Table `GISApp`.`POINT`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`POINT` (
  `POINT_ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL,
  `TYPE` VARCHAR(45) NOT NULL,
  `X` DOUBLE NOT NULL,
  `Y` DOUBLE NOT NULL,
  `Z` DOUBLE NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`POINT_ID`))
ENGINE = InnoDB
COMMENT = '地点情報の追加情報を登録するテーブル';


-- -----------------------------------------------------
-- Table `GISApp`.`FILE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`FILE` (
  `POINT_ID` INT NOT NULL,
  `FILE` MEDIUMBLOB NOT NULL COMMENT 'ファイル',
  PRIMARY KEY (`POINT_ID`),
  CONSTRAINT `fk_FILE_POINT1`
    FOREIGN KEY (`POINT_ID`)
    REFERENCES `GISApp`.`POINT` (`POINT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`POINT_INFORMATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`POINT_INFORMATION` (
  `POINT_ID` INT NOT NULL COMMENT '地点番号',
  `NAME` VARCHAR(32) NOT NULL COMMENT '情報名',
  `TYPE` VARCHAR(20) NOT NULL COMMENT '情報種別',
  `STRING` LONGTEXT NULL,
  `NUMBER` DOUBLE NULL,
  `BOOLEAN` TINYINT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`POINT_ID`, `NAME`),
  CONSTRAINT `fk_POINT_INFORMATION_POINT`
    FOREIGN KEY (`POINT_ID`)
    REFERENCES `GISApp`.`POINT` (`POINT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`GEOJSON_FILE_QUEUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`GEOJSON_FILE_QUEUE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL,
  `TYPE` VARCHAR(45) NOT NULL,
  `GEOJSON` LONGTEXT NOT NULL COMMENT 'ファイル',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;

USE `GISApp` ;

-- -----------------------------------------------------
-- Placeholder table for view `GISApp`.`SHELTER_INFORMATION_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`SHELTER_INFORMATION_VIEW` (`POINT_ID` INT, `PRIVATE` INT, `TYPE` INT, `X` INT, `Y` INT, `Z` INT, `P20_001` INT, `P20_002` INT, `P20_003` INT, `P20_004` INT, `P20_005` INT, `P20_006` INT, `P20_007` INT, `P20_008` INT, `P20_009` INT, `P20_010` INT, `P20_011` INT, `P20_012` INT, `OPEN` INT, `COMMENT` INT, `UPDATE_TIME` INT);

-- -----------------------------------------------------
-- Placeholder table for view `GISApp`.`POST_INFORMATION_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`POST_INFORMATION_VIEW` (`POINT_ID` INT, `PRIVATE` INT, `TYPE` INT, `X` INT, `Y` INT, `Z` INT, `INFORMATION` INT, `APPROVED` INT, `UPDATE_TIME` INT);

-- -----------------------------------------------------
-- View `GISApp`.`SHELTER_INFORMATION_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`SHELTER_INFORMATION_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `SHELTER_INFORMATION_VIEW` AS
    SELECT 
        point.POINT_ID,
        point.PRIVATE,
        point.TYPE,
        X,
        Y,
        Z,
        info1.STRING AS P20_001,
        info2.STRING AS P20_002,
        info3.STRING AS P20_003,
        info4.STRING AS P20_004,
        info5.NUMBER AS P20_005,
        info6.NUMBER AS P20_006,
        info7.NUMBER AS P20_007,
        info8.NUMBER AS P20_008,
        info9.NUMBER AS P20_009,
        info10.NUMBER AS P20_010,
        info11.NUMBER AS P20_011,
        info12.NUMBER AS P20_012,
        info13.BOOLEAN AS OPEN,
        info14.STRING AS COMMENT,
        info14.UPDATE_TIME AS UPDATE_TIME
    FROM
        GISApp.POINT AS point
            JOIN
        GISApp.POINT_INFORMATION AS info1 ON info1.NAME = 'P20_001'
            AND point.POINT_ID = info1.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info2 ON info2.NAME = 'P20_002'
            AND point.POINT_ID = info2.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info3 ON info3.NAME = 'P20_003'
            AND point.POINT_ID = info3.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info4 ON info4.NAME = 'P20_004'
            AND point.POINT_ID = info4.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info5 ON info5.NAME = 'P20_005'
            AND point.POINT_ID = info5.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info6 ON info6.NAME = 'P20_006'
            AND point.POINT_ID = info6.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info7 ON info7.NAME = 'P20_007'
            AND point.POINT_ID = info7.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info8 ON info8.NAME = 'P20_008'
            AND point.POINT_ID = info8.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info9 ON info9.NAME = 'P20_009'
            AND point.POINT_ID = info9.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info10 ON info10.NAME = 'P20_010'
            AND point.POINT_ID = info10.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info11 ON info11.NAME = 'P20_011'
            AND point.POINT_ID = info11.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info12 ON info12.NAME = 'P20_012'
            AND point.POINT_ID = info12.POINT_ID
            LEFT JOIN
        GISApp.POINT_INFORMATION AS info13 ON info13.NAME = 'OPEN'
            AND point.POINT_ID = info13.POINT_ID
            LEFT JOIN
        GISApp.POINT_INFORMATION AS info14 ON info14.NAME = 'COMMENT'
            AND point.POINT_ID = info14.POINT_ID
    WHERE
        point.TYPE = 'shelter';

-- -----------------------------------------------------
-- View `GISApp`.`POST_INFORMATION_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`POST_INFORMATION_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `POST_INFORMATION_VIEW` AS
    SELECT 
        point.POINT_ID,
        point.PRIVATE,
        point.TYPE,
        X,
        Y,
        Z,
        info1.STRING AS INFORMATION,
        info2.BOOLEAN AS APPROVED,
        info2.UPDATE_TIME AS UPDATE_TIME
    FROM
        GISApp.POINT AS point
            JOIN
        GISApp.POINT_INFORMATION AS info1 ON info1.NAME = 'INFORMATION'
            AND point.POINT_ID = info1.POINT_ID
            JOIN
        GISApp.POINT_INFORMATION AS info2 ON info2.NAME = 'APPROVED'
            AND point.POINT_ID = info2.POINT_ID
    WHERE
        point.TYPE = 'post_information';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
