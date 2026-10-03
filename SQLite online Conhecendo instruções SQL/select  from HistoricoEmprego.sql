select * from HistoricoEmprego
ORDER by salario DESC
LIMIT 5;
--limita a quantidade de dados consultados
----------------------------------------
select * from HistoricoEmprego
where datatermino is NULL
ORDER by salario DESC
LIMIT 5;
--IS NULL é a forma correta de pesquisar dados vazios NOT NULL faz o contrario
-------------------------------------------
SELECT * from Treinamento WHERE curso LIKE 'o poder%';
LIKE busca o texto parecido que exista na coluna
--% determina aonde começa ou termina o texto que não conhecemos
--------------------------------------------
SELECT * from HistoricoEmprego
WHERE cargo = 'Professor' and datatermino NOT NULL;
SELECT * from HistoricoEmprego WHERE cargo = 'Oftalmologista' OR cargo = 'Dermatologista';
--usando operados and e or
---------------------------------------------------------
SELECT * from HistoricoEmprego WHERE cargo in ('Oftalmologista', 'Dermatologista','Professor');
-------------------------------------------------------
SELECT * from Treinamento
WHERE (curso like 'O direito%' and instituicao = 'da Rocha') 
or ( curso like 'O conforto%' and instituicao = 'das Neves');
-----------------------------------------------------
SELECT mes, MAX(faturamento_bruto) from faturamento;
--max para encontrar o valor máximo dentro de fat.bruto, MIN faz o contrario
-----------------------------------------------------
SELECT SUM(numero_novos_clientes) as 'Novos Clientes 2023' from faturamento
WHERE mes like '%2023%'; 
--SUM somo todos os dados da coluna
--------------------------------------------------------------
SELECT avg(despesas) from faturamento;
SELECT avg(lucro_liquido) from faturamento;
--avg faz a medida dos dados na coluna
---------------------------------------------------------
SELECT COUNT(*) from HistoricoEmprego
WHERE datatermino not NULL;
SELECT COUNT(*) from Licencas
WHERE tipolicenca = 'férias';
--conta a quantidade da dados na coluna
----------------------------------------------------------
SELECT parentesco, COUNT(*) as 'Quantidade' from Dependentes
GROUP by parentesco;
--agrupa linhas que têm os mesmos valores na coluna que especificamos
---------------------------------------------------------------
SELECT instituicao, COUNT(curso) from Treinamento
GROUP by instituicao
HAVING COUNT(curso) > 2;
--quando se trabalha com dados que já foram agrupado se usa HAVING
--------------------------------------------------------------
SELECT nome, LENGTH(cpf) qtd from Colaboradores
WHERE qtd = 11;
--LENGTH conta a quantidade de caracteres

SELECT COUNT(*), LENGTH(cpf) qtd FROM Colaboradores
WHERE qtd = 11;
----------------------------------------------------------
SELECT ('A pessoa colaboradora ' || nome || ' de CPF ' || cpf || ' possui o seguinte endereço: '
        || endereco) as texto
        from Colaboradores;
--CONCAT ou || concatena textos e as informações das colunas, possibilitando a escrita de pequenas frases e textos
--pode se adicionar UPER ou LOWER após o SELECT para alterar o texto
-------------------------------------------------------------
SELECT id_colaborador, STRFTIME('%Y/%m', datainicio) from Licencas;
--consegue alterar o formato original da data em um determinado banco de dados para o formato que você deseja ver naquele momento.

SELECT id_colaborador, JULIANDAY(datatermino) - JULIANDAY (datacontratacao) AS 'Dias trabalhados' FROM 
HistoricoEmprego 
WHERE datatermino is NOT NULL;
--JULIANDAY vai trazer um intervalo de dias, de acordo com o cálculo entre duas colunas de uma tabela
---------------------------------------------------------------------
SELECT AVG (faturamento_bruto), ROUND( avg(faturamento_bruto), 2) 
from faturamento;
--ROUND arredonda duas casas decimais
SELECT CEIL(faturamento_bruto), CEIL (despesas) from faturamento;
SELECT floor(faturamento_bruto), floor (despesas) from faturamento;
-----------------------------------------------------------------------
SELECT (' O faturamento bruto medio foi ' || cast(round(avg(faturamento_bruto),2) as TEXT ))from
         faturamento;
--CAST converte dados
----------------------------------------------------------------
SELECT id_colaborador, cargo, salario,
CASE WHEN salario < 3000 THEN 'Baixo'
WHEN salario BETWEEN 3000 AND 6000 THEN 'Medio'
ELSE 'Alto'
end as categoria_salario
from HistoricoEmprego;
alter table HistoricoEmprego RENAME to CargosColaboradores;