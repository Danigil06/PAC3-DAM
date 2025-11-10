-- --------------- CREACION DATABASE ------------------

DROP DATABASE IF EXISTS `PAC3`;
CREATE DATABASE IF NOT EXISTS `PAC3`;
USE `PAC3`;

-- --------------- FIN CREACION DATABASE ------------------


-- --------------- CREACION TABLAS ------------------

-- APARTADO ALUMNOS
CREATE TABLE `alumne`(
	`email_personal` VARCHAR(64) NOT NULL
);

CREATE TABLE `alumne_estat`(
	`data_hora_ini` DATETIME NOT NULL,
    `data_hora_fi` DATETIME NULL,
    `estat` ENUM('actiu','baixa') NOT NULL,
    PRIMARY KEY (`data_hora_ini`)
);
-- --------

-- Apartado PERSONA
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
-- --------

-- Apartado PROFESOR
CREATE TABLE `professor`(
	`num_seg_social` CHAR(12) UNIQUE NOT NULL,
    `email_institucional` VARCHAR(64) UNIQUE NOT NULL,
    `categoria` CHAR(2) NOT NULL
);

CREATE TABLE `professor_grup_docent`(
	`data_inici`DATETIME NOT NULL, 
    `data_fi` DATETIME NULL
);

CREATE TABLE `grup_docen`(
	`codi` INT UNSIGNED AUTO_INCREMENT UNIQUE NOT NULL,
    `any_academic` DATE NOT NULL,
    `semestre` DATETIME NOT NULL,
    `torn` ENUM('mati', 'tarda') NOT NULL,
    `capacitat_maxima` CHAR(30)
);

CREATE TABLE matricula`(
	`data` DATE NOT NULL,
    `estat` ENUM('pendent', 'actiu', 'denegada') NOT NULL
);
-- --------

-- --------------- FIN CREACION TABLAS ------------------


-- 
