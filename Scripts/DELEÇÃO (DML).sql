-- =============================================
-- SCRIPTS DE DELEÇÃO (DML) COM BASE NOS DADOS INSERIDOS
-- =============================================

-- 1. Deletar a área de conhecimento 'Psicologia'
SELECT * FROM areasconhecimento WHERE descricao = 'Psicologia';

-- 2. Deletar o autor 'Martin Fowler'
DELETE FROM autores WHERE nome = 'Martin Fowler';

-- 3. Deletar a associação do livro 'Sentimento do Mundo' com Carlos Drummond de Andrade
DELETE FROM livrosautores WHERE isbn = '9788501112331' AND cod_autor = 1;

-- 4. Deletar a associação do livro 'A Hora da Estrela' com a palavra-chave 'Romance'
DELETE FROM livrospalavraschave WHERE isbn = '9788520937075' AND cod_palavra = 2;


-- 5. Deletar o exemplar com número de série '9788595086173-2'
DELETE FROM exemplares WHERE num_serie = '9788595086173-2';

-- 6. Deletar o pedido com código 10
DELETE FROM pedidos WHERE cod_pedido = 10;

-- 7. Deletar o item de pedido referente ao livro 'Sentimento do Mundo' no pedido 1
DELETE FROM itenspedido WHERE cod_pedido = 1 AND num_serie = '9788501112331-1';

-- 8. Deletar todos os funcionários do departamento 'Financeiro'
DELETE FROM funcionarios WHERE cod_departamento = (SELECT cod_departamento FROM departamentos WHERE nome = 'Financeiro');


-- 9. Deletar todas as associações do autor 'Stephen Hawking' com livros
DELETE FROM livrosautores WHERE cod_autor = 6;

-- 10. Deletar todas as associações da palavra-chave 'Física' com livros
DELETE FROM livrospalavraschave WHERE cod_palavra = 9;


-- 11. Deletar todos os exemplares do livro 'Cem Anos de Solidão'
DELETE FROM exemplares WHERE isbn = '9788501096241';

-- 12. Deletar todos os pedidos feitos pelo cliente 'Ricardo Souza'
DELETE FROM pedidos WHERE cod_cliente = (SELECT cod_cliente FROM clientes WHERE nome = 'Ricardo Souza');

-- 13. Deletar todos os itens do pedido com código 3
DELETE FROM itenspedido WHERE cod_pedido = 3;


-- 14. Deletar todos os funcionários que trabalham no departamento de Marketing
DELETE FROM funcionarios WHERE cod_departamento = (SELECT cod_departamento FROM departamentos WHERE nome = 'Marketing');


-- 15. Deletar todos os livros que pertencem à área de conhecimento 'Literatura'
DELETE FROM livros WHERE cod_area = (SELECT cod_area FROM areasconhecimento WHERE descricao = 'Literatura');


-- 16. Deletar todos os funcionários que trabalham no departamento 'Editorial' e são 'Editora'
DELETE FROM funcionarios WHERE cod_departamento = (SELECT cod_departamento FROM departamentos WHERE nome = 'Editorial') AND cargo = 'Editora';



-- 17. Deletar todos os livros que têm mais de 200 páginas e pertencem à área de conhecimento 'Literatura'
DELETE FROM livros WHERE num_paginas > 200 AND cod_area = (SELECT cod_area FROM areasconhecimento WHERE descricao = 'Literatura');



-- 18. Deletar todos os funcionários que não são 'Gerente de Marketing' e trabalham no departamento 'Marketing'
DELETE FROM funcionarios WHERE cargo != 'Gerente de Marketing' AND cod_departamento = (SELECT cod_departamento FROM departamentos WHERE nome = 'Marketing');


-- 19. Deletar todos os livros que não têm autores associados a eles
DELETE FROM livros 
WHERE isbn NOT IN (SELECT isbn FROM livrosautores);


-- 20. Deletar todos os exemplares que não possuem localização definida
DELETE FROM exemplares 
WHERE localizacao IS NULL;

