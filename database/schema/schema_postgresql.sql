CREATE DATABASE sistema_upt_unificado;

-- Conectarse a la base
\c sistema_upt_unificado;

-- =====================================================
-- TABLA TIPO USUARIO
-- =====================================================
CREATE TABLE tipo_usuario (
    id_tipo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    tipo_usuario VARCHAR(50) NOT NULL
);

-- =====================================================
-- TABLA CARRERA
-- =====================================================
CREATE TABLE carrera (
    id_carrera INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- =====================================================
-- TABLA GRUPO
-- =====================================================
CREATE TABLE grupo (
    id_grupo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_grupo VARCHAR(50),
    grupo VARCHAR(20),
    cuatrimestre INT,
    id_carrera INT REFERENCES carrera(id_carrera)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================================================
-- TABLA EDIFICIO
-- =====================================================
CREATE TABLE edificio (
    id_edificio INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_edificio VARCHAR(50)
);

-- =====================================================
-- TABLA AULA
-- =====================================================
CREATE TABLE aula (
    id_aula INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero_aula INT,
    nombre_aula VARCHAR(50),
    id_edificio INT REFERENCES edificio(id_edificio)
        ON DELETE CASCADE ON UPDATE CASCADE
);

-- =====================================================
-- TABLA HORARIO
-- =====================================================
CREATE TABLE horario (
    id_horario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    horario TIME NOT NULL
);

-- =====================================================
-- TABLA USUARIO
-- =====================================================
CREATE TABLE usuario (
    id_usuario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_tipo INT REFERENCES tipo_usuario(id_tipo),
    id_carrera INT REFERENCES carrera(id_carrera),
    id_grupo INT REFERENCES grupo(id_grupo),
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100),
    apellido_materno VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    matricula VARCHAR(20) UNIQUE,
    contrasena VARCHAR(255),
    estatus BOOLEAN DEFAULT TRUE,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLA ADMIN
-- =====================================================
CREATE TABLE admin (
    id_admin INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50)
);

-- =====================================================
-- TABLA COMPUTADORA
-- =====================================================
CREATE TABLE computadora (
    id_computadora INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    numero_equipo VARCHAR(20),
    marca VARCHAR(50),
    modelo VARCHAR(50),
    numero_serie VARCHAR(100) UNIQUE,
    estado VARCHAR(20) DEFAULT 'DISPONIBLE'
        CHECK (estado IN ('DISPONIBLE','PRESTADA','MANTENIMIENTO')),
    ubicacion VARCHAR(100)
);

-- =====================================================
-- TABLA PRESTAMO
-- =====================================================
CREATE TABLE prestamo (
    id_prestamo INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_computadora INT NOT NULL REFERENCES computadora(id_computadora),
    fecha_prestamo TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_devolucion TIMESTAMP,
    estado_pc VARCHAR(20)
        CHECK (estado_pc IN ('FUNCIONAL','LENTA','DAÑADA')),
    observacion TEXT,
    estado VARCHAR(20) DEFAULT 'ACTIVO'
        CHECK (estado IN ('ACTIVO','FINALIZADO'))
);

-- =====================================================
-- TABLA INVENTARIO
-- =====================================================
CREATE TABLE inventario (
    id_inventario INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre VARCHAR(50),
    id_computadora INT REFERENCES computadora(id_computadora),
    numero_inventario VARCHAR(50) UNIQUE,
    responsable VARCHAR(100),
    fecha_asignacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- =====================================================
-- TABLA RESERVA
-- =====================================================
CREATE TABLE reserva (
    id_reserva INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha_reserva TIMESTAMP NOT NULL,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_aula INT NOT NULL REFERENCES aula(id_aula),
    id_horario INT REFERENCES horario(id_horario)
);

-- =====================================================
-- TABLA DOCUMENTO
-- =====================================================
CREATE TABLE documento (
    id_documento INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_documento VARCHAR(100),
    ruta_archivo VARCHAR(255),
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT REFERENCES usuario(id_usuario)
);

-- =====================================================
-- TABLA IMAGEN
-- =====================================================
CREATE TABLE imagen (
    id_imagen INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    imagen BYTEA
);

-- =====================================================
-- TABLA EVIDENCIA
-- =====================================================
CREATE TABLE evidencia (
    id_evidencia INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_imagen INT REFERENCES imagen(id_imagen) ON DELETE CASCADE,
    descripcion VARCHAR(100)
);

-- =====================================================
-- TABLA ESTADO REPORTE
-- =====================================================
CREATE TABLE estado_reporte (
    id_estado INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    estado VARCHAR(20)
);

-- =====================================================
-- TABLA REPORTE
-- =====================================================
CREATE TABLE reporte (
    id_reporte INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_estado INT REFERENCES estado_reporte(id_estado),
    id_usuario INT REFERENCES usuario(id_usuario),
    id_computadora INT REFERENCES computadora(id_computadora),
    id_edificio INT REFERENCES edificio(id_edificio),
    id_aula INT REFERENCES aula(id_aula),
    id_evidencia INT REFERENCES evidencia(id_evidencia),
    descripcion TEXT,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    estado VARCHAR(20) DEFAULT 'PENDIENTE'
        CHECK (estado IN ('PENDIENTE','RESUELTO'))
);

-- =====================================================
-- TERMINOS
-- =====================================================
CREATE TABLE tipo_termino (
    id_tipo_termino INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_tipo VARCHAR(100)
);

CREATE TABLE terminos_condiciones (
    id_terminos_condiciones INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_tipo_termino INT NOT NULL REFERENCES tipo_termino(id_tipo_termino),
    contenido TEXT NOT NULL,
    fecha_publicacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    activo BOOLEAN DEFAULT TRUE
);

CREATE TABLE validacion_terminos (
    id_validacion_termino INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_usuario INT NOT NULL REFERENCES usuario(id_usuario),
    id_terminos_condiciones INT NOT NULL REFERENCES terminos_condiciones(id_terminos_condiciones),
    aceptado BOOLEAN NOT NULL,
    fecha_validacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);