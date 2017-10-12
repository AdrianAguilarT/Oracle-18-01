
-- Clase de Sábado 7 de Octubre
CREATE TABLE almacen(
  numero_almacen INTEGER,
  ubicacion_almacen VARCHAR2(80),
  CONSTRAINT pk_na PRIMARY KEY(numero_almacen)
);

-- Generación de procedimiento almacenado para guardar una entidad o registro de tipo almacén
CREATE OR REPLACE PROCEDURE guardar_almacen(mi_id IN INTEGER, mi_ubicacion IN VARCHAR2)
  AS
  BEGIN
  -- Lógica del procedimiento
  INSERT INTO almacen VALUES(mi_id, mi_ubicacion);
END;
/

-- Prueba de Procedimiento
BEGIN
  guardar_almacen(1, 'Plymouth');
END;
/

SELECT * FROM almacen;

-- Creación de Tabla Vendedor
CREATE TABLE vendedor(
  numero_vendedor INTEGER,
  nombre_vendedor VARCHAR2(60),
  area_ventas VARCHAR2(60),
  CONSTRAINT pk_nv PRIMARY KEY(numero_vendedor)
);

DESCRIBE almacen;
DESCRIBE vendedor;

-- Creación de tabla Cliente
CREATE TABLE cliente(
  numero_cliente INTEGER,
  numero_almacen INTEGER,
  nombre_cliente VARCHAR2(60),
  CONSTRAINT pk_nc PRIMARY KEY(numero_cliente),
  CONSTRAINT fk1_na FOREIGN KEY(numero_almacen) REFERENCES almacen(numero_almacen)
);

-- Creación de tabla Ventas
CREATE TABLE ventas(
  id_ventas INTEGER,
  numero_cliente INTEGER,
  numero_vendedor INTEGER,
  monto_venta FLOAT(126),
  CONSTRAINT pk_idvv1 PRIMARY KEY(id_ventas),
  CONSTRAINT fk_nc1 FOREIGN KEY(numero_cliente) REFERENCES cliente(numero_cliente),
  CONSTRAINT fk_nv1 FOREIGN KEY(numero_vendedor) REFERENCES vendedor(numero_vendedor)
);