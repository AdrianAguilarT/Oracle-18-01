-- Ejemplo 1 - Disparador Tipo Base

-- Creación de tabla "Mayores":
CREATE TABLE Mayores(
  id INTEGER PRIMARY KEY,
  nombre VARCHAR2(60),
  edad INTEGER
);

-- Disparador que impida registrar usuarios menores de edad en "Mayores":
CREATE OR REPLACE TRIGGER dispMayores BEFORE INSERT ON Mayores
FOR EACH ROW  -- Garantiza que se dispare en cada fila si se ejecuta un cursor
BEGIN
  IF :NEW.edad < 18 THEN
    RAISE_APPLICATION_ERROR(-20000, 'EDAD INCORRECTA'); -- Excepción: error en tiempo de ejecución
  END IF;
END;
/

INSERT INTO Mayores VALUES(1,'Juan',20);
SELECT * FROM Mayores;
INSERT INTO Mayores VALUES(2,'Ana',16);


-- Ejemplo 2 - Disparador Tipo BEFORE con operación UPDATE

-- Creación de tabla "Nomina":
CREATE TABLE Nomina(
  id INTEGER PRIMARY KEY,
  sueldoBase FLOAT,
  horasLaboradas INTEGER,
  deposito FLOAT
);

INSERT INTO Nomina VALUES(1,2000,20,28000);
INSERT INTO Nomina VALUES(2,1000,16,50000);
SELECT * FROM Nomina;

/* Para cada trabajadir de necesita actualizzar su depósito de la sig. manera:
   deposito = deposito + horasLaboradas * sueldoBase;
   Usar un Disparador */
   
CREATE OR REPLACE TRIGGER dispNomina BEFORE UPDATE ON Nomina
FOR EACH ROW
BEGIN
  :NEW.deposito := :OLD.deposito + :NEW.horasLaboradas * :OLD.sueldoBase;
END;
/

/* Probar que funciona para el UPDATE del registro cuyo id=1 considerar las
   horasLaboradas=20 */
   
UPDATE Nomina SET horasLaboradas = 20 WHERE id = 1;