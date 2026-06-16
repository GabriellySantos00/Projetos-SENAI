-- Define a base de dados que será usada.
USE varejo_db;

-- Exibe todos os valores da tabela de categorias.
SELECT * FROM categorias;

-- Exibe todos os valores da tabela de produtos.
SELECT * FROM produtos;

-- Quantidade de produtos que a loja vende.
SELECT COUNT(nome) AS "Quantidade de Produtos"
FROM produtos;

-- Quantidade de produtos em estoque.
SELECT SUM(estoque) AS "Itens em Estoque"
FROM produtos;

-- Quantidade de produtos em estoque por categoria.
SELECT id_categoria, SUM(estoque) AS "Itens em Estoque"
FROM produtos
GROUP BY id_categoria;

-- Preço médio, máximo e mínimo dos produtos no geral.
SELECT AVG(preco), MIN(preco), MAX(preco)
FROM produtos;

-- Preço medio, maximo e minimo por categoria
SELECT id_categoria, AVG(preco), MIN(preco), MAX(preco)
FROM produtos
GROUP BY id_categoria;

-- Qual é o preço médio, maximo e minimo da categoria de eletronicos.
SELECT id_categoria, AVG(preco), MIN(preco), MAX(preco)
FROM produtos
WHERE id_categoria = 1;

-- Preço médio de produtos maiores que 100,00 por categoria. 
SELECT id_categoria, AVG(preco)
FROM produtos
WHERE preco > 100.00
GROUP BY id_categoria;

-- Valor total de venda dos produtos em estoque.
SELECT SUM(preco * estoque) AS "Total"
FROM produtos
GROUP BY id_categoria;

-- Valor total de venda para cada produto em estoque.
SELECT nome, (preco * estoque) AS "Total"
FROM produtos;

-- DESAFIO (30 minutos):
-- 1) Quantos produtos estão cadastrados na categoria de roupas?

SELECT COUNT(nome) AS "Total"
FROM produtos
WHERE id_categoria = 2;


-- 2) Qual é o preço médio de todos os produtos da loja que possuem estoque maior que zero?

SELECT AVG(estoque) AS "Preço Médio"
FROM produtos
WHERE estoque > 0;

-- 3) Qual é o valor do produto mais caro e do produto mais barato de cada categoria?

SELECT id_categoria, 
	MIN(preco) AS "Mais Barato",
	MAX(preco) AS "Mais Caro"
FROM produtos
WHERE id_categoria;

-- 4) Quantas categorias existem cadastradas em cada setor?

SELECT setor,
	COUNT(nome) AS "Quantidade"
FROM categorias
GROUP BY setor;

-- 5) Qual é a soma total de itens em estoque por categoria, excluindo os produtos que custam R$ 100,00 ou mais?

SELECT id_categoria, 
	SUM(preco) AS "Total"
FROM produtos
WHERE preco < 100.00
GROUP BY id_categoria;
