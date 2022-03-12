create database if not exists aulaBD;
Use aulaBD;

create table Cliente (
ID_Cliente int not null auto_increment,
nome varchar(30),
endereco varchar(40),
cidade varchar (30),
telefone varchar(11) check(length(telefone)>=10),
tipo varchar(10),
primary key (ID_Cliente)
);


create table Empresa (
ID_Empresa int not null auto_increment,
CNPJ varchar(30),
nome varchar(20),
endereco varchar(40),
cidade varchar (30),
telefone varchar(11) check(length(telefone)>=10),
primary key (ID_Empresa)
);
 

create table Cliente_Empresa(
ID_Cliente int not null,
ID_Empresa int not null,
primary key (ID_Cliente, ID_Empresa),
constraint foreign key (ID_Cliente) references Cliente(ID_Cliente) on delete cascade on update cascade,
constraint foreign key (ID_Empresa) references Empresa(ID_Empresa) on delete cascade on update cascade
);


create table Produto(
ID_Produto int not null auto_increment,
nome varchar(20) not null,
qnt_vendida int,
valor decimal(7,2),
total_produzido int,
primary key (ID_Produto)
);


create table Produto_Empresa(
ID_Produto int not null,
ID_Empresa int not null,
primary key (ID_Produto, ID_Empresa),
constraint foreign key (ID_Produto) references Produto(ID_Produto) on delete cascade on update cascade,
constraint foreign key (ID_Empresa) references Empresa(ID_Empresa) on delete cascade on update cascade
);

create table Produto_Comprado_Cliente(
ID_Produto int not null,
ID_Cliente int not null,
quantidade int,
primary key (ID_Produto, ID_Cliente),
constraint foreign key (ID_Produto) references Produto(ID_Produto) on delete cascade on update cascade,
constraint foreign key (ID_Cliente) references Cliente(ID_Cliente) on delete cascade on update cascade
);

insert into Empresa(CNPJ, nome, endereco,cidade,telefone)
values ("111", "empresa1", "Av. Um, 123","Uberlândia","3412345678"),
("112","empresa2","Av. Dois, 1123","Uberlândia","3412345658"),
("113","empresa3","Av. Um, 1233","Uberlândia","3412315678"),
("114","empresa4","Av. Dois, 1323","Uberlândia","3422345678"),
("115","empresa5","Av. Três, 1283","Uberlândia","3416545678");


insert into Cliente (nome, endereco, cidade, telefone, tipo)
values ("Ana Ribeiro", "Rua 1, 234", "Uberlândia", "3432221111","varejista"),
("Leandro Silva", "Rua 1, 1234", "Uberlândia", "3432223111","varejista"),
("José Santos", "Rua 10, 2234", "Uberlândia", "3432221431","atacadista"),
("Maria Custódio", "Rua 3, 734", "Uberlândia", "3432111111","varejista"),
("Gabriel Machado", "Rua 7, 2334", "Uberlândia", "3432229811","varejista"),
("Carol Oliveira", "Rua 15, 2534", "Uberlândia", "3432223411","atacadista");



insert into Produto (nome, qnt_vendida,valor,total_produzido)
values ("p1",10,120,90),
("p2",15,60,85),
("p3",34,70,100),
("p4",32,170,110),
("p5",100,200,200),
("p6",30,350,230);


insert into Cliente_Empresa
values (1,1),
(3,1),
(2,3),
(2,2),
(4,1),
(5,5),
(3,4);

insert into Produto_Empresa
values (1,2),
(2,1),
(3,4),
(4,5),
(5,5),
(6,3);

insert into Produto_Comprado_Cliente
values (1,2,5),
(1,1,5),
(2,3,8),
(2,5,7),
(3,4,30),
(3,5,4),
(4,3,32),
(5,5,100),
(6,1,15),
(6,2,15);


select * from Cliente;
/exercicio1/
select nome, endereco from Empresa;
/exercicio2/
select  COUNT(*) AS QuantidadeProdutos from Produto where valor < 500;
/exercicio3/
select nome, valor  from Produto where total_produzido > 100;
/exercicio4/
select distinct ID_Produto from produto_comprado_cliente;

/exercicio5/
select avg(quantidade) as media from Produto_Comprado_Cliente;


/07/10/2021/
/*exercicio1: Dê o comando que liste o nome das empresas 
e de seus respectivos produtos.
*/
select e.nome as Empresa, p.nome as Produto from Empresa e, Produto p, Produto_Empresa pe where e.ID_Empresa=pe.ID_Empresa and p.ID_Produto=pe.ID_Produto;

/*exercicio2: Dê o comando que liste a quantidade de itens 
comprados por cada cliente.*/

select c.nome as Cliente, sum(pcc.quantidade) as QttComprada  from Cliente c, Produto_Comprado_Cliente pcc where c.ID_Cliente = pcc.ID_Cliente group by c.ID_Cliente;
/*3) Dê o comando que liste o valor gasto por cada 
cliente na compra de cada produto.*/
select c.nome as Cliente, p.nome as Produto , sum(pcc.quantidade*p.valor) as ValorGasto
from Cliente c, Produto p, Produto_Comprado_Cliente pcc 
where c.ID_Cliente=pcc.ID_Cliente and p.ID_Produto=pcc.ID_Produto group by p.ID_Produto;

/Exercicio1/
/*A)Crie uma visão, para o esquema de tabelas apresentado, que 
contenha uma relação entre o nome das empresas, os 
produtos produzidos por elas e seus valores.*/

create view RelacaoProdutosEmpresa as select e.nome as Empresa, p.nome as Produto, p.valor as ValorProduto
from produto p, empresa e, produto_empresa pe where p.ID_Produto = pe.ID_Produto and
e.ID_Empresa = pe.ID_Empresa;

/*B)Consulte a visão criada apresentando a quantidade de tipos 
produtos produzidos por cada empresa.*/

select r.empresa, count(*) as QntTipoProdutos from
relacaoprodutosempresa r group by r.empresa;

/exercicio2 visao/
/*A)Crie uma visão, para o esquema de tabelas apresentado, que 
apresenta uma relação entre as empresas e seus clientes, 
tendo na visão os IDs das empresas e dos clientes, além de 
seus respectivos nomes.*/

create view RelacaoClienteEmpresa as select c.ID_Cliente, c.nome as Cliente, e.ID_Empresa, e.nome as Empresa
from cliente c, empresa e, cliente_empresa ce where c.ID_Cliente = ce.ID_Cliente and
e.ID_Empresa = ce.ID_Empresa;
/*B)Consulte a visão criada apresentando a quantidade de clientes 
de cada empresa.*/
select r.empresa, count(*) as QntCliente from relacaoclienteempresa r group by r.id_empresa;
/*Exercício 3
A)Crie uma visão, para o esquema de tabelas apresentado, que 
apresente o nome dos produtos e a quantidade de cada 
produto em estoque.*/
create view QntProdutoEstoque as select p.nome as Produto, (p.total_produzido-p.qnt_vendida) as QntEmEstoque
from produto p;

select q.produto from qntprodutoestoque q where q.qntemestoque >= 80;



/*Trigger*/
create table Log(
id integer auto_increment,
dataLog datetime,
obs varchar(50),
tabela varchar(20),
atributo varchar(20),
constraint primary key(id)
);

delimiter $$
CREATE TRIGGER VerificaValor
AFTER INSERT 
ON Produto
FOR EACH ROW
BEGIN
if (NEW.valor < 0) then
INSERT INTO Log
SET
datalog = now(),
obs = "Valor do produto inválido",
tabela="Produto",
atributo="valor";
END IF;
END;$$

 insert into produto (nome, qnt_vendida,valor,total_produzido) values ('novo produto',0,-10,100);

delimiter $$
CREATE TRIGGER VerificaProducao
BEFORE UPDATE
ON Produto
FOR EACH ROW
BEGIN
if (NEW.total_produzido < OLD.total_produzido) then
SET NEW.total_produzido = OLD.total_produzido;
END IF;
END;$$
select * from produto;
SET SQL_SAFE_UPDATES = 0;
update produto set total_produzido = -10 where nome = 'p3';
update produto set total_produzido = -10 where nome = 'p2';

delimiter $$
CREATE TRIGGER ControleDelete
BEFORE DELETE
ON Produto 
FOR EACH ROW
BEGIN
DELETE FROM produto 
WHERE ID_Produto = -1; /*Altera o comando de deleção atribuindo o ID a um ID que não 
existe, logo a deleção não ocorrerá*/
END;$$

delimiter $$
CREATE TRIGGER VerificacaoCliente
BEFORE UPDATE
ON Produto
FOR EACH ROW
BEGIN
if (NEW.total_produzido < OLD.total_produzido) then
SET NEW.total_produzido = OLD.total_produzido;
END IF;
END;$$

/Exercicio1: Aula: 28/10/2021/
select * from cliente;
select * from produto;

delimiter $$
CREATE TRIGGER VerificacaoClienteCidade
BEFORE insert
/antes da inserção a verificação deve ser realizada/
ON Cliente
FOR EACH ROW/cada registro executado o trigger será acionado/
BEGIN
/Verificação a inserção/
if (new.cidade = 'Curitiba') then
set new.tipo = 'atacadista';
end if;
end;$$

insert into Cliente (nome, endereco, cidade, telefone, tipo) 
values ( 'Antonio', 'Rua A', 'Curitiba', '11111111111', 'varejista');

/Exercicio2:/
/Verificando uma atualizao de registro onde n é alterado o cnpj/
select * from Empresa;
delimiter $$
CREATE TRIGGER VerificacaoCnpjs
BEFORE UPDATE
ON Empresa
FOR EACH ROW
BEGIN
if (NEW.CNPJ <> OLD.CNPJ) then
SET NEW.CNPJ = OLD.CNPJ;
END IF;
END;$$
/teste/
update Empresa  set CNPJ= '222' where  CNPJ= '111';
set sql_safe_updates=0;

/Exercicio 3:/

select * from Produto_Comprado_Cliente;
delimiter $$
CREATE TRIGGER VerificacaoProduto
BEFORE UPDATE
ON Produto_Comprado_Cliente
FOR EACH ROW
BEGIN
if (NEW.quantidade < OLD.quantidade) then
SET NEW.quantidade = OLD.quantidade;
END IF;
END;$$

update produto_comprado_cliente SET quantidade=1 where  id_cliente='1';

/Exercicio4/
select * from produto;
delimiter $$
CREATE TRIGGER VerificacaoTotalNegativo
BEFORE insert
ON Produto
FOR EACH ROW
BEGIN
if (new.total_produzido < 0) then
set new.total_produzido= 0;
end if;
end;$$

insert into Produto (nome, qnt_vendida, valor, total_produzido) values ('produtoB', 11, 10.00,  -10);
insert into Produto (nome, qnt_vendida, valor, total_produzido) values ('produtoA', 11, 10.00,  -10);
insert into Produto (nome, qnt_vendida, valor, total_produzido) values ('produtoC', 50, 20.00,  -20);

/*Exercício 5
● Crie um trigger que impeça a inserção de um cliente cujo tipo 
seja diferente de atacadista ou varejista. Se isso ocorrer o 
campo tipo deve ficar em branco.*/
select * from cliente;

delimiter $$
CREATE TRIGGER VerificacaoTipo2
BEFORE insert
ON Cliente
FOR EACH ROW
BEGIN
if (new.tipo <>'atacadista' and new.tipo <> 'varejista') then
set new.tipo= null;
end if;
end;$$
DROP trigger VerificacaoTipo2;
insert into Cliente (nome, endereco, cidade, telefone, tipo) values ('Pedro', 'Rua B', 'uberlandia', '3432323131', 'motorista');

/*Exercício 6
● Crie um trigger que impeça a atualização do campo cidade na 
tabela Empresa sem mudar também o campo endereço. Se 
isto ocorrer o campo endereço deve ficar em branco.*/

select * from Empresa;
delimiter $$
CREATE TRIGGER VerificacaoCidadeEndereco
BEFORE UPDATE
ON Empresa
FOR EACH ROW
BEGIN
if (NEW.cidade <> OLD.cidade and new.endereco = old.endereco) then
SET NEW.endereco = null;
END IF;
END;$$

update Empresa SET cidade='prata' where id_empresa=2;

/*7.Considere que o recurso on delete cascade não tenha sido 
usado na criação das tabelas e crie um trigger que seja ativado 
caso um cliente seja deletado da tabela Cliente, então os 
registros referentes a este cliente nas tabelas 
Produto_Comprado_Cliente e Cliente_Empresa também 
deverão ser deletados.*/
select * from Produto_Comprado_Cliente;
/id_cliente/
select * from cliente;
select * from Cliente_Empresa;


delimiter $$
CREATE TRIGGER PropagaDelecaoCliente
after DELETE
ON Cliente
FOR EACH ROW
BEGIN
DELETE FROM Produto_Comprado_Cliente
WHERE ID_Cliente = old.ID_Cliente;
DELETE FROM cliente_empresa
WHERE ID_Cliente = old.ID_Cliente;
END;$$

delete  from Cliente where ID_Cliente=1;

/*Banco de dados 3 Momento
data:09/11/2021
Anotações Indexes
Sempre uma publicação executa uma consulta utilizamos a condição where, aumentando a quantidade de registros
index organiza os itens das tabelas, armazenados em ordem alfabetica ou numéria, em um local chamado index
reduzir a taxa de acesso ao disco, a busca e pesquisa sera mais veloz
desvantagem: pode causa ineficiencia, atualização demoraria */
/exemplos/
select * from Produto;
select * from empresa;
create index ProdutoEmpresa on produto_empresa (id_empresa, 
id_produto);
 create index nomeEmpresa on Empresa (nome desc);
/*1) Crie um index que otimize a busca por clientes em função de 
seus tipos.
*/

select * from Cliente where tipo = 'varejista'; 
create index  tipoCliente on Cliente (tipo);


/2) Crie um index que otimize a busca pelos produtos mais caros./
select nome, valor from Produto order by valor desc;
select * from produto;
create index  valorProduto on Produto (valor desc);
/*3) Crie um index que otimize tanto a busca por empresas pelo seu 
id quanto pelo CNPJ.
*/
/verificar sempre duration se automatizou o banco em suas pesquisas/
select id_empresa, cnpj from empresa;
create index BuscaEmpresa on empresa (id_empresa, 
cnpj);
select * from empresa where id_empresa =1;
/4) Crie um index que otimize a busca pelo produto mais vendido/
select nome, qnt_vendida from produto order by qnt_vendida desc;
create index ProdutoMaisVendido on produto (qnt_vendida desc);

/correção/
select p.nome as ProdutoMaisVendido from Produto_Comprado_Cliente pcc, Produto p where p.Id_Produto = pcc.ID_Produto
and pcc.quantidade = (select max(quantidade) from Produto_Comprado_Cliente);
create index ProdutoMaisVendido on Produto_Comprado_Cliente (quantidade desc);