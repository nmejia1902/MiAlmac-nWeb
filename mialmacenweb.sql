create database mialmacenweb;

use mialmacenweb;

-- Se crea la tabla categorias donde se define el id, nombre y descripcion de la categoria de los productos
CREATE TABLE `categorias` (
  `id_categoria` int primary key,
  `nombre_categoria` varchar(35) not null,
  `descripcion_categoria` text
);

-- Se crea la tabla proveedores donde se registra la info de los proveedores como el contacto y el estado
CREATE TABLE `proveedores` (
  `proveedor_id` int primary KEY,
  `razon_social` VARCHAR(50) NOT NULL,
  `telefono` VARCHAR(9),
  `correo` VARCHAR(40),
  `direccíon` VARCHAR(60),
  `estado` ENUM('activo','inactivo') default 'activo',
  `ciudad` VARCHAR(50),
  `creado_en` timestamp default current_timestamp
);

-- Se crea la tabla usuarios que es la que gestiona los datos en el sistema, dependiendo su rol, y estado
CREATE TABLE `usuarios` (
  `usuario_id` INT PRIMARY KEY,
  `nombre_completo` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(40) NOT NULL UNIQUE,
  `username` VARCHAR(20) NOT NULL UNIQUE,
  `rol` ENUM('administrador', 'vendedor', 'usuario') DEFAULT 'usuario',
  `estado` ENUM('activo', 'inactivo') DEFAULT 'activo',
  `creado_en` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Se crea la tabla que contiene los productos disponibles, su precio, stock y su categoria
CREATE TABLE `productos` (
  `id_producto` int primary key,
  `nombre_producto` varchar(35) not null,
  `descripcion_producto` text,
  `sku` int unique,
  `precio_compra` double not null,
  `precio_venta` double not null,
  `stock_min` int default 0,
  `stock_actual` int default 0,
  `estado` enum('activo', 'inactivo', 'agotado') DEFAULT 'activo',
  `categoria_id` int not null,
  foreign key (categoria_id) references `categorias`(`id_categoria`)
  on update cascade 
  on delete restrict
);

/*
	Se crea la relación entre productos y usuarios donde se registran los movimientos del inventario
    realizados por los usuarios con fecha, cantidad, etc
 */
CREATE TABLE `productos_movimientos_usuarios` (
  `movimiento_id` INT PRIMARY KEY,
  `tipo_movimiento` ENUM('E', 'S') NOT NULL,
  `cantidad` INT NOT NULL,
  `fecha_movimiento` DATETIME NOT NULL,
  `observaciones` VARCHAR(240),
  `referencia` VARCHAR(100),
  `usuario_id` INT NOT NULL,
  `producto_id` INT NOT NULL,
  `creado_en` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios`(`usuario_id`)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT,
  FOREIGN KEY (`producto_id`) REFERENCES `productos`(`id_producto`)
    ON UPDATE CASCADE 
    ON DELETE RESTRICT
);