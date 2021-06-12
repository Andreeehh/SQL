a)
select Nome from curso GROUP BY Nome;

b)
select Nome, Telefone from aluno where cidade = "Sao Carlos - SP" order by Nome desc;

c)
select Nome, Admissao from professor where Admissao < '1993-01-01';

d)
select Nome from aluno where Nome like "J%";

e)
select T2.Nome 
from curso T0
	INNER JOIN disciplinacurso T1 ON T0.idcurso = T1.id_curso
	INNER JOIN disciplina T2 on T1.id_disciplina = T2.iddisciplina
where T0.Nome = "Ciencia da Computacao";

f)
select T0.Nome 
from curso T0
	INNER JOIN disciplinacurso T1 ON T0.idcurso = T1.id_curso
	INNER JOIN disciplina T2 on T1.id_disciplina = T2.iddisciplina
where T2.Nome = "Calculo Numerico";

g)
select T2.Nome
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T0.Nome = "Marcos Joao Casanova" AND T1.Semestre = "01/1998";

select T0.Nome, T2.Nome, T1.Semestre
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T0.Nome = "Marcos Joao Casanova" AND T1.Semestre = "01/1998";

h)select T0.Nome, T2.Nome, T1.Nota
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T0.Nome = "Ailton Castro" AND T1.Nota < 7;

i)
select T0.Nome, T1.Nota, T1.Semestre, T2.Nome
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T2.Nome = "Calculo Numerico" AND T1.Semestre ="01/1998";

j)select T0.Nome, T2.Nome
from professor T0 
	INNER JOIN aula T1 ON T0.idprofessor = T1.id_professor
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T0.Nome = "Ramon Travanti" GROUP BY T2.Nome;

k)select T0.Nome, T2.Nome
from professor T0 
	INNER JOIN aula T1 ON T0.idprofessor = T1.id_professor
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T2.Nome = "Banco de Dados" GROUP BY T0.Nome;

l) select MAX(Nota), MIN(Nota)
from aula
where Semestre = "01/1998";

m)select MAX(T1.Nota), T0.Nome
from aluno T0 
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T2.Nome = "Engenharia Software" and T1.Semestre = "01/1998";

n)select T0.Nome as "Nome Aluno", T2.Nome as "Nome Disciplina", T3.Nome as "Nome Professor"
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
	INNER JOIN professor T3 ON T1.id_professor = T3.idprofessor
where T1.Semestre = "01/1998"
ORDER BY T0.Nome;

o)select T0.Nome as "Nome Aluno", T2.Nome as "Nome Disciplina", T1.Nota
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
	INNER JOIN disciplinacurso T3 ON T2.iddisciplina = T3.id_disciplina
	INNER JOIN curso T4 ON T3.id_curso = T4.idcurso
where T1.Semestre = "01/1998" and T4.Nome = "Ciencia da Computacao"
ORDER BY T0.Nome;

p) select T0.Nome, AVG(T1.Nota)
from professor T0
	INNER JOIN aula T1 on T0.idprofessor = T1.id_professor
where T0.Nome = "Marcos Salvador";

q)select T0.Nome as "Nome Aluno", T2.Nome as "Nome Disciplina", T1.Nota
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T1.Nota >= 5 AND T1.Nota <= 7
ORDER BY T2.Nome;

r)select AVG(T0.Nota), T0.Semestre
from aula T0
	INNER JOIN disciplina T1 ON T0.id_disciplina = T1.iddisciplina
where T1.Nome = "Calculo Numerico" AND T0.Semestre = "01/1998";

s) select COUNT(*)
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN professor T2 ON T1.id_professor = T2.idprofessor
where T2.Nome = "Abgair Simon Ferreira" AND T1.Semestre = "01/1998";

t)select T0.Nome, AVG(T1.Nota)
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
where T0.Nome = "Edvaldo Carlos Silva";


u)select T0.Nome, AVG(T1.Nota)
from disciplina T0
	INNER JOIN aula T1 ON T0.iddisciplina = T1.id_disciplina
where T1.Semestre = "01/1998"
GROUP BY T0.Nome;

v)select T0.Nome, AVG(T1.Nota)
from professor T0
	INNER JOIN aula T1 ON T0.idprofessor = T1.id_professor
where T1.Semestre = "01/1998"
GROUP BY T0.Nome;

w)
select T0.Nome, AVG(T1.Nota)
from disciplina T0
	INNER JOIN aula T1 ON T0.iddisciplina = T1.id_disciplina
	INNER JOIN disciplinacurso T2 ON T0.iddisciplina = T2.id_disciplina
	INNER JOIN curso T3 ON T2.id_curso = T3.idcurso
where T3.Nome = "Ciencia da Computacao" AND T1.Semestre = "01/1998" 
GROUP BY T0.Nome;

x)select T0.Nome, SUM(T2.QuantCreditos)
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T0.Nome = "Edvaldo Carlos Silva" and T1.Nota > 7;


y)select T0.Nome, SUM(T2.QuantCreditos)
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
where T1.Nota >= 7 
GROUP BY T0.Nome;

z)select T0.Nome as "Nome Aluno", T2.Nome as "Nome Disciplina", T3.Nome as "Nome Professor"
from aluno T0
	INNER JOIN aula T1 ON T0.idaluno = T1.id_aluno
	INNER JOIN disciplina T2 ON T1.id_disciplina = T2.iddisciplina
	INNER JOIN professor T3 ON T1.id_professor = T3.idprofessor
	INNER JOIN disciplinacurso T4 ON T2.iddisciplina = T4.id_disciplina
	INNER JOIN curso T5 ON T4.id_curso = T5.idcurso
where T1.Semestre = "01/1998" AND T1.Nota >= 8 AND T5.Nome = "Ciencia da Computacao"
ORDER BY T0.Nome;

