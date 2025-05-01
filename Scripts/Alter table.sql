-- =============================================
-- SCRIPTS DE ALTERAÇÃO (DDL)
-- =============================================

-- Script 1: Adicionar coluna de email ao departamento
ALTER TABLE departamentos ADD COLUMN email_departamento VARCHAR(100);

-- Script 2: Aumentar tamanho do campo biografia em autores
ALTER TABLE autores MODIFY COLUMN biografia TEXT NOT NULL;

-- Script 3: Adicionar campo de desconto na tabela de itens pedido
ALTER TABLE itenspedido ADD COLUMN desconto DECIMAL(5,2) DEFAULT 0.00;

-- Script 4: Adicionar índice para busca por nome de autor
ALTER TABLE autores ADD INDEX idx_autores_nome (nome);

-- Script 5: Adicionar restrição de verificação para número de páginas
ALTER TABLE livros ADD CONSTRAINT chk_num_paginas CHECK (num_paginas > 0);

-- Script 6: Adicionar coluna de avaliação para livros
ALTER TABLE livros ADD COLUMN avaliacao DECIMAL(3,1) DEFAULT NULL;

-- Script 7: Modificar o tipo de dados do campo telefone em clientes
ALTER TABLE clientes MODIFY COLUMN telefone VARCHAR(30);

-- Script 8: Adicionar campo de observação para pedidos
ALTER TABLE pedidos ADD COLUMN observacao TEXT;

-- Script 9: Adicionar campo para controle de estoque mínimo
ALTER TABLE exemplares ADD COLUMN estoque_minimo INT DEFAULT 5;

-- Script 10: Adicionar coluna de data de atualização em livros
ALTER TABLE livros ADD COLUMN data_atualizacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;