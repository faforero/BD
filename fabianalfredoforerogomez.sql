create database eventos;
use eventos;

create table evento(id_evento int primary key,nombre_evento varchar(30),
objetivo varchar(30),fecha date, hora varchar(10), lugar varchar(30), 
dirigido varchar(30));

create table costo(id_costo int primary key, cargo varchar(30),valor int);
alter table costo add column evento int;
alter table costo add constraint fk_evento_costo foreign key(evento) references evento(id_evento);

create table inscripcion(id_inscripcion int primary key, tipo varchar(30), cargo int,fecha_inscripcion date);

create table participante(id_participante int primary key,nombre varchar(30),apellido varchar(30),
cargo_par varchar(30));

create table ponente(id_ponente int primary key, nombre varchar(30),apellido varchar(30),ponencia int,evento int);

create table ponencia(id_ponencia int primary key, nombre_ponencia varchar(30));

create table jurado(id_jurado int primary key, nombre_completo varchar(60));

create table puntaje(id_puntaje int primary key,n_ponencia int,n_jurado int,puntaje int);

alter table inscripcion add constraint fk_costo_inscripcion foreign key(cargo) 
references costo(id_costo);

alter table ponente add constraint fk_ponencia_ponente foreign key(ponencia) 
references ponencia(id_ponencia);

alter table ponente add constraint fk_evento_ponenete foreign key(evento)
references evento(id_evento);

insert into evento values(1,'juridico','informativo',25/04/2017,'2:00pm','universidad amazonia','estudiantes');
insert into evento values(2,'eleccion','elegir rector',26/04/2017,'2:00pm','universidad amazonia','plantel universidad');

insert into costo values(1,'estudiante',10000);
insert into costo values(2,'docente',20000);
insert into costo values(3,'egresados',30000);

UPDATE costo set evento=1 where costo.id_costo=1;
UPDATE costo set evento=1 where costo.id_costo=2;
UPDATE costo set evento=2 where costo.id_costo=3;

insert into inscripcion values(1,'participante',1,12/04/2017);
insert into inscripcion values(2,'ponente',1,12/04/2017);
insert into inscripcion values(3,'participante',3,20/04/2017);

insert into ponencia values(1,'ingenieria de sistemas');
insert into ponencia values(2,'base de datos');

insert into ponente values(1,'fabian','forero',1,1);
insert into ponente values(2,'fabio','gomez',2,1);

insert into participante values(1,'leonel','messi','docente');
insert into participante values(2,'cristiano','ronaldo','egresado');

insert into jurado values(1,'jose mouriho');
insert into jurado values(2,'josep guardiola');

insert into puntaje values(1,1,1,100);
insert into puntaje values(2,1,2,80);

delimiter $$
create trigger update_puntaje before update on puntaje
for each row 
begin
if(new.puntaje >= old.puntaje)then
set new.puntaje=old.puntaje+new.puntaje;
end if;
end $$
delimiter ;


delimiter $$
create trigger insert_costo before insert on costo
for each row 
begin
if(new.cargo = 'estudiante')then
set new.valor=10000;
if(new.cargo = 'docente')then
set new.valor=20000;
if(new.cargo = 'egresado')then
set new.valor=30000;
end if;
end if;
end if;
end $$
delimiter ;

delimiter $$
create trigger insert_inscripcion before insert on inscripcion
for each row 
begin
if(new.fecha_inscripcion = evento.fecha)then
set new.fecha_inscripcion='error';
end if;
end $$
delimiter ;


create trigger insert_ponente before insert on ponente
for each row 
begin
if(new.nombre =ponente.nombre)then
 set message_text="valor excedido";
end if;

se desea conocer:

select id_evento, count(evento) PONENTE_POR_EVENTO from ponente 
inner join evento on(id_evento=ponente.evento) group by id_evento;

select id_evento EVENTO, sum(valor) RECAUDADO from costo
inner join evento on (id_evento=costo.evento) group by id_evento;


create table aud_inscripcion(
id_inscripcion int primary key, tipo varchar(30), cargo int,fecha_inscripcion date);
create trigger auditoria_inscripcion before insert on inscripcion
for each row
insert into aud_inscripcion values(new.id_inscripcion , new.tipo, 
new.cargo ,new.fecha_inscripcion,now(),'insert',current_user);

create view 
lol as
select id_evento EVENTO, ponente.nombre,ponente.apellido,jurado.nombre_completo JURADO,
max(puntaje.puntaje) puntos from puntaje
inner join evento on(evento.id_evento=puntaje.id_puntaje)
inner join ponente on(ponente.id_ponente=puntaje.id_puntaje)
inner join jurado on(jurado.id_jurado=puntaje.id_puntaje)
group by id_evento;