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

--Exercício 4--
SELECT produto, IF(quantidade > 0, 'Em estoque', 'Fora de estoque') AS quantidade_estoque FROM produtos;

SELECT produto, 
	CASE
        WHEN preco < 500 THEN 'Barato'
        WHEN preco >= 1000 AND preco < 1500 THEN 'Médio'
        ELSE 'Caro'
    END 
    AS categoria FROM produtos;

--Exercício 5--
DELIMITER //
CREATE FUNCTION TOTAL_VALOR(preco DECIMAL(12, 5), quantidade INT)
RETURNS DECIMAL(12, 5) DETERMINISTIC
BEGIN
    DECLARE valor_total DECIMAL(12, 5);
    SET valor_total = preco * quantidade;
    RETURN valor_total;
END;
// DELIMITER ;

SELECT produto, TOTAL_VALOR(preco, quantidade) AS valor_total FROM produtos;

--Exercício 6--
SELECT COUNT(*) AS quantidade_produtos FROM produtos;

SELECT produto, MAX(preco) AS preco_maximo FROM produtos GROUP BY produto;

SELECT produto, MIN(preco) AS preco_minimo FROM produtos GROUP BY produto;

SELECT SUM(IF(quantidade > 0, quantidade, 0)) AS quantidade_estoque FROM produtos;
