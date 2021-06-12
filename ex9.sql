CREATE TABLE produtos (
	idproduto VARCHAR(3) PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(50) UNIQUE,
	estoque INT NOT NULL
);

CREATE TABLE itensvenda (
	idvenda INT,
	produto INT(3),
	quantidade INT
);

--A. Trigger: AFTER INSERT para dar baixa no estoque

DELIMITER $
CREATE TRIGGER ajuste_estoque
AFTER INSERT ON itensvenda 
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = ((select estoque from produtos where idproduto = new.produto) - new.quantidade)
    WHERE idproduto = new.produto;
END
$
DELIMITER ;

insert into itensvenda values (1,1,5);

--Trigger: AFTER DELETE para fazer a devolução da quantidade do produto.

DELIMITER $
CREATE TRIGGER delete_estoque
AFTER DELETE ON itensvenda 
FOR EACH ROW
BEGIN
    UPDATE produtos
    SET estoque = ((select estoque from produtos where idproduto = old.produto) + old.quantidade)
    WHERE idproduto = old.produto;
END
$
DELIMITER ;

delete from itensvenda where idvenda = 1;

--Faça uma Trigger de Auditoria, para logar sempre que houver uma alteração
--Produtos.

CREATE DATABASE backup;
USE backup;
CREATE TABLE bkp_produto(
    idbackup INT PRIMARY KEY AUTO_INCREMENT,
    idproduto INT,
    descricao VARCHAR(30),
    estoque_original int,
    estoque_alterado int,
    data DATETIME,
    usuario VARCHAR(30),
    evento CHAR(1)
);

use ex9;

DELIMITER $
CREATE TRIGGER auditoria_produto
AFTER UPDATE ON produtos
FOR EACH ROW
BEGIN
    insert into backup.bkp_produto values (
        NULL,
        old.idproduto,
        old.descricao,
        old.estoque,
        new.estoque,
        now(),
        current_user(),
        "U"
    );
END
$
DELIMITER ;


insert into itensvenda values (1,1,5);
delete from itensvenda where idvenda = 1;

--Faça uma SP que faça a inserção de produtos, recebendo os dados por
--parâmetro.

DELIMITER $
CREATE PROCEDURE cad_produto (
    descricao VARCHAR(50),
    estoque INT
    )
BEGIN
    insert into produtos values (null, descricao, estoque);
END
$
DELIMITER ;

--Faça uma SP que mostre os dados da Auditoria.

DELIMITER $
CREATE PROCEDURE chama_audit()
BEGIN
    select * from backup.bkp_produto;
END
$
DELIMITER ;


CREATE TABLE tempo (
	id INT PRIMARY KEY AUTO_INCREMENT,
	dia INT NOT NULL,
	mes INT NOT NULL,
	ano INT NOT NULL,
	data INT
);


INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (1,15,1,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (2,15,2,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (3,15,3,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (4,15,4,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (5,15,5,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (6,15,6,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (7,15,7,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (8,15,8,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (9,15,9,1999);
INSERT INTO TEMPO (ID,DIA,MES,ANO) VALUES (10,15,10,1999);

--Crie uma stored procedure para somar os campos dia, mês e ano com um valor
--passado como parâmetro no campo data da tabela tempo, resultado esperado:


DELIMITER $
CREATE PROCEDURE adiciona_data(n1 INT)
BEGIN
    SELECT
        dia, mes, ano, (dia+mes+ano) as data
    FROM tempo;
END
$
DELIMITER ;

select dia + mes + ano from tempo;



CREATE TABLE aluno (
	idaluno INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30) NOT NULL,
	cpf VARCHAR(30) NOT NULL
);

CREATE TABLE disciplina (
	iddisciplina INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(30) NOT NULL
);

CREATE TABLE nota (
	idnota INT PRIMARY KEY AUTO_INCREMENT,
	id_aluno INT NOT NULL,
	id_disciplina INT NOT NULL,
	nota float(10,2) NOT NULL,

	FOREIGN KEY(id_aluno) REFERENCES aluno(idaluno),
	FOREIGN KEY(id_disciplina) REFERENCES disciplina(iddisciplina)
);


--Crie uma procedure para inserir dados na tabela Disciplina, passando para ela o nome Disciplina;


DELIMITER $
CREATE PROCEDURE cad_disc(nome VARCHAR(30))
BEGIN
    insert into disciplina values(NULL, nome);
END
$
DELIMITER ;


--Crie uma procedure para inserir dados na tabela Aluno, passando para ela o nome Aluno e cpf;

DELIMITER $
CREATE PROCEDURE cad_aluno(nome VARCHAR(30), cpf VARCHAR(30))
BEGIN
    insert into aluno values(NULL, nome, cpf);
END
$
DELIMITER ;

--Crie uma procedure para inserir dados na tabela Nota, passando para ela o idaluno, iddisciplina e a nota;

DELIMITER $
CREATE PROCEDURE cad_nota(idaluno INT, iddiscp INT, nota float(10,2))
BEGIN
    insert into nota values(NULL, idaluno, iddiscp, nota);
END
$
DELIMITER ;

--Crie uma procedure que insira 10 alunos automaticamente, passando para ela o nome do aluno. Exemplo: Aluno->Aluno1,Aluno2,Aluno3... / o cpf vai ser por padrão 12345678;

DELIMITER $
CREATE PROCEDURE cad_10alunos(nome1 VARCHAR(30),nome2 VARCHAR(30),nome3 VARCHAR(30),nome4 VARCHAR(30),nome5 VARCHAR(30),nome6 VARCHAR(30),nome7 VARCHAR(30),nome8 VARCHAR(30),nome9 VARCHAR(30),nome10 VARCHAR(30))
BEGIN
    insert into aluno values(NULL, nome1, "12345678");
    insert into aluno values(NULL, nome2, "12345678");
    insert into aluno values(NULL, nome3, "12345678");
    insert into aluno values(NULL, nome4, "12345678");
    insert into aluno values(NULL, nome5, "12345678");
    insert into aluno values(NULL, nome6, "12345678");
    insert into aluno values(NULL, nome7, "12345678");
    insert into aluno values(NULL, nome8, "12345678");
    insert into aluno values(NULL, nome9, "12345678");
    insert into aluno values(NULL, nome10, "12345678");
END
$
DELIMITER ;

--Criar uma procedure que liste o nome de todas as disciplinas;

DELIMITER $
CREATE PROCEDURE lista_discp()
BEGIN
    select nome from disciplina;
END
$
DELIMITER ;


--Criar uma procedure conte quantas disciplinas temos;


DELIMITER $
CREATE PROCEDURE count_discp()
BEGIN
    select COUNT(*) from disciplina;
END
$
DELIMITER ;


--Criar uma procedure que retorne a médias das notas de um determinado Aluno, passando para a procedure o código do aluno;

DELIMITER $
CREATE PROCEDURE media_aluno(id INT)
BEGIN
    select AVG(nota) from nota where id_aluno = id;
END
$
DELIMITER ;

--Criar uma procedure que retorne a média das notas de determinado aluno e o seu nome, passando para a procedure o código do aluno;

DELIMITER $
CREATE PROCEDURE media_aluno_nome(id INT)
BEGIN
    select t2.nome, AVG(t1.nota) 
    from nota t1
    INNER JOIN aluno t2 on t1.id_aluno = t2.idaluno
    where t1.id_aluno = id
    GROUP BY t2.nome;
END
$
DELIMITER ;

--Criar uma procedure que retorne a média dos alunos de uma determinada disciplina e o nome da disciplina, passando para a procedure o código da disciplina;

DELIMITER $
CREATE PROCEDURE media_discp(id INT)
BEGIN
    select t3.nome, AVG(t1.nota) 
    from nota t1
    INNER JOIN aluno t2 on t1.id_aluno = t2.idaluno
    inner JOIN disciplina t3 on t1.id_disciplina = t3.iddisciplina
    where t1.id_disciplina = id;
END
$
DELIMITER ;

--Criar uma procedure que retorne a maior nota dos alunos de uma determinada disciplina, passando para a procedure o código da disciplina;

DELIMITER $
CREATE PROCEDURE nota_max(id INT)
BEGIN
    select MAX(t1.nota) 
    from nota t1
    INNER JOIN aluno t2 on t1.id_aluno = t2.idaluno
    inner JOIN disciplina t3 on t1.id_disciplina = t3.iddisciplina
    where t1.id_disciplina = id;
END
$
DELIMITER ;

--Criar uma procedure que mostre o nome das matérias e o nome do aluno em que um determinadoaluno tem nota agrupando pelo nome da matéria, passando para a procedure o código do aluno;

DELIMITER $
CREATE PROCEDURE materias_aluno(id INT)
BEGIN
    select t3.nome, t2.nome
    from nota t1
    INNER JOIN aluno t2 on t1.id_aluno = t2.idaluno
    inner JOIN disciplina t3 on t1.id_disciplina = t3.iddisciplina
    where t1.id_aluno = id
    GROUP BY t3.nome;
END
$
DELIMITER ;