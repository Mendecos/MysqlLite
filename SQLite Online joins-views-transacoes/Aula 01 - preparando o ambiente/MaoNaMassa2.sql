
-- EXERCÍCIOS SQL - BANCO DE DADOS SERENATTO
-- 1. Traga todos os dados da cliente Maria Silva.

SELECT *
FROM clientes
WHERE nome = 'Maria Silva';


-- 2. Busque o ID do pedido e o ID do cliente
-- dos pedidos onde o status esteja como entregue.

SELECT id, idcliente
FROM pedidos
WHERE status = 'Entregue';


-- 3. Retorne todos os produtos onde o preço
-- seja maior que 10 e menor que 15.

SELECT *
FROM produtos
WHERE preco > 10
  AND preco < 15;


-- 4. Busque o nome e o cargo dos colaboradores
-- contratados entre 2022-01-01 e 2022-06-30.

SELECT nome, cargo
FROM colaboradores
WHERE DATE(datacontratacao)
BETWEEN '2022-01-01' AND '2022-06-30';


-- 5. Recupere o nome do cliente que fez o primeiro pedido.

SELECT c.nome
FROM pedidos p
INNER JOIN clientes c
    ON p.idcliente = c.id
ORDER BY p.datahorapedido ASC, p.id ASC
LIMIT 1;


-- 6. Liste os produtos que nunca foram pedidos.

SELECT pr.*
FROM produtos pr
LEFT JOIN itenspedidos ip
    ON pr.id = ip.idproduto
WHERE ip.idproduto IS NULL;


-- 7. Liste os nomes dos clientes que fizeram pedidos
-- entre 2023-01-01 e 2023-12-31.

SELECT DISTINCT c.nome
FROM clientes c
INNER JOIN pedidos p
    ON c.id = p.idcliente
WHERE p.datahorapedido >= '2023-01-01'
  AND p.datahorapedido < '2024-01-01';


-- 8. Recupere os nomes dos produtos que estão
-- em menos de 15 pedidos.

SELECT pr.nome
FROM produtos pr
LEFT JOIN itenspedidos ip
    ON pr.id = ip.idproduto
GROUP BY pr.id, pr.nome
HAVING COUNT(DISTINCT ip.idpedido) < 15;


-- 9. Liste os produtos e o ID do pedido realizados
-- pelos clientes Pedro Alves ou Ana Rodrigues.

SELECT pr.nome AS produto,
       p.id AS id_pedido
FROM produtos pr
INNER JOIN itenspedidos ip
    ON pr.id = ip.idproduto
INNER JOIN pedidos p
    ON ip.idpedido = p.id
INNER JOIN clientes c
    ON p.idcliente = c.id
WHERE c.nome IN ('Pedro Alves', 'Ana Rodrigues')
ORDER BY c.nome, p.id;


-- 10. Recupere o nome e o ID do cliente que mais
-- comprou em valor no Serenatto.

SELECT c.nome,
       c.id AS id_cliente,
       SUM(ip.precounitario) AS total_comprado
FROM clientes c
INNER JOIN pedidos p
    ON c.id = p.idcliente
INNER JOIN itenspedidos ip
    ON p.id = ip.idpedido
GROUP BY c.id, c.nome
ORDER BY total_comprado DESC
LIMIT 1;

