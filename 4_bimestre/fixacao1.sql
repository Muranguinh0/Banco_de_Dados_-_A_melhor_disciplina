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

--Exercício 2--
CREATE TABLE produtos(
	produto VARCHAR(255),
	preco DECIMAL(12,5),
	quantidade INT
);

SELECT produto, ROUND(preco, 2) AS preco FROM produtos;

SELECT produto, ABS(quantidade) AS quantidade FROM produtos;

SELECT produto, AVG(preco) AS media FROM produtos GROUP BY produto;
