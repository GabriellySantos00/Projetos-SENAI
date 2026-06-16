
-- Cria o banco de dados.
DROP DATABASE IF EXISTS papyro;
CREATE DATABASE IF NOT EXISTS papyro;
USE papyro;

-- Cria a tabela de leitores.
DROP TABLE IF EXISTS leitores;
CREATE TABLE IF NOT EXISTS leitores (
  cpf varchar(15) NOT NULL,
  nome varchar(100) NOT NULL,
  endereco varchar(200) DEFAULT NULL,
  telefone varchar(20) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  ativo int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (cpf) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Cria a tabela de livros.
DROP TABLE IF EXISTS livros;
CREATE TABLE IF NOT EXISTS livros (
  isbn varchar(20) NOT NULL,
  titulo varchar(200) NOT NULL,
  autor varchar(100) DEFAULT NULL,
  editora varchar(20) DEFAULT NULL,
  ano_publicacao year(4) DEFAULT NULL,
  edicao varchar(20) DEFAULT NULL,
  genero varchar(100) DEFAULT NULL,
  ativo int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (isbn) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Cria a tabela de empréstimos.
DROP TABLE IF EXISTS emprestimos;
CREATE TABLE IF NOT EXISTS emprestimos (
  id int(11) NOT NULL AUTO_INCREMENT,
  cpf_leitor varchar(15) DEFAULT NULL,
  isbn_livro varchar(20) DEFAULT NULL,
  data_emprestimo date DEFAULT NULL,
  fornecedor VARCHAR(100),
  ativo int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (id),
  KEY FK_LEITOR (cpf_leitor),
  KEY FK_LIVRO (isbn_livro),
  CONSTRAINT FK_LEITOR FOREIGN KEY (cpf_leitor) REFERENCES leitores (cpf) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_LIVRO FOREIGN KEY (isbn_livro) REFERENCES livros (isbn) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;