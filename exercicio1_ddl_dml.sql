CREATE DATABASE exercicio1_ddl_dml
GO 
USE exercicio1_ddl_dml
GO
CREATE TABLE projects(
id_p			INT			NOT NULL	IDENTITY(10001, 1),
name_p  		VARCHAR(45) NOT NULL,
description_p	VARCHAR(45),
date_p			DATE		NOT NULL
PRIMARY KEY(id_p),
CONSTRAINT chk_date CHECK(date_p > '2014-09-01')
)
GO
CREATE TABLE users(
id_u			INT			NOT NULL	IDENTITY,
name_u			VARCHAR(45) NOT NULL,
username		VARCHAR(10) NOT NULL	UNIQUE,
password_u		VARCHAR(8)	NOT NULL	DEFAULT('123Mudar'),
email			VARCHAR(45) NOT NULL
PRIMARY KEY(id_u)
)
GO
CREATE TABLE user_has_projects(
users_id_u		INT			NOT NULL,
projects_id_p	INT			NOT NULL
FOREIGN KEY(users_id_u) REFERENCES users(id_u),
FOREIGN KEY(projects_id_p) REFERENCES projects(id_p)
)
GO 
INSERT INTO users(name_u, username, email) VALUES
('Maria', 'Rh_maria', 'maria@empresa.com')
GO
INSERT INTO users(name_u, username, password_u, email) VALUES
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com')
GO
INSERT INTO users(name_u, username, email) VALUES
('Ana', 'Rh_ana', 'ana@empresa.com'),
('Clara', 'Ti_clara', 'clara@empresa.com')
GO
INSERT INTO users(name_u, username, password_u, email) VALUES
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com')
GO
INSERT INTO projects(name_p, description_p, date_p) VALUES
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção PCs', 'Manutenção PCs', '2014-09-06')
GO
INSERT INTO projects(name_p, date_p) VALUES
('Auditoria', '2014-09-07')
GO
INSERT INTO user_has_projects(users_id_u, projects_id_p) VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)
GO
SELECT * FROM projects
SELECT * FROM users
SELECT * FROM user_has_projects
GO

UPDATE projects
SET date_p = '2014-09-12'
WHERE name_p = 'Manutenção PCs'
GO
UPDATE users
SET username = 'Rh_cido'
WHERE name_u = 'Aparecido'
GO
UPDATE users
SET password_u = '888@*'
WHERE username = 'Rh_Maria' AND password_u = '123Mudar'
GO
DELETE user_has_projects
WHERE users_id_u = 2 AND projects_id_p = 10002