-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS nombre_de_tu_base_de_datos;

-- Seleccionar la base de datos
USE nombre_de_tu_base_de_datos;

-- Creación de la tabla de Clientes
CREATE TABLE Clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255),
    fecha_registro DATE
);

-- Trigger para establecer la fecha de registro automática
DELIMITER //
CREATE TRIGGER before_insert_clientes
BEFORE INSERT ON Clientes
FOR EACH ROW
BEGIN
    IF NEW.fecha_registro IS NULL THEN
        SET NEW.fecha_registro = CURDATE();
    END IF;
END;
//
DELIMITER ;

-- Creación de la tabla de Habitaciones
CREATE TABLE Habitaciones (
    habitacion_id INT AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(10) UNIQUE NOT NULL,
    tipo VARCHAR(50) NOT NULL,
    precio_por_noche DECIMAL(10, 2) NOT NULL,
    estado ENUM('Disponible', 'Ocupada', 'Mantenimiento') DEFAULT 'Disponible'
);

-- Creación de la tabla de Reservas
CREATE TABLE Reservas (
    reserva_id INT AUTO_INCREMENT PRIMARY KEY,
    cliente_id INT NOT NULL,
    habitacion_id INT NOT NULL,
    fecha_reserva DATE DEFAULT CURDATE(),
    fecha_checkin DATE NOT NULL,
    fecha_checkout DATE NOT NULL,
    estado ENUM('Confirmada', 'Cancelada', 'Finalizada') DEFAULT 'Confirmada',
    FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
    FOREIGN KEY (habitacion_id) REFERENCES Habitaciones(habitacion_id),
    CONSTRAINT chk_fechas CHECK (fecha_checkin < fecha_checkout)
);

-- Creación de la tabla de Pagos
CREATE TABLE Pagos (
    pago_id INT AUTO_INCREMENT PRIMARY KEY,
    reserva_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    fecha_pago DATE DEFAULT CURDATE(),
    metodo_pago ENUM('Tarjeta de crédito', 'PayPal', 'Efectivo') NOT NULL,
    FOREIGN KEY (reserva_id) REFERENCES Reservas(reserva_id)
);

-- Creación de la tabla de Empleados
CREATE TABLE Empleados (
    empleado_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    telefono VARCHAR(15)
);

-- Creación de la tabla de Servicios Adicionales
CREATE TABLE Servicios_Adicionales (
    servicio_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre_servicio VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    descripcion TEXT
);

-- Relación entre Reservas y Servicios Adicionales
CREATE TABLE Reserva_Servicio (
    reserva_id INT NOT NULL,
    servicio_id INT NOT NULL,
    FOREIGN KEY (reserva_id) REFERENCES Reservas(reserva_id),
    FOREIGN KEY (servicio_id) REFERENCES Servicios_Adicionales(servicio_id),
    PRIMARY KEY (reserva_id, servicio_id)
);

-- Índice único para evitar reservas superpuestas en la misma habitación
CREATE UNIQUE INDEX idx_habitacion_reserva ON Reservas (habitacion_id, fecha_checkin, fecha_checkout);
