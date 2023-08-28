SELECT titulo FROM livros;

SELECT nome FROM autores 
WHERE nascimento < '1900-01-01';

SELECT livros.titulo FROM livros
INNER JOIN autores ON livros.autor_id = autores.id
AND autores.nome = 'J.K. Rowling';
