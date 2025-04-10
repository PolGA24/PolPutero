/*
Ejercicio 03
Cread un evento que cada final de mes guarde todos los correos electrónicos de la tabla persona (si el atributo del correo para un
registro es null hemos de obviar aquella fila) en un fichero de texto que tendrá el nombre siguiente: correos_MES_AÑO.txt (donde MES
sea el número de mes actual y AÑO sea el año actual).
*/

SET GLOBAL event_scheduler = 1;

DELIMITER $$
DROP EVENT IF EXISTS guardarCorreos $$
CREATE EVENT guardarCorreos
ON SCHEDULE EVERY 1 MONTH STARTS TIMESTAMP(CURRENT_DATE + INTERVAL (1 - DAY(CURRENT_DATE)) DAY) + INTERVAL 1 MONTH - INTERVAL 1 DAY
DO BEGIN
    SET @file_name = CONCAT('C:/xampp/mysql/data', LPAD(MONTH(CURRENT_DATE), 2, '0'), '_', YEAR(CURRENT_DATE), '.txt');
    PREPARE stmt1 FROM @file_name;
    EXECUTE stmt1;
    DEALLOCATE PREPARE stmt1;
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