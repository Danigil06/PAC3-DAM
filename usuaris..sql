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
