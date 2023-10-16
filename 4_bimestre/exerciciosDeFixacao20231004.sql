--Exercício 1--
DELIMITER //
CREATE FUNCTION total_livros_por_genero(genero_nome VARCHAR(255)) RETURNS INT DETERMINISTIC
BEGIN
    DECLARE fim INT;
    DECLARE titulo VARCHAR(255);
    DECLARE genero_id INT;
    DECLARE total_livros INT;
    SET total_livros = 0;

    DECLARE cursor_livros CURSOR FOR 
    SELECT livro.titulo, livro.id_genero FROM Livro 
    INNER JOIN Genero ON Livro.id_genero = Genero.id 
    WHERE Genero.nome_genero = genero_nome;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 0;

    OPEN cursor_livros;

    livros_loop: LOOP
        FETCH cursor_livros INTO titulo, genero_id;

        IF fim = 0 THEN
            LEAVE livros_loop;
        END IF;

        SET total_livros = total_livros + 1;
    END LOOP livros_loop;

    CLOSE cursor_livros;

    RETURN total_livros;
END;
//
DELIMITER ;

--Exercício 2--
DELIMITER //
CREATE FUNCTION listar_livros_por_autor(primeiro_nome_autor VARCHAR(255), ultimo_nome_autor VARCHAR(255)) RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE fim INT;
    DECLARE x_titulo_livro TEXT;
    DECLARE lista_titulos TEXT DEFAULT '';
    
    DECLARE cursor_livros_autor CURSOR FOR 
    SELECT livro.titulo FROM Livro 
    INNER JOIN Livro_Autor ON Livro.id = Livro_Autor.id_livro 
    INNER JOIN Autor ON Livro_Autor.id_autor = Autor.id 
    WHERE Autor.primeiro_nome = primeiro_nome_autor AND Autor.ultimo_nome = ultimo_nome_autor;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 0;

    OPEN cursor_livros_autor;

    livros_loop: LOOP
        FETCH cursor_livros_autor INTO x_titulo_livro;

        IF fim = 0 THEN
            LEAVE livros_loop;
        END IF;

        IF lista_titulos <> '' THEN
            SET lista_titulos = CONCAT(lista_titulos, ', ', x_titulo_livro);
        ELSE
            SET lista_titulos = x_titulo_livro;
        END IF;
    END LOOP livros_loop;

    CLOSE cursor_livros_autor;

    RETURN lista_titulos;
END;
//
DELIMITER ;

--Exercício 3--
DELIMITER //
CREATE FUNCTION atualizar_resumos() RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE fim INT;
    DECLARE a_id INT;
    DECLARE a_resumo TEXT;
    
    DECLARE cursor_livros CURSOR FOR SELECT id, resumo FROM Livro;
        
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 0;
    
    OPEN cursor_livros;
    
    livros_loop: LOOP
        FETCH cursor_livros INTO a_id, a_resumo;
        
        IF fim = 0 THEN
            LEAVE livros_loop;
        END IF;
        
        SET a_resumo = CONCAT(a_resumo, ' Este é um excelente livro!');
        
        UPDATE Livro SET resumo = a_resumo WHERE id = a_id;
    END LOOP livros_loop;
    
    CLOSE cursor_livros;
    RETURN 'Miau';
END;
//
DELIMITER ;

--Exercício 4--
DELIMITER //
CREATE FUNCTION media_livros_por_editora()
RETURNS DECIMAL(12,5)
DETERMINISTIC
BEGIN
    DECLARE fim INT;
    DECLARE a_livro INT;
    DECLARE a_editora INT;
    DECLARE media_livros_por_editora DECIMAL(12,5);
    SET a_livro = 0;
    SET a_editora = 0;
    SET media_livros_por_editora = 0;
    DECLARE cursor_editora CURSOR FOR SELECT id FROM Editora;
    
	DECLARE cursor_livro CURSOR FOR SELECT COUNT(*) FROM Livro WHERE id_editora = a_editora;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 0;
    
    OPEN cursor_editora;
    editora_loop: LOOP
        FETCH cursor_editora INTO a_editora;
        IF fim = 0 THEN
            LEAVE editora_loop;
        END IF;
        
        OPEN cursor_livro;
			FETCH cursor_livro INTO a_livro;
        CLOSE cursor_livro;
        
        SET media_livros_por_editora = media_livros_por_editora + (a_livro / (SELECT COUNT(*) FROM Editora));
    END LOOP editora_loop;
    
    CLOSE cursor_editora;
    
    RETURN media_livros_por_editora;
END;
//
DELIMITER ;

--Exercício 5--
DELIMITER //
CREATE FUNCTION autores_sem_livros()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE fim INT;
    DECLARE id_autor INT;
    DECLARE primeiro_nome VARCHAR(255);
    DECLARE ultimo_nome VARCHAR(255);
    DECLARE lista_autores TEXT;
    SET lista_autores = '';

    DECLARE cursor_autores CURSOR FOR
        SELECT id, primeiro_nome, ultimo_nome FROM Autor;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fim = 0;

    OPEN cursor_autores;

    autores_loop: LOOP
        FETCH cursor_autores INTO id_autor, primeiro_nome, ultimo_nome;

        IF fim = 0 THEN
            LEAVE autores_loop;
        END IF;

		IF lista_autores = '' THEN
			SET lista_autores = CONCAT(primeiro_nome, ' ', ultimo_nome);
		ELSE
			SET lista_autores = CONCAT(lista_autores, ', ', CONCAT(primeiro_nome, ' ', ultimo_nome));
		END IF;
    END LOOP autores_loop;

    CLOSE cursor_autores;

    RETURN lista_autores;
END//
DELIMITER ;
