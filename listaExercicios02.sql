DELIMITER // /*Esse Delimiter marca o início do bloco de código da procedure*/
CREATE PROCEDURE sp_ListarAutores() /*A criação da procedure*/
BEGIN /*Início da Procedure*/
	SELECT Nome FROM Autor; /*Seleciona o que a procedure vai consultar*/
END; /*Fim da Procedure*/
// DELIMITER ; /*Esse Delimiter marca o fim do bloco de código da procedure*/
CALL sp_ListarAutores(); /*Chama a procedure*/

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

DELIMITER // 
CREATE PROCEDURE sp_TitulosPorCategoria(IN categoria_nome VARCHAR(250))
BEGIN
	SELECT Livro.Titulo FROM Livro 
    	INNER JOIN Categoria 
   	WHERE Categoria.Categoria_ID = Livro.Categoria_ID 
    	AND Categoria.Nome = categoria_nome;
END;
// DELIMITER ;
CALL sp_TitulosPorCategoria('Autoajuda');

DELIMITER // 
CREATE PROCEDURE sp_AdicionarLivro(IN nome VARCHAR(255))
BEGIN
	DECLARE quantidade_livros INT;
    	SELECT COUNT(Titulo) INTO quantidade_livros 
	FROM Livro WHERE nome = Titulo;
	IF quantidade_livros = 0 THEN
		INSERT INTO Livro (Titulo) VALUES (nome);
	ELSE
		SELECT Titulo FROM Livro WHERE Titulo = nome;
	END IF;
END;
// DELIMITER ;
CALL sp_AdicionarLivro('Miau');

DELIMITER // 
CREATE PROCEDURE sp_AutorAntigo()
BEGIN 
	SELECT Nome FROM Autor 
    	ORDER BY Data_Nascimento LIMIT  1;
END; 
// DELIMITER ; 
CALL sp_AutorAntigo();

/*No exercício 9, eu expliquei o exercício 1*/
