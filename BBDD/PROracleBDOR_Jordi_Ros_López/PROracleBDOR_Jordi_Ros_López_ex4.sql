DROP TYPE producto_fresco_t FORCE;
DROP TYPE producto_t FORCE;
DROP TYPE lista_productos_t FORCE;
DROP TYPE lista_productos_frescos_t FORCE;

CREATE OR REPLACE TYPE producto_t AS OBJECT (
    idProducto NUMBER,
    nombre VARCHAR2(100),
    precio_base NUMBER(10, 2),
    impuesto NUMBER,

    MEMBER PROCEDURE mostrarInfoProducto,
    MEMBER PROCEDURE precioTotal,

    MAP MEMBER FUNCTION ordenar_por_precio RETURN NUMBER
)
NOT FINAL;
/

CREATE OR REPLACE TYPE producto_fresco_t UNDER producto_t (
    tipo_producto VARCHAR2(50),
    fecha_caducidad DATE,

    OVERRIDING MEMBER PROCEDURE mostrarInfoProducto,
    MEMBER PROCEDURE verificarCaducidad
);
/

CREATE OR REPLACE TYPE BODY producto_t AS
    MEMBER PROCEDURE mostrarInfoProducto IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('ID            : ' || SELF.idProducto);
        DBMS_OUTPUT.PUT_LINE('Nombre        : ' || SELF.nombre);
        DBMS_OUTPUT.PUT_LINE('Precio base   : ' || SELF.precio_base || ' €');
        DBMS_OUTPUT.PUT_LINE('Impuesto      : ' || SELF.impuesto || ' %');
        DBMS_OUTPUT.PUT_LINE('');
    END;

    MEMBER PROCEDURE precioTotal IS
        precioImpuesto NUMBER (10, 2);
    BEGIN
        precioImpuesto := SELF.precio_base+(SELF.precio_base/100)*SELF.impuesto;
        DBMS_OUTPUT.PUT_LINE('Precio final  : ' || precioImpuesto || ' €');
        DBMS_OUTPUT.PUT_LINE('');
    END;

    MAP MEMBER FUNCTION ordenar_por_precio RETURN NUMBER IS
    BEGIN
        RETURN SELF.precio_base;
    END;
END;
/

CREATE OR REPLACE TYPE BODY producto_fresco_t AS
    OVERRIDING MEMBER PROCEDURE mostrarInfoProducto IS
    BEGIN    
        DBMS_OUTPUT.PUT_LINE('ID            : ' || SELF.idProducto);
        DBMS_OUTPUT.PUT_LINE('Nombre        : ' || SELF.nombre);
        DBMS_OUTPUT.PUT_LINE('Precio base   : ' || SELF.precio_base || ' €');
        DBMS_OUTPUT.PUT_LINE('Impuesto      : ' || SELF.impuesto || ' %');
        DBMS_OUTPUT.PUT_LINE('Tipo producto : ' || SELF.tipo_producto);
        DBMS_OUTPUT.PUT_LINE('Caducidad     : ' || TO_CHAR(SELF.fecha_caducidad, 'DD-MM-YYYY'));
        DBMS_OUTPUT.PUT_LINE('');
    END;

    MEMBER PROCEDURE verificarCaducidad IS
    BEGIN
        IF SELF.fecha_caducidad < TRUNC(SYSDATE) THEN
            DBMS_OUTPUT.PUT_LINE('Producto caducado.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Producto en buen estado.');
        END IF;
        DBMS_OUTPUT.PUT_LINE('');
    END;
END;
/

CREATE OR REPLACE TYPE lista_productos_t AS TABLE OF producto_t;
/

CREATE OR REPLACE TYPE lista_productos_frescos_t AS TABLE OF producto_fresco_t;
/

DECLARE
    p1 PRODUCTO_T := PRODUCTO_T(1, 'Manzana', 2.99, 10);
    p2 PRODUCTO_T := PRODUCTO_T(2, 'Platano', 1.50, 15);
    p3 PRODUCTO_T := PRODUCTO_T(3, 'Pera',    1.80, 20);

    pf1 PRODUCTO_FRESCO_T := PRODUCTO_FRESCO_T(4, 'Uvas', 3.50, 18, 'Fruta', TO_DATE('2025-06-01','YYYY-MM-DD'));
    pf2 PRODUCTO_FRESCO_T := PRODUCTO_FRESCO_T(5, 'Sandia', 10.99, 14, 'Fruta', TO_DATE('2025-04-23','YYYY-MM-DD'));

    productos LISTA_PRODUCTOS_T := LISTA_PRODUCTOS_T(p1, p2, p3);
    productos_frescos LISTA_PRODUCTOS_FRESCOS_T := LISTA_PRODUCTOS_FRESCOS_T(pf1, pf2);
BEGIN
    FOR i IN (SELECT VALUE(p) prod FROM TABLE(productos) p
        ORDER BY VALUE(p)
    ) LOOP
        i.prod.mostrarInfoProducto();
        i.prod.precioTotal();
    END LOOP;

    FOR i IN (SELECT VALUE(p) prod FROM TABLE(productos_frescos) p
        ORDER BY VALUE(p)
    ) LOOP
        i.prod.mostrarInfoProducto();
        i.prod.verificarCaducidad();
        i.prod.precioTotal();
    END LOOP;
END;
/
