SELECT titulo FROM livros;

SELECT nome FROM autores 
WHERE nascimento < '1900-01-01';

SELECT livros.titulo FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
AND autores.nome = 'J.K. Rowling';

SELECT alunos.nome FROM alunos
INNER JOIN matriculas ON alunos.id = matriculas.aluno_id
AND matriculas.curso = 'Engenharia de Software';

SELECT produto, SUM(receita) 
AS total FROM vendas GROUP BY produto;

SELECT nome, COUNT(*) 
AS qtd_livros FROM autores 
INNER JOIN livros ON livros.autor_id = autores.id 
GROUP BY nome;

SELECT matriculas.curso, COUNT(alunos.id)
AS qtd_alunos FROM matriculas 
INNER JOIN alunos ON matriculas.aluno_id = alunos.id
GROUP BY curso;

SELECT produto, AVG(receita) AS receita_media
FROM vendas GROUP BY produto;

SELECT produto, SUM(receita) AS total
FROM vendas GROUP BY produto 
HAVING SUM(receita) > 10000;

SELECT nome, COUNT(*) 
AS qtd_livros FROM autores
INNER JOIN livros ON livros.autor_id = autores.id
GROUP BY nome HAVING COUNT(*) = 2;
