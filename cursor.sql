/*Cursores*/

CREATE DATABASE cursores;
USE cursores;

CREATE TABLE vendedores(
	idvendedor INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50),
	jan INT,
	fev INT,
	mar INT
);

INSERT INTO vendedores VALUES (null,"Oliver",1000,2000,3000);
INSERT INTO vendedores VALUES (null,"Mariana",100,1500,3000);
INSERT INTO vendedores VALUES (null,"Emma",3000,5000,100);
INSERT INTO vendedores VALUES (null,"Luiz",300,2000,2050);
INSERT INTO vendedores VALUES (null,"Otávio",450,2000,2500);
INSERT INTO vendedores VALUES (null,"Fernanda",1000,2000,3000);

# Operações em linha

SELECT nome, (jan+fev+mar) Total, (jan+fev+mar)/3 Média
FROM vendedores

# Resolvendo com Cursor

CREATE TABLE vendedores_total(
	nome VARCHAR(50),
	jan INT,
	fev INT,
	mar INT,
	total INT,
	media INT
);

## Cursor
DROP PROCEDURE processa_vendedores;

DELIMITER $

CREATE PROCEDURE processa_vendedores()
BEGIN
	# Declarando variáveis
	declare fim int default 0;
	declare proc_jan, proc_fev, proc_mar, proc_total, proc_media int;
	declare proc_nome varchar(50);

	# Declarando o cursor com seu 'resultset'
	declare cursor_vendedores cursor for(

		SELECT nome, jan, fev, mar
		FROM vendedores

	);

	# Declarando o manipulador
	declare continue handler for not found set fim = 1;

	open cursor_vendedores;

	repeat

		fetch cursor_vendedores into proc_nome, proc_jan, proc_fev, proc_mar;

		if not fim then

			set proc_total = proc_jan + proc_fev + proc_mar;
			set proc_media = proc_total/3;

			INSERT INTO vendedores_total
			VALUES(proc_nome, proc_jan, proc_fev, proc_mar, proc_total, proc_media);

		end if;


	until fim end repeat;

	close cursor_vendedores;

END
$

DELIMITER ;