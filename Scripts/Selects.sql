-- =============================================
-- SCRIPTS DE CONSULTA/RELATÓRIO (DQL)
-- =============================================

-- Script 1: Listar todos os livros com seus autores
SELECT l.isbn, l.titulo, a.nome AS autor
FROM livros l
JOIN livrosautores la ON l.isbn = la.isbn
JOIN autores a ON la.cod_autor = a.cod_autor
ORDER BY l.titulo;

-- Script 2: Contabilizar livros por área de conhecimento
SELECT ac.descricao AS area, COUNT(l.isbn) AS quantidade
FROM areasconhecimento ac
LEFT JOIN livros l ON ac.cod_area = l.cod_area
GROUP BY ac.cod_area, ac.descricao
ORDER BY quantidade DESC;

-- Script 3: Relatório de vendas por mês
SELECT 
    DATE_FORMAT(p.data_pedido, '%Y-%m') AS mes,
    COUNT(DISTINCT p.cod_pedido) AS total_pedidos,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total
FROM pedidos p
JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
WHERE p.status != 'cancelado'
GROUP BY mes
ORDER BY mes;

-- Script 4: Listar exemplares disponíveis por livro
SELECT l.titulo, COUNT(e.num_serie) AS exemplares_disponiveis
FROM livros l
JOIN exemplares e ON l.isbn = e.isbn
WHERE e.estado = 'disponível'
GROUP BY l.isbn, l.titulo
ORDER BY exemplares_disponiveis DESC;

SELECT
    c.nome,
    COUNT(DISTINCT p.cod_pedido) AS total_pedidos,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total
FROM clientes c
JOIN pedidos p ON c.cod_cliente = p.cod_cliente
JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
WHERE p.data_pedido > DATE_SUB(NOW(), INTERVAL 1 YEAR)
GROUP BY c.cod_cliente, c.nome
ORDER BY valor_total DESC
LIMIT 10;

-- Script 6: Relatório de funcionários por departamento
SELECT 
    d.nome AS departamento, 
    COUNT(f.cod_funcionario) AS total_funcionarios,
    GROUP_CONCAT(f.nome SEPARATOR ', ') AS funcionarios
FROM departamentos d
LEFT JOIN funcionarios f ON d.cod_departamento = f.cod_departamento
GROUP BY d.cod_departamento, d.nome;

-- Script 7: Verificar livros mais vendidos
SELECT 
    l.titulo, 
    COUNT(ip.num_serie) AS vendas,
    SUM(ip.quantidade) AS exemplares_vendidos
FROM livros l
JOIN exemplares e ON l.isbn = e.isbn
JOIN itenspedido ip ON e.num_serie = ip.num_serie
JOIN pedidos p ON ip.cod_pedido = p.cod_pedido
WHERE p.status IN ('enviado', 'entregue')
GROUP BY l.isbn, l.titulo
ORDER BY exemplares_vendidos DESC;

-- Script 8: Relatório de vendas por forma de pagamento
SELECT 
    forma_pagamento, 
    COUNT(cod_pedido) AS total_pedidos,
    SUM(
        (SELECT SUM(preco_unitario * quantidade) 
         FROM itenspedido 
         WHERE cod_pedido = p.cod_pedido)
    ) AS valor_total
FROM pedidos p
WHERE status != 'cancelado'
GROUP BY forma_pagamento
ORDER BY valor_total DESC;

-- Script 9: Encontrar autores mais publicados
SELECT 
    a.nome, 
    COUNT(la.isbn) AS total_livros,
    GROUP_CONCAT(l.titulo SEPARATOR ', ') AS obras
FROM autores a
JOIN livrosautores la ON a.cod_autor = la.cod_autor
JOIN livros l ON la.isbn = l.isbn
GROUP BY a.cod_autor, a.nome
ORDER BY total_livros DESC;

-- Script 10: Relatório de pedidos pendentes
SELECT 
    p.cod_pedido, 
    c.nome AS cliente, 
    p.data_pedido, 
    p.forma_pagamento,
    COUNT(ip.num_serie) AS itens,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total
FROM pedidos p
JOIN clientes c ON p.cod_cliente = c.cod_cliente
JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
WHERE p.status = 'pendente'
GROUP BY p.cod_pedido, c.nome, p.data_pedido, p.forma_pagamento
ORDER BY p.data_pedido;

-- Script 11: Encontrar exemplares danificados
SELECT 
    e.num_serie, 
    l.titulo, 
    e.localizacao
FROM exemplares e
JOIN livros l ON e.isbn = l.isbn
WHERE e.estado = 'danificado'
ORDER BY l.titulo;

-- Script 12: Relatório de palavras-chave mais utilizadas
SELECT 
    pc.descricao, 
    COUNT(lpc.isbn) AS total_livros,
    GROUP_CONCAT(DISTINCT l.titulo SEPARATOR ', ') AS livros
FROM palavraschave pc
LEFT JOIN livrospalavraschave lpc ON pc.cod_palavra = lpc.cod_palavra
LEFT JOIN livros l ON lpc.isbn = l.isbn
GROUP BY pc.cod_palavra, pc.descricao
ORDER BY total_livros DESC;

-- Script 13: Encontrar clientes sem pedidos
SELECT c.cod_cliente, c.nome, c.email
FROM clientes c
LEFT JOIN pedidos p ON c.cod_cliente = p.cod_cliente
WHERE p.cod_pedido IS NULL;

-- Script 14: Relatório de livros por década de publicação
SELECT 
    CONCAT(FLOOR(YEAR(data_publicacao)/10)*10, 's') AS decada,
    COUNT(isbn) AS total_livros,
    GROUP_CONCAT(titulo SEPARATOR ', ') AS livros
FROM livros
GROUP BY decada
ORDER BY decada;

-- Script 15: Encontrar funcionários sem departamento
SELECT f.cod_funcionario, f.nome, f.cargo
FROM funcionarios f
LEFT JOIN departamentos d ON f.cod_departamento = d.cod_departamento
WHERE f.cod_departamento IS NULL;

-- Script 16: Relatório de exemplares por status
SELECT 
    estado, 
    COUNT(num_serie) AS total,
    COUNT(num_serie) * 100.0 / (SELECT COUNT(*) FROM exemplares) AS percentual
FROM exemplares
GROUP BY estado
ORDER BY total DESC;

-- Script 17: Encontrar livros sem exemplares disponíveis
SELECT l.isbn, l.titulo
FROM livros l
LEFT JOIN exemplares e ON l.isbn = e.isbn AND e.estado = 'disponível'
GROUP BY l.isbn, l.titulo
HAVING COUNT(e.num_serie) = 0;

-- Script 18: Relatório de vendas por gênero literário
SELECT 
    l.genero, 
    COUNT(DISTINCT ip.cod_pedido) AS total_pedidos,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total
FROM livros l
JOIN exemplares e ON l.isbn = e.isbn
JOIN itenspedido ip ON e.num_serie = ip.num_serie
JOIN pedidos p ON ip.cod_pedido = p.cod_pedido
WHERE p.status IN ('enviado', 'entregue')
GROUP BY l.genero
ORDER BY valor_total DESC;

-- Script 19: Encontrar pedidos com mais itens
SELECT 
    p.cod_pedido, 
    c.nome AS cliente, 
    COUNT(ip.num_serie) AS total_itens,
    SUM(ip.quantidade) AS total_exemplares,
    SUM(ip.preco_unitario * ip.quantidade) AS valor_total
FROM pedidos p
JOIN clientes c ON p.cod_cliente = c.cod_cliente
JOIN itenspedido ip ON p.cod_pedido = ip.cod_pedido
GROUP BY p.cod_pedido, c.nome
ORDER BY total_exemplares DESC
LIMIT 10;

-- Script 20: Encontrar autores por nacionalidade
SELECT 
    nacionalidade, 
    COUNT(cod_autor) AS total_autores,
    GROUP_CONCAT(nome SEPARATOR ', ') AS autores
FROM autores
GROUP BY nacionalidade
ORDER BY total_autores DESC;