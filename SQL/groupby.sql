-- TABLE
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
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
SELECT f.nome, COUNT(fe.id_empresa) AS quantidade_de_empregos
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
  GROUP BY fe.id_funcionario;
  
  
SELECT e.nome, COUNT(fe.id_funcionario) AS quantidade_de_funcionarios
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
  GROUP BY fe.id_empresa;
  

  
SELECT f.nome, e.nome, COUNT(fe.id_funcionario) AS quantidade_de_colegas
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE (fe.ativo = 'S' OR fe.ativo IS NULL)
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario
  GROUP BY CUBE(f.id, e.id);

