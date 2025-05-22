DROP TYPE red_social_t FORCE;

CREATE OR REPLACE TYPE red_social_t AS OBJECT (
    nombre              VARCHAR2(100),
    fundador            VARCHAR2(100),
    pais_creacion       VARCHAR2(100),
    millones_usuarios   NUMBER,
    ano_fundacion       NUMBER,
    cotizacion_bolsa    NUMBER,

    MEMBER PROCEDURE getKarma,  -- PROCEDIMIENTO PARA MOSTRAR EL KARMA DE LA RED
    MEMBER PROCEDURE getNombre, -- PROCEDIMIENTO PARA MOSTRAR EL NOMBRE DE LA RED Y EL FUNDADOR
    
    -- CONSTRUCTOR DE RED SIN NOMBRE DE FUNDADOR
    STATIC FUNCTION crear_red_social(
        p_nombre            VARCHAR2,
        p_millones_usuarios NUMBER,
        p_ano_fundacion     NUMBER,
        p_cotizacion_bolsa  NUMBER
    ) RETURN RED_SOCIAL_T
);
/

CREATE OR REPLACE TYPE BODY red_social_t AS
    MEMBER PROCEDURE getKarma IS
        ano_actual NUMBER;
        karma NUMBER;
    BEGIN
        -- CALCULAR EL KARMA DE LA RED Y MOSTRAR POR PANTALLA
        ano_actual := EXTRACT(YEAR FROM SYSDATE);
        karma := ((ano_actual - SELF.ano_fundacion) * (SELF.millones_usuarios + SELF.cotizacion_bolsa));
        DBMS_OUTPUT.PUT_LINE('Karma ' || SELF.nombre || ': ' || karma);
    END;

    MEMBER PROCEDURE getNombre IS
    BEGIN
        -- SI EL NOMBRE DEL FUNDADOR ES 'null' ESCRIBE "Dato Desconocido"
        IF (SELF.fundador = 'null') THEN
            DBMS_OUTPUT.PUT_LINE('Red social: ' || SELF.nombre || ' | Fundador: Dato Desconocido');
        ELSE
        -- SI NO ESCRIBE EL NOMBRE DEL FUNDADOR
            DBMS_OUTPUT.PUT_LINE('Red social: ' || SELF.nombre || ' | Fundador: ' || SELF.fundador);
        END IF;
    END;

    STATIC FUNCTION crear_red_social(
        p_nombre            VARCHAR2,
        p_millones_usuarios NUMBER,
        p_ano_fundacion     NUMBER,
        p_cotizacion_bolsa  NUMBER
    ) RETURN RED_SOCIAL_T IS
    BEGIN
        -- MOSTRAR KARMA RED SOCIAL
        return RED_SOCIAL_T(p_nombre, 'null', 'null', p_millones_usuarios, p_ano_fundacion, p_cotizacion_bolsa);
    END;
END;
/

DECLARE
    -- CREAR REDES SOCIALES
    r1 RED_SOCIAL_T := RED_SOCIAL_T('Facebook', 'Mark Zuckerberg', 'EEUU', 3000, 2004, 800000); -- CON FUNDADOR
    r2 RED_SOCIAL_T := RED_SOCIAL_T.crear_red_social('TikTok', 1500, 2016, 250000);             -- SIN FUNDADOR
BEGIN
    -- BERIFICAR PROCEDIMIENTO QUE RETORNA EL KARMA DE LA RED SOCIAL
    r1.getKarma();
    r2.getKarma();

    -- BERIFICAR PROCEDIMIENTO QUE RETORNA EL NOMBRE DEL DEL FUNDADOR DE LA RED SOCIAL
    r1.getNombre();
    r2.getNombre();
END;
/
