-- CREACIÓ DE ROLS
DROP ROLE IF EXISTS `tecnic`, `administratiu`, `professor`;

-- CREACION DE ROLES
CREATE ROLE `tecnic`;
CREATE ROLE `administratiu`;
CREATE ROLE `professor`;


-- PRIVILEGIS DEL ROL "tecnic"
GRANT ALL PRIVILEGES ON `PAC3`.* TO `tecnic`;

-- PRIVILEGIS DEL ROL "administratiu"
GRANT SELECT, INSERT, UPDATE, DELETE ON `PAC3`.* TO `administratiu`;

-- PRIVILEGIS DEL ROL "professor"
GRANT SELECT ON `PAC3`.* TO `professor`;
GRANT INSERT, UPDATE ON `PAC3`.`Matricula_Assignatura` TO `professor`;

-- APLICACIÓ DELS CANVIS
FLUSH PRIVILEGES;

DROP USER IF EXISTS 'jvancells'@'%';
DROP USER IF EXISTS 'smoreno'@'%';
DROP USER IF EXISTS 'dgonzalez'@'%';

CREATE USER 'jvancells'@'%' IDENTIFIED BY 'password_jvancells';
CREATE USER 'smoreno'@'%' IDENTIFIED BY 'password_smoreno';
CREATE USER 'dgonzalez'@'%' IDENTIFIED BY 'password_dgonzalez';

GRANT `tecnic` TO 'jvancells'@'%';
GRANT `professor` TO 'jvancells'@'%';

GRANT `administratiu` TO 'smoreno'@'%';

GRANT `professor` TO 'dgonzalez'@'%';

SET DEFAULT ROLE ALL TO 'jvancells'@'%';
SET DEFAULT ROLE ALL TO 'smoreno'@'%';
SET DEFAULT ROLE ALL TO 'dgonzalez'@'%';

FLUSH PRIVILEGES;
