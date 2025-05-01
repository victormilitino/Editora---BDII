-- =============================================
-- SCRIPTS DE DESTRUIÇÃO (DDL)
-- =============================================


-- Script 1: Remover tabelas de associação
DROP TABLE IF EXISTS livrospalavraschave;
DROP TABLE IF EXISTS livrosautores;

-- Script 2: Remover tabela de itens pedido
DROP TABLE IF EXISTS itenspedido;

-- Script 3: Remover tabela de pedidos
DROP TABLE IF EXISTS pedidos;

-- Script 4: Remover tabela de exemplares
DROP TABLE IF EXISTS exemplares;

-- Script 5: Remover tabela de funcionários
DROP TABLE IF EXISTS funcionarios;

-- Script 6: Remover tabela de livros
DROP TABLE IF EXISTS livros;

-- Script 7: Remover tabelas de apoio
DROP TABLE IF EXISTS palavraschave;
DROP TABLE IF EXISTS areasconhecimento;

-- Script 8: Remover tabelas de pessoas
DROP TABLE IF EXISTS autores;
DROP TABLE IF EXISTS clientes;

-- Script 9: Remover tabela de departamentos
DROP TABLE IF EXISTS departamentos;

-- Script 10: Remover o banco de dados inteiro
DROP DATABASE IF EXISTS editora;