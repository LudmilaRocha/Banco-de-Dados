/*Prova*/
create schema prova;
use prova;



create table Aluno(
codAluno int auto_increment  not null,
nomeAluno varchar(40),
idade varchar(40),
primary key (codAluno)
);

create table Disciplina(
codDisciplina int auto_increment,
nomeDisc varchar(35),
carga_horaria varchar(60),
primary key (codDisciplina)
);

create table Professor(
codProfessor int auto_increment not null,
nomeProf varchar(35),
titulo varchar(60),
primary key (codProfessor)
);


create table Matricula(
id int auto_increment,
cod_Aluno int,
cod_Disciplina int,
primary key (id),
constraint foreign key(cod_Aluno) references Aluno(codAluno) on delete cascade on update cascade,
constraint foreign key(cod_Disciplina) references Disciplina(codDisciplina) on delete cascade on update cascade
);


create table Ministra(
id int auto_increment,
sala varchar(3),
horario varchar(10),
cod_Professor int, 
cod_Disciplina int,
primary key(id),
constraint foreign key(cod_Professor) references Professor(codProfessor) on delete cascade on update cascade,
constraint foreign key(cod_Disciplina) references Disciplina(codDisciplina) on delete cascade on update cascade
);

/*Apresente o comando de criação de um index, considerando o esquema de tabelas apresentado nas instruções gerais desta prova. 
O index a ser criado deve otimizar a busca pelas disciplinas com maior carga horária.*/

create index MaiorCarga on Disciplina (carga_horaria desc);

/*Apresente o comando de criação de uma view, considerando o esquema de tabelas apresentado nas instruções gerais desta prova.
 A view a ser criada deve conter o nome dos professores e a quantidade de disciplinas que cada um ministra.*/
 
 

create view RelacaoProfessorDisciplina as select p.nomeProf AS NomeProfessores, count(codDisciplina) as QntDisciplinas
from Professor p, Disciplina d, ministra m 
where p.codProfessor = m.cod_Professor and d.codDisciplina = m.cod_Disciplina  group by codDisciplina;


/*Apresente o comando de criação de um trigger, considerando o esquema de tabelas apresentado nas instruções gerais desta prova. 
O trigger a ser criado não deve permitir que uma atualização na tabela Professor altere o campo codProfessor para um valor diferente do registrado na tabela.
*/


delimiter $$
CREATE TRIGGER VerificacaoCodProfessor
BEFORE UPDATE
ON Professor
FOR EACH ROW
BEGIN
if (NEW.codProfessor <> OLD.codProfessor) then
SET NEW.codProfessor = OLD.codProfessor;
END IF;
END;$$