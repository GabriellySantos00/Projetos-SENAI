-- Cria o banco de dados se ainda não existir
CREATE DATABASE IF NOT EXISTS biblioteca_db;

-- Define o uso da base de dados
USE biblioteca_db;

-- Cria a tabela de aluno
CREATE TABLE aluno (

	-- Atributos do aluno
	id INT AUTO_INCREMENT PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	nascimento DATE NOT NULL,
	cpf VARCHAR(14) NOT NULL,
    registro_aluno VARCHAR(20) NOT NULL,
    curso VARCHAR(50) NOT NULL
);

-- Exibe os detalhes da tabela aluno
DESCRIBE aluno;

-- Cria a tabela de livro
CREATE TABLE IF NOT EXISTS livro(
	id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    autor VARCHAR(100) NOT NULL,
    editora VARCHAR(100) NOT NULL,
    genero_literario VARCHAR(100) NOT NULL,
    numero_paginas INT NOT NULL,
    ano_publicacao YEAR NOT NULL
);

-- Exibe os detalhes da tabela livro
DESCRIBE livro;

-- Cria a tabela de empréstimo (associação)

CREATE TABLE IF NOT EXISTS emprestimo (
	
    -- Atributos do empréstimo.
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_aluno INT NOT NULL, 
    id_livro INT NOT NULL,
    data_emprestimo DATETIME NOT NULL,
    data_devolucao DATETIME NOT NULL,
    FOREIGN KEY (id_aluno) REFERENCES aluno (id),
    FOREIGN KEY (id_livro) REFERENCES livro (id)
    
);

