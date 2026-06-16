-- Seleciona o banco de dados.
USE aeronautica_db;

-- insere os dados dos materiais.
INSERT INTO materiais (id, nome, descricao, medida, estoque_minimo, ativo) VALUES
(1, 'Chapa de alumínio', 'Chapa de alumínio de liga 6061-T6', 'm²', 100, 1),
(2, 'Tubo de titânio', 'Tubo de titânio grau 5', 'm', 50, 1),
(3, 'Parafuso de aço inoxidável', 'Parafuso de aço inoxidável AISI 316', 'unidade', 200, 1),
(4, 'Fio de cobre', 'Fio de cobre esmaltado', 'm', 150, 1),
(5, 'Rebite de alumínio', 'Rebite de alumínio sólido', 'unidade', 300, 1),
(6, 'Chapa de fibra de carbono', 'Chapa de fibra de carbono pré-impregnada', 'm²', 80, 1),
(7, 'Resina epóxi', 'Resina epóxi para laminação', 'kg', 40, 1),
(8, 'Tecido de fibra de vidro', 'Tecido de fibra de vidro para laminação', 'm²', 120, 1),
(9, 'Pintura poliuretânica', 'Pintura poliuretânica para aeronaves', 'l', 30, 1),
(10, 'Adesivo estrutural', 'Adesivo estrutural de alta resistência', 'kg', 25, 1);


-- Insere os dados dos fornecedores.
INSERT INTO fornecedores (id, nome, contato, telefone, ativo) VALUES
(1, 'Aerometalúrgica do Sudeste', 'João Silva', '(11) 9999-9999', 1),
(2, 'Titânio do Brasil', 'Maria Souza', '(21) 3333-3333', 1),
(3, 'Fixadores Industriais', 'Pedro Santos', '(31) 2222-2222', 1),
(4, 'Condutor Elétrico', 'Ana Oliveira', '(41) 5555-5555', 1),
(5, 'Rebites e Fixadores', 'Carlos Rodrigues', '(19) 8888-8888', 1),
(6, 'Fibra & Carbono Technology', 'Juliana Almeida', '(11) 4444-4444', 1),
(7, 'Epoxi & Compostos', 'Roberto Mendes', '(27) 7777-7777', 1),
(8, 'Fibra de Vidro do Brasil', 'Fernanda Costa', '(48) 6666-6666', 1),
(9, 'Tintas Aeronáuticas', 'Marcelo Santos', '(11) 2222-2222', 1),
(10, 'Adesivos Especiais', 'Patricia Lima', '(47) 9999-9999', 1);

-- Seleciona os daos que foram importantes.
SELECT * FROM materiais;
SELECT * FROM fornecedores;

