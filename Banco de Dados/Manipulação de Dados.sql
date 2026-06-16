-- Define o banco de dados que será utilizada
USE biblioteca_db;

-- Insere um novo registro a tabela de alunos.
INSERT INTO aluno (nome, nascimento, cpf, registro_aluno, curso)
VALUES ( 'Ana Clara de Souza', '2004-04-15', '111.222.333-44', 'SN01', 'Python');

-- Insere um novo registro a tabela de alunos.
INSERT INTO aluno (nome, nascimento, cpf, registro_aluno, curso)
VALUES ( 'Bruno de Lima da Costa', '2006-08-22', '555.666.777-88', 'SN02', 'Java');

-- Exibe todos os registros de uma tabela.
SELECT * FROM aluno;


-- Insere um novo registro a tabela de livros.
INSERT INTO livro (titulo, autor, editora, genero_literario, numero_paginas, ano_publicacao)
VALUES( 'SQL Duvidoso', 'Allen Taylor', 'Sem Ideias', 'TI', 500, 2020);

-- Insere um novo registro a tabela de livros.
INSERT INTO livro (titulo, autor, editora, genero_literario, numero_paginas, ano_publicacao)
VALUES( 'Engenharia de Software', 'Ian Sommerlie', 'Pearson', 'TI', 550, 2020);



-- Exibe todos os registros da tabela de livros.
SELECT * FROM livro


