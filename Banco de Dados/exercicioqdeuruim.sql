-- Cria o banco de dados.
DROP DATABASE IF EXISTS vendas_online_db;
CREATE DATABASE vendas_online_db;

-- Define o uso da base de dados.
USE vendas_online_db;

-- Cria a tabela para armazenar dados de clientes.
CREATE TABLE clientes (
	id INT AUTO_INCREMENT PRIMARY KEY , 
	nome VARCHAR(100) NOT NULL,
	cpf VARCHAR (14) NOT NULL UNIQUE,
	email VARCHAR (100) NOT NULL,
	cidade VARCHAR (100) NOT NULL,
 
	-- Cria um indice de desempenho para filtragens.
	INDEX idx_cidade (cidade)
);

-- Cria tabela para armazenar dados de pedidos. 
CREATE TABLE pedidos (
		id INT AUTO_INCREMENT PRIMARY KEY,
        id_cliente INT NOT NULL,
        valor DECIMAL (10,2) NOT NULL,
        data_pedido DATE NOT NULL,
        
-- Cria a chave estrangeira com a tabela de clientes. (boa prática)
        FOREIGN KEY (id_cliente) REFERENCES clientes (id)
        );
        
-- Cria um índicie de desempemho para filtragens. 
CREATE INDEX idx_data_pedido ON pedidos (data_pedido);
        
-- Cria tabela para armazenar dados de entregas. 
 CREATE TABLE entrega (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    data_entrega DATE NOT NULL,
    status VARCHAR (50) NOT NULL,
    valor_frete DECIMAL (10,2) NOT NULL,
    
    -- Cria a chave estrangeira com a tabela de pedidos.
    FOREIGN KEY (id_pedido) REFERENCES pedidos (id),
    
     -- Cria um índice de desempenho para filtragens.
    INDEX idx_data_entrega (data_entrega)
 );   
 
-- Cria a tabela para armazenar dados de pedidos.
CREATE TABLE pedidos (
	id INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    data_pedido DATE NOT NULL,
    
    -- Cria a chave estrangeira com a tabela de clientes.
    FOREIGN KEY (id_cliente) REFERENCES clientes (id)
);

-- Cria um indice de desempenho para filtragens.
CREATE INDEX idx_data_pedido ON pedidos (data_pedido);


-- Insere novos clientes com e-mail.
INSERT INTO clientes (nome, cpf, email, cidade)
VALUES ('Ana Souza',   '11111111111', 'ana.souza@exemplo.com.br',   'São Paulo'),
       ('Bruno Lima',  '22222222222', 'bruno.lima@exemplo.com.br',  'São Paulo'),
       ('Carla Nunes', '33333333333', 'carla.nunes@exemplo.com.br', 'Rio de Janeiro'),
       ('Diego Martins','44444444444','diego.martins@exemplo.com.br','Curitiba'),
       ('Elisa Rocha', '55555555555', 'elisa.rocha@exemplo.com.br', 'São Paulo');

-- Insere novos pedidos (inalterado).
INSERT INTO pedidos (id_cliente, valor, data_pedido)
VALUES (1, 150.00, '2025-01-10'),
       (1,  89.90, '2025-02-05'),
       (2, 320.00, '2025-03-12'),
       (3, 500.00, '2025-04-01'),
       (3,  75.50, '2025-04-15'),
       (4, 120.00, '2025-05-02');
       
INSERT INTO entregas (id_pedido, data_entrega, status, valor_frete)
VALUES (1, '2025-01-13', 'Entregue', 25,00),
		(2, '2025-02-07', 'Entregue', 18,50),
        (3, '2025-03-20', 'Cancelada', 0,00),
        (4, '2025-04-05', 'Entregue', 35,00),
        (5, '2025-04-17', 'Pendente', 28,90),
        (6, '2025-05-16', 'Entregue', 22,00);