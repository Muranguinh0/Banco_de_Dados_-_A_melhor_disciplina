--Exercício 1--
CREATE TABLE nomes(
	nome VARCHAR(255)
);
INSERT INTO nomes VALUES
('Roberta'),
('Roberto'),
('Maria Clara'),
('João');

SELECT UPPER(nome) AS nomes FROM nomes;

SELECT nome, LENGTH(nome) AS tamanho FROM nomes;

SELECT CONCAT(IF(nome = 'Roberto' or nome = 'João', 'Sr. ', 'Sra. '), nome) AS nome FROM nomes;
