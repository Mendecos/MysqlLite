-- ============================================================
-- EXERCÍCIOS MYSQL
-- Tabela: funcionarios
-- ============================================================
-- 1) CRIAÇÃO DA TABELA FUNCIONARIOS
CREATE TABLE funcionarios (
    id INT PRIMARY KEY,
    nome VARCHAR(100),
    departamento VARCHAR(100),
    salario FLOAT
);

INSERT INTO funcionarios
(id, nome, departamento, salario)
VALUES
(1, 'Heitor Vieira', 'Financeiro', 4959.22),
(2, 'Daniel Campos', 'Vendas', 3884.44),
(3, 'Luiza Dias', 'TI', 8205.78),
(4, 'Davi Lucas Moraes', 'Financeiro', 8437.02),
(5, 'Pietro Cavalcanti', 'TI', 4946.88),
(6, 'Evelyn da Mata', 'Vendas', 5278.88),
(7, 'Isabella Rocha', 'Marketing', 4006.03),
(8, 'Sra. Manuela Azevedo', 'Vendas', 6101.88),
(9, 'Brenda Cardoso', 'TI', 8853.34),
(10, 'Danilo Souza', 'TI', 8242.14);

-- ============================================================
-- 2) SELECIONAR TODOS OS CAMPOS DE TODOS OS REGISTROS

SELECT *
FROM funcionarios;

-- ============================================================
-- 3) SELECIONAR FUNCIONÁRIOS DO DEPARTAMENTO DE VENDAS

SELECT nome
FROM funcionarios
WHERE departamento = 'Vendas';

-- ============================================================
-- 4) SELECIONAR FUNCIONÁRIOS COM SALÁRIO MAIOR QUE 5000

SELECT *
FROM funcionarios
WHERE salario > 5000;

-- ============================================================
-- 5) SELECIONAR TODOS OS DEPARTAMENTOS DISTINTOS

SELECT DISTINCT departamento
FROM funcionarios;

-- ============================================================
-- 6) ATUALIZAR SALÁRIO DOS FUNCIONÁRIOS DO DEPARTAMENTO DE TI

UPDATE funcionarios
SET salario = 7500
WHERE departamento = 'TI';

-- Verificar a alteração
SELECT *
FROM funcionarios
WHERE departamento = 'TI';

-- ============================================================
-- 7) EXCLUIR FUNCIONÁRIOS COM SALÁRIO MENOR QUE 4000

DELETE FROM funcionarios
WHERE salario < 4000;

-- Verificar os registros restantes
SELECT *
FROM funcionarios;

-- ============================================================
-- 8) SELECIONAR NOME E SALÁRIO DOS FUNCIONÁRIOS DE VENDAS
-- COM SALÁRIO MAIOR OU IGUAL A 6000

SELECT nome, salario
FROM funcionarios
WHERE departamento = 'Vendas'
AND salario >= 6000;

-- ============================================================
-- 9) CRIAR A TABELA PROJETOS

CREATE TABLE projetos (
    id_projeto INT PRIMARY KEY,
    nome_projeto VARCHAR(100),
    id_gerente INT,
    FOREIGN KEY (id_gerente) REFERENCES funcionarios(id)
);

-- ============================================================
-- INSERIR PROJETOS

INSERT INTO projetos
(id_projeto, nome_projeto, id_gerente)
VALUES
(1, 'Indietora', 1),
(2, 'Projeto Vendas', 2),
(3, 'Metrolopis', 3);

-- ============================================================
-- SELECIONAR PROJETOS DO GERENTE COM ID 2

SELECT *
FROM projetos
WHERE id_gerente = 2;

-- ============================================================
-- CONSULTA EXTRA: PROJETO + NOME DO GERENTE

SELECT
    projetos.nome_projeto,
    funcionarios.nome AS gerente
FROM projetos
JOIN funcionarios
ON projetos.id_gerente = funcionarios.id;

-- ============================================================
-- 10) REMOVER AS TABELAS

-- A tabela projetos deve ser removida primeiro,
-- pois possui uma FOREIGN KEY relacionada a funcionarios.

DROP TABLE projetos;

DROP TABLE funcionarios;