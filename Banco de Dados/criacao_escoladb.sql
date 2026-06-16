-- Cria o banco de dados.
DROP DATABASE IF EXISTS escola_db;
CREATE DATABASE escola_db;

-- Define a base de dados que será usada.
USE escola_db;

-- Cria a tabela para armazenar dados dos alunos.
CREATE TABLE alunos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(125) NOT NULL,
  cpf VARCHAR(14) NOT NULL UNIQUE,
  nascimento DATE NOT NULL,
  
  -- Exclusão lógica. tinyint (inteiro de um valor só)
  ativo TINYINT(1) NOT NULL DEFAULT 1,

  -- Índice para melhorar o desempenho em consultas.
  INDEX idx_nome (nome)
);

-- Cria a tabela para armazenar dados dos cursos.
CREATE TABLE cursos (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(125) NOT NULL UNIQUE,
  area VARCHAR(125) NOT NULL,
  carga_horaria INT NOT NULL,
  
   -- Exclusão lógica. tinyint (inteiro de um valor só)
  ativo TINYINT(1) NOT NULL DEFAULT 1,

  -- Índice para melhorar o desempenho em consultas.
  INDEX idx_area (area)
);

-- Cria a tabela para registrar as matrículas dos alunos em cursos.
CREATE TABLE matriculas (
  id INT PRIMARY KEY AUTO_INCREMENT,
  id_aluno INT NOT NULL,
  id_curso INT NOT NULL,
  data_matricula DATE NOT NULL DEFAULT (CURRENT_DATE), -- Pega a data diretamente do sistema operacional (atual)
  
   -- Exclusão lógica. tinyint (inteiro de um valor só)
  ativo TINYINT(1) NOT NULL DEFAULT 1,

  -- Chaves estrangeiras.
  FOREIGN KEY (id_aluno) REFERENCES alunos(id),
  FOREIGN KEY (id_curso) REFERENCES cursos(id),

  -- Índice para melhorar o desempenho em consultas.
  INDEX idx_data_matricula (data_matricula)
);


-- Insere alguns regitros de alunos.
INSERT INTO alunos (nome, cpf, nascimento, ativo) VALUES
('Ana Clara Souza', '123.456.789-00', '2000-05-10', 1),
('Bruno Martins', '987.654.321-00', '1998-09-02', 1),
('Carlos Eduardo', '555.666.777-88', '2001-11-20', 1),
('Daniela Castro', '111.222.333-44', '1999-01-15', 1),
('Eduardo Lima', '999.888.777-66', '2002-03-28', 1);

-- Insere alguns registros de cursos.
INSERT INTO cursos (nome, area, carga_horaria, ativo) VALUES
('Excel Básico', 'Informática', 24, 1),
('Lógica de Programação', 'Tecnologia', 40, 1),
('Inglês para Iniciantes', 'Idiomas', 60, 1),
('Fotografia Digital', 'Artes', 36, 1),
('Marketing Pessoal', 'Comunicação', 20, 1);

-- Insere algumas matrículas.
INSERT INTO matriculas (id_aluno, id_curso, data_matricula, ativo) VALUES
(1, 1, '2024-02-10', 1),
(1, 2, '2024-03-05', 1),
(2, 2, '2024-04-15', 1),
(2, 3, '2024-06-20', 1),
(3, 1, '2024-07-10', 1),
(3, 4, '2024-08-05', 1),
(4, 5, '2024-09-10', 1),
(5, 3, '2024-10-12', 1);