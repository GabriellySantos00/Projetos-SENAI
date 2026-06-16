-- Deleta o banco de dados caso já exista.
DROP DATABASE IF EXISTS agroindustria_db;

-- Cria o banco de dados.
CREATE DATABASE agroindustria_db;

-- Define o uso da base de dados.
USE agroindustria_db;

-- Cria a tabela de setores.
CREATE TABLE setor (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(40) NOT NULL,
descricao TEXT
);

-- Cria a tabela de medidas do processo produtivo para cada setor.
CREATE TABLE medidas (
id INT PRIMARY KEY AUTO_INCREMENT,
id_setor INT NOT NULL,
data_hora DATETIME NOT NULL,
variavel VARCHAR(20) NOT NULL,
valor DECIMAL(10,2) NOT NULL,

-- Define a chave estrangeira.
FOREIGN KEY (id_setor) REFERENCES setor(id)
);

-- Cadastro dos setores.
INSERT INTO setor (nome, descricao) VALUES
('Moagem', 'Responsável pela extração do caldo da cana-de-açúcar.'),
('Clarificação', 'Remove impurezas do caldo e ajusta pH.'),
('Evaporação', 'Concentra o caldo por remoção de água.'),
('Fermentação', 'Converte açúcares em etanol através de leveduras.'),
('Destilação', 'Separa o etanol produzido na fermentação.'),
('Caldeira', 'Gera vapor para os processos industriais.');

-- Registro das medidas coletadas.
INSERT INTO medidas (id_setor, data_hora, variavel, valor) VALUES
(1, '2025-10-09 08:00:00', 'VAZÃO', 210.50),
(1, '2025-10-09 08:10:00', 'TEMP', 32.80),
(2, '2025-10-09 08:20:00', 'PH', 6.45),
(2, '2025-10-09 08:30:00', 'BRIX', 13.20),
(3, '2025-10-09 08:40:00', 'TEMP', 78.50),
(3, '2025-10-09 08:50:00', 'BRIX', 36.70),
(4, '2025-10-09 09:00:00', 'PH', 4.60),
(4, '2025-10-09 09:10:00', 'TEMP', 33.90),
(5, '2025-10-09 09:20:00', 'ETOH', 92.10),
(6, '2025-10-09 09:30:00', 'PRESSÃO', 17.80);

 -- Consultas simples nas duas tabelas.
SELECT * FROM setor;
SELECT * FROM medidas;

-- 1. Liste o ID, a variável e o valor de todas as medições, ordenando da mais recente para a mais antiga, por data e hora decrescente.
SELECT id, variavel, valor, data_hora
FROM medidas
ORDER BY data_hora DESC;

-- 2. Mostre as medições em que a variável seja TEMP (Temperatura do Processo), ordenadas do maior para o menor valor.

SELECT * FROM medidas
WHERE variavel = "TEMP"
ORDER BY valor DESC;


-- 3. Exiba as medições de BRIX (Concentração de Açucares) cujo valor esteja entre 30 e 80 %, ordenadas do menor para o maior valor.

SELECT * FROM medidas
WHERE variavel = "BRIX"
AND valor BETWEEN 30 AND 80
ORDER BY valor ASC;

-- 4. Exiba a quantidade de medidas de cada variável (VAZÃO, TEMP, PH, BRIX e ETOH), ordenadas da maior para a menor contagem.

SELECT variavel, COUNT(*) AS quantidade
FROM medidas
GROUP BY variavel
ORDER BY quantidade DESC;

-- 5. Exiba o valor médio de cada variável (VAZÃO, TEMP, PH, BRIX e ETOH), ordenadas do maior para o menor valor médio.

SELECT variavel, AVG(valor) AS valorMedio
FROM medidas
GROUP BY variavel
ORDER BY valorMedio DESC;

-- 6. Para cada variável (VAZÃO, TEMP, PH, BRIX e ETOH), exiba o menor valor (mínimo) e o maior valor (máximo), ordenados pelo nome da variável do A ao Z.

SELECT variavel, 
		MIN(valor) AS valorMinimo,
		MAX(valor) AS valorMaximo
FROM medidas
GROUP BY variavel
ORDER BY variavel ASC;

-- 7. Apresente, para cada setor (exibindo o nome), a média dos valores de TEMP(Temperatura do Processo), ordenando do maior para o menor valor médio.	
SELECT s.nome AS nomeSetor,
		AVG(m.valor) AS valorMedio
        FROM setor s
        JOIN medidas m ON m.id_setor = s.id
        GROUP BY nomeSetor 
        ORDER BY valorMedio DESC;
        
-- 8. Mostre o maior e o menor valor de ETOH (Teor de Etanol no Produto) para cada setor (exibindo o nome), ordenando pelo nome do setor de A ao Z.

SELECT s.nome AS nomeSetor,
		MIN(m.valor) AS valorMinimo,
		MAX(m.valor) AS valorMaximo
        FROM setor s
        JOIN medidas m ON m.id_setor = s.id
        GROUP BY nomeSetor 
        ORDER BY nomeSetor ASC;
        

-- 9. Exiba quantas medições existem no total para cada setor (exibindo o nome), e ordenando do maior para o menor número total de medição.
SELECT s.nome AS nomeSetor,
		COUNT(m.id) AS total
        FROM setor s
        JOIN medidas m ON m.id_setor = s.id
        GROUP BY nomeSetor 
        ORDER BY Total DESC;

