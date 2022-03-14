-- MySQL Script generated by MySQL Workbench
-- Mon Mar 14 21:35:51 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema COMMON
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema COMMON
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `COMMON` ;
USE `COMMON` ;

-- -----------------------------------------------------
-- Table `COMMON`.`OBSERVER_SETTING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMMON`.`OBSERVER_SETTING` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `ENABLE` TINYINT NOT NULL COMMENT '0:無効\n1:有効',
  `APPLICATION` VARCHAR(45) NOT NULL,
  `MODULE` VARCHAR(45) NOT NULL,
  `CLASS` MEDIUMTEXT NOT NULL,
  `METHOD` VARCHAR(45) NOT NULL,
  `TIMEOUT` INT NOT NULL COMMENT 'time out in msec',
  `INTERVAL_TIME` INT NOT NULL COMMENT '0:One shot timer\n>0:timer interval in msec',
  `UPDATE_TIME` DATETIME(3) NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
COMMENT = '監視処理の設定テーブル';


-- -----------------------------------------------------
-- Table `COMMON`.`OBSERVER_TARGET`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMMON`.`OBSERVER_TARGET` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `APPLICATION` VARCHAR(45) NOT NULL,
  `MODULE` VARCHAR(45) NOT NULL,
  `CLASS` MEDIUMTEXT NOT NULL,
  `METHOD` VARCHAR(45) NOT NULL,
  `STATUS` LONGTEXT NULL,
  `UPDATE_TIME` DATETIME(3) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `COMMON`.`TIMER_SETTING`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COMMON`.`TIMER_SETTING` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `APPLICATION` VARCHAR(45) NOT NULL,
  `MODULE` VARCHAR(45) NOT NULL,
  `CLASS` MEDIUMTEXT NOT NULL,
  `TIMEOUT` INT NOT NULL COMMENT 'time out in msec',
  `INTERVAL_TIME` INT NOT NULL COMMENT '0:One shot timer\n>0:timer interval in msec',
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
COMMENT = 'タイマーの設定テーブル';


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `COMMON`.`OBSERVER_SETTING`
-- -----------------------------------------------------
START TRANSACTION;
USE `COMMON`;
INSERT INTO `COMMON`.`OBSERVER_SETTING` (`ID`, `ENABLE`, `APPLICATION`, `MODULE`, `CLASS`, `METHOD`, `TIMEOUT`, `INTERVAL_TIME`, `UPDATE_TIME`) VALUES (1, 1, 'COMMONApp', 'COMMONApp-ejb-1.0-SNAPSHOT', 'com.r_terai.java.ee.common.commonapp.ejb.OvserverTimer', 'timeout', 10000, 60000, '2000-01-01 00:00:00.000');

COMMIT;


-- -----------------------------------------------------
-- Data for table `COMMON`.`TIMER_SETTING`
-- -----------------------------------------------------
START TRANSACTION;
USE `COMMON`;
INSERT INTO `COMMON`.`TIMER_SETTING` (`ID`, `APPLICATION`, `MODULE`, `CLASS`, `TIMEOUT`, `INTERVAL_TIME`) VALUES (1, 'COMMONApp', 'COMMONApp-ejb-1.0-SNAPSHOT', 'com.r_terai.java.ee.common.commonapp.ejb.OvserverTimer', 10000, 60000);

COMMIT;

