create database ex05;

user ex05;

create table projeto(
	idprojeto INT PRIMARY KEY AUTO_INCREMENT,
	descricao varchar(50) NOT NULL
);

create table cargo(
	idcargo INT PRIMARY KEY AUTO_INCREMENT,
	descricao varchar(50) NOT NULL,
	salario FLOAT(10,2)
);

create table empregado(
	idempregado INT PRIMARY KEY AUTO_INCREMENT,
	nome varchar(50) NOT NULL,
	sexo ENUM("F","M") NOT NULL,
	idade INT NOT NULL,
	id_cargo INT,
	FOREIGN KEY(id_cargo)
	REFERENCES cargo(idcargo)
);

create table alocacao(
	idalocacao INT PRIMARY KEY AUTO_INCREMENT,
	data DATE NOT NULL,
	id_empregado INT ,
	id_projeto INT ,
	FOREIGN KEY(id_empregado)
	REFERENCES empregado(idempregado),
	FOREIGN KEY(id_projeto)
	REFERENCES projeto(idprojeto)
);

--INSERT PROJETO
insert into projeto values(null,'Reformulação de website');
insert into projeto values(null,'Implantação de sistema ERP');
insert into projeto values(null,'Instalação de rede WiFi');

--INSERT Cargo
insert into cargo values(null,'Analista de sistemas', 2000);
insert into cargo values(null,'Programador', 1500);
insert into cargo values(null,'Web Desginer', 1300);
insert into cargo values(null,'Analista de banco de dados', 5000);
insert into cargo values(null,'Analista de redes', 3000);

--INSERT EMPREGADO
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','João', 34,1);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','Pedro', 24,2);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'F','Maria', 23,2);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','José', 33,2);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'F','Laura', 36,1);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'F','Roberta', 22,3);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'F','Daniela', 26,2);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','Paulo', 26 , 4);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','Marcelo', 32,5);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','William', 35,5);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'M','Felipe', 42,3);
insert into empregado (idempregado,sexo,nome,idade,id_cargo) values(null, 'F','Larissa', 26,1);

--INSERT ALOCACAO
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,1, 1, '2013-04-10');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,1, 2, '2013-04-10');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,1, 12, '2013-04-10');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,1, 5, '2013-04-11');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,2, 1, '2013-04-11');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,2, 4, '2013-04-11');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,2, 7, '2013-04-11');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,2, 8, '2013-04-12');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,2, 9, '2013-04-12');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,3, 9, '2013-04-10');
insert into alocacao (idalocacao, id_projeto, id_empregado, data) values(null,3, 10, '2013-04-10');

Exercício 5
1) 
select t0.nome, t1.salario
from empregado t0
	INNER JOIN cargo t1 ON t0.id_cargo = t1.idcargo;

2)
select t0.nome, t1.salario
from empregado t0
	INNER JOIN cargo t1 ON t0.id_cargo = t1.idcargo
where t0.sexo = "F"
order by T1.salario DESC;

3)

select t0.nome, t1.descricao, t0.idade
from empregado t0
	INNER JOIN cargo t1 ON t0.id_cargo = t1.idcargo;

4)
select t0.nome
from empregado t0
	INNER JOIN alocacao t1 ON t0.idempregado = t1.id_empregado
where t1.id_projeto = 1;

5)
select t0.nome, t2.descricao
from empregado t0
	INNER JOIN alocacao t1 ON t0.idempregado = t1.id_empregado
	INNER JOIN cargo t2 ON t0.id_cargo = t2.idcargo
where t1.id_projeto = 2;

6)
select t0.idprojeto, t0.descricao, t2.nome
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado;

7)

select t0.idprojeto, t0.descricao, t2.idempregado, t2.nome, t3.descricao
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
	inner join cargo t3 ON t2.id_cargo = t3.idcargo;

8)

select t2.nome,t2.idade, t3.descricao,t3.salario,t1.data
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
	inner join cargo t3 ON t2.id_cargo = t3.idcargo
where t0.idprojeto = 3;

9)

select COUNT(*)
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
where t0.idprojeto = 1; --4 funcionários


select COUNT(*)
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
where t0.idprojeto = 2; -- 5 funcionários


select COUNT(*)
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
where t0.idprojeto = 3;  -- 2 funcionários

10)
select COUNT(*)
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
where t0.idprojeto = 1
GROUP BY t0.descricao; --4 funcionários


select COUNT(*)
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
where t0.idprojeto = 2
GROUP BY t0.descricao; -- 5 funcionários


select COUNT(*)
from projeto t0
	inner join alocacao t1 ON t0.idprojeto = t1.id_projeto
	inner join empregado t2 ON t1.id_empregado = t2.idempregado
where t0.idprojeto = 3
GROUP BY t0.descricao;  -- 2 funcionários