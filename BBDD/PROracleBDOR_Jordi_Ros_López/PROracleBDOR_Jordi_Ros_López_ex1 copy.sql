Object type Concierto:
- id NUMBER,
- nombre_concierto VARCHAR2(50),
- nombre_artista VARCHAR2(50),
- nombre_grupo VARCHAR2(50),
- direccion Direccion,
- fecha_hora DATE
- mostrarInforConcierto()

Object type Direccion:
- calle VARCHAR2(100),
- numero INT,
- poblacion VARCHAR2(50)

Object type Promotor
- nombre VARCHAR2(50),
- telefono NUMBER,
- direccion_web VARCHAR2(100)
