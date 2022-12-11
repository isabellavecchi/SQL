BEGIN TRANSACTION;

CREATE TABLE empresa (
  id     NUMBER(10)    NOT NULL,      -- NÃ£o nulidade (NOT NULL)
  nome   VARCHAR2(100) NOT NULL,
  PRIMARY KEY (id)               -- Chave primÃ¡ria (Primary Key)
);

CREATE TABLE funcionario (
  id     NUMBER(10)    NOT NULL,
  nome   VARCHAR2(100) NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE funcionario_empresa (
  id_funcionario NUMBER(10)  NOT NULL,
  id_empresa     NUMBER(10)  NOT NULL,
  ativo          CHAR(1) NULL CHECK (ativo IN ('S', 'N')),   -- Nulidade explicitada (NULL) - Constraint de Ckeck
  UNIQUE (id_funcionario, id_empresa),                -- Unicidade(Unique Key)
  FOREIGN KEY (id_funcionario) REFERENCES funcionario(id),   -- Chave estrangeira (Foreing Key)
  FOREIGN KEY (id_empresa)     REFERENCES empresa(id)        -- Chave estrangeira (Foreing Key)
);

-- Observe que nÃ£o foram indicadas as colunas nos inserts. Somente os valores
INSERT INTO empresa values(1, 'Kyros Tecnologia');
INSERT INTO empresa values(2, 'Algar Telecom');
INSERT INTO empresa values(3, 'HC - Medicina');
INSERT INTO empresa values(4, 'PMU - Prefeitura');

INSERT INTO funcionario values(1, 'Flávio');
INSERT INTO funcionario values(2, 'Alexia');
INSERT INTO funcionario values(3, 'Victor');
INSERT INTO funcionario values(4, 'Fonseca');
INSERT INTO funcionario values(5, 'Cairo');
INSERT INTO funcionario values(6, 'Cristiane');

-- Boa prÃ¡tica indicar as colunas que sÃ£o inseridas
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(1, 1);
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(2, 1);
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(3, 1);
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(3, 2);
INSERT INTO funcionario_empresa(id_funcionario, id_empresa, ativo) values(4, 1, 'N'); -- Inserindo coluna ativo
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(4, 3);
INSERT INTO funcionario_empresa(id_funcionario, id_empresa, ativo) values(5, 2, 'S'); -- Inserindo coluna ativo
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(6, 1);
INSERT INTO funcionario_empresa(id_funcionario, id_empresa) values(6, 2);

SELECT fe.id_funcionario, f.nome, COUNT(fe.id_empresa) AS quantidade_de_empregos
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
  GROUP BY fe.id_funcionario, f.nome;
  
  
SELECT fe.id_empresa, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_funcionarios
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
  GROUP BY fe.id_empresa, e.nome;
  
SELECT f.id, f.nome, e.id, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_colegas
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
  GROUP BY CUBE((f.id, f.nome), (e.id, e.nome));
  

SELECT fe.id_empresa, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_colegas
   FROM funcionario f2, funcionario f, empresa e, funcionario_empresa fe, funcionario_empresa fe2
  WHERE (fe.ativo = 'S'
    OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
    AND f2.nome = 'Flávio'
    AND fe2.id_funcionario = f2.id
    AND fe2.id_empresa = e.id
    AND f.id != f2.id
  GROUP BY fe.id_empresa, e.nome;


-- subconsulta no where
SELECT fe.id_empresa, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_funcionarios
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
    AND EXISTS (
                SELECT 'X'  --usar char economiza bits
                  FROM funcionario_empresa fe2, funcionario f2, empresa e2
                  WHERE fe2.id_funcionario = f2.id
                    AND e2.id = fe.id_empresa
                    AND f2.nome = 'Flávio'
                    AND fe2.id_empresa = e.id
                )
GROUP BY fe.id_empresa, e.nome;

-- subconsulta no select
SELECT e.id AS id_empresa, e.nome,
       (SELECT COUNT(fe.id_funcionario) AS quantidade_de_funcionarios
           FROM funcionario f,
                funcionario_empresa fe
           WHERE fe.id_empresa = e.id--e.id -> referenciando a consulta externa
             AND(fe.ativo = 'S' OR fe.ativo IS NULL)
             AND f.id = fe.id_funcionario)  AS quantidade_de_funcionarios
  FROM empresa e
     
     
--CUIDADO!
--  em subconsultas tomar o cuidado de n deixar retornar mais de uma linha.

-- subconsulta no from
SELECT t.*, fe2.id_funcionario, fe2.ativo
  FROM (SELECT fe.id_empresa, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_funcionarios
          FROM funcionario f, empresa e, funcionario_empresa fe
          WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
            AND e.id = fe.id_empresa
            AND f.id = fe.id_funcionario
        GROUP BY fe.id_empresa, e.nome) t,
        funcionario_empresa fe2
WHERE t.quantidade_de_funcionarios >= 2
  AND fe2.
--HAVING COUNT(*) >= 2;

-- subconsulta no from
SELECT t.*, fe2.id_funcionario, fe2.ativo
  FROM (
        SELECT fe.id_empresa, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_funcionarios
          FROM funcionario f, empresa e, funcionario_empresa fe
          WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
            AND e.id = fe.id_empresa
            AND f.id = fe.id_funcionario
        GROUP BY fe.id_empresa, e.nome
        ) t,
        funcionario_empresa fe2
  WHERE t.quantidade_de_funcionarios >= 2
    AND fe2.id_empresa = t.id_empresa;
    

SELECT *
FROM (
        SELECT e.id AS id_empresa, e.nome, (
          SELECT COUNT(fe.id_funcionario)
            FROM    funcionario f,
                    funcionario_empresa fe
            WHERE fe.id_empresa = e.id
              AND (fe.ativo = 'S' OR fe.ativo IS NULL)
              AND f.id = fe.id_funcionario) AS quantidade_de_funcionarios
            FROM empresa e
           ) tab  
          WHERE tab.quantidade_de_funcionarios != 0;

COMMIT;
ROLLBACK;