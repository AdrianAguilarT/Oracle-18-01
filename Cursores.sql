-- 1) CREAR TABLA:
CREATE TABLE usuario_x(
  id INTEGER PRIMARY KEY,
  nombre VARCHAR2(40),
  edad INTEGER);
  
-- 2) LLENAR TABLA:
INSERT INTO usuario_x VALUES (1,'Juan',40);
INSERT INTO usuario_x VALUES (2,'Ana',32);
INSERT INTO usuario_x VALUES (3,'Pedro',27);
INSERT INTO usuario_x VALUES (4,'María',30);

SELECT * FROM usuario_x WHERE edad > 30;

SET SERVEROUTPUT ON;  -- PERMITE VER SALIDAS DE IMPRESIÓN

-- DECLARACIÓN DEL CURSOR EXPLÍCITO
DECLARE
CURSOR cur_1 IS SELECT * FROM usuario_x;
BEGIN
  FOR fila IN cur_1 LOOP  -- ASIGNA A FILA EL NÚM. DE REGISTROS EN LA TABLA
  DBMS_OUTPUT.PUT_LINE('El nombre actual es '||fila.nombre);
  END LOOP;
END;
/

/*CURSOR QUE CONTENGA UNA VARIABLE INTERNA Y QUE REALICE LA SIG. OPERACIÓN
SI LA EDAD ES ESTRÍCTAMENTE MAYOR A 30. ASIGNAR SUELDO_BASE UN FACTOR DE 1.5
Y SI ES MENOR, NO ASIGNAR EL FACTOR DONDE SUELDO_BASE=6000 PESOS*/
DECLARE
CURSOR cur_2 IS SELECT * FROM usuario_x;
sueldo_base INTEGER;
BEGIN
  FOR fila IN cur_2 LOOP
    sueldo_base:=6000;
    IF fila.edad > 30 THEN
      sueldo_base:=sueldo_base*1.5;
    END IF;
    DBMS_OUTPUT.PUT_LINE('El sueldo base es '||sueldo_base||' Edad: '||fila.edad);
  END LOOP;
END;
/

-------------------------------------------------------------------------------

-- CURSORES IMMPLÍCITOS
CREATE TABLE cartera_clientes(
  id INTEGER PRIMARY KEY,
  nombre VARCHAR2(40),
  edad INTEGER,
  sueldo_base FLOAT
);
  
INSERT INTO cartera_clientes VALUES(1, 'Juan', 25, 60000);
INSERT INTO cartera_clientes VALUES(2, 'Ana', 45, 40000);
INSERT INTO cartera_clientes VALUES(3, 'Pedro', 32, 40000);
INSERT INTO cartera_clientes VALUES(4, 'Irma', 45, 70000);
INSERT INTO cartera_clientes VALUES(5, 'Luis', 55, 20000);

SELECT * FROM cartera_clientes;

/* ESCRIBIR IPLÍCITO QUE OBTENGA EL SUELDO_BASE DE EL REGISTRO QUE TIENE ID=3,
UNA VEZ OBTENIDO, QUE MULTIPLIQUE EL SUELDO_BASE POR 20 HORAS LABORADAS Y
LO ASIGNE A UNA VARIABLE LOCAL LLAMADA PAGO-NÓMINA.

IMPRIMIR EL RESULTADO DE ESA VARIABLE*/

DECLARE
sueldo FLOAT;
pago_nomina FLOAT;
BEGIN
  -- Declaramos el cursor implícito:
  SELECT sueldo_base INTO sueldo FROM cartera_clientes WHERE id=3;
  pago_nomina:=sueldo*20;
  DBMS_OUTPUT.PUT_LINE('EL PAGO ES '||pago_nomina);
END;
/

SET SERVEROUTPUT ON;


/* GENERA LA TABLA SOLICITADA QUE TENGA SU CAMPO PRIMARY KEY AUNTO INCREMENTADO
DE 2 EN 2, EMPEZANDO DESDE EL 1. ES DECIR LLEVARÁ LA SECUENCIA 1, 3, 5, 7, 9...*/

-- 1) Crear Tabla
CREATE TABLE nominas(
  id_nomina INTEGER PRIMARY KEY,
  nombre VARCHAR2(60)
);

-- 2) Generar Secuencia
CREATE SEQUENCE sec_nominas
START WITH 1
INCREMENT BY 2
NOMAXVALUE; -- No hay límite superior (MAXVALUE=10;)

-- 3) Crear el procedimiento de enlace de tabla y secuencia
CREATE OR REPLACE PROCEDURE guardar_nomina(
my_id OUT INTEGER,
my_nombre IN VARCHAR2)
AS
BEGIN
  SELECT sec_nominas.NEXTVAL INTO my_id FROM DUAL;
  INSERT INTO nominas VALUES(my_id, my_nombre);
END;
/


-- Prueba delprocedimiento con un bloque PL SQL
DECLARE
valor INTEGER;
BEGIN
  guardar_nomina(valor,'Juan');
  DBMS_OUTPUT.PUT_LINE('EL PK GENERADO ES '||valor);
END;
/

SELECT * FROM nominas;