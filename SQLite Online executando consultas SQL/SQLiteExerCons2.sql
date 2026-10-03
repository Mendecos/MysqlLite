--Consulta 1: Retornar a média de Notas dos Alunos em história.
SELECT AVG(nota) from Notas WHERE id_disciplina = 2;

--Consulta 2: Retornar as informações dos alunos cujo Nome começa com 'A'.
SELECT * from Alunos where nome_aluno LIKE 'A%';

--Consulta 3: Buscar apenas os alunos que fazem aniversário em fevereiro.
SELECT * FROM Alunos WHERE STRFTIME('%m', data_nascimento) = '02';

--Consulta 4: Realizar uma consulta que calcula a idade dos Alunos.
SELECT nome_aluno, data_nascimento,
(strftime('%Y', CURRENT_DATE) - strftime('%Y', data_nascimento)) 
 as Idade from alunos;

--Consulta 5: Retornar se o aluno está ou não aprovado. Aluno é considerado aprovado se a sua nota foi igual ou maior que 6.
 SELECT id_aluno, nota, CASE when nota < 6 THEN 'Reprovado'
 ELSE 'Aprovado'
 end as Situacao 
 from Notas;