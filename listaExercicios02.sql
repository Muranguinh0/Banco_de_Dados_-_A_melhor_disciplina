DELIMITER // 
CREATE PROCEDURE sp_ListarAutores()
BEGIN
	SELECT Nome FROM Autor;
END;
// DELIMITER ;
CALL sp_ListarAutores();

DELIMITER //
CREATE PROCEDURE sp_LivrosPorCategoria(IN categoria_nome VARCHAR(250))
BEGIN
	SELECT Titulo FROM Livro
	INNER JOIN Categoria ON Livro.Categoria_ID = Categoria.Categoria_ID
	AND Categoria.Nome = categoria_nome;
END;
// DELIMITER ;
CALL sp_LivrosPorCategoria('Ficção Científica');

DELIMITER //
CREATE PROCEDURE sp_ContarLivrosPorCategoria(IN categoria_nome VARCHAR(250))
BEGIN
	SELECT Categoria.Nome, COUNT(*) AS quantidade_livros
	FROM Livro INNER JOIN Categoria
	ON Categoria.Categoria_ID = Livro.Categoria_ID 
	WHERE Categoria.Nome = categoria_nome GROUP BY Nome;
END;
// DELIMITER ;
CALL sp_ContarLivrosPorCategoria('História');

DELIMITER // 
CREATE PROCEDURE sp_VerificarLivrosCategoria(IN categoria_nome VARCHAR(250), OUT possui_livros VARCHAR(50))
BEGIN
	DECLARE quantidade_livros INT;
	SELECT COUNT(*) INTO quantidade_livros
	FROM Livro INNER JOIN Categoria 
	ON Categoria.Categoria_ID = Livro.Categoria_ID 
	WHERE Categoria.Nome = categoria_nome GROUP BY Nome;
	IF quantidade_livros > 0 THEN
		SET possui_livros = 'Possui Livros';
	ELSE
		SET possui_livros = 'Não Possui Livros';
	END IF;
END;
// DELIMITER ;
CALL sp_VerificarLivrosCategoria('Romance', @possui_livros);
SELECT @possui_livros;

DELIMITER // 
CREATE PROCEDURE sp_LivrosAteAno(data_ano INT)
BEGIN
	SELECT Titulo FROM Livro WHERE Ano_Publicacao <= data_ano;
END;
// DELIMITER ;
CALL sp_LivrosAteAno('2000');
