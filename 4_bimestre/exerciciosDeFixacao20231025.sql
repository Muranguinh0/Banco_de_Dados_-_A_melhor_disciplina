CREATE TRIGGER exercicio1
	BEFORE INSERT ON Clientes
	FOR EACH ROW 
INSERT INTO Auditoria (mensagem) VALUES ('miau');

CREATE TRIGGER exercicio2
	AFTER DELETE ON Clientes
	FOR EACH ROW
INSERT INTO Auditoria (mensagem) VALUES ('miau');
