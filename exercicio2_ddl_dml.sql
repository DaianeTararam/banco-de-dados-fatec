CREATE DATABASE exercicio2_ddl_dml
GO
USE exercicio2_ddl_dml
GO
CREATE TABLE filme(
id_f				INT			NOT NULL	IDENTITY(1001,1),
titulo				VARCHAR(80)	NOT NULL,
ano					INT	CHECK((ano) <= 2021)
PRIMARY KEY(id_f)
)
drop database exercicio2_ddl_dml
GO
CREATE TABLE estrela(
id_e				INT			NOT NULL	IDENTITY(9901, 1),
nome				VARCHAR(50)	NOT NULL,
nome_real			VARCHAR(50)	
PRIMARY KEY(id_e)
)
GO
CREATE TABLE cliente(
num_cadastro		INT				NOT NULL	IDENTITY(5501, 1),
nome				VARCHAR(70)		NOT NULL,
logradouro			VARCHAR(150)	NOT NULL,
num					INT				NOT NULL	CHECK((num) >= 0),
cep					CHAR(8)	CHECK(LEN(cep) = 8)
PRIMARY KEY(num_cadastro)
)
GO
CREATE TABLE filme_estrela(
filme_id_f			INT				NOT NULL,
estrela_id_e		INT				NOT NULL
PRIMARY KEY(filme_id_f, estrela_id_e)
FOREIGN KEY (filme_id_f) REFERENCES filme(id_f),
FOREIGN KEY (estrela_id_e) REFERENCES estrela(id_e)
)
GO
CREATE TABLE DVD(
num					INT				NOT NULL	IDENTITY(10001, 1),
data_fabric			DATE			NOT NULL	CHECK((data_fabric) < GETDATE()),
filme_id_f			INT				NOT NULL
PRIMARY KEY(num)
FOREIGN KEY (filme_id_f) REFERENCES filme(id_f)
)
GO
CREATE TABLE locacao (
data_locacao		DATE			NOT NULL DEFAULT CAST(GETDATE() AS DATE),
data_devolucao		DATE			NOT NULL,
valor				DECIMAL(7,2)	NOT NULL CHECK (valor >= 0),
cliente_num_cadastro	INT			NOT NULL,
DVD_num					INT
PRIMARY KEY (data_locacao, cliente_num_cadastro, DVD_num),
FOREIGN KEY (cliente_num_cadastro) REFERENCES cliente(num_cadastro),
FOREIGN KEY (DVD_num) REFERENCES DVD (num)
)
GO
ALTER TABLE locacao
ADD CONSTRAINT chkdata CHECK (data_devolucao > data_locacao);
GO
INSERT INTO filme(titulo, ano) VALUES
('Whiplash', 2015),
('Birdman', 2015),
('Interestelar', 2014),
('A Culpa é das estrelas', 2014),
('Alexandre e o Dia Terrível, Horrível, Espantoso e Horroroso', 2014),
('Sing', 2016)
GO
INSERT INTO estrela(nome, nome_real) VALUES
('Michael Keaton', 'Michael John Douglas'),
('Emma Stone', 'Emily Jean Stone')
GO
INSERT INTO estrela(nome) VALUES 
('Miles Teller')
GO
INSERT INTO estrela(nome, nome_real) VALUES
('Steve Carell', 'Steven John Carell'),
('Jennifer Garner', 'Jennifer Anne Garner')
GO
INSERT INTO filme_estrela(filme_id_f, estrela_id_e) VALUES
(1002, 9901),
(1002, 9902),
(1001, 9903),
(1005, 9904),
(1005, 9905)
GO
INSERT INTO DVD(data_fabric, filme_id_f) VALUES
('2020-12-02', 1001),
('2019-10-18', 1002),
('2020-04-03', 1003),
('2020-12-02', 1001),
('2019-10-18', 1004),
('2020-04-03', 1002),
('2020-12-02', 1005),
('2019-10-18', 1002),
('2020-04-03', 1003),
('2019-07-14', 1005)
GO 
INSERT INTO cliente (nome, logradouro, num, cep) VALUES
('Matilde Luz', 'Rua Síria', 150, '03086040'),
('Carlos Carreiro', 'Rua Bartolomeu Aires', 1250, '04419110')
GO
INSERT INTO cliente (nome, logradouro, num) VALUES
('Daniel Ramalho', 'Rua Itajutiba', 169), 
('Roberta Bento', 'Rua Jayme Von Rosenburg', 36)
GO
INSERT INTO cliente (nome, logradouro, num, cep) VALUES
('Rosa Cerqueira', 'Rua Arnaldo Simões Pinto', 235, '02917110');
GO
INSERT INTO locacao (DVD_num, cliente_num_cadastro, data_locacao, data_devolucao, valor) VALUES
(10001, 5502, '2021-02-18', '2021-02-21', 3.50),
(10009, 5502, '2021-02-18', '2021-02-21', 3.50),
(10002, 5503, '2021-02-18', '2021-02-19', 3.50),
(10002, 5505, '2021-02-20', '2021-02-23', 3.00),
(10004, 5505, '2021-02-20', '2021-02-23', 3.00),
(10005, 5505, '2021-02-20', '2021-02-23', 3.00),
(10001, 5501, '2021-02-24', '2021-02-26', 3.50),
(10008, 5501, '2021-02-24', '2021-02-26', 3.50)
GO
UPDATE cliente
SET cep = '08411150'
WHERE num_cadastro = 5503
GO
UPDATE cliente
SET cep = '02918190'
WHERE num_cadastro = 5504
GO 
UPDATE locacao
SET valor = 3.25
WHERE cliente_num_cadastro = 5502 AND data_locacao = '2021-02-18'
GO
UPDATE locacao
SET valor = 3.10
WHERE cliente_num_cadastro = 5501 AND data_locacao = '2021-02-24'
GO
UPDATE DVD
SET data_fabric = '2019-07-14'
WHERE num = 10005
GO
UPDATE estrela
SET nome_real = 'Miles Alexander Teller'
WHERE nome = 'Miles Teller'
GO
DELETE filme
WHERE titulo = 'Sing'
GO

-- Fazer um select que retorne os nomes dos filmes de 2014
SELECT titulo FROM filme 
WHERE ano = 2014

-- Fazer um select que retorne o id e o ano do filme Birdman
SELECT id_f,  ano FROM filme
WHERE titulo = 'Birdman'

--Fazer um select que retorne o id e o ano do filme que tem o nome terminado por plash
SELECT id_f, ano FROM filme
WHERE titulo LIKE '%plash'

--Fazer um select que retorne o id, o nome e o nome_real da estrela cujo nome começa com Steve
SELECT id_e, nome, nome_real FROM estrela
WHERE nome LIKE 'Steve%'

--Fazer um select que retorne FilmeId e a data_fabricação em formato (DD/MM/YYYY),(apelidar de fab) dos filmes fabricados a partir de 01-01-2020
SELECT filme_id_f, CONVERT(VARCHAR(10), data_fabric, 103) AS fab FROM DVD
WHERE data_fabric >= '2020-01-01'

--Fazer um select que retorne DVDnum, data_locacao, data_devolucao, valor e valor com multa de acréscimo de 2.00 da locação do cliente 5505
SELECT DVD_num, data_locacao, data_devolucao, valor, CONVERT(VARCHAR(7), valor + 2.00) AS valor_multa FROM locacao
WHERE cliente_num_cadastro = 5505

--Fazer um select que retorne Logradouro, num e CEP de Matilde Luz
SELECT logradouro, num, cep FROM cliente
WHERE nome = 'Matilde Luz'

--Fazer um select que retorne Nome real de Michael Keaton
SELECT nome_real FROM estrela
WHERE nome = 'Michael Keaton'

--Fazer um select que retorne o num_cadastro, o nome e o endereço completo, concatenando (logradouro, numero e CEP), apelido end_comp, dos clientes cujo ID é maior ou igual 5503
SELECT num_cadastro, nome, logradouro + ', ' + CONVERT(VARCHAR(180), num) + ' - ' + cep AS end_comp FROM cliente
WHERE num_cadastro >= 5503

SELECT * FROM cliente
SELECT * FROM filme
SELECT * FROM estrela
SELECT * FROM filme_estrela
SELECT * FROM locacao
SELECT * FROM DVD