-- Crie um BD com nome clinica
CREATE DATABASE clinica;

CREATE TABLE ambulatorios(
	cod_amb INT PRIMARY KEY,
	andar NUMERIC(3) NOT NULL,
	capacidade SMALLINT
);

CREATE TABLE medicos(
	cod_med INTEGER PRIMARY KEY,
	nome VARCHAR(40) NOT NULL,
	idade SMALLINT NOT NULL,
	especialidade CHAR(20),
	cpf VARCHAR(11) UNIQUE,
	cidade VARCHAR(30),
	cod_amb INTEGER,
	FOREIGN KEY (cod_amb) REFERENCES ambulatorios (cod_amb) -- se usar foreign key tem que ter a coluna nas 2 tabelas!
);

CREATE TABLE pacientes(
	cod_pac INTEGER PRIMARY KEY,
	nome VARCHAR(40) NOT NULL,
	idade SMALLINT NOT NULL,
	cidade CHAR(30),
	cpf VARCHAR(11) UNIQUE,
	doenca VARCHAR(40) NOT NULL
);

CREATE TABLE funcionarios(
	cod_fun INTEGER PRIMARY KEY,
	nome VARCHAR(40) NOT NULL,
	idade SMALLINT,
	cpf VARCHAR(11) UNIQUE,
	cidade VARCHAR(30),
	salario NUMERIC(10),
	cargo VARCHAR(20)
);

CREATE TABLE consultas(
  	cod_con INTEGER PRIMARY KEY,
	cod_med INTEGER,
	cod_pac INTEGER,
	data DATE NOT NULL,
	hora TIME NOT NULL,
  	FOREIGN KEY (cod_med) REFERENCES medicos (cod_med),
	FOREIGN KEY (cod_pac) REFERENCES pacientes (cod_pac)
);

--ambulatorios
INSERT INTO ambulatorios(cod_amb, andar, capacidade)
VALUES (1, 1, 30);

INSERT INTO ambulatorios(cod_amb, andar, capacidade)
VALUES (2, 1, 50);

INSERT INTO ambulatorios(cod_amb, andar, capacidade)
VALUES (3, 2, 40);

INSERT INTO ambulatorios(cod_amb, andar, capacidade)
VALUES (4, 2, 25);

INSERT INTO ambulatorios(cod_amb, andar, capacidade)
VALUES (5, 2, 55);

--medicos
INSERT INTO medicos(cod_med, nome, idade, especialidade, cpf,	cidade, cod_amb)
VALUES (1, 'Dayanna', 40, 'Nutrição', '10000100000', 'Varginha', 1);

INSERT INTO medicos(cod_med, nome, idade, especialidade, cpf,	cidade, cod_amb)
VALUES (2, 'Maria', 42, 'Traumatologia', '10000100001', 'Varginha', 2);

INSERT INTO medicos(cod_med, nome, idade, especialidade, cpf,	cidade, cod_amb)
VALUES (3, 'Pedro', 51, 'Pediatria', '10000100002', 'Varginha', 3);

INSERT INTO medicos(cod_med, nome, idade, especialidade, cpf,	cidade, cod_amb)
VALUES (4, 'Carlos', 28, 'Ortopedia', '10000100003', 'Lavras', 4);

INSERT INTO medicos(cod_med, nome, idade, especialidade, cpf,	cidade, cod_amb)
VALUES (5, 'Marcia', 33, 'Neurologia', '10000100004', 'Belo Horizonte', 5);

INSERT INTO public.medicos(
	cod_med, nome, idade, especialidade, cpf, cidade, cod_amb)
	VALUES (6, 'Michael', 32, 'Teste', 12345678901, 'Varginha', 1);

-- pacientes
INSERT INTO pacientes(cod_pac, nome, idade,	cidade,	cpf, doenca)
VALUES (1, 'Ana', 20, 'São Paulo', '12345678910', 'Obesidade');

INSERT INTO pacientes(cod_pac, nome, idade,	cidade,	cpf, doenca)
VALUES (2, 'Paulo', 24, 'Lavras', '12345678911', 'Fratura');

INSERT INTO pacientes(cod_pac, nome, idade,	cidade,	cpf, doenca)
VALUES (3, 'Lucia', 30, 'Belo Horizonte', '12345678912', 'Tendinite');

INSERT INTO pacientes(cod_pac, nome, idade,	cidade,	cpf, doenca)
VALUES (4, 'Carlos', 28, 'Poços de Caldas', '12345678913', 'Sarampo');

--funcionarios
INSERT INTO funcionarios (cod_fun, nome, idade, cidade, salario, cpf)
VALUES (1, 'Rita', 32, 'Belo Horizonte', 1200, '12345678920');

INSERT INTO funcionarios (cod_fun, nome, idade, cidade, salario, cpf)
VALUES (2, 'Maria', 55, 'Varginha', 1220, '12345678921');

INSERT INTO funcionarios (cod_fun, nome, idade, cidade, salario, cpf)
VALUES (3, 'Caio', 45, 'Lavras', 1100, '12345678922');

INSERT INTO funcionarios (cod_fun, nome, idade, cidade, salario, cpf)
VALUES (4, 'Carlos', 44, 'Varginha', 1200, '12345678923');

INSERT INTO funcionarios (cod_fun, nome, idade, cidade, salario, cpf)
VALUES (5, 'Paula', 33, 'Varginha', 2500, '12345678924');

--consultas
-- Sem informar os atributos 
-- NOTE: DATE format: yyyy-mm-dd
INSERT INTO consultas
VALUES (1, 1, 1, '2021-10-12', '1400');

INSERT INTO consultas
VALUES (2, 1, 4, '2021-10-13', '1000');

INSERT INTO consultas
VALUES (3, 2, 1, '2021-10-13', '0900');

INSERT INTO consultas
VALUES (4, 2, 2, '2021-10-14', '1400');

INSERT INTO consultas
VALUES (5, 2, 4, '2021-10-14', '1700');

INSERT INTO consultas
VALUES (6, 3, 1, '2021-10-19', '1800');

INSERT INTO consultas
VALUES (7, 3, 3, '2021-10-12', '1000');

INSERT INTO consultas
VALUES (8, 3, 4, '2021-10-19', '1300');

INSERT INTO consultas
VALUES (9, 4, 4, '2021-10-22', '1930');
