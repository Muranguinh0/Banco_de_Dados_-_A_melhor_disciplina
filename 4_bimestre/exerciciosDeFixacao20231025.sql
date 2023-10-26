CREATE TRIGGER exercicio1
	BEFORE INSERT ON Clientes
	FOR EACH ROW 
INSERT INTO Auditoria (mensagem) VALUES ('miau');
