CREATE DATABASE exercicio_select_joins01
GO
USE exercicio_select_joins01
GO
CREATE TABLE projects(
id_p			INT					NOT NULL	IDENTITY(10001, 1),
name_p			VARCHAR(45)			NOT NULL,
description_p	VARCHAR(45),
date_p			DATE				NOT NULL	CHECK((date_p) >= '2014-09-01')
PRIMARY KEY(id_p)
)
GO
CREATE TABLE users(
id_u			INT					NOT NULL	IDENTITY,
name_u			VARCHAR(45)			NOT NULL,
username		VARCHAR(10)			NOT NULL	UNIQUE,
password_u		VARCHAR(8)			NOT NULL	DEFAULT('123mudar'),
email			VARCHAR(45)			NOT NULL
PRIMARY KEY(id_u)
)
GO
CREATE TABLE users_has_projects(
users_id_u		INT					NOT NULL,
projects_id_p	INT					NOT NULL
PRIMARY KEY(users_id_u, projects_id_p)
FOREIGN KEY(users_id_u) REFERENCES users(id_u),
FOREIGN KEY(projects_id_p) REFERENCES projects(id_p)
)
GO
INSERT INTO users (name_u, username, password_u, email) VALUES
('Maria', 'Rh_maria', '123mudar', 'maria@empresa.com'),
('Paulo', 'Ti_paulo', '123@456', 'paulo@empresa.com'),
('Ana', 'Rh_ana', '123mudar', 'ana@empresa.com'),
('Clara', 'Ti_clara', '123mudar', 'clara@empresa.com'),
('Aparecido', 'Rh_apareci', '55@!cido', 'aparecido@empresa.com');
GO
INSERT INTO projects (name_p, description_p, date_p) VALUES
('Re-folha', 'Refatoração das Folhas', '2014-09-05'),
('Manutenção PCs', 'Manutenção PCs', '2014-09-06'),
('Auditoria', NULL, '2014-09-07');
GO
INSERT INTO users_has_projects (users_id_u, projects_id_p) VALUES
(1, 10001),
(5, 10001),
(3, 10003),
(4, 10002),
(2, 10002)
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
WHERE username = 'Rh_maria' AND password_u = '123mudar'
GO 
DELETE FROM users_has_projects
WHERE users_id_u = 2 AND projects_id_p = 10002
GO
INSERT INTO users (name_u, username, password_u, email) VALUES
('Joao', 'Ti_joao', '123mudar', 'joao@empresa.com')
GO
INSERT INTO projects(name_p, description_p, date_p) VALUES
('Atualização de Sistemas', 'Modificação de Sistemas Operacionais nos PCs', '2014-09-12')
GO
SELECT 
    u.id_u, 
	u.name_u,
	u.email,
    p.id_p, 
	p.name_p, 
	p.description_p,
	p.date_p
FROM users u INNER JOIN users_has_projects up
ON u.id_u = up.users_id_u
INNER JOIN projects p
ON p.id_p = up.projects_id_p
WHERE p.name_p = 'Re-folha'
GO
SELECT p.name_p
FROM projects p
LEFT JOIN users_has_projects up 
ON p.id_p = up.projects_id_p
WHERE up.users_id_u IS NULL
GO
SELECT u.name_u
FROM users u
LEFT JOIN users_has_projects up 
ON u.id_u = up.users_id_u
WHERE up.projects_id_p IS NULL

