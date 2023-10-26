CREATE TRIGGER exercicio1
	BEFORE INSERT ON Clientes
	FOR EACH ROW 
INSERT INTO Auditoria (mensagem) VALUES ('miau');

CREATE TRIGGER exercicio2
	AFTER DELETE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES ('miau');

CREATE TRIGGER exercicio3
	BEFORE UPDATE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES (concat(old.nome, new.nome));

DELIMITER //
CREATE TRIGGER exercicio4
	BEFORE UPDATE ON Clientes
	FOR EACH ROW
	IF new.nome is NULL or new.nome = '' THEN
		UPDATE Clientes SET nome = old.nome;
		INSERT INTO Auditoria (mensagem) VALUES ('miau');
	END IF;
//
DELIMITER ;
