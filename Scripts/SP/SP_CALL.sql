use lasyemitas;

/*
sp_InsertDetalleOrden  
sp_InsertVenta
sp_InsertCliente
sp_InsertOrden
Fecha: 11/10
Autor: Felipe Sepúlveda
*/
call sp_InsertDetalleOrden(8, '50', 3, 2, 1, 5, 4);
call sp_DeleteDetalleOrden(3);
call sp_UpdateDetalleOrden(2, 7, '60', 4, 3, 2, 5, 6);
call sp_SelectDetalleOrden();

call sp_InsertVenta(120000,'2023-01-11 18:35:00');
call sp_DeleteVenta(8);
call sp_UpdateVenta(7, 110000, '2023-01-11 16:05:00');
call sp_SelectVenta();

call sp_InsertCliente("Valentina LLados","+56953550896","vitacumbia #604","Transferencia bancaria");
call sp_DeleteCliente(14);
call sp_UpdateCliente(15,"Santiago Valladares","+56944770673","Avenida España #543","Efectivo");
call sp_SelectCliente();

call sp_InsertOrden('2023-10-12 17:30:05');
call sp_DeleteOrden(4);
call sp_UpdateOrden(1,'2023-10-07 10:45:00');
call sp_SelectOrden();

/* /
sp_insertPrecioEnvio
sp_InsertHuevo
sp_UpdateEstadoOrdenSimple
Fecha: 11/10
Autor: Juan Riveros
*/
call sp_insertPrecioEnvio(5000, "18 kilometros"); 
call sp_eliminarEnvioPrecio(3);
call sp_UpdatePrecioEnvio(1, 500, "1 kl menos");
call sp_SelectPrecioEnvio(); 

call sp_InsertHuevo(230, "Mediano", "Nuevo Estado");
call sp_DeleteHuevo(1);
call sp_UpdateHuevo(2, 300, "Grande", "Estado Actualizado");
call sp_SelectHuevos();

call sp_UpdateEstadoOrdenSimple(1, "En caminito");
call sp_DeleteEstadoOrden(2);
call sp_insertarEstadoOrden("En camino");
call sp_SelectEstadoOrden();