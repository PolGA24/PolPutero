DROP TABLE alumnos FORCE;
DROP TYPE alumno_t FORCE;

CREATE OR REPLACE TYPE alumno_t AS OBJECT (
    id NUMBER,
    nombre VARCHAR2(50),
    delegado REF alumno_t,
    telefono NUMBER,
    nota_media VARCHAR(50)
);
/

CREATE TABLE alumnos OF alumno_t (
    PRIMARY KEY (id)
);

DECLARE
    r1 REF alumno_t;
    r2 REF alumno_t;
BEGIN
    INSERT INTO alumnos VALUES (alumno_t(1, 'Jordi Ros López', NULL, 674490954, 'Se mereze puro diezes'));

    SELECT REF(a) INTO r1 FROM alumnos a WHERE a.id = 1;
    INSERT INTO alumnos VALUES (alumno_t(2, 'Pol Gonzàlez Arribas', r1, 123456789, 'Pol putero'));

    SELECT REF(a) INTO r2 FROM alumnos a WHERE a.id = 2;
    INSERT INTO alumnos VALUES (alumno_t(3, 'Gerard Fornès', r1, 987654321, 'Puro genio'));

    UPDATE alumnos SET telefono = NULL WHERE id = 2;      -- BORRAR TELEFONO ALUMNO 2

    UPDATE alumnos SET telefono = 111222333 WHERE id = 3; -- TELEFONO ALUMNO 3 MODIFICADO

    UPDATE alumnos SET delegado = r2 WHERE id = 3;        -- ESTABLECIDO DELEGADO ALUMNO 2

    --SELECT nombre FROM alumnos WHERE delegado IS NULL;    -- VER ALUMNOS SIN DELEGADOS

    --SELECT delegado FROM alumnos WHERE id = 3;            -- OBTENER DELEGADO DEL ALUMNO 3
END;
/
