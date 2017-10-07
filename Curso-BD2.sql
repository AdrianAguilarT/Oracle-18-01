
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