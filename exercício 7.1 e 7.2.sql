7.1.
1) select sum(quantidade) from informatica;

2) select quantidade from informatica where idproduto = 6;

3) select produto from informatica where valor = (select MAX(valor) from informatica);

4) select produto from informatica where valor = (select MIN(valor) from informatica);

5) select produto, quantidade from informatica where produto LIKE "M%";

--Professor, não entendi se valor médio era só as médias dos valores, ou média dos valores * quantidade em estoque.

6) select AVG(Valor) from informatica;
   --ou
   select AVG(Valor*quantidade) from informatica;

   

7) select AVG(Valor) from informatica Having produto LIKE "%dor";
--ou
   select AVG(Valor*quantidade) from informatica Having produto LIKE "%dor";

7.2.
1) select SUM(salario) from funcionarios;

2) select nome from funcionarios where bairro = "Jabaquara" and salario = (select MIN(salario) from funcionarios);

3) select AVG(salario) from funcionarios where (bairro = "Jurubatuba" or bairro = "Grajaú") and sexo = "F" and nome LIKE "%Nunes";

4) select count(*) from funcionarios where setor = "Marketing";

5) select setor, AVG(salario) from funcionarios GROUP BY setor ORDER BY AVG(salario) DESC;

6) select count(*) from funcionarios where salario < 3000 and bairro = "Socorro";

7) select setor, count(*) as QUANTIDADE from funcionarios  GROUP BY setor having QUANTIDADE > 3;

8) select bairro, count(*) as QUANTIDADE from funcionarios  GROUP BY bairro having QUANTIDADE > 2;

9) select bairro, SUM(salario) from funcionarios GROUP BY bairro;

10) select nome, setor, salario from funcionarios where salario = (select MIN(salario) from funcionarios);

11) select MAX(salario), bairro from funcionarios GROUP BY bairro;

12) create view vQuery10 as select nome, setor, salario from funcionarios where salario = (select MIN(salario) from funcionarios);
