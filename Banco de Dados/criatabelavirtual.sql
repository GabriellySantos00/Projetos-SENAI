-- Define o uso da base de dados.
USE vendas_online_db;

-- Consultas simples nas tabelas existentes.
SELECT * FROM clientes;
SELECT * FROM pedidos;

-- Cria uma tabela virtual para apresentar todos os pedidos.
CREATE VIEW pedidosFeitos AS 
SELECT c.nome AS nomeCliente,
		p.valor AS valorPedido,
        p.data_pedido AS dataPedido
FROM clientes c
JOIN pedidos p ON c.id = p.id_cliente
ORDER BY dataPedido DESC;

-- Exibe a tabela virtual.
SELECT * FROM pedidosFeitos;


-- Cria uma tabela virtual para resumir informações dos pedidos.
CREATE VIEW pedidosClientes AS 
SELECT c.nome AS nomeCliente,
		COUNT(p.id) AS quantidadePedidos,
        SUM(p.valor) AS totalGasto
FROM clientes c
JOIN pedidos p ON c.id = p.id_cliente
GROUP BY nomeCliente;

-- Exibe a tabela virtual.
SELECT * FROM pedidosClientes;
