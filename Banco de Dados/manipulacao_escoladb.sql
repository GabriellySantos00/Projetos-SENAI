-- define o uso da base de dados
USE escola_db;

-- Consultas simples.
SELECT * FROM alunos;
SELECT * FROM cursos;
SELECT * FROM matriculas;

-- Exclusão lógica de alunos.
CALL excluir_aluno (5);
CALL excluir_aluno (1);

-- Exclusão lógica de cursos.
CALL excluir_curso (4);
CALL excluir_curso (2);

-- Exclusão lógica de matriculas.
CALL excluir_matricula (2);
CALL excluir_matricula (6);

-- Altera a carga horaria de alguns cursos. 
CALL alterar_carga_horaria (80, 2);
CALL alterar_carga_horaria (40, 5);

-- Chama a função para calcular a idade de um aluno.
SELECT calcular_idade(1);

-- Chama a função para calcular as matriculas de um aluno.
SELECT matriculas_alunos(4);

SELECT matriculas_totais(1);

SELECT matriculas_concluidas(4);

SELECT totalizar_alunos(3);

SELECT cursos_area(2);

