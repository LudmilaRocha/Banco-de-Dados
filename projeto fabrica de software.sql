create schema db_fabrica;
use db_fabrica;

create table tb_login(
id int auto_increment not null,
nome varchar(35),
email varchar(60),
senha varchar(15),
id_escola int not null,
primary key(id),
constraint foreign key(id_escola) references tb_escola(id) on delete cascade on update cascade
);

create table tb_escola(
id int auto_increment not null,
nome varchar(40),
primary key (id)
);

create table tb_materia(
id int auto_increment not null,
nome varchar(20),
primary key (id)
);

create table tb_pergunta(
id int auto_increment not null,
descricao varchar(200),
gabarito char(1),
id_materia int not null,
primary key (id),
constraint foreign key(id_materia) references tb_materia(id) on delete cascade on update cascade
);

create table tb_resposta(
id int auto_increment not null,
letra char(1),
descricao varchar(50),
id_pergunta int not null,
primary key (id),
constraint foreign key(id_pergunta) references tb_pergunta(id) on delete cascade on update cascade
);

create table tb_resposta_usuario(
id int auto_increment not null,
id_login int not null,
id_pergunta int not null,
resposta char(1),
primary key (id),
constraint foreign key(id_login) references tb_login(id) on delete cascade on update cascade,
constraint foreign key(id_pergunta) references tb_pergunta(id) on delete cascade on update cascade
);

create table tb_pontuacao(
id int auto_increment not null,
id_login int not null,
pontuacao int(10),
data date not null,
primary key (id),
constraint foreign key(id_login) references tb_login(id) on delete cascade on update cascade
);

insert into tb_