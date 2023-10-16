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
