
-- Clase de S�bado 7 de Octubre
CREATE TABLE almacen(
  numero_almacen INTEGER,
  ubicacion_almacen VARCHAR2(80),
  CONSTRAINT pk_na PRIMARY KEY(numero_almacen)
);

-- Generaci�n de procedimiento almacenado para guardar una entidad o registro de tipo almac�n
CREATE OR REPLACE PROCEDURE guardar_almacen(mi_id IN INTEGER, mi_ubicacion IN VARCHAR2)
  AS
  BEGIN
  -- L�gica del procedimiento
  INSERT INTO almacen VALUES(mi_id, mi_ubicacion);
END;
/

-- Prueba de Procedimiento
BEGIN
  guardar_almacen(1, 'Plymouth');
END;
/

SELECT * FROM almacen;