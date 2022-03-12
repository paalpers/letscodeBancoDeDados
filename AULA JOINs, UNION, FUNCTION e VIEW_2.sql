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



-- ---------------------------------------------------------------------------
-- Buscar o nome dos funcionários que terminam com a letra “a”
SELECT nome
FROM funcionarios
WHERE nome LIKE '%a';


-- ---------------------------------------------------------------------------
-- Buscar o nome e a especialidade dos médicos cuja 
-- segunda e a última letra de seus nomes seja a letra “o”
SELECT 
	nome,
	especialidade
FROM medicos
WHERE nome LIKE '_o%o';


-- ---------------------------------------------------------------------------
-- Buscar os códigos e nomes dos pacientes com mais de 
-- 25 anos que estão com tendinite, fratura,gripe ou sarampo
SELECT 
  cod_pac, 
  nome,
  idade,
  doenca
FROM pacientes
WHERE 
  idade > 25
  AND (
    	doenca = 'Tendinite'
    	OR 
    	doenca = 'Fratura'
    	OR
    	doenca = 'Obesidade'
    	OR 
    	doenca = 'Sarampo'
  );


-- ---------------------------------------------------------------------------
-- Buscar os CPFs, nomes e idades de todas as pessoas
-- (médicos, pacientes ou funcionários) que residem em Florianópolis 
SELECT 
  cpf,
  nome,
  idade,
  cidade
FROM 
      (
        SELECT cpf, nome, idade, cidade
	FROM pacientes
        UNION
	SELECT cpf, nome, idade, cidade
	FROM funcionarios
        UNION
	SELECT cpf, nome, idade, cidade
	FROM medicos
        ) as todas_pessoas
WHERE cidade = 'Varginha';


-- ---------------------------------------------------------------------------
--JOIN!
-- Buscar o número e o andar dos ambulatórios utilizados por médicos ortopedistas
SELECT 
  ambulatorios.cod_amb,
  ambulatorios.andar
FROM ambulatorios 
INNER JOIN medicos ON ambulatorios.cod_amb = medicos.cod_amb
WHERE medicos.cod_amb = 1;

SELECT medicos.nome, medicos.cpf, especialidade
FROM medicos 
INNER JOIN consultas ON medicos.cod_med = consultas.cod_med
WHERE medicos.cod_amb = 1;

SELECT medicos.nome, medicos.cpf, especialidade
FROM medicos 
LEFT JOIN consultas ON medicos.cod_med = consultas.cod_med
WHERE medicos.cod_amb = 1;

SELECT medicos.nome, medicos.cpf, especialidade
FROM medicos 
RIGHT JOIN consultas ON medicos.cod_med = consultas.cod_med
WHERE medicos.cod_amb = 1;


-- ---------------------------------------------------------------------------
-- Retornar pares (código, nome) de funcionários e
-- de médicos que residem na mesma cidade (tabela resultado
-- deve ter 4 atributos)
SELECT 
  funcionarios.cod_fun,
  funcionarios.nome,
  medicos.cod_med,
  medicos.nome
FROM funcionarios 
INNER JOIN medicos ON funcionarios.cidade = medicos.cidade;


-- ---------------------------------------------------------------------------
-- Buscar o código e nome dos médicos que possuem consultas 
-- marcadas para antes das 12 horas e possuem idade inferior à idade do médico Pedro

-- parte 01: código e nome dos médicos que possuem consultas marcadas para antes das 12 horas
SELECT 
  medicos.cod_med,
  medicos.nome
FROM medicos 
INNER JOIN consultas ON medicos.cod_med = consultas.cod_med
WHERE 
  hora < '1200';


-- ---------------------------------------------------------------------------
-- Buscar o nome e o salário dos funcionários que moram na mesma 
-- cidade do funcionário caio e possuem salário superior ao dele

-- parte 01: nome e o salário dos funcionários que moram na mesma cidade do funcionário Caio
SELECT 
  nome,
  salario
FROM funcionarios
WHERE cidade = (
                  SELECT cidade 
                  FROM funcionarios 
                  WHERE nome='Maria'
                );

-- parte 02: tudo
SELECT 
  nome,
  salario
FROM funcionarios
WHERE 
  cidade IN (
              SELECT cidade 
              FROM funcionarios 
              WHERE nome='Maria'
            )
  AND
  salario > (
              SELECT salario
              FROM funcionarios 
              WHERE nome = 'Maria'
            );

-- ---------------------------------------------------------------------------
-- Buscar o código, nome e data dos pacientes com consulta marcada para horários após às 14 horas
SELECT 
  pacientes.cod_p,
  pacientes.nome,
  consultas.data
FROM 
  pacientes JOIN consultas ON pacientes.cod_p=consultas.cod_p
WHERE hora > '1400';


-- ---------------------------------------------------------------------------
-- Buscar o número e o andar dos ambulatórios cujos 
-- médicos possuem consultas marcadas para o dia 12/10/2016
SELECT 
  ambulatorios.nroa,
  ambulatorios.andar
FROM 
  ambulatorios NATURAL JOIN consultas
WHERE data='2016-10-12';


-- ---------------------------------------------------------------------------
-- Buscar o nome, CPF e especialidade dos médicos que 
-- possuem consultas marcadas com pacientes que estão com tendinite
SELECT medicos.nome, medicos.cpf, especialidade
FROM medicos 
INNER JOIN consultas ON medicos.cod_med = consultas.cod_med
INNER JOIN pacientes ON consultas.cod_pac = pacientes.cod_pac
WHERE doenca='Tendinite';


-- ---------------------------------------------------------------------------
-- Buscar os dados de todos os ambulatórios e para aqueles 
-- ambulatórios onde médicos dão atendimento, exibir também os seus códigos e nomes
SELECT 
  ambulatorios.nroa,
  ambulatorios.andar,
  ambulatorios.capacidade,
  medicos.cod_m AS codigo_medico,
  medicos.nome AS nome_medico
FROM 
  ambulatorios JOIN medicos ON ambulatorios.nroa=medicos.nroa;


-- ---------------------------------------------------------------------------
-- Buscar o CPF e o nome de todos os médicos e, para aqueles médicos com
-- consultas marcadas, exibir os CPFs e nomes dos seus pacientes e as datas das consultas
SELECT 
  medicos.cpf,
  medicos.nome,
  pacientes.cpf,
  pacientes.nome,
  consultas.data
FROM medicos 
    INNER JOIN consultas ON medicos.cod_med = consultas.cod_med
    FULL JOIN pacientes ON consultas.cod_pac = pacientes.cod_pac;