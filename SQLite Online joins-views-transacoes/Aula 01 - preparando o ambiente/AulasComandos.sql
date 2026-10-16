CREATE TABLE produtos (
  id TEXT PRIMARY KEY,
  nome VARCHAR(255),
  descricao VARCHAR(255),
  preco DECIMAL(10,2),
  categoria VARCHAR(50)
);
CREATE TABLE colaboradores (
  ID TEXT PRIMARY KEY,
  Nome VARCHAR(255) NOT NULL,
  Cargo VARCHAR(100),
  DataContratacao DATE,
  Telefone VARCHAR(20),
  Email VARCHAR(100),
  Rua VARCHAR(100) NOT NULL,
  Bairro VARCHAR(100) NOT NULL,
  Cidade VARCHAR(100) NOT NULL,
  Estado VARCHAR(2) NOT NULL,
  cep VARCHAR(8) NOT NULL
);
CREATE TABLE fornecedores (
  ID TEXT PRIMARY KEY,
  Nome VARCHAR(255) NOT NULL,
  Contato VARCHAR(100) NOT NULL,
  Telefone VARCHAR(20),
  Email VARCHAR(100),
  Rua VARCHAR(100) NOT NULL,
  Bairro VARCHAR(100) NOT NULL,
  Cidade VARCHAR(100) NOT NULL,
  Estado VARCHAR(2) NOT NULL,
  cep VARCHAR(8) NOT NULL
);

CREATE TABLE clientes (
  id TEXT NOT NULL,
  nome VARCHAR(255),
  telefone VARCHAR(20),
  email VARCHAR(100) DEFAULT 'Sem email',
  endereco VARCHAR(255),
  PRIMARY KEY (id)
);

CREATE TABLE pedidos (
  id TEXT PRIMARY KEY,
  idcliente INTEGER,
  datahorapedido DATETIME,
  status VARCHAR(50),
  FOREIGN KEY (idcliente) REFERENCES clientes(id) ON DELETE CASCADE
);


CREATE TABLE itenspedidos (
  idpedido TEXT,
  idproduto TEXT,
  quantidade INTEGER,
  precounitario DECIMAL(10,2),
  PRIMARY KEY (idpedido, idproduto),
  FOREIGN KEY (idpedido) REFERENCES pedidos(id) ON DELETE CASCADE,
  FOREIGN KEY (idproduto) REFERENCES produtos(id) ON DELETE CASCADE
);



SELECT rua, bairro,cidade,cep FROM colaboradores
UNION
SELECT rua, bairro,cidade,cep FROM fornecedores;
--serve para juntar os resultados de duas ou mais consultas SELECT em uma única lista.
--UNION ALL resulta em uma lista que inclui todas as linhas de cada consulta, incluindo duplicatas.
--EXCEPT é usado para retornar todas as linhas que estão presentes na primeira consulta (conjunto A) 
--e não estão presentes na segunda consulta (conjunto B)
--INTERSECT é usado para retornar todas as linhas que estão presentes tanto na primeira consulta 
--(conjunto A) quanto na segunda consulta (conjunto B)

SELECT nome, telefone FROM clientes WHERE id = 
(SELECT idcliente from pedidos 
WHERE datahorapedido = '2023-01-02 08:15:00');
-- Subcuonsulta: é uma consulta SQL aninhada dentro de outra consulta SQL. 
--Ela é usada para retornar um conjunto de resultados que será utilizado pela consulta externa.

SELECT nome, telefone from clientes
WHERE id in (SELECT idcliente from pedidos 
where strftime('%m', datahorapedido) = '01');
-- IN é usado para verificar se um valor está presente em uma lista de valores retornada por uma subconsulta.

SELECT nome,preco
from produtos
GROUP by nome,preco
HAVING preco > (SELECT avg(preco) from produtos);

-- HAVING é usado para filtrar os resultados de uma consulta SQL com base em uma condição aplicada a um grupo de resultados.

SELECT c.nome,p.id, p.datahorapedido from clientes c
inner join pedidos p 
on c.id = p.idcliente;

--inner join é usado para combinar linhas de duas ou mais tabelas com base em uma condição de correspondência entre elas.

SELECT pr.nome, ip.idproduto, ip.idpedido from itenspedidos ip
RIGHT join produtos pr
on pr.id = ip.idproduto;
--RIGHT JOIN é usado para combinar linhas de duas ou mais tabelas, retornando todas as linhas da tabela à direita e as 
--linhas correspondentes da tabela à esquerda. Se não houver correspondência, os valores da tabela à esquerda serão nulos.

---------------------------------------------------------------------------------------------------------------------------
SELECT c.nome, p.id from clientes c
left join pedidos p
on c.id = p.idcliente
WHERE strftime('%m',p.datahorapedido) = '10';
--LEFT JOIN é usado para combinar linhas de duas ou mais tabelas, retornando todas as linhas da tabela à esquerda e as
--linhas correspondentes da tabela à direita. Se não houver correspondência, os valores da tabela à direita serão nulos.
--"mostre o nome dos clientes e IDs do pedido, comece na tabela Clientes, junte com a tabela Pedidos mas mantenha todos os clientes
--da tabela da esquerda, e cliente.id seja igual a pedidos.idcliente, onde a datahorapedido (data do pedido) tenha sido feita no mês 10 (outubro)".

SELECT c.nome, x.id from clientes c
left join 
(SELECT p.id, p.idcliente from pedidos p 
WHERE strftime('%m', p.datahorapedido) = '10') x
on c.id = x.idcliente
WHERE x.idcliente is null;
-- "mostre cliente.nome, X.id da tabela clientes, comece pela tabela clientes, junte com a subconsulta que ira mostrar pedidos.id 
--e pedidos.idcliente da tabela pedidos, onde a datahorapedido (data do pedido) tenha sido feita no mês 10 (outubro),
-- e cliente.id seja igual a pedidos.idcliente, onde X.idcliente seja nulo".

SELECT c.nome, p.id
from clientes c
full join pedidos p
on c.id = p.idcliente;
--full join é usado para combinar linhas de duas ou mais tabelas, retornando todas as linhas de ambas as tabelas.
--"mostre cliente.nome, pedidos.id da tabela clientes, retorne todas as informacoes de ambas as tabelas, onde c.id seja igual a p.idcliente". 

SELECT c.nome, p.id
from clientes c
full join pedidos p
on c.id = p.idcliente
WHERE c.id is null; 
-- "mostre cliente.nome, pedidos.id da tabela clientes, retorne todas as informacoes de ambas as tabelas, onde c.id seja igual a p.idcliente,
--onde c.id seja nulo (pedidos sem clientes)".

SELECT c.nome, p.id
from clientes c
full join pedidos p
on c.id = p.idcliente
WHERE p.id is null; 
--"mostre cliente.nome, pedidos.id da tabela clientes, retorne todas as informacoes de ambas as tabelas, onde c.id seja igual a p.idcliente,
--onde p.id seja nulo (clientes que nao fizeram pedidos)".

SELECT p.id,ip.quantidade,ip.precounitario 
from pedidos p 
join itenspedidos ip
on p.id = ip.idpedido
-- "mostre pedidos.id, itenspedidos.quantidade, itenspedidos.precounitario da tabela pedidos, junto com a tabela itenspedidos, onde produto.id
--seja igual a itenspedidos.idproduto".

SELECT p.id,ip.quantidade,pr.preco,ip.precounitario 
from pedidos p 
join itenspedidos ip
on p.id = ip.idpedido
join produtos pr on pr.id = ip.idproduto;
--"mostre pedidos.id, itenspedidos.quantidade, produtos.preco, itenspedidos.precounitario da tabela pedidos, junto com a tabela itenspedidos, onde produto.id
--seja igual a itenspedidos.idproduto, junto com a tabela produtos, onde produto.id seja igual a itenspedidos.idproduto".
-- para mostrar se o preço na tabela de itenspedidos ja esta multiplicado pela quantidade ou se é apenas o preço unitário do produto.

SELECT p.id,c.nome,ip.precounitario 
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
join itenspedidos ip
on p.id = ip.idpedido
--"mostre pedidos.id, clientes.nome, itenspedidos.precounitario da tabela clientes, junto com a tabela pedidos, onde cliente.id seja igual
-- a pedidos.idcliente, junto com a tabela itenspedidos, onde produto.id seja igual a itenspedidos.idproduto".

SELECT p.id,c.nome,sum(ip.precounitario) as ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
join itenspedidos ip
on p.id = ip.idpedido
GROUP by p.id, c.nome
--"mostre pedidos.id, clientes.nome, a soma de itenspedidos.precounitario da tabela clientes, junto com a tabela pedidos, 
--onde cliente.id seja igual a pedidos.idcliente, junto com a tabela itenspedidos, onde produto.id seja igual a itenspedidos.idproduto,
--agrupando por pedidos.id e clientes.nome".

CREATE VIEW ValorTotalPedido AS
SELECT p.id,c.nome,sum(ip.precounitario) as ValorTotalPedido
FROM clientes c
JOIN pedidos p ON c.id = p.idcliente
join itenspedidos ip
on p.id = ip.idpedido
GROUP by p.id, c.nome;

SELECT * from ValorTotalPedido;
--VIEW é uma tabela virtual baseada no resultado de uma consulta SQL. Ela não armazena dados fisicamente, mas sim a consulta que gera os dados.
--Pode ser aplicados filtros, ordenações e junções em uma VIEW, assim como em uma tabela normal. No entanto, a VIEW não pode ser atualizada diretamente,
--ou seja, não é possível inserir, atualizar ou excluir dados diretamente em uma VIEW.
SELECT nome FROM ViewValorTotalPedido
WHERE ValorTotalPedido > 10;
drop VIEW ValorTotalPedido;
-----------------------------------------------------------------------------------------------------------------------------------------
CREATE TRIGGER CalculaFaturamentoDiario
AFTER INSERT on itenspedidos
for EACH ROW
BEGIN
delete from FaturamentoDiario;
INSERT into FaturamentoDiario(dia,faturamentototal)  
SELECT DATE(datahorapedido) as Dia, sum(ip.precounitario) as FaturamentoDiario 
from pedidos p 
join itenspedidos ip
on p.id = ip.idpedido
group by Dia
ORDER by Dia;
end;
--TRIGGER é um objeto de banco de dados que é associado a uma tabela e é executado automaticamente quando um evento específico
-- ocorre nessa tabela.
--"Crie uma trigger chamada CalculaFaturamentoDiario que sera executada apos inserção de infomarções na tabela itenspedidos,
-- para cada linha inserida, que irá deletar os dados da tabela FaturamentoDiario e inserir o dia e o faturamento total do dia,
-- que é a soma do preço unitário dos itens pedidos agrupados por dia, ordenados por dia".
--PRAGMA foreign_keys = ON;
INSERT INTO Pedidos(ID, IDCliente, DataHoraPedido, Status)
VALUES (451, 27, '2023-10-07 14:30:00', 'Em Andamento');
INSERT INTO Pedidos (ID, IDCliente, DataHoraPedido, Status) 
VALUES (452, 28, '2023-10-07 14:35:00', 'Em Andamento');
INSERT INTO ItensdePedido(IDPedido, IDProduto, Quantidade, PrecoUnitario)
VALUES (451, 14, 1, 6.0),
         (451, 13, 1, 7.0);
INSERT INTO ItensdePedido(IDPedido, IDProduto, Quantidade, PrecoUnitario) VALUES (452, 10, 1, 5.0),
         (452, 31, 1, 12.50);
--Dados inseridos para testar a trigger CalculaFaturamentoDiario, que ira delatar os dados anteriores ao INSERT em ItensdePedidos
-- e inserir os novos dados na tabela FaturamentoDiario, com o dia e o faturamento total do dia, que é a soma do preço unitário dos
-- itens pedidos agrupados por dia, ordenados por dia.
--PRAGMA foreign_keys = ON
--O pragma é uma funcionalidade exclusiva do SQLite online. Usada para modificar as configuraçõe e validar nossas chaves estrangeiras.

UPDATE produtos set preco = 13.0 WHERE id = 30;
SELECT * FROM produtos;
--UPTADATE é usado para modificar os dados existentes em uma tabela. O comando UPDATE altera os valores das colunas especificadas 
--para as linhas que atendem a uma condição específica.
--Atualiza o preço do produto com id 30 para 13.0 e seleciona todos os produtos para verificar a atualização.
UPDATE produtos set descricao = 'Croissant recheado com amendoas' WHERE id = 28
SELECT * from produtos WHERE nome like 'croissant%';
--Atualiza a descrição do produto com id 28 para 'Croissant recheado com amendoas' e seleciona todos os produtos cujo nome começa
-- com 'croissant' para verificar a atualização.

DELETE FROM clientes where id = 27;
--DELETE é usado para remover linhas de uma tabela com base em uma condição específica.
--como havia em outras tabelas, colunas que faziam referência a esse cliente, apos o comando pragma foreign_keys = ON, o SQLite online
--permitirar que essas linhas sejam deletadas, pois os compos referenciados em outras tabelas serão deletados automaticamente com
--ON DELETE CASCADE, que foi definido na criação da tabela pedidos e itenspedidos.

BEGIN TRANSACTION;
UPDATE pedidos set status = 'Cncluido'
DELETE from clientes
SELECT * from pedidos
SELECT * from clientes
ROLLBACK;
--BEGIN TRANSACTION inicia uma transação, que é um conjunto de operações que são executadas como uma única unidade de trabalho.
--ROLLBACK desfaz todas as operações realizadas desde o início da transação, revertendo o banco de dados para o estado anterior à transação.
--COMMIT finaliza a transação, tornando permanentes todas as operações realizadas desde o início da transação.