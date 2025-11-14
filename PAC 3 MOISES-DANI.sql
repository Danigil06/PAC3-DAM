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
    `equipament` VARCHAR (128) NOT NULL
	PRIMARY KEY (`equipament`)
	
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

-- --------------- CREACION RELACIONES------------------
-- Relació PERSONA <--> PROFESSOR
ALTER TABLE `professor` ADD CONSTRAINT fk_professor_persona
FOREIGN KEY (`CODI_PERSONA`) REFERENCES `persona`(`CODI`)
ON UPDATE CASCADE ON DELETE NO ACTION;

-- Relació PERSONA <--> ALUMNE
ALTER TABLE `alumne` ADD CONSTRAINT fk_alumne_persona
FOREIGN KEY (`CODI_PERSONA`) REFERENCES `persona`(`CODI`)
ON UPDATE CASCADE ON DELETE NO ACTION;

-- Relació PERSONA <--> TELEFON
ALTER TABLE `persona_telefon` ADD CONSTRAINT fk_persona_telefon_persona
FOREIGN KEY (`CODI_PERSONA`) REFERENCES `persona`(`CODI`)
ON UPDATE CASCADE ON DELETE NO ACTION;

-- Relació AULA <--> AULA_EQUIPAMENT
ALTER TABLE `aula_equipament` ADD CONSTRAINT fk_aula_equipament_aula
FOREIGN KEY (`CAMPUS`, `EDIFICI`, `CODI_AULA`) REFERENCES `aula`(`CAMPUS`, `EDIFICI`, `CODI`)
ON UPDATE CASCADE ON DELETE CASCADE;

-- Relació PROFESSOR <--> GRUP_DOCENT
ALTER TABLE `professor_grup_docent` ADD CONSTRAINT fk_pg_professor
FOREIGN KEY (`CODI_PROFESSOR`) REFERENCES `professor`(`CODI_PERSONA`)
ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE `professor_grup_docent` ADD CONSTRAINT fk_pg_grup_docent
FOREIGN KEY (`CODI_GRUP_DOCENT`) REFERENCES `grup_docent`(`CODI`)
ON UPDATE CASCADE ON DELETE NO ACTION;

-- Relació ALUMNE <--> ALUMNE_ESTAT
ALTER TABLE `alumne_estat` ADD CONSTRAINT fk_alumne_estat_alumne
FOREIGN KEY (`CODI_ALUMNE`) REFERENCES `alumne`(`CODI_PERSONA`)
ON UPDATE CASCADE ON DELETE NO ACTION;
ALTER TABLE `pla_estudis_assignat`
ADD CONSTRAINT `fk_pla_est_assign_pla` 
    FOREIGN KEY (`codi_pla_estudis`) REFERENCES `pla_estudis`(`codi`)
    ON UPDATE CASCADE ON DELETE CASCADE,
ADD CONSTRAINT `fk_pla_est_assign_assig` 
    FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatura`(`codi`)
    ON UPDATE CASCADE ON DELETE CASCADE;

ALTER TABLE `matricula`
ADD CONSTRAINT `fk_matricula_alumne` 
    FOREIGN KEY (`codi_alumne`) REFERENCES `alumne`(`codi_persona`)
    ON UPDATE CASCADE ON DELETE NO ACTION,
ADD CONSTRAINT `fk_matricula_grup` 
    FOREIGN KEY (`codi_grup_docent`) REFERENCES `grup_docent`(`codi`)
    ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE `matricula_assignatura`
ADD CONSTRAINT `fk_matr_assig_assignatura` 
    FOREIGN KEY (`codi_assignatura`) REFERENCES `assignatura`(`codi`)
    ON UPDATE CASCADE ON DELETE NO ACTION,
ADD CONSTRAINT `fk_matr_assig_alumne` 
    FOREIGN KEY (`codi_alumne`) REFERENCES `alumne`(`codi_persona`)
    ON UPDATE CASCADE ON DELETE NO ACTION,
ADD CONSTRAINT `fk_matr_assig_grup` 
    FOREIGN KEY (`codi_grup_docent`) REFERENCES `grup_docent`(`codi`)
    ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE `sessio`
ADD CONSTRAINT `fk_sessio_grup` 
    FOREIGN KEY (`codi_grup_docent`) REFERENCES `grup_docent`(`codi`)
    ON UPDATE CASCADE ON DELETE NO ACTION,
ADD CONSTRAINT `fk_sessio_aula` 
    FOREIGN KEY (`campus`, `edifici`, `codi_aula`) REFERENCES `aula`(`campus`, `edifici`, `codi`)
    ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE `horari`
ADD CONSTRAINT `fk_horari_sessio` 
    FOREIGN KEY (`dia`, `hora_inici`, `hora_fi`) REFERENCES `sessio`(`dia`, `hora_inici`, `hora_fi`)
    ON UPDATE CASCADE ON DELETE NO ACTION;

ALTER TABLE `aula_equipament`
ADD CONSTRAINT `fk_aula_equip_aula` 
    FOREIGN KEY (`campus`, `edifici`, `codi_aula`) REFERENCES `aula`(`campus`, `edifici`, `codi`)
    ON UPDATE CASCADE ON DELETE CASCADE;
-- --------------- FIN CREACION RELACIONES ------------------

-- --------------- CREACION ROLES ------------------

-- --------------- FIN CREACION ROLES ------------------

