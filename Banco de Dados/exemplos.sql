-- Define a base de dados que será usada.
USE oficina_mecanica;

-- Filtragem simples usando o nome.
SELECT * FROM clientes
WHERE nome = 'João da Silva';

-- Filtragem das ordens de servico com valor maior que 150 reais.
SELECT * FROM ordens_servico
WHERE valor_total > 150;

-- Filtragem dos veiculos fabricados a partir de 2018.
SELECT * FROM veiculos
WHERE ano_fabricacao >= 2018;

-- Filtragem de mecanicos contratados após 2024 e especialista em freios.
SELECT * FROM mecanicos
WHERE data_contratacao > '2024-01-01'
AND funcao = 'Especialista em Freios';

-- Selecione o nome, CPF e o telefone de todos os mecanicos.
SELECT nome , cpf, telefone FROM mecanicos;

-- Selecione o ID do veiculo, descricao e o valor total de ordens de servico abertas.

SELECT id_veiculo , descricao, valor_total FROM ordens_servico
WHERE status = 'Aberta';

-- Filtragem de clientes de Botucatu e Pardinho.
SELECT nome, cpf, telefone, endereco_completo FROM clientes
WHERE endereco_completo LIKE '%Botucatu%'
OR endereco_completo LIKE '%Pardinho%';

-- Filtragem de veiculos que nao são da Fiat.
SELECT * FROM veiculos
WHERE NOT marca = 'Fiat';

-- Exibiçao de todos os clientes em ordem alfabetica (A ao Z).
SELECT * FROM clientes
ORDER BY nome ASC;

-- Exibicao de todos os veiculos do mais novo para o mais antigo.
SELECT * FROM veiculos
ORDER BY ano_fabricacao DESC;

