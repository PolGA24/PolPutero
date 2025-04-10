/*
Ejercicio 01
Crea los triggers necesarios para que cada vez que tengamos una modificación de la tabla de ServerStatus en los atributos is_broken,
ram_upgrade, ram_downgrade, siempre que el valor nuevo sea TRUE haced lo siguiente:
- Si is_broken es TRUE, añadid una alerta de tipo_alerta ‘Prioritario’, descripción ‘El servidor ID_SERVIDOR está estropeado’ y la
  fecha actual.
- Si ram_upgrade es TRUE aumenta la ram del servidor que corresponda a ram+256 y añade una alerta de tipo alerta ‘Mantenimiento’,
  descripción ‘Ram en el servidor ID_SERVIDOR aumentada’ y la fecha actual.
- Si ram_downgrade es TRUE disminuye la ram del servidor que corresponda a ram-256 y añade una alerta de tipo alerta ‘Mantenimiento’,
  descripción ‘Ram en el servidor ID_SERVIDOR reducida’ y la fecha actual. Si el valor es igual a 256 no se tiene que reducir y no se
  generará ninguna alerta.
En el caso que borremos un servidor també hemos de generar una alerta de tipo_alerta ‘Baja’, descripción ‘El servidor ID_SERVIDOR ha
sido dado de baja’ y la fecha actual.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS update_servidorstatus $$
CREATE TRIGGER update_servidorstatus AFTER UPDATE ON servidorstatus
FOR EACH ROW
BEGIN
  IF NEW.is_broken IS TRUE THEN
    INSERT INTO alertas VALUES (null, "Prioritario", CONCAT("El servidor ", NEW.id_servidor, " esta estropeado."), null, NOW());
  END IF;
  IF NEW.ram_upgrade IS TRUE THEN
    INSERT INTO alertas VALUES (null, "Mantenimento", CONCAT("Ram al servidor ", NEW.id_servidor, " augmentada."), null, NOW());
    UPDATE servidor SET ram = ram + 256 WHERE id_servidor = NEW.id_servidor;
  END IF;
  IF NEW.ram_downgrade IS TRUE THEN
    SET @vram = (SELECT ram FROM servidor WHERE id_servidor = NEW.id_servidor);
    IF @vram > 256 THEN
      INSERT INTO alertas VALUES (null, "Mantenimento", CONCAT("Ram al servidor ", NEW.id_servidor, " reducida."), null, NOW());
      UPDATE servidor SET ram = ram - 256 WHERE id_servidor = NEW.id_servidor;
    END IF;
  END IF;
END $$
DELIMITER ;

DELIMITER $$
DROP TRIGGER IF EXISTS delete_servidor $$
CREATE TRIGGER delete_servidor AFTER DELETE ON servidor
FOR EACH ROW
BEGIN
  INSERT INTO alertes VALUES (null, "Baja", CONCAT("El servidor ", OLD.id_servidor, " se ha dado de baja."), null, NOW());
END $$
DELIMITER ;

/*
Ejercicio 02
Cread los triggers necesarios que registren en una tabla de log todas las inserciones, modificaciones o borrados que se produzcan.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS insert_persona $$
CREATE TRIGGER insert_persona AFTER INSERT ON persona
FOR EACH ROW
BEGIN
 INSERT INTO log VALUES (null, CONCAT("Se ha añadido un usuario nuevo con id: ",NEW.id," y el DNI: ",NEW.dni));
END $$
DELIMITER ;

# Segundo trigger
DELIMITER $$
DROP TRIGGER IF EXISTS update_persona $$
CREATE TRIGGER update_persona AFTER UPDATE ON persona
FOR EACH ROW
BEGIN
	IF OLD.nombre <> NEW.nombre THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo nombre. El valor antiguao era ",OLD.nombre,". El valor nuevo es ",NEW.nombre,"."));
	END IF;
	IF OLD.apellido <> NEW.apellido THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo apellido. El valor antiguao era ",OLD.apellido,". El valor nuevo es ",NEW.apellido,"."));
	END IF;
	IF OLD.apellido2 <> NEW.apellido2 THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo apellido2. El valor antiguao era ",OLD.apellido2,". El valor nuevo es ",NEW.apellido2,"."));
	END IF;
	IF OLD.correo_electronico <> NEW.correo_electronico THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo correo_electronico. El valor antiguao era ",OLD.correo_electronico,". El valor nuevo es ",NEW.correo_electronico,"."));
	END IF;
	IF OLD.dni <> NEW.dni THEN
		INSERT INTO log VALUES (null, CONCAT("Se ha efectuado un cambio al registro con id: ",OLD.id," en el campo dni. El valor antiguao era ",OLD.dni,". El valor nuevo es ",NEW.dni,"."));
	END IF;
END $$
DELIMITER ;

# Tercer trigger
DELIMITER $$
DROP TRIGGER IF EXISTS delete_persona $$
CREATE TRIGGER delete_persona AFTER DELETE ON persona
FOR EACH ROW
BEGIN
	INSERT INTO log VALUES (null, CONCAT("Se ha eliminado el registro del usuario con id: ",OLD.id," y el DNI: ",OLD.dni));
END $$
DELIMITER ;

/*
Ejercicio 03
Cread un evento que cada final de mes guarde todos los correos electrónicos de la tabla persona (si el atributo del correo para un
registro es null hemos de obviar aquella fila) en un fichero de texto que tendrá el nombre siguiente: correos_MES_AÑO.txt (donde MES
sea el número de mes actual y AÑO sea el año actual).
*/

SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT guardarCorreos
ON SCHEDULE EVERY 1 MONTH STARTS TIMESTAMP(CURRENT_DATE + INTERVAL (1 - DAY(CURRENT_DATE)) DAY) + INTERVAL 1 MONTH - INTERVAL 1 DAY
DO
BEGIN
    SET @file_name = CONCAT('/tmp/correos_', LPAD(MONTH(CURRENT_DATE), 2, '0'), '_', YEAR(CURRENT_DATE), '.txt');
    SELECT email FROM persona WHERE email IS NOT NULL
    INTO OUTFILE @file_name
    FIELDS TERMINATED BY '\n'
    LINES TERMINATED BY '\n';
END $$

DELIMITER ;

/*
Ejercicio 04
Cread un evento que cada domingo a las 23:59 guarde cuantos registros haya en la tabla log sobre INSERT, cuantos registros haya sobre
UPDATE y cuantos registros haya sobre DELETE. El nombre del fichero será estadísticas_FECHA_ACTUAL.txt (Dónde FECHA_ACTUAL es el valor
de la fecha del día en que se ejecuta el evento).
*/

SET GLOBAL event_scheduler = ON;

DELIMITER  $$

CREATE EVENT guardar_estadisticas_domingo
ON SCHEDULE EVERY 1 WEEK STARTS TIMESTAMP(DATE_ADD(CURRENT_DATE, INTERVAL (7 - DAYOFWEEK(CURRENT_DATE)) DAY) + INTERVAL '23:59' HOUR_MINUTE)
DO
BEGIN
    SET @file_name = CONCAT('/tmp/estadisticas_', CURRENT_DATE, '.txt');
    SELECT CONCAT('INSERTS: ', COUNT(*)) FROM log WHERE operacion = 'INSERT'
    UNION ALL
    SELECT CONCAT('UPDATES: ', COUNT(*)) FROM log WHERE operacion = 'UPDATE'
    UNION ALL
    SELECT CONCAT('DELETES: ', COUNT(*)) FROM log WHERE operacion = 'DELETE'
    INTO OUTFILE @file_name
    FIELDS TERMINATED BY '\n'
    LINES TERMINATED BY '\n';
END $$

DELIMITER ;

/*
Ejercicio 05
Cread un evento que cada día a las 4:00 de la mañana haga una copia de backup de la base de datos usada en los ejercicios anteriores.
Las tablas solo deben crearse la primera vez ya que después siempre existirán. Posteriormente debéis vaciarlas y volverlas a llenar
con la información actual de la BBDD sobre la que hacéis el backup.
*/

SET GLOBAL event_scheduler = ON;

DELIMITER $$

CREATE EVENT backup_diario
ON SCHEDULE EVERY 1 DAY STARTS TIMESTAMP(CURRENT_DATE + INTERVAL 4 HOUR)
DO
BEGIN
    CREATE TABLE IF NOT EXISTS backup_persona LIKE persona;
    TRUNCATE TABLE backup_persona;
    INSERT INTO backup_persona SELECT * FROM persona;
    CREATE TABLE IF NOT EXISTS backup_log LIKE log;
    TRUNCATE TABLE backup_log;
    INSERT INTO backup_log SELECT * FROM log;
END $$

DELIMITER ;

--Ejercicio 06
--Escribe las operaciones de DCL detalladas en la siguiente lista:

-- Crea el usuario ‘user1’ sin contraseña
CREATE USER user1;
-- Crea el usuario ‘user2’ con contraseña ‘pwd2’
CREATE USER user2 IDENTIFIED BY ‘pwd2’;
-- Crea el usuario ‘user3’ con contraseña ‘pwd3’
CREATE USER user3 IDENTIFIED BY ‘pwd3’;
-- Crea el usuario ‘user4’ con contraseña ‘pwd4’
CREATE USER user4 IDENTIFIED BY ‘pwd4’;
-- Borra el usuario ‘user4’
DROP USER user4;
-- Cambia el nombre del ‘user2’ a ‘admindb’
RENAME USER user2 TO admindb;
-- Cambia el password de ‘admindb’ a ‘pwdadmin’
SET PASSWORD FOR admindb = PASSWORD('pwdadmin');
-- Da privilegios totales (ALL + GRANT OPTION al usuario ‘admindb’) sobre todas las bases de datos (todas las bases de datos -> *.*).
GRANT ALL PRIVILEGES ON *.* TO 'admindb';
-- Da privilegios de SELECT, INSERT, UPDATE, DELETE al ‘user1’ sobre todas las bases de datos (todas las bases de datos -> *.*).
GRANT SELECT, INSERT, UPDATE, DELET, FILE ON *.* TO 'user1';
-- Quita los permisos de INSERT, UPDATE, DELETE al ‘user1’
REVOKE INSERT, UPDATE, DELETE ON *.* FROM 'user1';
-- Da permisos de SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP al ‘user3’.
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, ALTER, DROP ON *.*  TO user3;
-- Quita todos los permisos al 'admindb'
REVOKE ALL PRIVILEGES ON *.* FROM 'admindb';
