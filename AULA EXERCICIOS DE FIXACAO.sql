-----Manipulando Datas
---Pegando a data atual: Para pegar a data atual usamos a função current_date.
SELECT date_part('day', current_date);
SELECT date_part('month', current_date);
SELECT date_part('year', current_date);

---Exemplo: Mostrando os meses das vendas
SELECT order_id, date_part('month', required_date) FROM orders

----Exemplo: Verificando a média do frete
SELECT 
    DATE_PART('month', required_date), 
	orders.order_id,
    AVG(freight) 
FROM orders
GROUP BY DATE_PART('month', required_date), orders.order_id 
ORDER BY 1;

SELECT CURRENT_DATE;
SELECT CURRENT_TIME;
SELECT CURRENT_TIME(0);

--Obtendo o dia do mês:
SELECT DATE_PART('DAY', CURRENT_DATE) AS Dia;

--Somar dias e horas a uma data:
SELECT CAST(CURRENT_DATE AS DATE) + INTERVAL '27 DAYS' AS Data;

SELECT TO_DATE('2022-03-05', 'YYYY-MM-DD')
SELECT TO_DATE('20220305', 'YYYYMMDD')
--Função timeofday (retorna texto)
select TIMEOFDAY();

A função CAST() é utilizada para converter explicitamente tipos de dados em outros.

----
CREATE DATABASE empresa;

CREATE TABLE Departamento (
    ID_Depto    SERIAL,
    NomeDepto   VARCHAR(30)   NOT NULL,
    ID_Gerente  INTEGER     NOT NULL,
    CONSTRAINT pk_depto PRIMARY KEY (ID_Depto),
    CONSTRAINT uk_nome UNIQUE (NomeDepto)
);

CREATE TABLE Funcionario (
    ID_Func     SERIAL,
    NomeFunc    VARCHAR(50)  NOT NULL,
    Endereco    VARCHAR(80)  NOT NULL,
    DataNasc    DATE          NOT NULL,
    Sexo        CHAR(1)       NOT NULL,
    Salario     DECIMAL(8,2)   NOT NULL,
    ID_Superv   INTEGER         NULL,
    ID_Depto    INTEGER     NOT NULL,
    CONSTRAINT pk_func PRIMARY KEY (ID_Func),
    CONSTRAINT ck_sexo CHECK (Sexo='M' or Sexo='F')
);

CREATE TABLE Projeto (
    ID_Proj       SERIAL,
    NomeProj      VARCHAR(30)  NOT NULL,
    Localizacao   VARCHAR(30)      NULL,
    ID_Depto      INTEGER    NOT NULL,
    CONSTRAINT pk_proj PRIMARY KEY (ID_Proj),
    CONSTRAINT fk_proj_depto FOREIGN KEY (ID_Depto)
       REFERENCES Departamento (ID_Depto),
    CONSTRAINT uk_nomeProj UNIQUE (NomeProj)
);

CREATE TABLE Dependente (
    ID_Dep       SERIAL,
    ID_Func      INTEGER     NOT NULL,
    NomeDep      VARCHAR(50)  NOT NULL,
    DataNasc     DATE          NOT NULL,
    Sexo         CHAR(1)       NOT NULL,
    Parentesco   CHAR(15)          NULL,
    CONSTRAINT pk_depend PRIMARY KEY (ID_Dep),
    CONSTRAINT fk_dep_func FOREIGN KEY (ID_Func)
       REFERENCES Funcionario (ID_Func)
       ON DELETE CASCADE,
    CONSTRAINT ck_sexo_dep CHECK (Sexo='M' or Sexo='F')
);

CREATE TABLE Trabalha (
    ID_Func    SERIAL,
    ID_Proj    INTEGER     NOT NULL,
    NumHoras   DECIMAL(6,1)       NULL,
    CONSTRAINT pk_trab PRIMARY KEY (ID_Func,ID_Proj),
    CONSTRAINT fk_trab_func FOREIGN KEY (ID_Func)
       REFERENCES Funcionario (ID_Func)
       ON DELETE CASCADE,
    CONSTRAINT fk_trab_proj FOREIGN KEY (ID_Proj)
       REFERENCES Projeto (ID_Proj)
       ON DELETE CASCADE
);

INSERT INTO Funcionario
VALUES (1,'João B. Silva','R. Guaicui, 175','1955/02/01','M',500,2,1);
INSERT INTO Funcionario
VALUES (2,'Frank T. Santos','R. Gentios, 22','1966/02/02','M',1000,8,1);
INSERT INTO Funcionario
VALUES (3,'Alice N. Pereira','R. Curitiba, 11','1970/05/15','F',700,4,3);
INSERT INTO Funcionario
VALUES (4,'Júnia B. Mendes','R. E. Santos, 123','1976/07/06','F',1200,8,3);
INSERT INTO Funcionario
VALUES (5,'José S. Tavares','R. Iraí, 153','1975/10/12','M',1500,2,1);
INSERT INTO Funcionario
VALUES (6,'Luciana S. Santos','R. Iraí, 175','1960/10/10','F',600,2,1);
INSERT INTO Funcionario
VALUES (7,'Maria P. Ramos','R. C. Linhares, 10','1965/11/05','F',1000,4,3);
INSERT INTO Funcionario
VALUES (8,'Jaime A. Mendes','R. Bahia, 111','1960/11/25','M',2000,NULL,2);

INSERT INTO Departamento
VALUES (1,'Pesquisa',2);
INSERT INTO Departamento
VALUES (2,'Administração',8);
INSERT INTO Departamento
VALUES (3,'Construção',4);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_depto FOREIGN KEY (ID_Depto)
       REFERENCES Departamento (ID_Depto);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_superv FOREIGN KEY (ID_Superv)
       REFERENCES Funcionario (ID_Func);

ALTER TABLE Departamento
ADD CONSTRAINT fk_depto_func FOREIGN KEY (ID_Gerente)
        REFERENCES Funcionario (ID_Func);

INSERT INTO Dependente
VALUES (1,2,'Luciana','1990/11/05','F','Filha');
INSERT INTO Dependente
VALUES (2,2,'Paulo','1992/11/11','M','Filho');
INSERT INTO Dependente
VALUES (3,2,'Sandra','1996/12/14','F','Filha');
INSERT INTO Dependente
VALUES (4,4,'Mike','1997/11/05','M','Filho');
INSERT INTO Dependente
VALUES (5,1,'Max','1979/05/11','M','Filho');
INSERT INTO Dependente
VALUES (6,1,'Rita','1985/11/07','F','Filha');
INSERT INTO Dependente
VALUES (7,1,'Bety','1960/12/17','F','Esposa');

INSERT INTO Projeto
VALUES (1,'ProdX','Savassi',1);
INSERT INTO Projeto
VALUES (2,'ProdY','Luxemburgo',1);
INSERT INTO Projeto
VALUES (3,'ProdZ','Centro',1);
INSERT INTO Projeto
VALUES (10,'Computação','C. Nova',3);
INSERT INTO Projeto
VALUES (20,'Organização','Luxemburgo',2);
INSERT INTO Projeto
VALUES (30,'N. Benefícios','C. Nova',1);

INSERT INTO Trabalha
VALUES (1,1,32.5);
INSERT INTO Trabalha
VALUES (1,2,7.5);
INSERT INTO Trabalha
VALUES (5,3,40.0);
INSERT INTO Trabalha
VALUES (6,1,20.0);
INSERT INTO Trabalha
VALUES (6,2,20.0);
INSERT INTO Trabalha
VALUES (2,2,10.0);
INSERT INTO Trabalha
VALUES (2,3,10.0);
INSERT INTO Trabalha
VALUES (2,10,10.0);
INSERT INTO Trabalha
VALUES (2,20,10.0);
INSERT INTO Trabalha
VALUES (3,30,30.0);
INSERT INTO Trabalha
VALUES (3,10,10.0);
INSERT INTO Trabalha
VALUES (7,10,35.0);
INSERT INTO Trabalha
VALUES (7,30,5.0);
INSERT INTO Trabalha
VALUES (4,20,15.0);
INSERT INTO Trabalha
VALUES (8,20,NULL);

-----EXERCÍCIOS
Exercícios de Álgebra Relacional
1. Selecione o nome e o endereço do empregado de nome ‘Luciana S. Santos’.
2. Selecione o nome e o salário dos empregados que nasceram na década de 60, do sexo feminino
e que ganham menos de 1000.
3. Selecione o nome dos dependentes do empregado de nome ‘Luciana S. Santos’.
4. Selecione o nome dos projetos que o empregado de nome ‘Frank T. Santos’ trabalha.
5. Selecione o nome dos empregados que trabalham em projetos controlados pelo departamento de
nome ‘ Construção’.
6. Selecione o nome dos empregados supervisionados pelo empregado de nome ‘Frank T. Santos’.
7. Selecione o nome e endereço dos empregados que não tem nenhum dependente.
8. Selecione o nome dos empregados que trabalham no departamento de nome ‘Pesquisa’ ou que
trabalham no projeto de nome ‘N. Benefícios’.
9. Selecione o nome dos empregados que trabalham em algum projeto controlado pelo
departamento cujo gerente é o empregado de nome ‘Frank T. Santos’.
10. Selecione o nome dos empregados que trabalham em todos os projetos controlados pelo
departamento cujo gerente é o empregado de nome ‘Frank T. Santos’.

select NomeFunc, salario from funcionario where salario <> 1000;

SELECT NomeFunc, Endereco FROM funcionario WHERE NomeFunc = 'Luciana S. Santos';

SELECT NomeFunc, Salario 
FROM funcionario 
WHERE DataNasc BETWEEN '1961/01/01' AND '1970/12/31'
AND Sexo = 'F' AND Salario < 1000;

SELECT NomeFunc 
FROM funcionario F 
WHERE EXISTS 
(SELECT * FROM dependente D WHERE F.ID_Func = D.ID_Func);

SELECT DISTINCT NomeFunc 
FROM funcionario F, dependente D 
where F.ID_Func = D.ID_Func;

SELECT ID_Func, NomeFunc, ID_Superv 
FROM funcionario where ID_Superv IS NOT NULL;

SELECT ID_Func, NomeFunc, ID_Superv 
FROM funcionario where ID_Superv != 1;

SELECT ID_Func, NomeFunc, ID_Superv 
FROM funcionario where ID_Superv != 1 OR ID_Superv IS NULL;

SELECT NomeFunc, NomeDep 
FROM funcionario F, dependente D where F.ID_Func = D.ID_Func;
SELECT NomeFunc, NomeDep FROM funcionario F JOIN dependente D ON F.ID_Func = D.ID_Func;
SELECT NomeFunc, NomeDep FROM funcionario F LEFT OUTER JOIN dependente D ON F.ID_Func = D.ID_Func;

SELECT NomeFunc, COUNT(*) as NumFunc, 
MIN(salario) as MenorSalario, 
MAX(salario) as MaiorSalario, 
SUM(salario) as SomaSalarios, 
AVG(salario) as MediaSalario 
from funcionario;

SELECT ID_Depto, COUNT(*) as NumFunc, MIN(salario) as MenorSalario, MAX(salario) as MaiorSalario, SUM(salario) as SomaSalarios, AVG(salario) as MediaSalario 
from funcionario GROUP BY ID_Depto;

SELECT ID_Depto, COUNT(*) as NumFunc, MIN(salario) as MenorSalario, MAX(salario) as MaiorSalario, SUM(salario) as SomaSalarios, AVG(salario) as MediaSalario 
from funcionario GROUP BY ID_Depto HAVING COUNT(*) > 2;

SELECT COUNT(*) as NumFunc, COUNT(salario), COUNT(ID_Superv) from funcionario;

SELECT ID_Depto, NomeDepto, COUNT(*) FROM funcionario NATURAL JOIN departamento GROUP BY ID_Depto, NomeDepto;

SELECT * FROM funcionario ORDER BY salario DESC, NomeFunc ASC;

update funcionario
set Endereco = 'R. Bahia, 200', salario = 2200;

create view FuncReduzido as select ID_Func, NomeFunc, Endereco from Funcionario;
select * from funcreduzido;