-- Deleta a base de dados casojá exista.
DROP DATABASE IF EXISTS oficina_mecanica_db;

-- Cria a base de dados.
CREATE DATABASE IF NOT EXISTS oficina_mecanica;

-- Define o uso da base de dados.
USE oficina_mecanica;

-- Cria a tabela de clientes.
CREATE TABLE IF NOT EXISTS clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(15) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  email VARCHAR(100) NOT NULL UNIQUE,
  endereco_completo VARCHAR(255)
);

-- Cria a tabela de veículos.
CREATE TABLE IF NOT EXISTS veiculos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_cliente INT NOT NULL,
  placa VARCHAR(10) NOT NULL UNIQUE,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  ano_fabricacao INT NOT NULL,
  chassi VARCHAR(20) NOT NULL UNIQUE,

  -- Definição da chave estrangeira.
  FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

-- Cria a tabela de mecânicos.
CREATE TABLE IF NOT EXISTS mecanicos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf VARCHAR(15) NOT NULL UNIQUE,
  telefone VARCHAR(20),
  email VARCHAR(100) NOT NULL UNIQUE,
  data_contratacao DATE NOT NULL,
  funcao VARCHAR(50) NOT NULL
);

-- Tabela de ordens de serviço.
CREATE TABLE IF NOT EXISTS ordens_servico (
  id INT AUTO_INCREMENT PRIMARY KEY,
  id_veiculo INT NOT NULL,
  id_mecanico INT NOT NULL,
  data_abertura DATE NOT NULL,
  estimativa_entrega DATE NOT NULL,
  status VARCHAR(20) NOT NULL,
  descricao TEXT NOT NULL,
  valor_total DECIMAL(10,2) NOT NULL,

  -- Definição das chaves estrangeiras.
  FOREIGN KEY (id_veiculo) REFERENCES veiculos(id),
  FOREIGN KEY (id_mecanico) REFERENCES mecanicos(id)
);

-- Exibe as tabelas criadas.
SHOW TABLES;

-- Exibe detalhes das tabelas criadas.
DESCRIBE clientes;
DESCRIBE veiculos;
DESCRIBE mecanicos;
DESCRIBE ordens_servico;