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

/*
Ejercicio 02
Cread los triggers necesarios que registren en una tabla de log todas las inserciones, modificaciones o borrados que se produzcan.
*/

DELIMITER $$
DROP TRIGGER IF EXISTS insercion $$
CREATE TRIGGER insercion AFTER UPDATE ON personal
FOR EACH ROW
BEGIN
    /* FUNCIONALIDAD */
END $$
DELIMITER ;

/*
Ejercicio 03
Cread un evento que cada final de mes guarde todos los correos electrónicos de la tabla persona (si el atributo del correo para un
registro es null hemos de obviar aquella fila) en un fichero de texto que tendrá el nombre siguiente: correos_MES_AÑO.txt (donde MES
sea el número de mes actual y AÑO sea el año actual).
*/

/*
Ejercicio 04
Cread un evento que cada domingo a las 23:59 guarde cuantos registros haya en la tabla log sobre INSERT, cuantos registros haya sobre
UPDATE y cuantos registros haya sobre DELETE. El nombre del fichero será estadísticas_FECHA_ACTUAL.txt (Dónde FECHA_ACTUAL es el valor
de la fecha del día en que se ejecuta el evento).
*/

/*
Ejercicio 05
Cread un evento que cada día a las 4:00 de la mañana haga una copia de backup de la base de datos usada en los ejercicios anteriores.
Las tablas solo deben crearse la primera vez ya que después siempre existirán. Posteriormente debéis vaciarlas y volverlas a llenar
con la información actual de la BBDD sobre la que hacéis el backup.
*/

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
