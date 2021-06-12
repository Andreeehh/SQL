create database ex8;

use ex8;

create table cliente(
	idCliente INT NOT NULL,
	nome VARCHAR(25) NOT NULL,
	sexo ENUM("F","M") NOT NULL
);

create table carro(
	idCarro INT NOT NULL,
	nome VARCHAR(25) NOT NULL,
	marca VARCHAR(25) NOT NULL,
	placa VARCHAR(8) NOT NULL UNIQUE,
	modelo VARCHAR(25) NOT NULL,
	id_cliente INT NOT NULL	
);

create table carroCor(
	id_carro INT NOT NULL,
	cor VARCHAR(25) NOT NULL
);

create table clienteTelefone(
	idTelefone INT NOT NULL,
	id_cliente INT NOT NULL,
	tipoTelefone ENUM("cel","com","res"),
	numTelefone VARCHAR(14)
);



ALTER TABLE cliente ADD CONSTRAINT pk_cliente
PRIMARY KEY(idCliente);

ALTER TABLE cliente MODIFY idCliente INT NOT NULL AUTO_INCREMENT;


ALTER TABLE carro ADD CONSTRAINT pk_carro
PRIMARY KEY(idCarro);

ALTER TABLE carro MODIFY idCarro INT AUTO_INCREMENT;

ALTER TABLE carro ADD CONSTRAINT fk_cliente_carro
FOREIGN KEY (id_cliente) REFERENCES cliente (idcliente);


ALTER TABLE clienteTelefone ADD CONSTRAINT pk_clienteTelefone
PRIMARY KEY(idTelefone);

ALTER TABLE clienteTelefone MODIFY idTelefone INT AUTO_INCREMENT;

ALTER TABLE clienteTelefone ADD CONSTRAINT fk_telefone_cliente
FOREIGN KEY (id_cliente) REFERENCES carro (idCliente);

ALTER TABLE carroCor ADD CONSTRAINT fk_cor_carro
FOREIGN KEY (id_carro) REFERENCES carro (idCarro);


insert into cliente (idCliente, nome, sexo) VALUES (null, "André", "M");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 1, "cel", "14997521828");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 1, "res", "143293307");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Roberto", "M");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 2, "com", "14991711162");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 2, "res", "143293307");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Marco", "M");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 3, "cel", "14999999999");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 3, "res", "143293307");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Luciana", "F");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 3, "com", "14991351162");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 3, "res", "143293307");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Sylvia", "F");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 4, "cel", "14988888888");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 4, "res", "143293307");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Chandler Bing", "M");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 5, "cel", "0723416431");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 5, "res", "0123786456");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Rachel Green", "f");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 6, "cel", "07286453145");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 6, "res", "0764645312");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Joey", "M");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 7, "cel", "072645645312");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Pheobe Buffay", "f");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 8, "cel", "07234535424");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Monica Geller", "f");
insert into clienteTelefone (idTelefone, id_cliente, tipoTelefone, numTelefone) VALUES (null, 9, "cel", "078278378645");

insert into cliente (idCliente, nome, sexo) VALUES (null, "Ross", "M");
