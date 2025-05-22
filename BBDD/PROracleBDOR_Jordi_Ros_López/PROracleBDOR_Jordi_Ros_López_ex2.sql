DROP TYPE promotor_t FORCE;
DROP TYPE direccion_t FORCE;
DROP TYPE concierto_t FORCE;

CREATE OR REPLACE TYPE direccion_t AS OBJECT (
    calle VARCHAR2(100),
    numero INT,
    poblacion VARCHAR2(50),
    MEMBER PROCEDURE mostrarInfoDireccion
);
/

CREATE OR REPLACE TYPE promotor_t AS OBJECT (
    nombre VARCHAR2(50),
    tel NUMBER,
    web VARCHAR2(50),
    MEMBER PROCEDURE mostrarInfoPromotor
);
/

CREATE OR REPLACE TYPE concierto_t AS OBJECT (
    id_concierto NUMBER,
    nombre_concierto VARCHAR2(50),
    nombre_artista VARCHAR2(50),
    nombre_grupo VARCHAR2(50),
    direccion DIRECCION_T,
    fecha DATE,
    hora VARCHAR2(5),
    promotor PROMOTOR_T,
    MEMBER PROCEDURE mostrarInfoConcierto
);
/

CREATE OR REPLACE TYPE BODY direccion_t AS
    MEMBER PROCEDURE mostrarInfoDireccion IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Calle          : ' || SELF.calle);
        DBMS_OUTPUT.PUT_LINE('Num.           : ' || SELF.numero);
        DBMS_OUTPUT.PUT_LINE('Poblacion      : ' || SELF.poblacion);
    END;
END;
/

CREATE OR REPLACE TYPE BODY promotor_t AS
    MEMBER PROCEDURE mostrarInfoPromotor IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Nombre         : ' || SELF.nombre);
        DBMS_OUTPUT.PUT_LINE('Tel.           : ' || SELF.tel);
        DBMS_OUTPUT.PUT_LINE('Web            : ' || SELF.web);
        DBMS_OUTPUT.PUT_LINE('');
    END;
END;
/

CREATE OR REPLACE TYPE BODY concierto_t AS
    MEMBER PROCEDURE mostrarInfoConcierto IS
        dias_restantes NUMBER;
    BEGIN
        -- CALCULAR FECHA ACTUAL Y MOSTRAR VALORES CONCIERTO + DIAS RESTANTES
        dias_restantes := SELF.fecha - SYSDATE + 1;
        DBMS_OUTPUT.PUT_LINE('ID             : ' || SELF.id_concierto);
        DBMS_OUTPUT.PUT_LINE('Nombre         : ' || SELF.nombre_concierto);
        DBMS_OUTPUT.PUT_LINE('Artista        : ' || SELF.nombre_artista);
        DBMS_OUTPUT.PUT_LINE('Grupo          : ' || SELF.nombre_grupo);
        DBMS_OUTPUT.PUT_LINE('Direccion      : ' || SELF.direccion.calle || ' ' || SELF.direccion.numero || ' (' || SELF.direccion.poblacion || ')');
        DBMS_OUTPUT.PUT_LINE('Fecha          : ' || TO_CHAR(SELF.fecha));
        DBMS_OUTPUT.PUT_LINE('Hora           : ' || SELF.hora);
        DBMS_OUTPUT.PUT_LINE('Dias restantes : ' || round(dias_restantes));
        DBMS_OUTPUT.PUT_LINE('Promotor       : ' || SELF.promotor.nombre);
        DBMS_OUTPUT.PUT_LINE('');
    END;
END;
/

DECLARE
    dir DIRECCION_T := DIRECCION_T('Joanic', 100, 'BCN');                                   -- DECLARAR OBJETO DIRECCION
    pro PROMOTOR_T  := PROMOTOR_T('Jordi Ros López', 674490954, 'www.PromotionMusic.com');  -- DECLARAR OBJETO PROMOTOR
    con CONCIERTO_T := CONCIERTO_T(                                                         -- DECLARAR OBJETO CONCIERTO
        1,
        'Concierto de Rock',
        'Artista X',
        'Grupo Y',
        dir,
        TO_DATE('25-05-2025', 'DD-MM-YYYY'),
        '13:15',
        pro
    );
BEGIN
    pro.mostrarInfoPromotor();  -- INFORMACION PROMOTOS(NOMBRE, TELEFONO, WEB)
    con.mostrarInfoConcierto(); -- INFORMACION CONCIERTO(ID, NOMBRE, ARTISTA, GRUPO, DIRECCION, FECHA, HORA, NOMBRE PROMOTOR)
END;
/
