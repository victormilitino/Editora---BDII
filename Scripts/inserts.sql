-- =============================================
-- SCRIPTS DE INSERÇÃO (DML)
-- =============================================

-- Inserir áreas de conhecimento
INSERT INTO areasconhecimento (cod_area, descricao) VALUES
(1, 'Literatura'),
(2, 'Ciências Exatas'),
(3, 'Ciências Humanas'),
(4, 'Tecnologia'),
(5, 'Artes'),
(6, 'Medicina'),
(7, 'Direito'),
(8, 'Economia'),
(9, 'Filosofia'),
(10, 'Psicologia');

-- Inserir autores
INSERT INTO autores (cod_autor, nome, biografia, nacionalidade, data_nascimento) VALUES
(1, 'Carlos Drummond de Andrade', 'Um dos principais poetas brasileiros do século XX', 'Brasileira', '1902-10-31'),
(2, 'Clarice Lispector', 'Importante escritora brasileira conhecida por seu estilo único', 'Brasileira', '1920-12-10'),
(3, 'José Saramago', 'Escritor português vencedor do Prêmio Nobel de Literatura', 'Portuguesa', '1922-11-16'),
(4, 'Gabriel García Márquez', 'Escritor colombiano expoente do realismo mágico', 'Colombiana', '1927-03-06'),
(5, 'Agatha Christie', 'Famosa escritora de romances policiais', 'Britânica', '1890-09-15'),
(6, 'Stephen Hawking', 'Físico teórico e cosmólogo britânico', 'Britânica', '1942-01-08'),
(7, 'Daniel Kahneman', 'Psicólogo e economista, vencedor do Nobel de Economia', 'Israelense', '1934-03-05'),
(8, 'Yuval Noah Harari', 'Historiador e filósofo israelense', 'Israelense', '1976-02-24'),
(9, 'J.K. Rowling', 'Autora da série Harry Potter', 'Britânica', '1965-07-31'),
(10, 'Martin Fowler', 'Autor de livros sobre engenharia de software', 'Britânica', '1963-12-18');

INSERT INTO departamentos (cod_departamento, nome, responsavel, descricao) VALUES
(1, 'Editorial', 'Maria Santos', 'Responsável pela revisão e edição dos livros'),
(2, 'Marketing', 'João Silva', 'Responsável pela divulgação e promoção dos livros'),
(3, 'Financeiro', 'Ana Oliveira', 'Responsável pela gestão financeira da editora'),
(4, 'Recursos Humanos', 'Carlos Pereira', 'Responsável pela gestão de pessoal'),
(5, 'Produção', 'Juliana Costa', 'Responsável pela impressão e produção física dos livros');

-- Inserir funcionários
INSERT INTO funcionarios (nome, cargo, telefone, endereco, cod_departamento) VALUES 
('Roberto Almeida', 'Editor-chefe', '(11) 98765-4321', 'Rua das Flores, 123', 1),
('Fernanda Souza', 'Gerente de Marketing', '(11) 91234-5678', 'Avenida Paulista, 1000', 2),
('Marcelo Lima', 'Contador', '(11) 95555-9999', 'Rua Augusta, 500', 3),
('Patricia Nunes', 'Analista de RH', '(11) 94444-8888', 'Rua Oscar Freire, 200', 4),
('Leonardo Mendes', 'Supervisor de Produção', '(11) 93333-7777', 'Alameda Santos, 50', 5),
('Camila Rocha', 'Editora', '(11) 92222-6666', 'Rua Haddock Lobo, 300', 1),
('Bruno Dias', 'Designer Gráfico', '(11) 91111-3333', 'Avenida Rebouças, 400', 2),
('Renata Gomes', 'Assistente Financeiro', '(11) 99999-2222', 'Rua Teodoro Sampaio, 150', 3);

-- Inserir palavras-chave
INSERT INTO palavraschave (cod_palavra, descricao) VALUES
(1, 'Programação'),
(2, 'Romance'),
(3, 'História'),
(4, 'Medicina'),
(5, 'Negócios'),
(6, 'Autoajuda'),
(7, 'Ficção Científica'),
(8, 'Matemática'),
(9, 'Física'),
(10, 'Língua Portuguesa');

-- Inserir livros
INSERT INTO livros (isbn, titulo, data_publicacao, genero, num_paginas, descricao, cod_area) VALUES 
('9788501112331', 'Sentimento do Mundo', '1940-01-15', 'Poesia', 120, 'Coletânea de poemas de Carlos Drummond de Andrade', 1),
('9788520937075', 'A Hora da Estrela', '1977-05-20', 'Romance', 88, 'Último romance de Clarice Lispector', 1),
('9788535914849', 'Ensaio sobre a Cegueira', '1995-03-10', 'Romance', 310, 'Romance distópico sobre uma epidemia de cegueira', 1),
('9788501096241', 'Cem Anos de Solidão', '1967-06-05', 'Romance', 368, 'Obra-prima do realismo mágico', 1),
('9788595086173', 'Assassinato no Expresso do Oriente', '1934-01-01', 'Romance Policial', 256, 'Um dos mais famosos mistérios de Agatha Christie', 1),
('9788573025316', 'O Universo numa Casca de Noz', '2001-09-01', 'Ciência', 224, 'Visão acessível sobre o universo e suas teorias', 2),
('9788573029635', 'Uma Breve História do Tempo', '1988-04-01', 'Ciência', 290, 'Livro sobre cosmologia para o público leigo', 2),
('9788539004065', 'Rápido e Devagar', '2011-10-25', 'Psicologia', 608, 'Estudo sobre as duas formas de pensar', 10),
('9788535933925', 'Sapiens: Uma Breve História da Humanidade', '2011-09-01', 'História', 464, 'História da evolução humana', 3),
('9788532530783', 'Harry Potter e a Pedra Filosofal', '1997-06-26', 'Fantasia', 264, 'Primeiro livro da série Harry Potter', 1);

-- Inserir associações entre livros e autores
INSERT INTO livrosautores (isbn, cod_autor) VALUES 
('9788501112331', 1),
('9788520937075', 2),
('9788535914849', 3),
('9788501096241', 4),
('9788595086173', 5),
('9788573025316', 6),
('9788573029635', 6),
('9788539004065', 7),
('9788535933925', 8),
('9788532530783', 9);

-- Inserir associações entre livros e palavras-chave
INSERT INTO livrospalavraschave (isbn, cod_palavra) VALUES 
('9788501112331', 2),
('9788520937075', 2),
('9788535914849', 2),
('9788501096241', 2),
('9788595086173', 2),
('9788573025316', 9),
('9788573029635', 9),
('9788539004065', 6),
('9788535933925', 3),
('9788532530783', 2);

-- Inserir clientes
INSERT INTO clientes (cod_cliente, nome, telefone, email, endereco) VALUES
(1, 'Pedro Henrique', '(11) 98888-7777', 'pedro@email.com', 'Rua dos Pinheiros, 123'),
(2, 'Amanda Silva', '(11) 97777-6666', 'amanda@email.com', 'Avenida Faria Lima, 1000'),
(3, 'Ricardo Souza', '(11) 96666-5555', 'ricardo@email.com', 'Rua dos Bobos, 0'),
(4, 'Juliana Pereira', '(11) 95555-4444', 'juliana@email.com', 'Avenida Brasil, 500'),
(5, 'Marcos Oliveira', '(11) 94444-3333', 'marcos@email.com', 'Rua Augusta, 200'),
(6, 'Fernanda Lima', '(11) 93333-2222', 'fernanda@email.com', 'Rua Oscar Freire, 300'),
(7, 'Gabriel Santos', '(11) 92222-1111', 'gabriel@email.com', 'Avenida Paulista, 1500'),
(8, 'Carolina Costa', '(11) 91111-0000', 'carolina@email.com', 'Rua Consolação, 400'),
(9, 'Felipe Almeida', '(11) 90000-9999', 'felipe@email.com', 'Alameda Santos, 250'),
(10, 'Mariana Gomes', '(11) 99999-8888', 'mariana@email.com', 'Rua Haddock Lobo, 100');

-- Inserir exemplares
INSERT INTO exemplares (num_serie, isbn, estado, localizacao) VALUES 
('9788501112331-1', '9788501112331', 'disponível', 'Estante A, Prateleira 1'),
('9788520937075-1', '9788520937075', 'disponível', 'Estante B, Prateleira 1'),
('9788535914849-1', '9788535914849', 'disponível', 'Estante C, Prateleira 1'),
('9788501096241-1', '9788501096241', 'disponível', 'Estante D, Prateleira 1'),
('9788595086173-1', '9788595086173', 'disponível', 'Estante E, Prateleira 1'),
('9788501112331-2', '9788501112331', 'disponível', 'Estante A, Prateleira 1'),
('9788520937075-2', '9788520937075', 'disponível', 'Estante B, Prateleira 1'),
('9788535914849-2', '9788535914849', 'disponível', 'Estante C, Prateleira 1'),
('9788501096241-2', '9788501096241', 'disponível', 'Estante D, Prateleira 1'),
('9788595086173-2', '9788595086173', 'disponível', 'Estante E, Prateleira 1');

-- Inserir pedidos
INSERT INTO pedidos (cod_pedido, cod_cliente, data_pedido, status, forma_pagamento) VALUES
(1, 1, '2023-01-05 10:30:00', 'entregue', 'Cartão de Crédito'),
(2, 2, '2023-01-10 14:45:00', 'entregue', 'Boleto Bancário'),
(3, 3, '2023-01-15 09:15:00', 'entregue', 'Pix'),
(4, 4, '2023-02-01 11:00:00', 'enviado', 'Cartão de Débito'),
(5, 5, '2023-02-10 16:30:00', 'processando', 'Cartão de Crédito'),
(6, 6, '2023-02-15 13:20:00', 'pendente', 'Boleto Bancário'),
(7, 7, '2023-03-01 10:00:00', 'entregue', 'Pix'),
(8, 8, '2023-03-10 15:45:00', 'enviado', 'Cartão de Crédito'),
(9, 9, '2023-03-15 14:30:00', 'processando', 'Cartão de Débito'),
(10, 10, '2023-04-01 09:30:00', 'pendente', 'Pix');

-- Inserir itens de pedido
INSERT INTO itenspedido (cod_pedido, num_serie, preco_unitario, quantidade) VALUES 
(1, '9788501112331-1', 45.90, 1),
(1, '9788520937075-1', 35.50, 1),
(2, '9788535914849-1', 55.00, 1),
(3, '9788501096241-1', 65.90, 1),
(3, '9788595086173-1', 42.30, 1);