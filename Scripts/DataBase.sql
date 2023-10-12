create database LasYemitas
character set "utf8mb4"
collate "utf8mb4_0900_ai_ci";

use Lasyemitas;


create table if not exists huevos (
id int auto_increment primary key,
precio_huevo int not null comment "Es el valor que tiene el precio del huevo.",
tamaño varchar(20) not null comment "Tamaño del huevo.",
estadoHuevo varchar(20) not null comment "Como se encuentra el huevo, en que estado viene."
);

create table if not exists estadoOrden(
id int auto_increment primary key,
descripcion varchar (30) not null comment "Una descripcion de la orden de esta."
);

create table if not exists precioEnvio(
id int auto_increment primary key,
precio_Envio int not null comment "El precio que sale por el envio.",
descripcion varchar (20) not null comment "Depenediendo de la distancia es el envio, una descripcion de cuantos km son"
);

create table if not exists ventas(
id int auto_increment primary key,
precio_venta int not null comment "Cuantas ventas se han hecho, pueden ser en meses, dias o semanas.",
fecha_hora datetime not null comment"Fecha del precio del envio para saber que dia se tiene que saber."
);

create table if not exists clientes(
id int auto_increment primary key,
nombre varchar (60) not null comment"Nombre del cliente.",
telefono varchar (12) not null comment"Telefono del cliente.",
direccion varchar (50) not null comment "Direccion del cliente.",		
tipoPago varchar (30) not null comment "Tipo de pago que selecciono el cliente, efectivo, tarjeta, etc."
);

create table if not exists ordenes(
id int auto_increment primary key,
fecha_Hora datetime not null comment "Fecha y hora en que se establecio la orden."
);

create table if not exists detalleOrden(
id int auto_increment primary key,
cliente_id int,
cantidad varchar (15) not null comment "La cantidad de huevos que se encargaron en la orden.",
huevos_id int,
estadoOrden_id int,
ventas_id int,
ordenes_id int,			
precioEnvio_id int,
foreign key (cliente_id) references clientes(id),
foreign key (huevos_id) references huevos(id),
foreign key (estadoOrden_id) references estadoOrden(id),
foreign key (ventas_id) references ventas(id),
foreign key (ordenes_id) references ordenes(id),
foreign key (precioEnvio_id) references precioEnvio(id)
);


insert into huevos(precio_huevo, tamaño, estadoHuevo)
values
	(120, "chico", "Limpio"),
    (150, "chico", "Sucio"),
    (160, "mediano", "Limpio"),
    (180, "mediano", "Sucio"),
    (200, "extra","Limpio"),
    (230, "extra","Limpio"),
    (250, "extraGrande","Limpio"),
    (270, "extragrande","Sucio"),
    (300, "jumbo","Limpio")
;

insert into estadoOrden(descripcion)
values
	("Pendiente"),
	("En tránsito"),
	("Entregada"),
	("Completada"),
	("Cancelada"),
	("Rechazada"),
	("Pendiente de Pago")
;

insert into precioEnvio(precio_Envio, descripcion)
values
	(0, "Menos de 1 km"),
    (1000, "2km de distancia"),
    (1500, "4km de distancia"),
    (2000, "6km de distancia"),
    (2500, "8km de distancia"),
    (3000, "10km de distancia"),
    (3500, "12km de distancia"),
    (4000, "14km de distancia"),
    (4500, "16km de distancia")
;

insert into ventas(precio_venta, fecha_hora)
	values
	(63000, '2023-01-03 16:55:00'),
    (70000, '2023-01-04 17:23:50'),
    (56000, '2023-01-05 15:45:24'),
    (45870, '2023-01-06 18:56:23'),
    (90500, '2023-01-07 13:23:54'),
    (87900, '2023-01-08 14:13:23'),
    (56890, '2023-01-09 15:54:45'),
    (78908, '2023-01-10 15:23:32')
;

insert into clientes(nombre, telefono, direccion, tipoPago)
values
	("María González", "+56987654321", "Madrid #700", "Tarjeta de crédito"),
	("Pedro Rodríguez", "+56976543210", "Valparaíso", "Efectivo"),
	("Ana Pérez", "+56965432109","Avenida Los Pinos #45",  "Transferencia bancaria"),
	("Juan Sánchez", "+56954321098","Avenida Principal #321", "Tarjeta de débito"),
	("Laura López", "+56943210987","Calle Libertad #789",  "Cheque"),
	("Diego Martínez", "+56932109876", "Calle del Sol #55", "Transferencia bancaria"),
	("Sofía Fernández", "+56921098765", "Avenida Los Robles #234",   "Tarjeta de crédito"),
	("Andrés Torres", "+56910987654", "Avenida de las Flores #678",  "Efectivo"),
	("Valentina Silva", "+56909876543", "Calle Victoria #987",  "Cheque"),
	("Felipe Muñoz", "+56998765432", "Avenida del Mar #2345",  "Tarjeta de débito"),
	("Carla Rojas", "+56987654321", "Calle Santa Rosa #111", "Efectivo"),
	("Cristian Contreras", "+56976543210","Avenida Los Pinos #45",  "Tarjeta de crédito"),
	("Natalia Espinoza", "+56965432109", "Avenida de los Volcanes #333", "Transferencia bancaria"),
	("Francisco Ríos", "+56954321098", "Calle Los Cerezos #456", "Cheque"),
	("Patricia Castro", "+56943210987", "Avenida Los Lagos #7890",  "Tarjeta de débito")
;

insert into ordenes(fecha_hora)
values
	('2023-10-03 08:30:00'),
	('2023-10-04 14:45:00'),
	('2023-10-05 10:15:00'),
	('2023-10-06 19:20:00'),
	('2023-10-07 16:55:00'),
    ('2023-10-08 16:55:00'),
    ('2023-10-09 16:55:00'),
    ('2023-10-10 16:55:00')
;

insert into detalleOrden(cliente_id, cantidad, huevos_id, estadoOrden_id, ventas_id , ordenes_id, precioEnvio_id)
values
	(8,76,2,4,1,3,4),
    (14,102,4,5,1,5,2)
;


-- TABLA HUEVOS --


delimiter $$
create procedure sp_InsertHuevo(
    in _precio_huevo int,
    in _tamaño varchar(20),
    in _estadoHuevo varchar(20)
)
begin
    insert into huevos(precio_huevo, tamaño, estadoHuevo)
    values (_precio_huevo, _tamaño, _estadoHuevo);
end 
$$
 
delimiter $$
create procedure sp_DeleteHuevo(
    in _id int
)
begin
    delete from huevos
    where id = _id;
end 
$$

delimiter $$
create procedure sp_UpdateHuevo(
    in _id int,
    in _nuevoPrecio int,
    in _nuevoTamaño varchar(20),
    in _nuevoEstadoHuevo varchar(20)
)
begin
    update huevos
    set precio_huevo = _nuevoPrecio,
        tamaño = _nuevoTamaño,
        estadoHuevo = _nuevoEstadoHuevo
    where id = _id;
end 
$$ 

delimiter $$
create procedure sp_SelectHuevos()
begin
    select * from huevos;
end 
$$



-- TABLA ESTADOORDEN --

delimiter $$
create procedure sp_insertarEstadoOrden(
	in _descripcion varchar(30)
)
begin
	insert into estadoOrden(descripcion)
    values(_descripcion);
end
$$

delimiter $$
create procedure sp_DeleteEstadoOrden(
    in _estadoOrden_id int
)
begin
    delete from estadoOrden
    where id = _estadoOrden_id;
end
$$ 

delimiter $$
create procedure sp_UpdateEstadoOrdenSimple(
    in _id int,
    in _nuevaDescripcion varchar(30)
)
begin
    update estadoOrden
    set descripcion = _nuevaDescripcion
    where id = _id;
end 
$$

delimiter $$
create procedure sp_SelectEstadoOrden()
begin
    select * from estadoOrden;
end 
$$


-- TABLA PRECIOENVIO --

delimiter $$
create procedure sp_insertPrecioEnvio(
	in _precio_envio int,
    in _descripcion varchar(20)
)
begin
	insert into precioEnvio(precio_envio, descripcion)
    values(_precio_envio, _descripcion);
end
$$

delimiter $$
create procedure sp_eliminarEnvioPrecio(
    in _id int
)
begin
    delete from precioEnvio
    where id = _id;
end 
$$

delimiter $$
create procedure sp_UpdatePrecioEnvio(
    in _id int,
    in _nuevoPrecioEnvio int,
    in _nuevaDescripcion varchar(20)
)
begin
    update precioEnvio
    set precio_Envio = _nuevoPrecioEnvio,
        descripcion = _nuevaDescripcion
    where id = _id;
end 
$$

DELIMITER $$
create procedure sp_SelectPrecioEnvio()
begin
    select * from precioEnvio;
end
$$


DELIMITER $$
CREATE PROCEDURE sp_InsertDetalleOrden(
    IN _cliente_id INT,
    IN _cantidad VARCHAR(15),
    IN _huevos_id INT,
    IN _estadoOrden_id INT,
    IN _ventas_id INT,
    IN _ordenes_id INT,
    IN _precioEnvio_id INT
)
BEGIN
    INSERT INTO detalleOrden(cliente_id, cantidad, huevos_id, estadoOrden_id, ventas_id, ordenes_id, precioEnvio_id)
    VALUES (_cliente_id, _cantidad, _huevos_id, _estadoOrden_id, _ventas_id, _ordenes_id, _precioEnvio_id);
END
$$
DELIMITER ;


DELIMITER $$
CREATE PROCEDURE sp_DeleteDetalleOrden(
    IN _id_detalleOrden INT
)
BEGIN
    DELETE FROM detalleOrden
    WHERE id = _id_detalleOrden;
END
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_UpdateDetalleOrden(
    IN _id_detalleOrden INT,
    IN _nuevoClienteId INT,
    IN _nuevaCantidad VARCHAR(15),
    IN _nuevoHuevosId INT,
    IN _nuevoEstadoOrdenId INT,
    IN _nuevoVentasId INT,
    IN _nuevoOrdenesId INT,
    IN _nuevoPrecioEnvioId INT
)
BEGIN
    UPDATE detalleOrden
    SET cliente_id = _nuevoClienteId,
        cantidad = _nuevaCantidad,
        huevos_id = _nuevoHuevosId,
        estadoOrden_id = _nuevoEstadoOrdenId,
        ventas_id = _nuevoVentasId,
        ordenes_id = _nuevoOrdenesId,
        precioEnvio_id = _nuevoPrecioEnvioId
    WHERE id = _id_detalleOrden;
END
$$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE sp_SelectDetalleOrden()
BEGIN
    SELECT * FROM detalleOrden;
END
$$
DELIMITER ;





-- TABLA VENTAS --

delimiter $$
create procedure sp_InsertVenta(
	in _precio_venta int,
    in _fecha_hora datetime
)
begin
	insert into ventas(precio_venta, fecha_hora)
    values (_precio_venta, _fecha_hora);
end
$$

delimiter $$
create procedure sp_DeleteVenta(
    in _id int
)
begin
    delete from ventas
    where id = _id;
end 
$$

delimiter $$
create procedure sp_UpdateVenta(
    in _id int,
    in _precio_venta int,
    in _fecha_hora datetime
)
begin
    update ventas
    set precio_venta = _precio_venta,
        fecha_hora = _fecha_hora
    where id = _id;
end 
$$ 

delimiter $$
create procedure sp_SelectVenta()
begin
    select * from ventas
    where precio_venta <= 80000 ;
end 
$$



-- TABLA CLIENTES -- 

delimiter $$
create procedure sp_InsertCliente(
	in _nombre varchar(60),
    in _telefono varchar(12),
    in _direccion varchar(50),
    in _tipoPago varchar(30)
)
begin
	insert into clientes(nombre, telefono, direccion, tipoPago)
    values (_nombre, _telefono, _direccion, _tipoPago);
end
$$


delimiter $$
create procedure sp_DeleteCliente(
    in _id int
)
begin
    delete from clientes
    where id = _id ;
end 
$$

delimiter $$
create procedure sp_UpdateCliente(
    in _id int,
    in _nombre varchar(60),
    in _telefono varchar(12),
    in _direccion varchar(50),
    in _tipoPago varchar(30)
)
begin
    update clientes
    set nombre = _nombre,
        telefono = _telefono,
        direccion = _direccion,
        tipoPago = _tipoPago
    where id = _id;
end 
$$

delimiter $$
create procedure sp_SelectCliente()
begin
    select * from clientes
    where tipoPago = "Efectivo" ;
end 
$$


-- TABLA ORDENES --

delimiter $$
create procedure sp_InsertOrden(
	in _fecha_hora datetime											
)
begin
	insert into ordenes(fecha_hora)
    values (_fecha_hora);
end
$$

delimiter $$
create procedure sp_DeleteOrden(
    in _id int
)
begin
   delete from ordenes
   where id = 4;


end 
$$

delimiter $$
create procedure sp_UpdateOrden(
	in _id int,
    in _fecha_hora datetime
)
begin
    update ordenes
    set fecha_hora = _fecha_hora
    where id = _id;
end 
$$ 

delimiter $$
create procedure sp_SelectOrden()
begin
    select * from ordenes
    where id = 5;
end 
$$
