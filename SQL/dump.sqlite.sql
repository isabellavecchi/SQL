-- TABLE
CREATE TABLE empresa(
  id	INTEGER		PRIMARY KEY,
  nome	VARCHAR(100)
);
CREATE TABLE funcionario(
  id	INTEGER		PRIMARY KEY,
  nome	VARCHAR(100)
);
CREATE TABLE funcionario_empresa(
  id_funcionario	INTEGER,
  id_empresa		INTEGER,
  ativo			BOOLEAN,
  	FOREIGN KEY (id_funcionario) REFERENCES funcionario(id),
  	FOREIGN KEY (id_empresa) REFERENCES empresa(id),
  	CONSTRAINT uk_funcionario_empresa UNIQUE (id_funcionario, id_empresa, ativo)
);
 
-- INSERT


INSERT INTO funcionario(id, nome)
  VALUES	(1, 'Flávio'),
  		(2, 'Alexia'),
            	(3, 'Victor'),
            	(4, 'Fonseca'),
            	(5, 'Cairo'),
            	(6, 'Cristiane');

INSERT INTO empresa(id, nome)
  VALUES	(1, 'Kyros Tecnologia'),
  		(2, 'Algar Telecom'),
            	(3, 'HC - Medicina');
            
INSERT INTO funcionario_empresa(id_funcionario, id_empresa)
  VALUES	(1, 1),
  		(2, 1),
            	(3, 1),
            	(3, 2),
            	(4, 1),
            	(4, 3),
            	(5, 2),
            	(6, 1),
            	(6, 2);


-- exercício pag 26
SELECT * FROM funcionario;

SELECT nome AS funcionario, id identificador FROM funcionario;

SELECT e.nome
  FROM empresa e
  WHERE e.id = 1;

SELECT DISTINCT fe.id_empresa FROM funcionario_empresa fe;


-- exercício pag 53
   --certo
SELECT f.nome
  FROM funcionario f, empresa e, funcionario_empresa fe
  WHERE e.nome = 'Kyros Tecnologia'
    AND e.id = fe.id_empresa
    AND f.id = fe.id_funcionario;
    
   --retorna somente a id
SELECT fe.id_funcionario, fe.id_empresa
  FROM funcionario_empresa fe
INTERSECT
SELECT f.id, e.id
  FROM funcionario f, empresa e
  WHERE e.nome = 'Kyros Tecnologia';

   --como seria feito?
SELECT fe.id_funcionario
  FROM funcionario_empresa fe
INNER JOIN empresa e 
  ON e.id = fe.id_empresa
  WHERE e.nome = 'Kyros Tecnologia'
RIGHT JOIN funcionario f
  ON f.id = fe.id_funcionario;

