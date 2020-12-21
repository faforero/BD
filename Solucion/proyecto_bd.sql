create database komputronik;
use komputronik;


create table empleado(

id_empleado int not null,
nombre1 varchar(15), 
nombre2 varchar(15),
			apellido1 varchar(15),
apellido2 varchar(15),
cedula int,
 edad int,
 cargo varchar(15),
 salario int, 
 telefono varchar(12),
 fk_usuario int);
 
 create table aud_empleado(
nombre1 varchar(15), 
nombre2 varchar(15),
apellido1 varchar(15),
apellido2 varchar(15),
cedula int,
 edad int,
 cargo varchar(15),
 salario int, 
 telefono varchar(12),
 fk_usuario int,
 operacion varchar(20),
 fecha datetime);
 
 create table usuario(
 id_usuario int not null,
 name1 varchar(15),
 password1 varchar(15));
 
 create table servicio(
 id_servicio int not null,
 hora varchar(10),
 estado_servicio varchar(12),
 fecha_ingreso date,
 fecha_salida date,
 fk_tiposervicio int);	
 
 create table aud_servicio(
 hora varchar(10),
 estado_servicio varchar(12),
 fecha_ingreso date,
 fecha_salida date,
 fk_tiposervicio int,
 operacion varchar(22)
 ,fecha datetime);
 

 create table pedido(
 id_pedido int not null,
 cantidad int,
 precio int);
 
 create table aud_pedido(
 cantidad int,
 precio int,
 operacion varchar(30),
 fecha datetime);
 
 
 create table atencion(
id_atencion int not null, 
fk_idempleado int not null, 
fk_idservicio int not null,
codigo int );

create table tipo_servicio(
id_tiposervicio int not null,
nombre_servicio varchar(25),
costo int

);

create table cliente(
id_cliente int not null,
nombre1 varchar(15), 
nombre2 varchar(15),
apellido1 varchar(15),
apellido2 varchar(15),
 cedula int,
 telefono varchar(12));

create table detalle_servicio(
id_detalleservicio int not null,
fk_idservicio int not null,
fk_idequipo int not null,
codigo int);

create table equipo(
id_equipo int not null,
marca varchar(15),
modelo varchar(30)
);


create table detalle(
id_detalle int not null,
fk_detalleservicio int,
codigo int);


create table factura(
id_factura int not null, 
fk_detalle int, 
fecha_expedicion datetime,
total_pagar int,
fk_idcliente int
);

create table detalle_pedido2(
id_detallepedido int not null, 
fk_idpedido int, 
fk_idproducto int);





create table producto(
id_producto int not null,
nombre_producto varchar(20),
cantidad_producto int,
valor int
);


create table proveedor(
id_proveedor int not null,
nombre_completo varchar(50),
nombre_empresa varchar(25),
direccion varchar(30),
nit int,
telefono varchar(12)
);

create table detalle_proveedor(
id_detalleproveedor int not null,
fk_idproveedor int ,
fk_idproducto int,
codigo int );

alter table empleado add primary key(id_empleado);
alter table usuario add primary key(id_usuario);
alter table pedido add primary key(id_pedido);
alter table servicio add primary key(id_servicio);
alter table tipo_servicio add primary key(id_tiposervicio);
alter table detalle add primary key(id_detalle);
alter table atencion add primary key(id_atencion);
alter table detalle_servicio add primary key(id_detalleservicio);
alter table equipo add primary key(id_equipo);
alter table cliente add primary key(id_cliente);
alter table factura add primary key(id_factura);
alter table producto add primary key(id_producto);
alter table proveedor add primary key(id_proveedor);
alter table detalle_pedido2 add primary key(id_detallepedido);
alter table detalle_proveedor add primary key(id_detalleproveedor);

alter table empleado  add constraint fk_usuario foreign key(fk_usuario ) references usuario(id_usuario);
alter table atencion  add constraint fk_empleado foreign key(fk_idempleado ) references empleado(id_empleado);


alter table atencion  add constraint fk_servicio foreign key(fk_idservicio ) references servicio(id_servicio);
alter table servicio  add constraint fk_tiposervicio foreign key(fk_tiposervicio ) references tipo_servicio(id_tiposervicio);
alter table detalle_servicio  add constraint fk_servicio1 foreign key(fk_idservicio ) references servicio(id_servicio);

alter table detalle_servicio  add constraint fk_equipo12 foreign key(fk_idequipo ) references equipo(id_equipo);

alter table detalle add constraint fk_dservicio foreign key(fk_detalleservicio ) references detalle_servicio(id_detalleservicio);
alter table factura  add constraint fk_factu foreign key(fk_idcliente ) references cliente(id_cliente);
alter table factura add constraint fk_detalle foreign key(fk_detalle ) references detalle(id_detalle);
alter table detalle_proveedor  add constraint fk_proveedor foreign key(fk_idproveedor ) references proveedor(id_proveedor);
alter table detalle_proveedor add constraint fk_producto1 foreign key(fk_idproducto ) references producto(id_producto);
alter table detalle_pedido2  add constraint fk_pedido12 foreign key(fk_idpedido ) references pedido(id_pedido);
alter table detalle_pedido2 add constraint fk_producto121 foreign key(fk_idproducto ) references producto(id_producto);



alter table servicio add constraint ck_servicio CHECK(estado_servicio in ('terminado','enproceso','cancelado'));



drop procedure if exists insert_empleado;
delimiter $$ 
create procedure insert_empleado (nombre1 varchar(15), nombre2 varchar(15),apellido1 varchar(15),
apellido2 varchar(15),cedula int, edad int, cargo varchar(15), salario int,  telefono varchar(12),
 fk_usuario int) begin
 declare
 id INT DEFAULT ( SELECT count( id_empleado ) + 1 FROM empleado );
 declare 
 val int default(select id_empleado from empleado as e where e.CEDULA = cedula);
 if	
 (val is null) then
 insert into empleado
 values(
 id,
 nombre1,
 nombre2,
 apellido1,
 apellido2,
 cedula,
 edad,
 cargo,
 salario,
 telefono,
 fk_usuario
 );
 end if;
 end;
 $$ delimiter ;
 

 
 create trigger insertar_empleado after insert 
on empleado
for each row
insert into aud_empleado(nombre1,nombre2 ,apellido1,apellido2 ,cedula , edad , cargo, salario , telefono ,
fk_usuario , operacion , fecha )
values(new.nombre1,new.nombre2 ,new.apellido1,new.apellido2 ,new.cedula , new.edad , new.cargo, new.salario , new.telefono ,
new.fk_usuario ,'NUEVO EMPLEADO', now());

 create trigger update_empleado after update 
on empleado
for each row
insert into aud_empleado(nombre1,nombre2 ,apellido1,apellido2 ,cedula , edad , cargo, salario , telefono ,
fk_usuario , operacion , fecha )
values(new.nombre1,new.nombre2 ,new.apellido1,new.apellido2 ,new.cedula , new.edad , new.cargo, new.salario , new.telefono ,
new.fk_usuario ,'ACTUALIZACION INFORMACION', now());

create trigger eliminar_empleado before delete 
on empleado
for each row
insert into aud_empleado(nombre1,nombre2 ,apellido1,apellido2 ,cedula , edad , cargo, salario , telefono ,
fk_usuario , operacion , fecha )
values(old.nombre1,old.nombre2 ,old.apellido1,old.apellido2 ,old.cedula , old.edad , old.cargo, old.salario , old.telefono ,
old.fk_usuario ,'TERMINACION DE CONTRATO', now());
 
 drop procedure if exists insert_usuario;
delimiter $$ 
create procedure insert_usuario ( name1 varchar(15), password1 varchar(15)) begin
 declare
 id INT DEFAULT ( SELECT count( id_usuario ) + 1 FROM usuario );
 declare 
 val int default(select id_usuario from usuario as t where t.PASSWORD1 = password1);
 if	
 (val is null) then
 insert into usuario
 values(
 id,
 name1,
password1
 );
 end if;
 end;
 $$ delimiter ;
 
 
  drop procedure if exists insert_servicio;
delimiter $$ 
create procedure insert_servicio ( hora varchar(10),
 estado_servicio varchar(12),fecha_ingreso date,fecha_salida date,fk_tiposervicio int) begin
 declare
 id INT DEFAULT ( SELECT count( id_servicio) + 1 FROM servicio );
 declare 
 val int default(select id_servicio from servicio as t where t.HORA= hora);
 if	
 (val is null) then
 insert into servicio
 values(
 id,
 hora,
 estado_servicio ,
 fecha_ingreso ,
 fecha_salida ,
 fk_tiposervicio
 );
 end if;
 end;
 $$ delimiter ;
 
 
  create trigger insertar_servicio after insert 
on servicio
for each row
insert into aud_servicio( hora ,estado_servicio ,fecha_ingreso ,fecha_salida, fk_tiposervicio,operacion,fecha  )
values( new.hora ,new.estado_servicio ,new.fecha_ingreso ,new.fecha_salida, new.fk_tiposervicio,'NUEVO servicio', now());

 create trigger update_servicio after update 
on servicio
for each row
insert into aud_servicio( hora ,estado_servicio ,fecha_ingreso ,fecha_salida, fk_tiposervicio,operacion,fecha  )
values( new.hora ,new.estado_servicio ,new.fecha_ingreso ,new.fecha_salida, new.fk_tiposervicio,'Actualizar servicio', now());

create trigger eliminar_servicio before delete 
on servicio
for each row
insert into aud_servicio( hora ,estado_servicio ,fecha_ingreso ,fecha_salida, fk_tiposervicio,operacion,fecha  )
values( old.hora ,old.estado_servicio ,old.fecha_ingreso ,old.fecha_salida, old.fk_tiposervicio,'Eliminar servicio', now());
 
 drop procedure if exists insert_atencion;
delimiter $$ 
create procedure insert_atencion ( codigo int ) begin
 declare
 id INT DEFAULT ( SELECT count( id_atencion ) + 1 FROM atencion );
 declare
 id1 INT DEFAULT ( SELECT count( fk_idempleado ) + 1 FROM atencion );
 declare 
 id2 INT DEFAULT ( SELECT count( fk_idservicio ) + 1 FROM atencion );
 declare 
 val int default(select id_atencion from atencion as t where t.CODIGO = codigo);
 if	
 (val is null) then
 insert into atencion
 values(
id,
id1 , 
id2,
codigo
 );
 end if;
 end;
 $$ delimiter ;

  drop procedure if exists insert_tiposervicio;
delimiter $$ 
create procedure insert_tiposervicio ( nombre_servicio varchar(25),costo int
) begin
 declare
 id INT DEFAULT ( SELECT count( id_tiposervicio ) + 1 FROM tipo_servicio );
 declare 
 val int default(select id_tiposervicio from tipo_servicio as t where t.NOMBRE_SERVICIO= nombre_servicio);
 if	
 (val is null) then
 insert into tipo_servicio
 values(
 id,
nombre_servicio ,
costo 
 );
 end if;
 end;
 $$ delimiter ;
  
  drop procedure if exists insert_cliente;
delimiter $$ 
create procedure insert_cliente ( nombre1 varchar(15), nombre2 varchar(15),
apellido1 varchar(15),apellido2 varchar(15),cedula int,telefono varchar(12)) begin
 declare
 id INT DEFAULT ( SELECT count( id_cliente ) + 1 FROM cliente );
 declare 
 val int default(select id_cliente from cliente as t where t.CEDULA = cedula);
 if	
 (val is null) then
 insert into cliente
 values(
 id,
nombre1 , 
nombre2 ,
apellido1 ,
apellido2 ,
 cedula ,
 telefono 
 );
 end if;
 end;
 $$ delimiter ;

  drop procedure if exists insert_detalleservicio;
delimiter $$ 
create procedure insert_detalleservicio ( codigo int  ) begin
 declare
 id INT DEFAULT ( SELECT count( id_detalleservicio ) + 1 FROM detalle_servicio );
  declare
 id1 INT DEFAULT ( SELECT count( id_detalleservicio ) + 1 FROM detalle_servicio );
 declare 
 id2 INT DEFAULT ( SELECT count( id_detalleservicio ) + 1 FROM detalle_servicio );
 declare 
 val int default(select id_detalleservicio from detalle_servicio as t where t.CODIGO = codigo);
 if	
 (val is null) then
 insert into detalle_servicio
 values(
id,
id1,
id2,
codigo 
 );
 end if;
 end;
 $$ delimiter ;
 
  
 drop procedure if exists insert_equipo;
delimiter $$ 
create procedure insert_equipo ( marca varchar(15),modelo varchar(30)  ) begin
 declare
 id INT DEFAULT ( SELECT count( id_equipo ) + 1 FROM equipo );
 declare 
 val int default(select id_equipo from equipo as t where t.MODELO= modelo);
 if	
 (val is null) then
 insert into equipo
 values(
id,
marca ,
modelo 
 );
 end if;
 end;
 $$ delimiter ;

 
  drop procedure if exists insert_factura;
delimiter $$ 
create procedure insert_factura (  fk_detalle int, fecha_expedicion date,total_pagar int, fk_idcliente int ) begin
 declare
 id INT DEFAULT ( SELECT count( id_factura ) + 1 FROM factura );
 declare 
 val int default(select id_factura from factura as t where t.FECHA_EXPEDICION = fecha_expedicion);
 if	
 (val is null) then
 insert into factura
 values(
id,
fk_detalle , 
fecha_expedicion ,
total_pagar,
fk_idcliente 
 );
 end if;
 end;
 $$ delimiter ;

 
 drop procedure if exists insert_pedido;
delimiter $$ 
create procedure insert_pedido (  cantidad int,precio int ) begin
 declare
 id INT DEFAULT ( SELECT count( id_pedido ) + 1 FROM pedido );
 declare 
 val int default(select id_pedido from pedido as t where t.PRECIO = precio);
 if	
 (val is null) then
 insert into pedido
 values(
id,
cantidad,
precio
 );
 end if;
 end;
 $$ delimiter ;



create trigger insertar_pedido after insert 
on pedido
for each row
insert into aud_pedido( cantidad ,precio ,operacion ,fecha  )
values( new.cantidad,new.precio ,'NUEVO PEDIDO', now());

 create trigger update_pedido after update 
on pedido
for each row
insert into aud_pedido( cantidad ,precio ,operacion ,fecha  )
values( new.cantidad,new.precio ,'ACTUALIZACION PEDIDO', now());

create trigger eliminar_pedido before delete 
on pedido
for each row
insert into aud_pedido( cantidad ,precio ,operacion ,fecha  )
values( old.cantidad,old.precio ,'CANCELACION PEDIDO', now());


 
 drop procedure if exists insert_detalle;
delimiter $$ 
create procedure insert_detalle (    codigo int ) begin
 declare
 id INT DEFAULT ( SELECT count( id_detalle ) + 1 FROM detalle );
 declare 
 id1 INT DEFAULT ( SELECT count( id_detalle ) + 1 FROM detalle );
 declare 
 val int default(select id_detalle from detalle as t where t.CODIGO = codigo);
 if	
 (val is null) then
 insert into detalle
 values(
id,
id1,
codigo
 );
 end if;
 end;
 $$ delimiter ;
 
   drop procedure if exists insert_producto;
delimiter $$ 
create procedure insert_producto (  nombre_producto varchar(20),cantidad_producto int,valor int) begin
 declare
 id INT DEFAULT ( SELECT count( id_producto ) + 1 FROM producto );
 declare 
 val int default(select id_producto from producto as t where t.NOMBRE_PRODUCTO = nombre_producto);
 if	
 (val is null) then
 insert into producto
 values(
id,
nombre_producto ,
cantidad_producto ,
valor
 );
 end if;
 end;
 $$ delimiter ;
 

     drop procedure if exists insert_proveedor;
delimiter $$ 
create procedure insert_proveedor ( nombre_completo varchar(50),nombre_empresa varchar(25),direccion varchar(30),nit int,telefono varchar(12)) begin
 declare
 id INT DEFAULT ( SELECT count( id_proveedor ) + 1 FROM proveedor );
 declare 
 val int default(select id_proveedor from proveedor as t where t.NOMBRE_EMPRESA = nombre_empresa);
 if	
 (val is null) then
 insert into proveedor
 values(
id,
nombre_completo ,
nombre_empresa ,
direccion ,
nit,
telefono 
 );
 end if;
 end;
 $$ delimiter ;
 
 
   drop procedure if exists insert_detalleproveedor;
delimiter $$ 
create procedure insert_detalleproveedor ( codigo int ) begin
 declare
 id INT DEFAULT ( SELECT count( id_detalleproveedor ) + 1 FROM detalle_proveedor );
 declare
 id1 INT DEFAULT ( SELECT count( id_detalleproveedor ) + 1 FROM detalle_proveedor );
 declare
 id2 INT DEFAULT ( SELECT count( id_detalleproveedor ) + 1 FROM detalle_proveedor );
 declare 
 val int default(select id_detalleproveedor from detalle_proveedor as t where t.CODIGO= codigo);
 if	
 (val is null) then
 insert into detalle_proveedor
 values(
id,
id1 ,
id2,
codigo 
 );
 end if;
 end;
 $$ delimiter ;
 
 call insert_usuario('tecnico','tec123');
  call insert_usuario('tecnico','tec124');
 call insert_empleado('fabian','alfredo','forero ','gomez',123214,21,'tecnico',200000,'312-345-2323',1);
  call insert_empleado('fabian','alfredo','forero ','gomez',12214,21,'tecnico',200000,'312-345-2323',2);
call insert_tiposervicio('formateo',40000);
 call insert_tiposervicio('instalacion',20000);
 call insert_servicio('4:30 pm','terminado','2017-01-01','2017-01-02',1);
 call insert_servicio('4:10 pm','terminado','2017-01-01','2017-01-02',2);
 call insert_servicio('4:11 pm','terminado','2017-01-01','2017-01-02',2);
 call insert_atencion(21);
 call insert_atencion(22);
 call insert_equipo('accer','a1 234');
 call insert_equipo('accer','a1 232');
 call insert_equipo('accer','a1 2322');
 call insert_detalleservicio(111);
  call insert_detalleservicio(13);
 call insert_detalle(12);
 call insert_detalle(13);
 call insert_cliente('juan',null,'pepe',null,2132,'3124567890');
 call insert_cliente('juan',null,'pepe',null,22332,'3124567890');
 call insert_factura(1,'2017-01-01',2300000,1);
  call insert_factura(2,'2017-02-01',200000,2);
  call insert_pedido(12,30000);
  call insert_pedido(11,3000);
  call insert_producto('disco duro',2,300000);
  call insert_producto('tinta',2,300000);
   INSERT Into detalle_pedido2 values(1,1,1);
    INSERT Into detalle_pedido2 values(2,2,2);
  call insert_proveedor('jorge luis', 'lol','calle22',12313,'313-345-3333');
   call insert_proveedor('jorge luigon', 'lol2','calle 222',122113,'313-345-1233');
   call insert_detalleproveedor(1);
   call insert_detalleproveedor(2);
  
 
 create view ver_empleado as
 select * from empleado;
 

 
 select  * from ver_empleado;

 
select * from aud_empleado;
select * from aud_pedido;
select * from usuario;
select * from servicio;
select * from tipo_servicio;
select * from atencion;
select * from cliente;
select * from equipo;
select * from detalle_servicio;
select * from detalle;
select * from factura;
select * from pedido;
select * from detalle_pedido2;
select * from producto;
select * from proveedor;
select * from detalle_proveedor;
