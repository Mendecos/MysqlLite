--Selecione os primeiros 5 registros da tabela clientes, ordenando-os pelo nome em ordem crescente.
SELECT * from Colaboradores WHERE CAST (id as int) <6;

--Encontre todos os produtos na tabela produtos que não têm uma descrição associada (suponha que a coluna de descrição possa ser nula).
SELECT * from CargosColaboradores WHERE datatermino is NOT NULL;

--Liste os funcionários cujo nome começa com 'A' e termina com 's' na tabela funcionarios.
SELECT * from Colaboradores WHERE nome like 'A%' and nome LIKE '%s';

--Exiba o departamento e a média salarial dos funcionários em cada departamento na tabela funcionarios, agrupando por departamento, apenas para os departamentos cuja média salarial é superior a $5000.
SELECT cargo, avg(salario)  from CargosColaboradores GROUP by cargo HAVING avg(salario) > 6000;

--Selecione todos os clientes da tabela clientes e concatene o primeiro e o último nome, além de calcular o comprimento total do nome completo.
SELECT  nome || ' ' || LENGTH(nome) from Colaboradores;

--Para cada venda na tabela vendas, exiba o ID da venda, a data da venda e a diferença em dias entre a data da venda e a data atual.
SELECT id_colaborador,tipolicenca, JULIANDAY(datafim) -JULIANDAY(datainicio) AS Diferença_dias from Licencas;


--Selecione todos os itens da tabela pedidos e arredonde o preço total para o número inteiro mais próximo.
SELECT CEIL(lucro_liquido) from faturamento;

--Converta a coluna data_string da tabela eventos, que está em formato de texto (YYYY-MM-DD), para o tipo de data e selecione todos os eventos após '2023-01-01'.
SELECT CAST(datainicio AS TEXT) FROM Licencas WHERE datainicio >'2023-01-01';

--Na tabela avaliacoes, classifique cada avaliação como 'Boa', 'Média', ou 'Ruim' com base na pontuação: 1-3 para 'Ruim', 4-7 para 'Média', e 8-10 para 'Boa'.
SELECT cargo, salario, case WHEN
salario < 8000 then 'Baixo'
WHEN salario BETWEEN 8000 and 14 THEN 'Medio'
ELSE 'Alto' 
end as Categoria_salario from CargosColaboradores;

--Altera o nome da coluna data_nasc para data_nascimento na tabela funcionarios e selecione todos os funcionários que nasceram após '1990-01-01'.
ALTER TABLE Licencas
RENAME COLUMN datainicio TO data_inicio;
SELECT * from Licencas where data_inicio > '2022-05-31'





