--adicionando coluna bairro
alter table endereco
add bairro varchar(20);
--trocando Chave estrangeira dos inserts
INSERT INTO ENDERECO VALUES(NULL,'RUA GUEDES','B. HORIZONTE','MG',7,'CASCADURA');
INSERT INTO ENDERECO VALUES(NULL,'RUA MAIA LACERDA','RIO DE JANEIRO','RJ',8,'ESTACIO');
INSERT INTO ENDERECO VALUES(NULL,'RUA VISCONDESSA','RIO DE JANEIRO','RJ',9,'CENTRO');
INSERT INTO ENDERECO VALUES(NULL,'RUA NELSON MANDELA','RIO DE JANEIRO','RJ',10,'COPACABANA');
INSERT INTO ENDERECO VALUES(NULL,'RUA ARAUJO LIMA','VITORIA','ES',11,'CENTRO');
INSERT INTO ENDERECO VALUES(NULL,'RUA CASTRO ALVES','RIO DE JANEIRO','RJ',12,'LEBLON');
INSERT INTO ENDERECO VALUES(NULL,'AV CAPITAO ANTUNES','CURITIBA','PR',13,'CENTRO');
INSERT INTO ENDERECO VALUES(NULL,'AV CARLOS BARROSO','SAO PAULO','SP',14,'JARDINS');
INSERT INTO ENDERECO VALUES(NULL,'ALAMEDA SAMPAIO','CURITIBA','PR',15,'BOM RETIRO');
INSERT INTO ENDERECO VALUES(NULL,'RUA DA LAPA','SAO PAULO','SP',16,'LAPA');
INSERT INTO ENDERECO VALUES(NULL,'RUA GERONIMO','RIO DE JANEIRO','RJ',17,'CENTRO');
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','RIO DE JANEIRO','RJ',18,'CENTRO');
INSERT INTO ENDERECO VALUES(NULL,'RUA GOMES FREIRE','RIO DE JANEIRO','RJ',19,'CENTRO');


INSERT INTO TELEFONE VALUES(NULL,'RES','68976565',7);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99656675',7);
INSERT INTO TELEFONE VALUES(NULL,'CEL','33567765',9);
INSERT INTO TELEFONE VALUES(NULL,'CEL','88668786',9);
INSERT INTO TELEFONE VALUES(NULL,'COM','55689654',9);
INSERT INTO TELEFONE VALUES(NULL,'COM','88687979',10);
INSERT INTO TELEFONE VALUES(NULL,'COM','88965676',11);
INSERT INTO TELEFONE VALUES(NULL,'CEL','89966809',13);
INSERT INTO TELEFONE VALUES(NULL,'COM','88679978',14);
INSERT INTO TELEFONE VALUES(NULL,'CEL','99655768',15);
INSERT INTO TELEFONE VALUES(NULL,'RES','89955665',16);
INSERT INTO TELEFONE VALUES(NULL,'RES','77455786',17);
INSERT INTO TELEFONE VALUES(NULL,'RES','89766554',17);
INSERT INTO TELEFONE VALUES(NULL,'RES','77755785',18);
INSERT INTO TELEFONE VALUES(NULL,'COM','44522578',18);


Exercício 4

1)
Select T0.idcliente, T0.nome, T0.sexo, T0.email, T0.cpf, T1.rua, T1.bairro, T1.cidade, T1.estado, T2.tipo, T2.numero
FROM cliente T0
	INNER JOIN endereco T1 ON T0.idcliente = T1.id_cliente
	INNER JOIN telefone T2 ON T0.idcliente = T2.id_cliente;

2)
Select T0.idcliente, T0.nome, T0.sexo, T0.email, T0.cpf, T1.rua, T1.bairro, T1.cidade, T1.estado, T2.tipo, T2.numero
FROM cliente T0
	INNER JOIN endereco T1 ON T0.idcliente = T1.id_cliente
	INNER JOIN telefone T2 ON T0.idcliente = T2.id_cliente
WHERE T0.sexo = 'M';
--UPDATE DE SEXO
UPDATE cliente
SET sexo = 'F'
WHERE idcliente = 10;
UPDATE cliente
SET sexo = 'F'
WHERE idcliente = 11;
UPDATE cliente
SET sexo = 'F'
WHERE idcliente = 16;
UPDATE cliente
SET sexo = 'F'
WHERE idcliente = 17;
UPDATE cliente
SET sexo = 'M'
WHERE idcliente = 14;


3)
Select T0.idcliente, T0.nome, T0.sexo, T0.email, T0.cpf, T1.rua, T1.bairro, T1.cidade, T1.estado, T2.tipo, T2.numero
FROM cliente T0
	INNER JOIN endereco T1 ON T0.idcliente = T1.id_cliente
	INNER JOIN telefone T2 ON T0.idcliente = T2.id_cliente
WHERE T0.sexo = 'F';


4)
select COUNT(*) 
from cliente
where sexo = 'M';  -- 5

select COUNT(*) 
from cliente
where sexo = 'F'; --8

5)
select T0.idcliente, T0.email, T0.nome, T0.sexo
from cliente T0
	INNER JOIN endereco T1 ON T0.idcliente = T1.id_cliente
where T0.sexo = 'F' AND T1.bairro = "Centro" AND T1.estado = "RJ";

6)
select T0.email, T0.nome, T2.numero, T2.tipo
from cliente T0
	INNER JOIN endereco T1 ON T0.idcliente = T1.id_cliente
	INNER JOIN telefone T2 ON T0.idcliente = T2.id_cliente
where T1.estado = "RJ" AND T2.tipo = "CEL"
ORDER BY T0.nome;

7)
select T0.email, T0.nome, T2.numero, T2.tipo
from cliente T0
	INNER JOIN endereco T1 ON T0.idcliente = T1.id_cliente
	INNER JOIN telefone T2 ON T0.idcliente = T2.id_cliente
where T1.estado = "SP" AND T2.tipo = "CEL" AND T0.sexo = "F"
ORDER BY T0.nome;


