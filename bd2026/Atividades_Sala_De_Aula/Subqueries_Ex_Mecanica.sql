-- Foram desenvolvidas apenas as subqueries, a database foi desenvolvida pelo professor.

USE master
GO
CREATE DATABASE Ex_Mecanica
GO
USE Ex_Mecanica
GO
CREATE TABLE Cliente(
	ID int IDENTITY(3401, 15),
	Nome varchar(100),
	Logradouro varchar(200),
	Numero int CHECK(Numero > 0),
	CEP char(8) CHECK(LEN(CEP) = 8),
	Complemento varchar(255)
	PRIMARY KEY(ID)
)
GO
CREATE TABLE Telefone_Cliente(
	ClienteID int,
	Telefone varchar(11) CHECK(LEN(Telefone) = 10 OR LEN(Telefone) = 11) 
	PRIMARY KEY(ClienteID, Telefone)
	FOREIGN KEY(ClienteID) REFERENCES Cliente(ID)
)
GO
CREATE TABLE Veiculo(
	Placa char(7),
	Marca varchar(30),
	Modelo varchar(30),
	Cor varchar(30),
	Ano_Fabricacao int CHECK(Ano_Fabricacao > 1997),
	Ano_Modelo int CHECK(Ano_Modelo > 1997),
	Data_Aquisicao int,
	ClienteID int
	PRIMARY KEY(Placa),
	FOREIGN KEY(ClienteID) REFERENCES Cliente(ID),
	CONSTRAINT chk_fabricacao_modelo CHECK(Ano_Modelo - Ano_Fabricacao >= 0)
)
GO
CREATE TABLE Peca(
	ID int IDENTITY(3411, 7),
	Nome varchar(30) UNIQUE,
	Preco decimal(4, 2) CHECK(Preco > 0),
	Estoque int CHECK(Estoque >= 10)
	PRIMARY KEY(ID)
)
GO
CREATE TABLE Categoria(
	ID int IDENTITY,
	Categoria varchar(10),
	Valor_Hora decimal(4, 2)
	PRIMARY KEY(ID),
	CONSTRAINT chk_Categoria_ValorHora CHECK(Categoria = 'Estagiário' AND Valor_Hora >= 15.00 OR
	Categoria = 'Nível 1' AND Valor_Hora >= 25.00 OR 
	Categoria = 'Nível 2' AND Valor_Hora >= 35.00 OR
	Categoria = 'Nível 3' AND Valor_Hora >= 50.00)
)
GO
CREATE TABLE Funcionario(
	ID int IDENTITY(101, 1),
	Nome varchar(100),
	Logradouro varchar(200),
	Numero int CHECK(Numero > 0),
	Telefone char(11),
	Categoria_Habilitacao varchar(2),
	CategoriaID int
	PRIMARY KEY(ID),
	FOREIGN KEY(CategoriaID) REFERENCES Categoria(ID),
	CONSTRAINT chk_categoria_habilitacao CHECK(Categoria_Habilitacao = 'A' OR
	Categoria_Habilitacao = 'B' OR Categoria_Habilitacao = 'C' OR
	Categoria_Habilitacao = 'D' OR Categoria_Habilitacao = 'E')
)
GO
CREATE TABLE Reparo(
	VeiculoPlaca char(7) CHECK(LEN(VeiculoPlaca) = 7),
	FuncionarioID int,
	PecaID int,
	Dt date DEFAULT GETDATE(),
	Custo_Total decimal(4, 2) CHECK(Custo_Total > 0),
	Tempo int CHECK(Tempo > 0)
	PRIMARY KEY(VeiculoPlaca, FuncionarioID, PecaID, Dt),
	FOREIGN KEY(VeiculoPlaca) REFERENCES Veiculo(Placa),
	FOREIGN KEY(FuncionarioID) REFERENCES Funcionario(ID),
	FOREIGN KEY(PecaID) REFERENCES Peca(ID)
)
GO
INSERT INTO categoria(Categoria, Valor_Hora) VALUES
('Estagiário', 20.00),
('Nível 1', 30.00),
('Nível 2', 40.00),
('Nível 3', 80.00)
GO
INSERT INTO cliente (nome, logradouro, numero, cep, complemento) VALUES
('Fulano de Tal', 'R. ABC', 78, '00000001', 'Casa'),
('Cicrano de Tal', 'R. BCD', 150, '00000002', 'Bloco 3 Apto 340'),
('Beltrano de Tal', 'R. CDE', 1500, '00000003', 'Casa')
GO
INSERT INTO veiculo VALUES
('AAA0A00', 'Fiat', 'Uno', 'Vermelho', 2001, 2002, 2010, 3401),
('AAA0A01', 'Renault', 'Sandero', 'Prata', 2010, 2011, 2015, 3416),
('AAA0A02', 'Honda', 'Civic', 'Cinza', 2018, 2019, 2022, 3401),
('AAA0A03', 'Ford', 'Focus', 'Azul', 2009, 2010, 2023, 3416),
('AAA0A04', 'Nissan', 'March', 'Verde', 2021, 2022, 2022, 3431),
('AAA0A05', 'Renault', 'Logan', 'Preta', 2008, 2009, 2018, 3401)
GO
SELECT * FROM Categoria
SELECT * FROM cliente
SELECT * FROM veiculo
go

-- Consultar:
-- O valor da hora de um estagiário
select Valor_Hora from categoria
where Categoria like 'Esta%'
go
--Nome e valor das Categorias que ganham menos de 35.00 em ordem crescente de valor
select Categoria from categoria
where Valor_Hora < 35.00
order by Valor_Hora asc

--Placa, marca, modelo e ano de fabricação dos carros cadastrados que foram fabricados entre 2000 e 2010 em ordem crescente de marca e modelo
select Placa, Marca, Modelo, Ano_Fabricacao from veiculo
where Ano_Fabricacao between 2000 and 2010
order by Marca asc
go
select Placa, Marca, Modelo, Ano_Fabricacao from veiculo
where Ano_Fabricacao between 2000 and 2010
order by Modelo asc
go

--Placa, marca, modelo e cor dos carros cadastrados adquiridos depois de 2014 em ordem descrescente de ano
select Placa, Marca, Modelo, Cor from veiculo
where Data_Aquisicao > 2014
order by Ano_Modelo desc
go
select Placa, Marca, Modelo, Cor from veiculo
where Data_Aquisicao > 2014
order by Ano_Fabricacao desc
go

--Placa, marca, modelo, cor dos carros do cliente 3401 em ordem descrescente de placa
select Placa, Marca, Modelo, Cor from veiculo
where ClienteID = 3401
order by Placa desc