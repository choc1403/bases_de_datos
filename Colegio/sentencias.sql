DROP DATABASE IF EXISTS bdColegio;
CREATE DATABASE IF NOT EXISTS bdColegio;

USE bdColegio;

-- Creacion de tablas en la base de datos
CREATE TABLE IF NOT EXISTS Director(
    id_director INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    genero ENUM('M','F') NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(8) NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp

);

CREATE TABLE IF NOT EXISTS Establecimiento(
    id_establecimiento INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_director INT UNSIGNED NOT NULL UNIQUE,
    nombre_del_establecimiento VARCHAR(70) NOT NULL,
    direccion VARCHAR(70) NOT NULL,
    telefono VARCHAR(8) NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp,
    FOREIGN KEY (id_director) REFERENCES Director(id_director) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Administracion(
    id_administracion INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_establecimiento INT UNSIGNED UNIQUE,
    nombre_persona_cargo VARCHAR(25)  NOT NULL,
    apellido_persona_cargo VARCHAR(25) NOT NULL,
    direccion VARCHAR(25) NOT NULL,
    edad INT UNSIGNED,
    genero ENUM('M','F'),
    telefono VARCHAR(8),
    tipo_de_cargo ENUM('SECRETARIA','SECRETARIO','GESTOR_DE_CUENTAS') NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp,

    FOREIGN KEY (id_establecimiento) REFERENCES Establecimiento(id_establecimiento) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Maestro(
    id_maestro INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_establecimiento INT UNSIGNED NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(8) NOT NULL,
    genero ENUM('M','F') NOT NULL,
    nit varchar(25) NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp,
    FOREIGN KEY (id_establecimiento) REFERENCES Establecimiento(id_establecimiento) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Aula(
    id_aula INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    piso ENUM('1','2') NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp    
);

CREATE TABLE IF NOT EXISTS Curso(
    id_curso INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_maestro INT UNSIGNED NOT NULL,
    nombre_curso VARCHAR(25) NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp,
    FOREIGN KEY (id_maestro) REFERENCES Maestro(id_maestro) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Seccion(
    id_seccion INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    tipo_de_seccion ENUM('A','B','C') NOT NULL,
    fecha_de_regisro DATETIME DEFAULT current_timestamp
); 

CREATE TABLE IF NOT EXISTS personal_a_cargo(
    id_personal_acargo INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    telefono VARCHAR(8) NOT NULL,
    tipo_de_personal_a_cargo ENUM('PADRE','MADRE','TUTOR') NOT NULL,
    genero ENUM('M','F') NOT NULL,
    fecha_de_regisro DATETIME DEFAULT  current_timestamp

);

CREATE TABLE IF NOT EXISTS Padre(
    id_padre INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    genero VARCHAR(1) DEFAULT 'M',
    telefono VARCHAR(50) NOT NULL,    
    fecha_de_regisro DATETIME DEFAULT current_timestamp
);

CREATE TABLE IF NOT EXISTS Madre(
    id_madre INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(25) NOT NULL,
    apellido VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    genero VARCHAR(1) DEFAULT 'F',
    telefono VARCHAR(50) NOT NULL,    
    fecha_de_regisro DATETIME DEFAULT current_timestamp

);

CREATE TABLE IF NOT EXISTS Alumno(
    id_alumno INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_personal_acargo INT UNSIGNED NOT NULL,
    id_establecimiento INT UNSIGNED NOT NULL,
    id_seccion INT UNSIGNED NOT NULL,
    id_padre INT UNSIGNED,
    id_madre INT UNSIGNED,
    nombre_alumno VARCHAR(25) NOT NULL,
    apellido_alumno VARCHAR(25) NOT NULL,
    edad INT UNSIGNED NOT NULL,
    genero ENUM('M','F'),
    direccion VARCHAR(50) NOT NULL,
    fecha_de_regisro DATETIME DEFAULT  current_timestamp,
    FOREIGN KEY (id_personal_acargo) REFERENCES personal_a_cargo(id_personal_acargo) ON DELETE CASCADE,
    FOREIGN KEY (id_establecimiento) REFERENCES Establecimiento(id_establecimiento) ON DELETE CASCADE,
    FOREIGN KEY (id_padre) REFERENCES Padre(id_padre) ON DELETE CASCADE,
    FOREIGN KEY (id_seccion) REFERENCES Seccion(id_seccion) ON DELETE CASCADE,
    FOREIGN KEY (id_madre) REFERENCES Madre(id_madre) ON DELETE CASCADE
);

-- TABLAS DE MUCHOS A MUCHOS
CREATE TABLE alumno_maestro(
    id_maestro INT UNSIGNED NOT NULL,
    id_alumno INT UNSIGNED NOT NULL,

    FOREIGN KEY (id_maestro) REFERENCES Maestro(id_maestro) ON DELETE CASCADE,
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id_alumno) ON DELETE CASCADE
); 

CREATE TABLE alumno_curso(
    id_curso INT UNSIGNED NOT NULL,
    id_alumno INT UNSIGNED NOT NULL,

    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_alumno) REFERENCES Alumno(id_alumno) ON DELETE CASCADE
);

CREATE TABLE curso_aula(
    id_curso INT UNSIGNED NOT NULL,
    id_aula INT UNSIGNED NOT NULL,

    FOREIGN KEY (id_curso) REFERENCES Curso(id_curso) ON DELETE CASCADE,
    FOREIGN KEY (id_aula) REFERENCES Aula(id_aula) ON DELETE CASCADE
);

CREATE TABLE aula_seccion(
    id_aula INT UNSIGNED NOT NULL,
    id_seccion INT UNSIGNED NOT NULL,

    FOREIGN KEY (id_aula) REFERENCES Aula(id_aula) ON DELETE CASCADE,
    FOREIGN KEY (id_seccion) REFERENCES Seccion(id_seccion) ON DELETE CASCADE
);

CREATE TABLE establecimiento_aula(
    id_aula INT UNSIGNED NOT NULL,
    id_establecimiento INT UNSIGNED NOT NULL,

    FOREIGN KEY (id_aula) REFERENCES Aula(id_aula) ON DELETE CASCADE,
    FOREIGN KEY (id_establecimiento) REFERENCES Establecimiento(id_establecimiento) ON DELETE CASCADE

);


-- Insertar datos a la base de datos
INSERT INTO Director(nombre, apellido,edad,genero,direccion,telefono)
    VALUES('Juan','Choc',19,'M','COBAN','42249955'),
          ('Juan','Choc',19,'M','COBAN','42249955');

INSERT INTO Establecimiento(id_director,nombre_del_establecimiento,direccion,telefono)
    VALUES(1,'COLEGIO ISAIAS BARRIENTOS','SAN PEDRO CARCHA','22556632'),
          (2,'LICEO DR. RICARDO BRESSANI','COBAN','75256365');

INSERT INTO Administracion(id_establecimiento,nombre_persona_cargo,apellido_persona_cargo,direccion,edad,genero,telefono,tipo_de_cargo)
    VALUES(1,'Carlos','Xol','COBAN',19,'M','42249955','GESTOR_DE_CUENTAS'),
          (2,'Julia','Pop','TACTIC',20,'F','32564215','SECRETARIA');


INSERT INTO Maestro(id_establecimiento,nombre,apellido,edad,direccion,telefono,genero,nit)
    VALUES(1,'Juan','Choc',19,'COBAN','42249955','M','1103567');

INSERT INTO Maestro(id_establecimiento,nombre,apellido,edad,direccion,telefono,genero,nit)           
    VALUES(2,'Martina','Rodriguez',20,'COBAN','F','16412456');

INSERT INTO Aula(piso)
    VALUES('1');

INSERT INTO Curso(id_maestro,nombre_curso)
    VALUES(1,'MATEMATICAS');  

INSERT INTO Seccion(tipo_de_seccion)
    VALUES('A'),
          ('B'),
          ('C');

INSERT INTO personal_a_cargo(nombre,apellido,edad,direccion,telefono,tipo_de_personal_a_cargo,genero)
    VALUES('Carlos','Pop',25,'CARCHA','42246528','TUTOR','M');

INSERT INTO Padre(nombre,apellido,edad,direccion,telefono)
    VALUES('JUAN','CHOC',35,'COBAN','42249955');

INSERT INTO Madre(nombre,apellido,edad,direccion,telefono)
    VALUES('JUAN','CHOC',35,'COBAN','42249955');
    
INSERT INTO Alumno(id_personal_acargo,id_establecimiento,id_seccion,id_padre,id_madre,nombre_alumno,apellido_alumno,edad,genero,direccion)
            VALUES(1,1,1,1,1,'Emanuel','Caal',10,'M','CARCHA');






-- MOSTRAR DATOS
SELECT * FROM Director;
SELECT * FROM Establecimiento\G;
SELECT * FROM Administracion\G;
SELECT * FROM Maestro\G;
SELECT * FROM Aula\G;
SELECT * FROM Curso\G;
SELECT * FROM Seccion\G;
SELECT * FROM personal_a_cargo\G;
SELECT * FROM Padre\G;
SELECT * FROM Madre\G;
SELECT * FROM Alumno\G;

-- Falta por generar los inner joins de las tablas de muchos a muchos