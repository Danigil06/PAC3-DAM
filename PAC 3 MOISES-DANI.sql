DROP DATABASE IF EXISTS `Facultat`;

CREATE DATABASE `Facultat` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE `Facultat`;

CREATE TABLE `departament` (
    `codi_depart` INT UNSIGNED AUTO_INCREMENT,
    `nom` VARCHAR(128) NOT NULL,
    PRIMARY KEY (`codi_depart`)
);

CREATE TABLE `professor` (
    `num_professor` INT UNSIGNED AUTO_INCREMENT,
    `nif` CHAR(9) NOT NULL UNIQUE,
    `nom_complet` VARCHAR(128) NOT NULL,
    `categoria` CHAR(2) NOT NULL,
    `email` VARCHAR(64),
    `codi_depart` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`num_professor`)
);

CREATE TABLE `alumne` (
    `num_alumne` INT UNSIGNED AUTO_INCREMENT,
    `nif` CHAR(9) NOT NULL UNIQUE,
    `nom_complet` VARCHAR(128) NOT NULL,
    `email` VARCHAR(64),
    PRIMARY KEY (`num_alumne`)
);

CREATE TABLE `alumne_estat` (
    `num_alumne` INT UNSIGNED,
    `estat` ENUM('Actiu', 'Baixa') NOT NULL,
    `data_estat` DATE NOT NULL,
    PRIMARY KEY (`num_alumne`, `data_estat`)
);

CREATE TABLE `edifici` (
    `codi_edifici` INT UNSIGNED AUTO_INCREMENT,
    `nom` VARCHAR(128) NOT NULL,
    `adreca` VARCHAR(128),
    PRIMARY KEY (`codi_edifici`)
);

CREATE TABLE `aula` (
    `codi_aula` INT UNSIGNED AUTO_INCREMENT,
    `num_aula` VARCHAR(64) NOT NULL,
    `capacitat` INT UNSIGNED,
    `codi_edifici` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`codi_aula`)
);

CREATE TABLE `equipament` (
    `codi_equip` INT UNSIGNED AUTO_INCREMENT,
    `descripcio` VARCHAR(128),
    `codi_aula` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`codi_equip`)
);

CREATE TABLE `assignatura` (
    `codi_assignatura` INT UNSIGNED AUTO_INCREMENT,
    `nom` VARCHAR(128) NOT NULL,
    `credits` DECIMAL(4,2) NOT NULL,
    `tipologia` ENUM('Troncal', 'Especialitat', 'Optativa', 'Lliure Disposició') NOT NULL,
    `curs` TINYINT UNSIGNED NOT NULL,
    `semestre` TINYINT UNSIGNED,
    `codi_depart` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`codi_assignatura`)
);

CREATE TABLE `pla_estudis` (
    `codi_pla` INT UNSIGNED AUTO_INCREMENT,
    `nom` VARCHAR(128) NOT NULL,
    `any_inici` YEAR NOT NULL,
    `estat` ENUM('Pendent', 'Actiu', 'Derogat') NOT NULL,
    PRIMARY KEY (`codi_pla`)
);

CREATE TABLE `pla_estudis_assignat` (
    `codi_pla` INT UNSIGNED,
    `codi_assignatura` INT UNSIGNED,
    `codi_oficial_assign` SMALLINT UNSIGNED NOT NULL,
    PRIMARY KEY (`codi_pla`, `codi_assignatura`)
);

CREATE TABLE `grup_docent` (
    `codi_grup` INT UNSIGNED AUTO_INCREMENT,
    `nom_grup` VARCHAR(64) NOT NULL,
    `torn` ENUM('Matí', 'Tarda') NOT NULL,
    `curs_academic` VARCHAR(9) NOT NULL,
    `codi_assignatura` INT UNSIGNED NOT NULL,
    `num_professor` INT UNSIGNED NOT NULL,
    `codi_aula` INT UNSIGNED,
    PRIMARY KEY (`codi_grup`)
);

CREATE TABLE `matricula` (
    `num_matricula` INT UNSIGNED AUTO_INCREMENT,
    `data_matricula` DATE NOT NULL,
    `estat` ENUM('Pendent', 'Admesa', 'Denegada') NOT NULL,
    `num_alumne` INT UNSIGNED NOT NULL,
    `codi_pla` INT UNSIGNED NOT NULL,
    PRIMARY KEY (`num_matricula`)
);

CREATE TABLE `matricula_assignatura` (
    `num_matricula` INT UNSIGNED,
    `codi_grup` INT UNSIGNED,
    `acta_ordinaria` DECIMAL(4,2) CHECK (`acta_ordinaria` >= 0.00 AND `acta_ordinaria` <= 10.00),
    `acta_extraordinaria` DECIMAL(4,2) CHECK (`acta_extraordinaria` >= 0.00 AND `acta_extraordinaria` <= 10.00),
    PRIMARY KEY (`num_matricula`, `codi_grup`)
);

ALTER TABLE `professor`
    ADD CONSTRAINT `fk_professor_departament`
        FOREIGN KEY (`codi_depart`)
        REFERENCES `departament`(`codi_depart`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

ALTER TABLE `alumne_estat`
    ADD CONSTRAINT `fk_alumne_estat_alumne`
        FOREIGN KEY (`num_alumne`)
        REFERENCES `alumne`(`num_alumne`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

ALTER TABLE `aula`
    ADD CONSTRAINT `fk_aula_edifici`
        FOREIGN KEY (`codi_edifici`)
        REFERENCES `edifici`(`codi_edifici`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

ALTER TABLE `equipament`
    ADD CONSTRAINT `fk_equipament_aula`
        FOREIGN KEY (`codi_aula`)
        REFERENCES `aula`(`codi_aula`)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE `assignatura`
    ADD CONSTRAINT `fk_assignatura_departament`
        FOREIGN KEY (`codi_depart`)
        REFERENCES `departament`(`codi_depart`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

ALTER TABLE `pla_estudis_assignat`
    ADD CONSTRAINT `fk_pla_assignat_pla`
        FOREIGN KEY (`codi_pla`)
        REFERENCES `pla_estudis`(`codi_pla`)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    ADD CONSTRAINT `fk_pla_assignat_assignatura`
        FOREIGN KEY (`codi_assignatura`)
        REFERENCES `assignatura`(`codi_assignatura`)
        ON UPDATE CASCADE
        ON DELETE CASCADE;

ALTER TABLE `grup_docent`
    ADD CONSTRAINT `fk_grup_docent_assignatura`
        FOREIGN KEY (`codi_assignatura`)
        REFERENCES `assignatura`(`codi_assignatura`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    ADD CONSTRAINT `fk_grup_docent_professor`
        FOREIGN KEY (`num_professor`)
        REFERENCES `professor`(`num_professor`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    ADD CONSTRAINT `fk_grup_docent_aula`
        FOREIGN KEY (`codi_aula`)
        REFERENCES `aula`(`codi_aula`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

ALTER TABLE `matricula`
    ADD CONSTRAINT `fk_matricula_alumne`
        FOREIGN KEY (`num_alumne`)
        REFERENCES `alumne`(`num_alumne`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    ADD CONSTRAINT `fk_matricula_pla`
        FOREIGN KEY (`codi_pla`)
        REFERENCES `pla_estudis`(`codi_pla`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;

ALTER TABLE `matricula_assignatura`
    ADD CONSTRAINT `fk_matricula_assignatura_matricula`
        FOREIGN KEY (`num_matricula`)
        REFERENCES `matricula`(`num_matricula`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    ADD CONSTRAINT `fk_matricula_assignatura_grup_docent`
        FOREIGN KEY (`codi_grup`)
        REFERENCES `grup_docent`(`codi_grup`)
        ON UPDATE CASCADE
        ON DELETE NO ACTION;
