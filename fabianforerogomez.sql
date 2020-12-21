CREATE USER nota IDENTIFIED BY nota;

create table estudiante(
id int not null primary key,
estado varchar(15) ,pazysalvo varchar(2) not null
);


create table matricula(
id_matricula int not null primary key,
matricula_periodo int not null,promedio_semestre int,
promedio_acumulado int,fk_estudiante int not null
);

create table materia(
id_materia int not null primary key,
nom_materia varchar(45),
cod_materia int ,nota int,creditos int 
);

create table grupo(
id_grupo int not null primary key,
nombre_grupo varchar(40) ,
estado int,capacidad int ,cantidad int ,
fk_materia int not null
);


create table calificacion(
id_calificacion int not null primary key,
nota_final int,aprobo varchar(2),
fk_matricula int not null,
fk_grupo int not null
);



alter table matricula add constraint fk_estudiante_materia foreign key (fk_estudiante)
references estudiante(id);

alter table calificacion add constraint fk_matricula_calificacion foreign key (fk_matricula) 
references eatricula(id_matricula);

alter table grupo add constraint fk_materia_grupo foreign key (fk_materia) 
references materia(id_materia);

alter table calificacion add constraint fk_grupo_calificacion foreign key (fk_grupo)
 references grupo (id_grupo);

 create sequence incremento
 increment by 2
 start with 2

create or replace procedure insertar_nota(
nota numeric,
fk_mat int,
fk_grupo int
)
is
begin
	if (nota between 0 and 5) and (nota>=3) then
	insert into calificacion values	((select count(id_calificacion) from calificacion)+(incremento.NextVal), nota,'si',fk_mat,fk_grupo);
		else
	insert into calificacion values	((select count(id_calificacion) from calificacion), nota,'no',fk_mat,fk_grupo);
	end if;
end insertar_nota;


create trigger update_promedio
	before insert on calificacion
	for each row 
begin
update matricula set promedio_semestre=((old.nota_final*creditos)/count(materia.creditos));
end update_promedio;


create trigger insert_cantidad
before insert on matricula
for each row
begin
if( select capacidad from grupo)<=30 then
update grupo set new.capacidad=old.capacidad+1;
else
 estado set='excede estado';
 end if;
 end insert_cantidad;

create or replace procedure promedio_acumulado(
id int
)
is
begin
if(select fk_estudiante from matricula where fk_estudiante=id),
case when(select promedio_acumulado from matricula where PROMEDIO_SEMESTRE>=3)!=0 then
PROMEDIO_ACUMULADO=(old.promedio_semestre)
end if;
end promedio_acumulado;


insert into estudiante values(1,'activo','si');
insert into estudiante values(2,'activo','si');


insert into matricula values(1,1,3,4,1);
insert into matricula values(2,1,3,3,2);

insert into materia values(1,'programacion',111,3,5);
insert into materia values(2,'base de datos',112,3,2);


insert into materia values(1,'grupo1',1,30,5,1);
insert into materia values(2,'grupo2',2,30,2,2);

insert into materia values(1,3,'si',1,1);
insert into materia values(2,4, ,2,2);