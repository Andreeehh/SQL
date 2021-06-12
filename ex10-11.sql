/*
Considere as tabelas descritas abaixo:

Tabela: vendedor
Campos:
	idvendedor: int auto incremento
	nome: varchar
	cpf: varchar
	email: varchar
	sexo: char ou enum
	salario: float

Tabela: telefone
Campos:
	idcontato: int auto incremento
	tipo: enum (cel, fixo)
	numero: varchar
	id_vendedor

** Um vendedor pode ter N telefones, mas 1 telefone somente 1 vendedor

Tabela: produtos
Campos:
	idproduto: int auto incremento
	descricao: varchar
	estoque: int
	preco: float

Tabela: vendas
Campos:
	idvenda: int auto incremento
	quantidade: int
	id_vendedor

Tabela: metavendas
Campos:
	idmeta: int auto incremento
	status: char ou enum (A - Atingida e F - Faltou)
	id_vendedor
*/


/*
Exercícios:
*/
CREATE DATABASE ex10;

use ex10;

CREATE TABLE vendedor (
    idvendedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    CPF VARCHAR(14),
    email VARCHAR(50),
    sexo ENUM("F","M"),
    salario INT
);

CREATE TABLE telefone (
    idtelefone INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM("cel","res"),
    numero VARCHAR(14),
    id_vendedor INT NOT NULL,

    FOREIGN KEY(id_vendedor) REFERENCES vendedor(idvendedor)
);

CREATE TABLE produto (
    idproduto INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(30),
    estoque INT,
    preco INT
);

CREATE TABLE venda(
    idvenda INT PRIMARY KEY AUTO_INCREMENT,
    quantidade INT NOT NULL,
    id_vendedor INT NOT NULL,

    FOREIGN KEY(id_vendedor) REFERENCES vendedor(idvendedor)
);

CREATE TABLE metavenda(
    idmeta INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM("A","F"),
    id_vendedor INT NOT NULL,

    FOREIGN KEY(id_vendedor) REFERENCES vendedor(idvendedor)
);

/*
10.1. Crie e normalize o banco.
*/
CREATE DATABASE ex10;

use ex10;

CREATE TABLE vendedor (
    idvendedor INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30),
    CPF VARCHAR(14),
    email VARCHAR(50),
    sexo ENUM("F","M"),
    salario INT
);

CREATE TABLE telefone (
    idtelefone INT PRIMARY KEY AUTO_INCREMENT,
    tipo ENUM("cel","res"),
    numero VARCHAR(14),
    id_vendedor INT NOT NULL,

    FOREIGN KEY(id_vendedor) REFERENCES vendedor(idvendedor)
);

CREATE TABLE produto (
    idproduto INT PRIMARY KEY AUTO_INCREMENT,
    descricao VARCHAR(30),
    estoque INT,
    preco INT
);

CREATE TABLE venda(
    idvenda INT PRIMARY KEY AUTO_INCREMENT,
    quantidade INT NOT NULL,
    id_vendedor INT NOT NULL,
    id_produto INT NOT NULL,

    FOREIGN KEY(id_vendedor) REFERENCES vendedor(idvendedor),
    FOREIGN KEY(id_produto) REFERENCES produto(idproduto)
);

CREATE TABLE metavenda(
    idmeta INT PRIMARY KEY AUTO_INCREMENT,
    status ENUM("A","F"),
    id_vendedor INT NOT NULL,

    FOREIGN KEY(id_vendedor) REFERENCES vendedor(idvendedor)
);
/*
10.2. Crie uma Procedure para automatizar a inserção de vendedores.
*/

DELIMITER $
CREATE PROCEDURE cad_vend(nome VARCHAR(30), cpf VARCHAR(14), email VARCHAR(50), sexo ENUM("F", "M"), salario INT)
BEGIN
    insert into vendedor values(NULL, nome, cpf, email, sexo, salario);
END
$
DELIMITER ;

call cad_vend("André","12345678","123@bol.com.br","M",1200);
call cad_vend("Guta","12345678","123@bol.com.br","f",1300);
call cad_vend("Xico","12345678","123@bol.com.br","M",1400);
call cad_vend("Rafa","12345678","123@bol.com.br","f",1500);
call cad_vend("Einsten","12345678","123@bol.com.br","M",1600);
call cad_vend("Claudia","12345678","123@bol.com.br","f",1700);

/*
10.3. Crie uma Procedure para automatizar a inserção de produtos.
*/
DELIMITER $
CREATE PROCEDURE cad_prod(descricao VARCHAR(30),estoque INT, preco INT)
BEGIN
    insert into produto values(NULL, descricao, estoque, preco);
END
$
DELIMITER ;

call cad_prod("agua", 30, 1);
call cad_prod("refri", 12, 5);
call cad_prod("suco", 45, 6);
call cad_prod("cerveja", 32, 5);
call cad_prod("vodka", 44, 40);
call cad_prod("energetico", 56, 6);
call cad_prod("whisky", 42, 80);


/*
10.4. Crie uma Procedure para automatizar a atualziação salarial de vendedores.
*/
DELIMITER $
CREATE PROCEDURE att_sal(idvendedorATT INT, salarioATT INT)
BEGIN
    UPDATE vendedor
    SET salario = salarioATT
    WHERE idvendedor = idvendedorATT;
END
$
DELIMITER ;

call att_sal(1, 1500);

/*

10.5. Crie uma Trigger de auditoria para armazenar os salários antes da alteração, com data tipo timestamp.
*/

CREATE TABLE auditSalario(
    idAudit INT PRIMARY KEY AUTO_INCREMENT,
    id_vendedor INT NOT NULL,
    salario_antigo INT NOT NULL,
    salario_novo INT NOT NULL,
    date DATETIME,
    usuario VARCHAR(30)
);

drop TRIGGER auditoria_Salario;
DELIMITER $
CREATE TRIGGER auditoria_Salario
AFTER UPDATE ON vendedor
FOR EACH ROW
BEGIN
    insert into auditSalario values (
        NULL,
        old.idvendedor,
        old.salario,
        new.salario,
        now(),
        current_user()
    );
END
$
DELIMITER ;

/*
10.5. Crie uma Trigger de auditoria para vendedores deletados com data tipo timestamp e usuário.
*/
CREATE TABLE auditDel_vend(
    idAudit INT PRIMARY KEY AUTO_INCREMENT,
    id_vendedor INT NOT NULL,
    nome VARCHAR(30),
    CPF VARCHAR(14),
    email VARCHAR(50),
    sexo ENUM("F","M"),
    salario INT,
    date DATETIME,
    usuario VARCHAR(30)
);


DELIMITER $
CREATE TRIGGER auditoria_Del_vendedor
AFTER DELETE ON vendedor
FOR EACH ROW
BEGIN
    insert into auditDel_vend values (
        NULL,
        old.idvendedor,
        old.nome,
        old.cpf,
        old.email,
        old.sexo,
        old.salario,
        now(),
        current_user()
    );
END
$
DELIMITER ;

delete from vendedor where idvendedor = 6;

/*

10.6. Crie uma View "Relatório", que irá exibir os vendedores por ordem de quem vende mais.
*/
CREATE VIEW vRelatorioVendasVendedores AS
    SELECT * 
    FROM vendedor t0
    INNER JOIN venda t1 ON t0.idvendedor = t1.id_vendedor 
    ORDER BY t1.quantidade DESC;
/*

10.7. Crie uma View "Relatório", que mostre os produtos, seu preço uni e sua quantidade no estoque, e o valor total do estoque.
*/
CREATE VIEW vRelatorioProdutosEstoque AS
    SELECT descricao, estoque, preco, (preco * estoque) as "Valor Estoque"
    FROM produto;
/*
10.8. Crie uma Trigger para automatizar a atualziação de estoque de acordo com a venda.
*/

DROP TRIGGER atualiza_estoque;
DELIMITER $
CREATE TRIGGER atualiza_estoque
AFTER INSERT ON venda
FOR EACH ROW
BEGIN
    UPDATE produto
    SET estoque = ((SELECT estoque FROM produto where idproduto = new.id_produto) - new.quantidade)
    where idproduto = new.id_produto;

END
$
DELIMITER ;


/*


10.9. Crie uma Trigger para automatizar a atualziação de estoque caso a venda seja cancelada, e o produto devolvido.
*/
DROP TRIGGER delete_estoque;
DELIMITER $
CREATE TRIGGER delete_estoque
AFTER DELETE ON venda 
FOR EACH ROW
BEGIN
    UPDATE produto
    SET estoque = ((select estoque from produto where idproduto = old.id_produto) + old.quantidade)
    WHERE idproduto = old.id_produto;
END
$
DELIMITER ;

/*

10.10. Crie uma procedure para realizar venda.

*/
DELIMITER $
CREATE PROCEDURE cad_venda(quantidade INT, idvendedor INT, idproduto INT)
BEGIN
    INSERT INTO venda
    VALUES (null, quantidade, idvendedor, idproduto);
END
$
DELIMITER ;

call cad_venda(2,2,2);
call cad_venda(3,1,7);
call cad_venda(15,1,7);
call cad_venda(5,2,2);
call cad_venda(10,2,4);
call cad_venda(3,2,4);

/*

10.11. Crie uma procedure para realizar o cancelamento da venda.
*/
DELIMITER $
CREATE PROCEDURE cancela_venda(id INT)
BEGIN
    DELETE from venda where idvenda = id;    
END
$
DELIMITER ;

/*

10.12. Crie uma procedure, utilizando Cursor, que aplique um aumento salarial de 10% para cada vendedor que vendeu mais de R$ 1000 em seu último pedido.*/

DELIMITER $

CREATE PROCEDURE aplica_bonus()
BEGIN

	declare fim int default 0;
	declare proc_salario, proc_idvendedor, proc_novosalario int;


	declare cursor_vendedores cursor for(

        SELECT t0.salario, t0.idvendedor
        FROM vendedor t0
        INNER JOIN venda t1 ON t0.idvendedor = t1.id_vendedor
        INNER JOIN produto t2 ON t1.id_produto = t2.idproduto
        WHERE t1.idvenda = (select MAX(t99.idvenda) FROM venda t99 WHERE t99.id_vendedor = t0.idvendedor)
        AND (t1.quantidade * (select preco FROM produto where idproduto = t1.id_produto)) > 1000


	);


	declare continue handler for not found set fim = 1;

	open cursor_vendedores;

	repeat

		fetch cursor_vendedores into proc_salario, proc_idvendedor;

		if not fim then
           set proc_novosalario = proc_salario + (proc_salario * 0.1);

           UPDATE vendedor
           set salario = proc_novosalario
           where idvendedor = proc_idvendedor;

		end if;


	until fim end repeat;

	close cursor_vendedores;

END
$

DELIMITER ;

           UPDATE vendedor
           set salario = proc_novosalario
           where idvendedor = proc_idvendedor
			
/*

10.13. Crie uma procedure, utilizando Cursor, que verifique os vendedores que bateram a meta do último pedido (venda > R$ 1000) e grave na tabela metavendas com o Status "A", ou Status "F" caso tenha falhado em vender > R$ 1000.
*/
DROP PROCEDURE insere_status;
DELIMITER $

CREATE PROCEDURE insere_status()
BEGIN
	declare fim int default 0;
	declare proc_idvendedor, proc_preco int;

	
	declare cursor_vendedores cursor for(

        SELECT  t0.idvendedor, t1.quantidade * t2.preco
        FROM vendedor t0
        INNER JOIN venda t1 ON t0.idvendedor = t1.id_vendedor
        INNER JOIN produto t2 ON t1.id_produto = t2.idproduto
        WHERE t1.idvenda = (select MAX(t99.idvenda) FROM venda t99 WHERE t99.id_vendedor = t0.idvendedor)


	);

	
	declare continue handler for not found set fim = 1;

	open cursor_vendedores;

	repeat

		fetch cursor_vendedores into proc_idvendedor, proc_preco;

		if not fim then
             if proc_preco > 1000 then
                INSERT INTO metavenda
                values (null, "A", proc_idvendedor);
            end if;
            
            if proc_preco <= 1000 then
                INSERT INTO metavenda
                values (null, "F", proc_idvendedor);
            end if;

		end if;


	until fim end repeat;

	close cursor_vendedores;

END
$

DELIMITER ;




/*
Considere as tabelas abaixo:

Tabela: avaliacao
Campos:
	semestre int
	ra int
	media float

Tabela: aprovados
Campos:
	semestre int
	ra int
	media float


Tabela: vendas
Campos:
	idvenda: int auto incremento
	data datetime
	id_produto
	quantidade: int

Tabela: estoque
Campos:
	id_produto
	quantidade
*/
CREATE DATABASE ex11;

use ex11;

CREATE TABLE avaliacao (
    semestre INT,
    ra INT,
    media FLOAT(10,2)    
);

CREATE TABLE aprovados (
    semestre INT,
    ra INT,
    media FLOAT(10,2)
);

CREATE TABLE estoque (
    idproduto INT PRIMARY KEY AUTO_INCREMENT,
    quantidade int
);


CREATE TABLE vendas (
    idvenda INT PRIMARY KEY AUTO_INCREMENT,
    data DATETIME,
    id_produto INT,
    quantidade int,
    FOREIGN KEY(id_produto) REFERENCES estoque(idproduto)    
);




/*
11.1. Leia os dados da tabela "avaliacao" para um semestre informado e, para cada linha, verifique se o aluno está aprovado ( media > 7 ) e caso seja aprovado grava na tabela "aprovados".
*/


INSERT INTO avaliacao VALUES (1, 46545564, 7.0);
INSERT INTO avaliacao VALUES (2, 46545564, 8.1);
INSERT INTO avaliacao VALUES (1, 46545565, 9.8);
INSERT INTO avaliacao VALUES (2, 46545565, 10.0);
INSERT INTO avaliacao VALUES (1, 46545566, 6.9);
INSERT INTO avaliacao VALUES (2, 46545566, 7.2);
INSERT INTO avaliacao VALUES (1, 46545567, 7.1);
INSERT INTO avaliacao VALUES (2, 46545567, 4.1);
INSERT INTO avaliacao VALUES (1, 46545568, 4.8);
INSERT INTO avaliacao VALUES (2, 46545568, 5.0);

DELIMITER $

CREATE PROCEDURE aprova_aluno()
BEGIN

	declare fim int default 0;
	declare proc_semestre, proc_ra int;
    declare proc_media FLOAT(10,2);


	declare cursor_alunos cursor for(

        SELECT semestre, ra, media
        FROM avaliacao
        where media > 7
    );


	declare continue handler for not found set fim = 1;

	open cursor_alunos;

	repeat

		fetch cursor_alunos into proc_semestre, proc_ra, proc_media;

		if not fim then
          
           INSERT INTO aprovados VALUES (proc_semestre, proc_ra, proc_media);

		end if;


	until fim end repeat;

	close cursor_alunos;

END
$

DELIMITER ;




/*
11.2. Leia os dados da tabela VENDAS para uma data informada e, para cada linha, atualize a tabela ESTOQUE para o produto que foi vendido, decrementando o campo quantidade_estoque da tabela ESTOQUE.
*/

INSERT INTO estoque VALUES (null,200);
INSERT INTO estoque VALUES (null,500);
INSERT INTO estoque VALUES (null,20);
INSERT INTO estoque VALUES (null,50);
INSERT INTO estoque VALUES (null,100);
INSERT INTO estoque VALUES (null,400);
INSERT INTO estoque VALUES (null,300);
INSERT INTO estoque VALUES (null,500);

insert into vendas VALUES (null, '2021-05-18 10:34:09',1,50);
insert into vendas VALUES (null, '2021-05-18 10:35:09',1,50);
insert into vendas VALUES (null, '2021-05-18 10:36:09',1,30);
insert into vendas VALUES (null, '2021-05-18 10:37:09',2,450);
insert into vendas VALUES (null, '2021-05-18 10:38:09',2,50);
insert into vendas VALUES (null, '2021-05-18 10:39:09',3,10);
insert into vendas VALUES (null, '2021-05-18 10:41:09',4,80);
insert into vendas VALUES (null, '2021-05-18 10:42:09',5,50);
insert into vendas VALUES (null, '2021-05-18 10:43:09',6,50);
insert into vendas VALUES (null, '2021-05-18 10:44:09',7,50);
insert into vendas VALUES (null, '2021-05-18 10:45:09',8,50);


DELIMITER $

CREATE PROCEDURE att_estoque11()
BEGIN

	declare fim int default 0;
	declare proc_id_produto, proc_quantidade int;


	declare cursor_vendas cursor for(

        SELECT id_produto, quantidade
        from vendas
    );


	declare continue handler for not found set fim = 1;

	open cursor_vendas;

	repeat

		fetch cursor_vendas into proc_id_produto, proc_quantidade;

		if not fim then
          
           UPDATE estoque
           SET quantidade = ((SELECT quantidade from estoque where idproduto = proc_id_produto) - proc_quantidade)
           where idproduto = proc_id_produto;

		end if;


	until fim end repeat;

	close cursor_vendas;

END
$

DELIMITER ;
