-- Crear la base de datos si no existe
CREATE DATABASE IF NOT EXISTS hotel_reservations;
USE hotel_reservations;

-- Crear la tabla de clientes
CREATE TABLE IF NOT EXISTS clientes (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Llave primaria autoincremental
    nombre VARCHAR(255) NOT NULL,        -- Nombre del cliente
    apellido VARCHAR(255) NOT NULL,      -- Apellido del cliente
    email VARCHAR(255) NOT NULL,         -- Email del cliente
    telefono VARCHAR(20) NOT NULL,       -- Teléfono de contacto
    UNIQUE (email)                       -- Restringe que el email sea único
);

-- Crear la tabla de habitaciones
CREATE TABLE IF NOT EXISTS habitaciones (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Llave primaria autoincremental
    numero VARCHAR(50) NOT NULL,         -- Número de habitación (por ejemplo, "101", "Suite A")
    tipo VARCHAR(50) NOT NULL,           -- Tipo de habitación (por ejemplo, "simple", "doble", "suite")
    precio DECIMAL(10, 2) NOT NULL       -- Precio por noche de la habitación
);

-- Crear la tabla de reservas
CREATE TABLE IF NOT EXISTS reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,   -- Llave primaria autoincremental
    cliente_id INT NOT NULL,             -- Llave foránea que referencia a la tabla de clientes
    habitacion_id INT NOT NULL,          -- Llave foránea que referencia a la tabla de habitaciones
    fecha_inicio DATE NOT NULL,          -- Fecha de inicio de la reserva
    fecha_fin DATE NOT NULL,             -- Fecha de finalización de la reserva
    estado ENUM('confirmada', 'pendiente', 'cancelada') NOT NULL, -- Estado de la reserva
    FOREIGN KEY (cliente_id) REFERENCES clientes(id) ON DELETE CASCADE,   -- Borra la reserva si el cliente es eliminado
    FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id) ON DELETE CASCADE -- Borra la reserva si la habitación es eliminada
);