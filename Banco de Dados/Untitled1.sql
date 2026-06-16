USE aeronautica_db;

-- Procedimento para dar entrada em materiais.
DELIMITER $$

	CREATE PROCEDURE registrar_entrada (
		IN p_id_material INT, IN p_id_fornecedor INT,
        IN p_data_entrada DATE, IN p_quantidade INT,
        IN p_preco DECIMAL(10,2), IN p_nota_fiscal VARCHAR(50)
    )
    BEGIN
		INSERT INTO entradas (id_material, id_fornecedor, data_entrada, quantidade, preco, nota_fiscal)
        VALUES(p_id_material, p_id_fornecedor, p_data_entrada, p_quantidade, p_preco, p_nota_fiscal);
        END;
$$

-- Procedimento para dar entrada em materiais.
DELIMITER $$

	CREATE PROCEDURE registrar_saida (
		IN p_id_material INT, IN p_data_saida DATE,
        IN p_quantidade INT, IN p_destino VARCHAR(50)
	)
	BEGIN
		INSERT INTO saidas (id_material, data_saida, quantidade, destino)
        VALUES (p_id_material, p_data_saida, p_quantidade, p_destino);
END;
$$

-- Procedimento para exclusão lógica de materiais.
DELIMITER $$

	CREATE PROCEDURE inativar_material (IN p_id_material INT)
	BEGIN
		UPDATE materiais
        SET ativo = 0
        WHERE id = p_id_material;
END;
$$

-- Procedimento para exclusão lógica de fornecedores.
DELIMITER $$

	CREATE PROCEDURE inativar_fornecedor (IN p_id_fornecedor INT)
	BEGIN
		UPDATE fornecedores
        SET ativo = 0
        WHERE id = p_id_fornecedor;
END;
$$

-- Função para calcular o estoque.
DELIMITER $$

CREATE FUNCTION calcular_estoque (p_id_material INT)
RETURNS INT 
DETERMINISTIC
BEGIN

	-- Variáveis de apoio.
    DECLARE total_entradas INT DEFAULT 0;
    DECLARE total_saidas INT DEFAULT 0;
    
    -- Verifica quantas entradas ocorreram.
    SELECT IFNULL(SUM(quantidade), 0)
    INTO total_entradas
    FROM entradas
    WHERE id_material = p_id_material;
    
    -- Retorna o estoque calculado.
    RETURN total_entradas - total_saidas;
    END;
$$

-- Cria uma visualização para calcular o estoque geral.
CREATE VIEW consultar_estoque AS 
SELECT
	id, nome,
    medida, estoque_minimo,
    calcular_estoque(id) AS estoque_atual
FROM materiais
ORDER BY nome ASC;

-- Exportação de arquivos.
SELECT * FROM entradas
INTO OUTFILE '/Users/SENAI/Desktop/entradas.csv'
FIELDS TERMINATED BY ';'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


