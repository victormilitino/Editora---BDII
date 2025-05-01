-- =============================================
-- SCRIPTS PARA CRIAÇÃO DE VIEWS (DDL)
-- =============================================

-- View 1: Catálogo de livros com detalhes
CREATE VIEW vw_catalogo_completo AS
SELECT 
    l.isbn, 
    l.titulo, 
    l.data_publicacao, 
    l.genero, 
    l.num_paginas,
    ac.descricao AS area_conhecimento,
    (SELECT GROUP_CONCAT(a.nome SEPARATOR ', ')
     FROM autores a
     JOIN livrosautores la ON a.cod_autor = la.cod_autor
     WHERE la.isbn = l.isbn) AS autores,
    (SELECT COUNT(*) FROM exemplares e WHERE e.isbn = l.isbn AND e.estado = 'disponível') AS exemplares_disponiveis
FROM livros l
LEFT JOIN areasconhecimento ac ON l.cod_area = ac.cod_area;

-- View 2: Resumo de vendas mensal
CREATE VIEW vw_vendas_mensais AS
SELECT 
    DATE_FORMAT(p.data_pedido, '%Y-%m') AS mes,
    COUNT(DISTINCT p.cod_pedido) AS total_pedidos,
    COUNT(DISTINCT p.cod_cliente) AS total_clientes,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total
FROM pedidos p
JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
WHERE p.status IN ('enviado', 'entregue')
GROUP BY mes;

-- View 3: Status dos departamentos
CREATE VIEW vw_status_departamentos AS
SELECT 
    d.cod_departamento,
    d.nome,
    d.responsavel,
    COUNT(f.cod_funcionario) AS total_funcionarios,
    GROUP_CONCAT(DISTINCT f.cargo SEPARATOR ', ') AS cargos
FROM departamentos d
LEFT JOIN funcionarios f ON d.cod_departamento = f.cod_departamento
GROUP BY d.cod_departamento, d.nome, d.responsavel;

-- View 4: Performance de vendas por autor
CREATE VIEW vw_vendas_por_autor AS
SELECT 
    a.cod_autor,
    a.nome AS autor,
    COUNT(DISTINCT l.isbn) AS total_livros,
    SUM(ip.quantidade) AS exemplares_vendidos,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_vendas
FROM autores a
JOIN livrosautores la ON a.cod_autor = la.cod_autor
JOIN livros l ON la.isbn = l.isbn
JOIN exemplares e ON l.isbn = e.isbn
JOIN itenspedido ip ON e.num_serie = ip.num_serie
JOIN pedidos p ON ip.cod_pedido = p.cod_pedido
WHERE p.status IN ('enviado', 'entregue')
GROUP BY a.cod_autor, a.nome;

-- View 5: Status de estoque
CREATE VIEW vw_status_estoque AS
SELECT 
    l.isbn,
    l.titulo,
    COUNT(e.num_serie) AS total_exemplares,
    SUM(CASE WHEN e.estado = 'disponível' THEN 1 ELSE 0 END) AS disponiveis,
    SUM(CASE WHEN e.estado = 'reservado' THEN 1 ELSE 0 END) AS reservados,
    SUM(CASE WHEN e.estado = 'danificado' THEN 1 ELSE 0 END) AS danificados,
    SUM(CASE WHEN e.estado = 'vendido' THEN 1 ELSE 0 END) AS vendidos
FROM livros l
LEFT JOIN exemplares e ON l.isbn = e.isbn
GROUP BY l.isbn, l.titulo;

-- View 6: Histórico de compras por cliente
CREATE VIEW vw_historico_cliente AS
SELECT 
    c.cod_cliente,
    c.nome,
    COUNT(DISTINCT p.cod_pedido) AS total_pedidos,
    SUM(ip.quantidade) AS total_exemplares,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total,
    MAX(p.data_pedido) AS ultima_compra
FROM clientes c
LEFT JOIN pedidos p ON c.cod_cliente = p.cod_cliente
LEFT JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
GROUP BY c.cod_cliente, c.nome;

-- View 7: Livros por área e suas palavras-chave
CREATE VIEW vw_livros_area_palavras AS
SELECT 
    ac.descricao AS area,
    l.isbn,
    l.titulo,
    GROUP_CONCAT(DISTINCT pc.descricao SEPARATOR ', ') AS palavras_chave
FROM areasconhecimento ac
JOIN livros l ON ac.cod_area = l.cod_area
LEFT JOIN livrospalavraschave lpc ON l.isbn = lpc.isbn
LEFT JOIN palavraschave pc ON lpc.cod_palavra = pc.cod_palavra
GROUP BY ac.descricao, l.isbn, l.titulo;

-- View 8: Pedidos completos com itens
CREATE VIEW vw_pedidos_completos AS
SELECT 
    p.cod_pedido,
    p.data_pedido,
    p.status,
    p.forma_pagamento,
    c.nome AS cliente,
    c.email,
    c.telefone,
    l.isbn,
    l.titulo,
    ip.preco_unitario,
    ip.quantidade,
    (ip.preco_unitario * ip.quantidade) AS subtotal
FROM pedidos p
JOIN clientes c ON p.cod_cliente = c.cod_cliente
JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
JOIN exemplares e ON ip.num_serie = e.num_serie
JOIN livros l ON e.isbn = l.isbn;

-- View 9: Ranking de livros mais vendidos
CREATE VIEW vw_ranking_livros AS
SELECT 
    l.isbn,
    l.titulo,
    COUNT(DISTINCT ip.cod_pedido) AS total_pedidos,
    SUM(ip.quantidade) AS exemplares_vendidos,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_vendas
FROM livros l
JOIN exemplares e ON l.isbn = e.isbn
JOIN itenspedido ip ON e.num_serie = ip.num_serie
JOIN pedidos p ON ip.cod_pedido = p.cod_pedido
WHERE p.status IN ('enviado', 'entregue')
GROUP BY l.isbn, l.titulo
ORDER BY exemplares_vendidos DESC;

-- View 10: Dashboard de vendas (resumo geral)
CREATE VIEW vw_dashboard_vendas AS
SELECT 
    (SELECT COUNT(*) FROM livros) AS total_livros,
    (SELECT COUNT(*) FROM autores) AS total_autores,
    (SELECT COUNT(*) FROM clientes) AS total_clientes,
    (SELECT COUNT(*) FROM pedidos WHERE status IN ('enviado', 'entregue')) AS pedidos_finalizados,
    (SELECT COUNT(*) FROM pedidos WHERE status = 'pendente') AS pedidos_pendentes,
    (SELECT SUM(ip.preco_unitario * ip.quantidade) 
     FROM itenspedido ip 
     JOIN pedidos p ON ip.cod_pedido = p.cod_pedido 
     WHERE p.status IN ('enviado', 'entregue')) AS receita_total;