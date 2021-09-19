DROP DATABASE IF EXISTS bdHotel;
CREATE DATABASE IF NOT EXISTS bdHotel;

USE bdHotel;

CREATE TABLE IF NOT EXISTS CLIENTE(
    id_cliente INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    genero ENUM('M','F') NOT NULL,
    edad INT UNSIGNED NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    nit VARCHAR(25) DEFAULT 'C/F',
    telefono VARCHAR(8) NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp
);

CREATE TABLE HABITACION(
    id_habitacion INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT UNSIGNED NOT NULL,
    tipo_de_habitacion ENUM('INDIVIDUAL','DOBLE','TWIN') NOT NULL,
    descripcion VARCHAR(150) NOT NULL,
    numero_de_piso INT UNSIGNED NOT NULL,
    precio DOUBLE  UNSIGNED NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp,
    FOREIGN KEY (id_cliente) REFERENCES CLIENTE(id_cliente) ON DELETE CASCADE
);

CREATE TABLE EMPLEADOS(
    id_empleado INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    genero ENUM('M','F'),
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(8) NOT NULL,
    nit VARCHAR(25) NOT NULL,
    -- POR DEFINIRSE tipo_de_empleado ENUM(''),
    fecha_de_regisro DATETIME DEFAULT current_timestamp
);






INSERT INTO CLIENTE(nombre,apellido,genero,edad,direccion,nit,telefono)
    VALUES('JUAN CARLOS','CHOC XOL','M',19,'SAN PEDRO CARCHA','1103645','42249955');

SELECT * FROM CLIENTE;