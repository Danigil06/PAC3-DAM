-- --------------- CREACION DATABASE ------------------

DROP DATABASE IF EXISTS `Facultat`;

CREATE DATABASE IF NOT EXISTS `Facultat`;

USE `Facultat`;
-- --------------- FIN CREACION DATABASE ------------------

-- --------------- CREACION TABLAS ------------------
CREATE TABLE `professor`(
    `num_seg_social` CHAR(12) UNIQUE NOT NULL,
    `email_institucional` VARCHAR(64) UNIQUE NOT NULL,
    `categoria` CHAR(2) NOT NULL
);

CREATE TABLE `professor_grup_docent`(
	`data_inici`DATETIME NOT NULL, 
    `data_fi` DATETIME NULL
);

CREATE TABLE `grup_docent`(
	`codi` INT UNSIGNED AUTO_INCREMENT UNIQUE NOT NULL,
    `any_academic` DATE NOT NULL,
    `semestre` DATETIME NOT NULL,
    `torn` ENUM('mati', 'tarda') NOT NULL,
    `capacitat_maxima` CHAR(30)
);

CREATE TABLE `alumne` (
    `email` VARCHAR(64) NOT NULL
);

CREATE TABLE `alumne_estat` (
    `data_hora_ini` DATETIME NOT NULL,
    `data_hora_fi` DATETIME NULL,
    `estat` ENUM('actiu','baixa') NOT NULL,
    PRIMARY KEY (`data_hora_ini`)
);

CREATE TABLE `persona`(
	`CODI` INT UNSIGNED AUTO_INCREMENT UNIQUE NOT NULL,
    `DNI_NIE` CHAR(9) UNIQUE NOT NULL,
    `NOMCOMPLET` VARCHAR(128) NOT NULL,
    `DATANAIX` DATE NOT NULL,
    PRIMARY KEY (`CODI`)
);

CREATE TABLE `persona_telefon`(
	`telefon` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`telefon`)
);

CREATE TABLE `aula` (
    `campus` VARCHAR(64) NOT NULL,
    `edifici` VARCHAR(64) NOT NULL,
    `codi` CHAR(9) NOT NULL,
    `capacitat` VARCHAR(8) NOT NULL,
    PRIMARY KEY (`codi`,`campus`,`edifici`)
);

CREATE TABLE `aula_equipament` (
    `equipament`
	
);

CREATE TABLE `assignatura` (
    `codi` CHAR(9) UNIQUE NOT NULL,
    `nom` VARCHAR(128) NOT NULL,
    `tipologia`	ENUM('Troncal', 'Especialitat','Optativa','Lliure Disposició') NOT NULL ,
    PRIMARY KEY(`codi`)
);

CREATE TABLE `pla_estudis` (
    `codi` CHAR(9) UNIQUE NOT NULL,
    `nom` VARCHAR(128) NOT NULL,
    `any_implantació` SMALLINT UNSIGNED NOT NULL,
    `estat`ENUM('Pendent','Actiu','Derogat') NOT NULL,
    PRIMARY KEY(`codi`)
);

CREATE TABLE `pla_estudis_assignat` (
    `codi_oficial_assign` CHAR(4) NOT NULL,
    `curs` VARCHAR (32) NOT NULL,
    `semestre` TINYINT UNSIGNED NOT NULL,
    `crédits_ects` SMALLINT NOT NULL 
);

CREATE TABLE matricula`(
	`data` DATE NOT NULL,
    `estat` ENUM('pendent', 'actiu', 'denegada') NOT NULL
);

CREATE TABLE `matricula_assignatura` (
    `actes_1a` DECIMAL(4,2) NOT NULL,
    `actes_2a`DECIMAL(4,2) NOT NULL,
    `actes_extra`DECIMAL(4,2) NOT NULL
);
CREATE TABLE `horari`(
    `dia`	DATE NOT NULL,
    `hora_inici`DATETIME NOT NULL,
    `hora_fi`DATETIME NULL
);
CREATE TABLE `sessió`(
    `data_sessió`TIME  UNIQUE NOT NULL,
    `número`CHAR(9) NOT NULL,
    PRIMARY KEY (`data_sessió`)
);
-- --------------- FIN CREACION TABLAS ------------------

ALTER TABLE 
