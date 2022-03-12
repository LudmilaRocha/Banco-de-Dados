create database if not exists bancoListaExercicios;

Use bancoListaExercicios;

create table Funcionarios(
CPF decimal(20) not null,
nome varchar(40),
cidade varchar(40),
telefone varchar (15) check(length(telefone) >= 8),
salario float,
funcao varchar(20),
primary key (CPF)
);

create table Editoras(
codigo int not null,
nome varchar(15),
cidade varchar(40),
contato varchar(30),
primary key(codigo)
);

create table Usuarios(
CPF decimal(20) not null,
nome varchar(40),
telefone varchar (15) check(length(telefone) >= 8),
cidade varchar(40),
primary key (CPF)
);


create table Autores(
codigo varchar(15) not null,
nome varchar(40),
nacionalidade varchar(30),
primary key(codigo)
);

create table Livros(
numero varchar(15) not null,
titulo varchar(80),
genero varchar(15),
edicao int,
ano_publicacao int,
CPF_funcionario_retira_Livro decimal(20),
codigo_editora int,
CPF_usuario_retira_livro decimal(20),
CPF_usuario_reserva_livro decimal(20),
primary key(numero),
constraint foreign key(CPF_funcionario_retira_Livro) references Funcionarios(CPF) on delete cascade on update cascade,
constraint foreign key(codigo_editora) references Editoras(codigo) on delete cascade on update cascade,
constraint foreign key(CPF_usuario_retira_livro) references Usuarios(cpf) on delete cascade on update cascade,
constraint foreign key(CPF_usuario_reserva_livro) references Usuarios(cpf) on delete cascade on update cascade,
constraint unique (titulo) /* Unique garante que o conteúdo da coluna será único para cada linha. Uma tabela pode ter várias chaves unique ou chaves candidatas. */
);

create table Livros_Autores(
numero_livro varchar(15) not null,
codigo_autor varchar(15) not null,
primary key(numero_livro, codigo_autor),
constraint foreign key(numero_livro) references Livros(numero) on delete cascade on update cascade,
constraint foreign key(codigo_autor) references Autores(codigo) on delete cascade on update cascade
);


insert into funcionarios
values (38162213416,'Ana Salles Azir','Ribeirão Preto','1521345178',1600,'Faxineiro'),
(30361290876,'Ademir José','Campinas','1422317865',2500,'Supervisor'),
(61254590871,'Lucia Vincentim','Salto','152131892',1500,'Bibliotecaria'),
(45678126513,'João Alberto','Itatiba','1723415671',1200,'Faxineiro'),
(32176254891,'Luís Henrique Talles','Campinas','1423176774',5000,'Gerente'),
(45318972643,'Francisco José Almeida','Indaiatuba','1623323114',1400, 'Atendente'),
(32178972643,'Fernando Almeida','Indaiatuba','1623323114',1200, 'Faxineiro');

insert into editoras
values (2134000,'Saraiva', 'São Paulo', '08003434'),
(2287000,'Eras','Brasília', '08002432'),
(3557000,'Summer','Curitiba','08002198'),
(6655000,'Pontos','São Paulo','08005600'),
(9898000,'Marks','Rio de Janeiro','08009000');

insert into usuarios 
values(10122010132, 'Maria de Lourdes Amaral', '35440089',NULL),
(19231123981, 'José Francisco de Paula','27219756','Rio de Janeiro'),
(70912147665, 'Luiza Souza Prado', '34559087',NULL),
(45399112114, 'Raquel Santos', '87603451', 'São Paulo'),
(22534776113, 'Ivete Medina Chernell','48170352', NULL);

insert into autores(nome, nacionalidade,codigo)
values('Ethevaldo Siqueira','Brasileira',85668900),
('Ana Lucia Jankovic Barduchi','Brasileira',77548854),
('Adélia Prado','Brasileira',55490076),
('Walter Isaacson','Americana',22564411),
('Steven K. Scott', 'Americana',90984133);


insert into livros
values(87659908,'Tecnologias que mudam nossa vida','tecnologia',2,2007,NULL,2134000,NULL,22534776113),
(67392217,'Empregabilidade-Competências Pessoais e Profissionais','administração',22,1977,61254590871,9898000,NULL,NULL),
(45112239,'Steve Jobs - a biografia','biografia',48,2011,NULL,2287000,22534776113,NULL),
(77680012,'A duração do dia', 'poesia',1,2010,NULL,2134000,10122010132,NULL),
(32176500,'Salomão - O homem mais rico que já existiu','romance',2,2011,45318972643,6655000,NULL,NULL),
(67554421,'Bagagem','poesia',5,1972,NULL,6655000,NULL,70912147665),
(10277843,'O Pelicano', 'romance',12,1984,NULL,2134000,NULL,NULL);

insert into livros_autores
values(10277843,55490076),
(32176500,90984133),
(45112239,22564411),
(67392217,77548854),
(67554421,55490076),
(77680012,55490076),
(87659908,85668900),
(10277843,85668900);


/1. Liste todos os dados dos autores./
select * from autores;

/2. Liste as funções que um funcionário pode exercer./
select funcao from Funcionarios;

/*3. Fazer uma busca pelos títulos de livros do gênero romance e dentre estes 
apresentar os que tenham ano de publicação anterior ao ano 2000.*/
select titulo from livros where ano_publicacao < 2000;

/*4. Insira o registro de um novo livro que não tenha sido reservado e nem retirado 
nenhum livro. Lembre-se que a inserção de um novo livro pode implicar na 
inserção de outros registros em outras tabelas referenciadas pelas chaves 
estrangeiras. Os dados como qual livro inserir podem ser definidos pelo aluno.
*/
insert into livros
values(84858485,'Harry Potter Pedra Filosofal','romance',2,2000,NULL,NULL,NULL,6655000);

SELECT * FROM LIVROS;

/5. Listar o nome dos autores e suas respectivas nacionalidades./
select nome, nacionalidade from autores;
/6. Apresentar a média dos salários dos funcionários em função de cada cidade./
select cidade, avg(salario) as MediaSalario from funcionarios group by cidade;

/7. Apresente as cidades com média salarial maior que 1000./
select R.cidade from (select cidade, avg(salario) as MediaSalario from funcionarios group by cidade) R where R.MediaSalario >1000 ;
select * from funcionarios;

/8. Listar o livro publicado mais recentemente./
select * from livros where ano_publicacao = 2011;
select * from livros;
/9. Apresentar a soma dos salários dos funcionários que moram em Campinas./
select * from funcionarios;
select sum(salario) as SomaSalarioFuncionario from funcionarios where cidade = "Campinas";
/*10. Apresentar a lista de funcionários ordenada em função do menor salário, 
apresentando o nome do funcionário e o valor do salário.*/
select nome, salario  from funcionarios salario order by salario asc;
/11. Listar a quantidade de funcionários que retiraram livros./
select * from livros;
select  count(CPF_funcionario_retira_livro) as QntRetiradaFuncionarios from livros;
/*12.Listar os títulos e gêneros dos livros que não estão reservados, mas que estão 
disponíveis.*/
select titulo, genero from livros where CPF_funcionario_retira_livro is null  and Cpf_usuario_retira_livro is null and CPF_usuario_reserva_livro is null;

/*13.Apresentar o nome dos funcionários que retiraram livros de autores estrangeiros, 
também apresente o nome do livro retirado e o nome da editora.*/
select * from livros;
select * from autores;
select * from livros_autores;
select * from funcionarios;
select * from editoras;
select f.nome AS NomeFuncionarioRetirada, l.titulo AS TituloLivroRetirada, e.nome AS NomeEditora
from livros l, autores a, livros_autores la, funcionarios f, editoras e
where l.CPF_funcionario_retira_Livro =  f.CPF  AND l.codigo_editora = e.codigo and
la.numero_livro = l.numero and la.codigo_autor = a.codigo and nacionalidade="Americana";


/14. Apresentar os usuários que retiraram livros de autores brasileiros./
select * from usuarios;
 select u.nome AS NomeUsuarioRetirada, l.titulo AS TituloLivroRetirada, e.nome AS NomeEditora
from livros l, autores a, livros_autores la, usuarios u, editoras e
where l.CPF_usuario_retira_livro =  u.CPF  AND l.codigo_editora = e.codigo and
la.numero_livro = l.numero and la.codigo_autor = a.codigo and nacionalidade="Brasileira";

/15.Apresentar a média de salários dos funcionários em relação a função ocupada./
select * from funcionarios;
select avg(salario) as MediaSalarialFuncao, funcao from funcionarios group  by funcao;
/16.Apresentar a quantidade de livros de cada autor./
select * from livros;
select * from autores;
select * from livros_autores;

select a.nome AS Autores, count(numero_livro) as QntLivros
from livros l, autores a, livros_autores la
where  la.numero_livro = l.numero and la.codigo_autor = a.codigo group by autores;

/17.Apresentar a editora com mais livros na base de dados. 2134000/
select * from livros;
select * from editoras;

select e.nome AS Editoras, count(l.codigo_editora) as QntLivros
from livros l, editoras e
where  l.codigo_editora = e.codigo  group by codigo_editora;
select R2.Editora from(
     select e.nome as Editora, count(*) as QntLivros from editoras e, livros l where e.codigo=l.codigo_editora group by e.codigo) R2 where R2.QntLivros = (select max(QntLivros) from (
		select e.nome as Editora, count(*) as QntLivros from editoras e, livros l where e.codigo=l.codigo_editora group by e.codigo)R3);


/18.Apresentar a quantidade de livros por edição./
select edicao, count(numero) as QntdeLivros from livros group by edicao;

/19.Apresentar a quantidade de livros publicados entre 1950 e 2010./
select * from livros where ano_publicacao between 1950 and 2010;
/20.Apresentar a quantidade de livros de cada editora./
select * from editoras;
select * from livros;
select * from livros_autores;
select e.nome AS Editoras, count(l.codigo_editora) as  QntLivros
from livros l, editoras e
where  l.codigo_editora = e.codigo  group by codigo_editora;

/*21. Liste o nome de todos os funcionários, e para aqueles que fizeram a retirada de 
algum livro, também apresente o nome do livro(s) retirados(s).*/
select f.nome, l.titulo from funcionarios f, livros l where f.CPF = l.CPF_funcionario_retira_Livro;
select * from funcionarios;
/22.Apresentar a quantidade de livros que estão disponíveis para reserva ou retirada./
select count(titulo) as LivrosDisponiveis, titulo from livros where CPF_usuario_reserva_livro is null and CPF_usuario_retira_livro is null and CPF_funcionario_retira_Livro is null group by titulo;
/*23.Liste o nome de todos os usuários, e para aqueles que possuem alguma reserva 
de livro, também apresente o nome do livro(s) reservado(s).*/
select * from usuarios;
select * from livros;

select u.nome, l.titulo  from livros l, usuarios u where  l.cpf_usuario_reserva_livro = u.cpf;

/*24. Atualize os registros de livros, de modo que os livros que estão reservados para 
um usuário, agora estejam como retirados e a reserva desapareça.*/
select * from livros;
select * from autores;
DELETE FROM livros
WHERE cpf_usuario_reserva_livro= 70912147665 and numero = 67554421;

Delete from livros where  cpf_usuario_reserva_livro= 22534776113 and numero = 87659908;

INSERT INTO livros 
VALUES (67554421,'Bagagem','poesia',5,1972,NULL,6655000,70912147665, NULL);
INSERT INTO livros values (87659908,'Tecnologias que mudam nossa vida','tecnologia',2,2007,NULL,2134000, 22534776113, NULL);


/*25.Apresentar uma lista dos funcionários com seus nomes, salários atuais e um novo 
salário que corresponde a um acréscimo de 20%.*/

select nome, salario, salario*0.2+salario as SalarioAtualizado from funcionarios;

/*26.Apague da tabela Livros, todos os registros de livros que não foram reservados e 
nem retirados por ninguém.*/
select * from livros;
Delete from livros where  cpf_usuario_reserva_livro is null and CPF_usuario_retira_livro is null and CPF_funcionario_retira_Livro is null;


/Lista 3/
/Questões/
/*1. Crie um trigger na tabela Usuário, que não permita alterar o CPF do usuário em
uma atualização. */
select * from usuarios;
delimiter $$
CREATE TRIGGER VerificacaoCpf
BEFORE UPDATE
ON Usuarios
FOR EACH ROW
BEGIN
if (NEW.CPF <> OLD.CPF) then
SET NEW.CPF = OLD.CPF;
END IF;
END;$$

update usuarios  set CPF= '10122010132' where  CPF= '111111111';
set sql_safe_updates=0;

/*2. Crie um trigger que não permita inserir registros na tabela Livros, caso o ano de
publicação seja superior ao ano corrente.*/
select * from livros;
delimiter $$
CREATE TRIGGER VerificacaoAno
BEFORE insert
ON Livros
FOR EACH ROW
BEGIN
if(new.ano_publicacao > year(current_date)) then
SET   new.ano_publicacao = null;
END IF;
END;$$

insert into livros
values(78787878,'Corvo','fantasia',2,2022,NULL,null,NULL,NULL);

DROP trigger  VerificacaoAno;

/*3. Crie um trigger que seja ativado na inserção de um novo funcionário na tabela
Funcionário, e caso o campo função não seja informado, o trigger deverá
preencher o campo com a informação “Novo contratado”.*/

select * from funcionarios;

delimiter $$
CREATE TRIGGER VerificacaoFuncionario
BEFORE insert
ON funcionarios
FOR EACH ROW
BEGIN
if(new.funcao  is null) then
SET  new.funcao = 'Novo contratado';
END IF;
END;$$

insert into  funcionarios values (7887787, 'J','Uberaba','125469998', 2500, null);


/*4. Crie um trigger que verifica o salário do funcionário antes de uma atualização. Se o
novo salário for menor que R$ 800,00, então será corrigido para 800. Se o salário
sofrer um aumento, este acréscimo não pode ser maior que 50% do valor atual.
Caso o aumento supere os 50%, então o valor do aumento deve ser reduzido para
50% do salário atual.*/

select * from funcionarios;

DROP trigger  VerificaSalario;

delimiter $$
CREATE TRIGGER SalarioVerificação
BEFORE UPDATE
ON funcionarios
FOR EACH ROW
BEGIN
if (NEW.salario < 800 ) then
SET NEW.salario = 800;
if (new.salario > 1.5 * old.salario) then
set new.salario = 1.5*old.salario;
END IF;
END IF;
END;$$


update funcionarios set salario = 300  where  CPF= '7887787';
set sql_safe_updates=0;
update funcionarios set salario = 1300  where  CPF= '7887787';
set sql_safe_updates=0;

/*5. Crie um trigger que não permita atualizar um registro na tabela Livro de modo que
um mesmo livro seja emprestado para um funcionário e para um usuário ao mesmo
tempo.
*/
drop trigger VerificaLivros;
select * from livros;

delimiter $$
CREATE TRIGGER VerificaLivros
BEFORE UPDATE
ON livros
FOR EACH ROW
BEGIN
if (new.cpf_usuario_retira_livro is not null and old.cpf_funcionario_retira_livro is not null ) then
SET NEW.cpf_usuario_retira_livro =null;
END IF;
if (old.cpf_usuario_retira_livro is not null and new.cpf_funcionario_retira_livro is not null ) then
SET NEW.cpf_funcionario_retira_livro =null;
END IF;
if ((old.cpf_usuario_retira_livro is not null and old.cpf_funcionario_retira_livro is not null) and (new.cpf_usuario_retira_livro is not null and new.cpf_funcionario_retira_livro is not null) ) then
SET NEW.cpf_funcionario_retira_livro =null;
END IF;
END;$$

update livros set cpf_funcionario_retira_livro = 61254590871 and cpf_usuario_retira_livro = 70912147665 where numero= '67392217';

/*6. Crie um trigger que não permita atualizar um registro na tabela Usuário de modo
que o campo telefone fique em branco. No caso em que o campo telefone esteja
em branco, o telefone deverá continuar sendo o mesmo do antigo registro.
*/

select * from usuarios;
delimiter $$
CREATE TRIGGER VerificaTelefone
BEFORE UPDATE
ON usuarios
FOR EACH ROW
BEGIN
if (NEW.telefone is null) then
SET NEW.telefone = old.telefone;
END IF;
END;$$

update usuarios set telefone = null  where  CPF= '19231123981';
set sql_safe_updates=0;

/*7. Crie uma visão que contenha uma listagem com o título, o gênero e o ano de 
publicação dos livros.
◦ Consulte a visão criada e apresente o título, o gênero da(s) publicação(ões) 
mais recentes.
*/
select * from livros;
CREATE VIEW LivrosMaisRecente AS
select titulo, genero, ano_publicacao
from livros
where ano_publicacao = (select max(ano_publicacao)
from livros);

select * from LivrosMaisRecente;

/*8. Crie uma visão que contenha uma lista dos títulos e gêneros dos livros que não 
estão reservados.
◦ Consulte a visão criada e contabilize quantos livros de cada gênero não foram 
reservados.*/


select * from livros;
CREATE VIEW LivrosNãoReservados AS
select titulo, genero
from livros
where cpf_usuario_reserva_livro  is not null;

select * from LivrosNãoReservados;
select count (genero) from LivrosNãoReservados where cpf_usuario_reserva_livro is null; 

/*9. Criar uma visão que contenha o nome dos funcionários que retiraram livros, o 
nome do livro retirado e o nome da editora.
◦ Consulte a visão criada e apresente o nome da editora que teve mais livros 
retirados por funcionários.*/
select * from funcionarios;
select * from livros;
select * from editoras;

CREATE VIEW VisaoFuncionarios AS
select f.nome AS  NomeFuncionarios, l.titulo AS NomeLivro, e.nome AS NomeEditora
from funcionarios f, livros l, editoras e
where f.cpf = l.cpf_funcionario_retira_livro AND
l.codigo_editora = e.codigo and l.cpf_funcionario_retira_livro is not null order by f.nome;

select R1.Editora, R1.QntLivroPorEditora 
from (
select Editor a, count (*) as QntLivroPorEditora
from VisaoFuncionarios group by Editora) R1 
where R1.QntLivroPorEditora = (select max(R2.QntLivroPorEditora)
from ( select Editora, count (*) as QntLivroPorEditora from LivroRetiradoFuncionario group by Editora) R2);

/*10. Crie uma visão que contenha uma relação da quantidade de livros por cada autor.
◦ Consulte a visão criada e apresente o autor que menos possui livros na base de
dados.*/

drop view VisaoAutorLivros;
create view VisaoAutorLivros as select a.nome AS Autores, count(a.codigo) as QntLivros
from livros l, autores a, livros_autores la
where la.numero_livro = l.numero and la.codigo_autor = a.codigo group by a.codigo;

select  Autores from VisaoAutorLivros where QntLivros = (select min(QntLivros) from VisaoAutorLivros);

/11. Crie um index que otimize a busca por livros na tabela Livros que foram publicados recentemente./



select titulo, ano_publicacao from livros order by ano_publicacao desc;
create index LivroRecente on livros (ano_publicacao desc);

/*
12. Crie um index que otimize a busca por livros em função de seus títulos. */
select * from livros;
select * from livros where titulo = 'Tecnologias que mudam nossa vida'; 
create index  tituloLivros on livros (titulo);

/13. Crie um index que otimize a busca por usuários que retiraram um livro./
select * from livros;

select * from livros where cpf_usuario_retira_livro = '22534776113';
SELECT * FROM livros WHERE cpf_usuario_retira_livro IS NOT NULL;
create index retiraLivros on livros (cpf_usuario_retira_livro);