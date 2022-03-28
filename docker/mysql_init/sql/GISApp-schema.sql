-- MySQL Script generated by MySQL Workbench
-- Mon Mar 28 21:48:51 2022
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
  `PRIVATE` TINYINT NOT NULL COMMENT '0:Open\n1:Private',
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
-- Table `GISApp`.`INFORMATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`INFORMATION` (
  `ID_TYPE` VARCHAR(45) NOT NULL,
  `ID` INT NOT NULL,
  `NAME` VARCHAR(32) NOT NULL COMMENT '情報名',
  `TYPE` VARCHAR(20) NOT NULL COMMENT '情報種別',
  `STRING` LONGTEXT NULL,
  `NUMBER` DOUBLE NULL,
  `BOOLEAN` TINYINT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`ID_TYPE`, `ID`, `NAME`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`GEOJSON_FILE_QUEUE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`GEOJSON_FILE_QUEUE` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL,
  `TYPE` VARCHAR(45) NOT NULL,
  `EXPAND` TINYINT NOT NULL COMMENT 'GeoJSONの座標情報を展開するか否か',
  `GEOJSON` LONGTEXT NOT NULL COMMENT 'ファイル',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`SHELTER_INFORMATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`SHELTER_INFORMATION` (
  `POINT_ID` INT NOT NULL,
  `PRIVATE` TINYINT NOT NULL,
  `TYPE` VARCHAR(45) NOT NULL,
  `X` DOUBLE NOT NULL,
  `Y` DOUBLE NOT NULL,
  `Z` DOUBLE NULL,
  `P20_001` LONGTEXT NULL,
  `P20_002` LONGTEXT NULL,
  `P20_003` LONGTEXT NULL,
  `P20_004` LONGTEXT NULL,
  `P20_005` DOUBLE NULL,
  `P20_006` DOUBLE NULL,
  `P20_007` DOUBLE NULL,
  `P20_008` DOUBLE NULL,
  `P20_009` DOUBLE NULL,
  `P20_010` DOUBLE NULL,
  `P20_011` DOUBLE NULL,
  `P20_012` DOUBLE NULL,
  `OPEN` TINYINT NULL,
  `COMMENT` LONGTEXT NULL,
  `UPDATE_TIME` DATETIME(3) NULL,
  PRIMARY KEY (`POINT_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`POLYGON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`POLYGON` (
  `POLYGON_ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL COMMENT '0:Open\n1:Private',
  `TYPE` VARCHAR(45) NOT NULL,
  `POLYGON` JSON NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`POLYGON_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`POLYGON_GEOMETRY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`POLYGON_GEOMETRY` (
  `POLYGON_ID` INT NOT NULL,
  `POLYGON_INDEX` INT NOT NULL,
  `POINT_INDEX` INT NOT NULL,
  `POINT_ID` INT NOT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`POLYGON_ID`, `POLYGON_INDEX`, `POINT_INDEX`),
  INDEX `fk_POLYGON_GEOMETRY_POINT1_idx` (`POINT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_POLYGON_GEOMETRY_POLYGON1`
    FOREIGN KEY (`POLYGON_ID`)
    REFERENCES `GISApp`.`POLYGON` (`POLYGON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_POLYGON_GEOMETRY_POINT1`
    FOREIGN KEY (`POINT_ID`)
    REFERENCES `GISApp`.`POINT` (`POINT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`MULTI_POLYGON`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`MULTI_POLYGON` (
  `MULTI_POLYGON_ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL COMMENT '0:Open\n1:Private',
  `TYPE` VARCHAR(45) NOT NULL,
  `MULTI_POLYGON` JSON NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`MULTI_POLYGON_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`MULTI_POLYGON_GEOMETRY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`MULTI_POLYGON_GEOMETRY` (
  `MULTI_POLYGON_ID` INT NOT NULL,
  `MULTI_POLYGON_INDEX` INT NOT NULL,
  `POLYGON_INDEX` INT NOT NULL,
  `POINT_INDEX` INT NOT NULL,
  `POINT_ID` INT NOT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`MULTI_POLYGON_ID`, `MULTI_POLYGON_INDEX`, `POLYGON_INDEX`, `POINT_INDEX`),
  INDEX `fk_MULTI_POLYGON_GEOMETRY_POINT1_idx` (`POINT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_MULTI_POLYGON_GEOMETRY_MULTI_POLYGON1`
    FOREIGN KEY (`MULTI_POLYGON_ID`)
    REFERENCES `GISApp`.`MULTI_POLYGON` (`MULTI_POLYGON_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MULTI_POLYGON_GEOMETRY_POINT1`
    FOREIGN KEY (`POINT_ID`)
    REFERENCES `GISApp`.`POINT` (`POINT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`LINE_STRING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`LINE_STRING` (
  `LINE_STRING_ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL COMMENT '0:Open\n1:Private',
  `TYPE` VARCHAR(45) NOT NULL,
  `LINE_STRING` JSON NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`LINE_STRING_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`MULTI_LINE_STRING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`MULTI_LINE_STRING` (
  `MULTI_LINE_STRING_ID` INT NOT NULL AUTO_INCREMENT,
  `PRIVATE` TINYINT NOT NULL COMMENT '0:Open\n1:Private',
  `TYPE` VARCHAR(45) NOT NULL,
  `MULTI_LINE_STRING` JSON NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`MULTI_LINE_STRING_ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`LINE_STRING_GEOMETRY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`LINE_STRING_GEOMETRY` (
  `LINE_STRING_ID` INT NOT NULL,
  `POINT_INDEX` INT NOT NULL,
  `POINT_ID` INT NOT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`LINE_STRING_ID`, `POINT_INDEX`),
  INDEX `fk_LINE_STRING_GEOMETRY_POINT1_idx` (`POINT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_LINE_STRING_GEOMETRY_LINE_STRING1`
    FOREIGN KEY (`LINE_STRING_ID`)
    REFERENCES `GISApp`.`LINE_STRING` (`LINE_STRING_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LINE_STRING_GEOMETRY_POINT1`
    FOREIGN KEY (`POINT_ID`)
    REFERENCES `GISApp`.`POINT` (`POINT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`MULTI_LINE_STRING_GEOMETRY`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`MULTI_LINE_STRING_GEOMETRY` (
  `MULTI_LINE_STRING_ID` INT NOT NULL,
  `LINE_STRING_INDEX` INT NOT NULL,
  `POINT_INDEX` INT NOT NULL,
  `POINT_ID` INT NOT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`MULTI_LINE_STRING_ID`, `LINE_STRING_INDEX`, `POINT_INDEX`),
  INDEX `fk_MULTI_LINE_STRING_GEOMETRY_POINT1_idx` (`POINT_ID` ASC) VISIBLE,
  CONSTRAINT `fk_MULTI_LINE_STRING_GEOMETRY_MULTI_LINE_STRING1`
    FOREIGN KEY (`MULTI_LINE_STRING_ID`)
    REFERENCES `GISApp`.`MULTI_LINE_STRING` (`MULTI_LINE_STRING_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MULTI_LINE_STRING_GEOMETRY_POINT1`
    FOREIGN KEY (`POINT_ID`)
    REFERENCES `GISApp`.`POINT` (`POINT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `GISApp`.`GEOJSON_FILE_LOCATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`GEOJSON_FILE_LOCATION` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `TYPE` VARCHAR(45) NOT NULL,
  `AREA_CODE` VARCHAR(45) NULL,
  `LOCATION` LONGTEXT NOT NULL,
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
-- Placeholder table for view `GISApp`.`A33_POLYGON_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`A33_POLYGON_VIEW` (`POLYGON_ID` INT, `PRIVATE` INT, `TYPE` INT, `POLYGON` INT, `UPDATE_TIME` INT, `A33_001` INT, `A33_002` INT, `A33_003` INT, `A33_004` INT, `A33_005` INT, `A33_006` INT, `A33_007` INT, `A33_008` INT);

-- -----------------------------------------------------
-- Placeholder table for view `GISApp`.`A33_LINE_STRING_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`A33_LINE_STRING_VIEW` (`LINE_STRING_ID` INT, `PRIVATE` INT, `TYPE` INT, `LINE_STRING` INT, `UPDATE_TIME` INT, `A33_001` INT, `A33_002` INT, `A33_003` INT, `A33_004` INT, `A33_005` INT, `A33_006` INT, `A33_007` INT, `A33_008` INT);

-- -----------------------------------------------------
-- Placeholder table for view `GISApp`.`A33_MULTI_POLYGON_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`A33_MULTI_POLYGON_VIEW` (`MULTI_POLYGON_ID` INT, `PRIVATE` INT, `TYPE` INT, `MULTI_POLYGON` INT, `UPDATE_TIME` INT, `A33_001` INT, `A33_002` INT, `A33_003` INT, `A33_004` INT, `A33_005` INT, `A33_006` INT, `A33_007` INT, `A33_008` INT);

-- -----------------------------------------------------
-- Placeholder table for view `GISApp`.`A48_MULTI_POLYGON_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`A48_MULTI_POLYGON_VIEW` (`MULTI_POLYGON_ID` INT, `PRIVATE` INT, `TYPE` INT, `MULTI_POLYGON` INT, `UPDATE_TIME` INT, `A48_001` INT, `A48_002` INT, `A48_003` INT, `A48_004` INT, `A48_005` INT, `A48_006` INT, `A48_007` INT, `A48_008` INT, `A48_009` INT, `A48_010` INT, `A48_011` INT, `A48_012` INT, `A48_013` INT, `A48_014` INT);

-- -----------------------------------------------------
-- Placeholder table for view `GISApp`.`A48_POLYGON_VIEW`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GISApp`.`A48_POLYGON_VIEW` (`POLYGON_ID` INT, `PRIVATE` INT, `TYPE` INT, `POLYGON` INT, `UPDATE_TIME` INT, `A48_001` INT, `A48_002` INT, `A48_003` INT, `A48_004` INT, `A48_005` INT, `A48_006` INT, `A48_007` INT, `A48_008` INT, `A48_009` INT, `A48_010` INT, `A48_011` INT, `A48_012` INT, `A48_013` INT, `A48_014` INT);

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
        GISApp.INFORMATION AS info1 ON info1.NAME = 'P20_001'
            AND info1.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info1.ID
            JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'P20_002'
            AND info2.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info2.ID
            JOIN
        GISApp.INFORMATION AS info3 ON info3.NAME = 'P20_003'
            AND info3.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info3.ID
            JOIN
        GISApp.INFORMATION AS info4 ON info4.NAME = 'P20_004'
            AND info4.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info4.ID
            JOIN
        GISApp.INFORMATION AS info5 ON info5.NAME = 'P20_005'
            AND info5.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info5.ID
            JOIN
        GISApp.INFORMATION AS info6 ON info6.NAME = 'P20_006'
            AND info6.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info6.ID
            JOIN
        GISApp.INFORMATION AS info7 ON info7.NAME = 'P20_007'
            AND info7.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info7.ID
            JOIN
        GISApp.INFORMATION AS info8 ON info8.NAME = 'P20_008'
            AND info8.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info8.ID
            JOIN
        GISApp.INFORMATION AS info9 ON info9.NAME = 'P20_009'
            AND info9.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info9.ID
            JOIN
        GISApp.INFORMATION AS info10 ON info10.NAME = 'P20_010'
            AND info10.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info10.ID
            JOIN
        GISApp.INFORMATION AS info11 ON info11.NAME = 'P20_011'
            AND info11.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info11.ID
            JOIN
        GISApp.INFORMATION AS info12 ON info12.NAME = 'P20_012'
            AND info12.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info12.ID
            LEFT JOIN
        GISApp.INFORMATION AS info13 ON info13.NAME = 'OPEN'
            AND info13.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info13.ID
            LEFT JOIN
        GISApp.INFORMATION AS info14 ON info14.NAME = 'COMMENT'
            AND info14.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info14.ID
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
        GISApp.INFORMATION AS info1 ON info1.NAME = 'INFORMATION'
            AND info1.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info1.ID
            JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'APPROVED'
            AND info2.ID_TYPE = 'POINT_ID'
            AND point.POINT_ID = info2.ID
    WHERE
        point.TYPE = 'post_information';

-- -----------------------------------------------------
-- View `GISApp`.`A33_POLYGON_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`A33_POLYGON_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `A33_POLYGON_VIEW` AS
    SELECT 
        polygon.POLYGON_ID,
        polygon.PRIVATE,
        polygon.TYPE,
        polygon.POLYGON,
        polygon.UPDATE_TIME,
        info1.STRING AS A33_001,
        info2.STRING AS A33_002,
        info3.STRING AS A33_003,
        info4.STRING AS A33_004,
        info5.STRING AS A33_005,
        info6.STRING AS A33_006,
        info7.STRING AS A33_007,
        info8.STRING AS A33_008
    FROM
        GISApp.POLYGON AS polygon
            LEFT JOIN
        GISApp.INFORMATION AS info1 ON info1.NAME = 'A33_001'
            AND info1.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info1.ID
            LEFT JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'A33_002'
            AND info2.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info2.ID
            LEFT JOIN
        GISApp.INFORMATION AS info3 ON info3.NAME = 'A33_003'
            AND info3.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info3.ID
            LEFT JOIN
        GISApp.INFORMATION AS info4 ON info4.NAME = 'A33_004'
            AND info4.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info4.ID
            LEFT JOIN
        GISApp.INFORMATION AS info5 ON info5.NAME = 'A33_005'
            AND info5.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info5.ID
            LEFT JOIN
        GISApp.INFORMATION AS info6 ON info6.NAME = 'A33_006'
            AND info6.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info6.ID
            LEFT JOIN
        GISApp.INFORMATION AS info7 ON info7.NAME = 'A33_007'
            AND info7.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info7.ID
            LEFT JOIN
        GISApp.INFORMATION AS info8 ON info8.NAME = 'A33_008'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info8.ID
    WHERE
        polygon.TYPE = 'A33';

-- -----------------------------------------------------
-- View `GISApp`.`A33_LINE_STRING_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`A33_LINE_STRING_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `A33_LINE_STRING_VIEW` AS
    SELECT 
        lineString.LINE_STRING_ID,
        lineString.PRIVATE,
        lineString.TYPE,
        lineString.LINE_STRING,
        lineString.UPDATE_TIME,
        info1.STRING AS A33_001,
        info2.STRING AS A33_002,
        info3.STRING AS A33_003,
        info4.STRING AS A33_004,
        info5.STRING AS A33_005,
        info6.STRING AS A33_006,
        info7.STRING AS A33_007,
        info8.STRING AS A33_008
    FROM
        GISApp.LINE_STRING AS lineString
            LEFT JOIN
        GISApp.INFORMATION AS info1 ON info1.NAME = 'A33_001'
            AND info1.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info1.ID
            LEFT JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'A33_002'
            AND info2.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info2.ID
            LEFT JOIN
        GISApp.INFORMATION AS info3 ON info3.NAME = 'A33_003'
            AND info3.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info3.ID
            LEFT JOIN
        GISApp.INFORMATION AS info4 ON info4.NAME = 'A33_004'
            AND info4.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info4.ID
            LEFT JOIN
        GISApp.INFORMATION AS info5 ON info5.NAME = 'A33_005'
            AND info5.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info5.ID
            LEFT JOIN
        GISApp.INFORMATION AS info6 ON info6.NAME = 'A33_006'
            AND info6.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info6.ID
            LEFT JOIN
        GISApp.INFORMATION AS info7 ON info7.NAME = 'A33_007'
            AND info7.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info7.ID
            LEFT JOIN
        GISApp.INFORMATION AS info8 ON info8.NAME = 'A33_008'
            AND info8.ID_TYPE = 'LINE_STRING_ID'
            AND lineString.LINE_STRING_ID = info8.ID
    WHERE
        lineString.TYPE = 'A33';

-- -----------------------------------------------------
-- View `GISApp`.`A33_MULTI_POLYGON_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`A33_MULTI_POLYGON_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `A33_MULTI_POLYGON_VIEW` AS
    SELECT 
        polygon.MULTI_POLYGON_ID,
        polygon.PRIVATE,
        polygon.TYPE,
        polygon.MULTI_POLYGON,
        polygon.UPDATE_TIME,
        info1.STRING AS A33_001,
        info2.STRING AS A33_002,
        info3.STRING AS A33_003,
        info4.STRING AS A33_004,
        info5.STRING AS A33_005,
        info6.STRING AS A33_006,
        info7.STRING AS A33_007,
        info8.STRING AS A33_008
    FROM
        GISApp.MULTI_POLYGON AS polygon
            LEFT JOIN
        GISApp.INFORMATION AS info1 ON info1.NAME = 'A33_001'
            AND info1.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info1.ID
            LEFT JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'A33_002'
            AND info2.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info2.ID
            LEFT JOIN
        GISApp.INFORMATION AS info3 ON info3.NAME = 'A33_003'
            AND info3.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info3.ID
            LEFT JOIN
        GISApp.INFORMATION AS info4 ON info4.NAME = 'A33_004'
            AND info4.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info4.ID
            LEFT JOIN
        GISApp.INFORMATION AS info5 ON info5.NAME = 'A33_005'
            AND info5.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info5.ID
            LEFT JOIN
        GISApp.INFORMATION AS info6 ON info6.NAME = 'A33_006'
            AND info6.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info6.ID
            LEFT JOIN
        GISApp.INFORMATION AS info7 ON info7.NAME = 'A33_007'
            AND info7.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info7.ID
            LEFT JOIN
        GISApp.INFORMATION AS info8 ON info8.NAME = 'A33_008'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info8.ID
    WHERE
        polygon.TYPE = 'A33';

-- -----------------------------------------------------
-- View `GISApp`.`A48_MULTI_POLYGON_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`A48_MULTI_POLYGON_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `A48_MULTI_POLYGON_VIEW` AS
    SELECT 
        polygon.MULTI_POLYGON_ID,
        polygon.PRIVATE,
        polygon.TYPE,
        polygon.MULTI_POLYGON,
        polygon.UPDATE_TIME,
        info1.STRING AS A48_001,
        info2.STRING AS A48_002,
        info3.STRING AS A48_003,
        info4.NUMBER AS A48_004,
        info5.STRING AS A48_005,
        info6.STRING AS A48_006,
        info7.NUMBER AS A48_007,
        info8.STRING AS A48_008,
        info9.STRING AS A48_009,
        info10.STRING AS A48_010,
        info11.STRING AS A48_011,
        info12.NUMBER AS A48_012,
        info13.STRING AS A48_013,
        info14.STRING AS A48_014
    FROM
        GISApp.MULTI_POLYGON AS polygon
            LEFT JOIN
        GISApp.INFORMATION AS info1 ON info1.NAME = 'A48_001'
            AND info1.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info1.ID
            LEFT JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'A48_002'
            AND info2.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info2.ID
            LEFT JOIN
        GISApp.INFORMATION AS info3 ON info3.NAME = 'A48_003'
            AND info3.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info3.ID
            LEFT JOIN
        GISApp.INFORMATION AS info4 ON info4.NAME = 'A48_004'
            AND info4.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info4.ID
            LEFT JOIN
        GISApp.INFORMATION AS info5 ON info5.NAME = 'A48_005'
            AND info5.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info5.ID
            LEFT JOIN
        GISApp.INFORMATION AS info6 ON info6.NAME = 'A48_006'
            AND info6.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info6.ID
            LEFT JOIN
        GISApp.INFORMATION AS info7 ON info7.NAME = 'A48_007'
            AND info7.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info7.ID
            LEFT JOIN
        GISApp.INFORMATION AS info8 ON info8.NAME = 'A48_008'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info8.ID
            LEFT JOIN
        GISApp.INFORMATION AS info9 ON info9.NAME = 'A48_009'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info9.ID
            LEFT JOIN
        GISApp.INFORMATION AS info10 ON info10.NAME = 'A48_010'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info10.ID
            LEFT JOIN
        GISApp.INFORMATION AS info11 ON info11.NAME = 'A48_011'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info11.ID
            LEFT JOIN
        GISApp.INFORMATION AS info12 ON info12.NAME = 'A48_012'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info12.ID
            LEFT JOIN
        GISApp.INFORMATION AS info13 ON info13.NAME = 'A48_013'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info13.ID
            LEFT JOIN
        GISApp.INFORMATION AS info14 ON info14.NAME = 'A48_014'
            AND info8.ID_TYPE = 'MULTI_POLYGON_ID'
            AND polygon.MULTI_POLYGON_ID = info14.ID
    WHERE
        polygon.TYPE = 'A48';

-- -----------------------------------------------------
-- View `GISApp`.`A48_POLYGON_VIEW`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `GISApp`.`A48_POLYGON_VIEW`;
USE `GISApp`;
CREATE  OR REPLACE VIEW `A48_POLYGON_VIEW` AS
    SELECT 
        polygon.POLYGON_ID,
        polygon.PRIVATE,
        polygon.TYPE,
        polygon.POLYGON,
        polygon.UPDATE_TIME,
        info1.STRING AS A48_001,
        info2.STRING AS A48_002,
        info3.STRING AS A48_003,
        info4.NUMBER AS A48_004,
        info5.STRING AS A48_005,
        info6.STRING AS A48_006,
        info7.NUMBER AS A48_007,
        info8.STRING AS A48_008,
        info9.STRING AS A48_009,
        info10.STRING AS A48_010,
        info11.STRING AS A48_011,
        info12.NUMBER AS A48_012,
        info13.STRING AS A48_013,
        info14.STRING AS A48_014
    FROM
        GISApp.POLYGON AS polygon
            LEFT JOIN
        GISApp.INFORMATION AS info1 ON info1.NAME = 'A48_001'
            AND info1.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info1.ID
            LEFT JOIN
        GISApp.INFORMATION AS info2 ON info2.NAME = 'A48_002'
            AND info2.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info2.ID
            LEFT JOIN
        GISApp.INFORMATION AS info3 ON info3.NAME = 'A48_003'
            AND info3.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info3.ID
            LEFT JOIN
        GISApp.INFORMATION AS info4 ON info4.NAME = 'A48_004'
            AND info4.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info4.ID
            LEFT JOIN
        GISApp.INFORMATION AS info5 ON info5.NAME = 'A48_005'
            AND info5.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info5.ID
            LEFT JOIN
        GISApp.INFORMATION AS info6 ON info6.NAME = 'A48_006'
            AND info6.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info6.ID
            LEFT JOIN
        GISApp.INFORMATION AS info7 ON info7.NAME = 'A48_007'
            AND info7.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info7.ID
            LEFT JOIN
        GISApp.INFORMATION AS info8 ON info8.NAME = 'A48_008'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info8.ID
            LEFT JOIN
        GISApp.INFORMATION AS info9 ON info9.NAME = 'A48_009'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info9.ID
            LEFT JOIN
        GISApp.INFORMATION AS info10 ON info10.NAME = 'A48_010'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info10.ID
            LEFT JOIN
        GISApp.INFORMATION AS info11 ON info11.NAME = 'A48_011'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info11.ID
            LEFT JOIN
        GISApp.INFORMATION AS info12 ON info12.NAME = 'A48_012'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info12.ID
            LEFT JOIN
        GISApp.INFORMATION AS info13 ON info13.NAME = 'A48_013'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info13.ID
            LEFT JOIN
        GISApp.INFORMATION AS info14 ON info14.NAME = 'A48_014'
            AND info8.ID_TYPE = 'POLYGON_ID'
            AND polygon.POLYGON_ID = info14.ID
    WHERE
        polygon.TYPE = 'A48';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
