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

--Exercício 3--
CREATE TABLE eventos (
    data_evento DATE
);
INSERT INTO eventos (data_evento) VALUES
('1997-04-24'),
('1937-12-25'),
('1964-06-14'),
('2006-07-02'),
('1935-09-29');

INSERT INTO eventos (data_evento) VALUES (NOW());

SELECT MIN(data_evento) AS primeiro_evento, MAX(data_evento) AS segundo_evento, DATEDIFF(MAX(data_evento), MIN(data_evento)) AS diferença_tempo FROM eventos;

SELECT data_evento, DAYNAME(data_evento) AS dia_semana FROM eventos;
