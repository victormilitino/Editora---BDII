# Banco de Dados - Sistema de Editora
Este repositório contém scripts SQL para implementação de um banco de dados completo para um sistema de gerenciamento de editora da AVA 1 de banco de dados 2 - professor Danilo Farias.

# Descrição

O sistema gerencia uma editora de livros, abrangendo toda a cadeia operacional desde o gerenciamento de autores e obras, até a comercialização de exemplares para clientes.

# Estrutura do Banco de Dados

areasconhecimento: Categoriza os livros por áreas do conhecimento
autores: Cadastro de autores com informações biográficas
clientes: Informações de contato dos clientes da editora
departamentos: Setores da editora
exemplares: Cópias físicas dos livros com seu estado e localização
funcionarios: Colaboradores da empresa vinculados aos departamentos
itenspedido: Relação muitos-para-muitos entre pedidos e exemplares
livros: Catálogo completo dos livros com metadados
livrosautores: Relação muitos-para-muitos entre livros e autores
livrospalavraschave: Relação muitos-para-muitos entre livros e palavras-chave
palavraschave: Lista de termos para indexação e busca
pedidos: Registro de compras feitas pelos clientes

# Conteúdo

O arquivo principal banco_dados_editora_completo.sql contém:

Scripts de criação das tabelas (DDL)
Scripts de alteração de estruturas (DDL)
Scripts de destruição (DDL)
Scripts de inserção de dados (DML)
Scripts de alteração e exclusão (DML)
Scripts de consulta/relatório (DQL)
Scripts de criação de views

