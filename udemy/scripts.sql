-- Caso tenhas estas tabelas criadas de outro curso como o SQL ou PL/SQL não precisa executar novamente


CREATE TABLE TALUNO
(
  COD_ALUNO INTEGER NOT NULL,
  NOME VARCHAR(30),
  CIDADE VARCHAR2(30),
  CEP VARCHAR(10),
  PRIMARY KEY (COD_ALUNO)
);

SELECT * FROM TALUNO;

INSERT INTO TALUNO(COD_ALUNO,NOME,CIDADE,CEP)
VALUES (1,'MARCIO','NOVO HAMBURGO','93000000');

INSERT INTO TALUNO(COD_ALUNO,NOME,CIDADE,CEP)
VALUES  (2,'PAULA','IVOTI','93000000');

INSERT INTO TALUNO(COD_ALUNO,NOME,CIDADE,CEP) VALUES  (3,'MARIA','SAPIRANGA','93000000');

CREATE TABLE TCURSO
(  COD_CURSO INTEGER NOT NULL PRIMARY KEY,
   NOME VARCHAR2(30),
   VALOR NUMBER(8,2),
   CARGA_HORARIA INTEGER
);

SELECT * FROM TCURSO;

INSERT INTO TCURSO VALUES(1,'ORACLE SQL e PL/SQL',500,25);
INSERT INTO TCURSO VALUES(2,'ORACLE DBA',499,25);
INSERT INTO TCURSO VALUES(3,'JAVA FUNDAMENTOS E OO',1500,100);
INSERT INTO TCURSO VALUES(4,'JAVASERVER FACES',1600,100);


CREATE TABLE TCONTRATO
(  COD_CONTRATO INTEGER NOT NULL PRIMARY KEY,
   DATA DATE,
   COD_ALUNO INTEGER,
   TOTAL NUMBER(8,2),
   DESCONTO NUMBER(5,2)
);

SELECT * FROM TCONTRATO;

INSERT INTO TCONTRATO VALUES(1, SYSDATE   ,1 ,500,10);
INSERT INTO TCONTRATO VALUES(2, SYSDATE   ,2 ,500,10);
INSERT INTO TCONTRATO VALUES(3, SYSDATE   ,3 ,1500,05);
INSERT INTO TCONTRATO VALUES(4, SYSDATE-5 ,2 ,1600,10);
INSERT INTO TCONTRATO VALUES(5, SYSDATE-4 ,5 ,800,10);
INSERT INTO TCONTRATO VALUES(6, SYSDATE-3 ,5 ,445,0);
INSERT INTO TCONTRATO VALUES(7, SYSDATE-2 ,5 ,445,20);



--Sequence
CREATE SEQUENCE SEQ_ALUNO START WITH 4;

INSERT INTO TALUNO(COD_ALUNO,NOME,CIDADE,CEP)
VALUES (SEQ_ALUNO.NEXTVAL,'VALDO','CANOAS','11000000');

INSERT INTO TALUNO(COD_ALUNO,NOME,CIDADE,CEP)
VALUES (SEQ_ALUNO.NEXTVAL,'ANDRE','IVOTI','12000000');

SELECT * FROM TALUNO;

CREATE TABLE TITEM
 ( COD_ITEM INTEGER NOT NULL PRIMARY KEY,
   COD_CURSO INTEGER,
   COD_CONTRATO INTEGER,
   VALOR NUMBER(8,2) );

 INSERT INTO TITEM VALUES (1, 1, 1, 500);
 INSERT INTO TITEM VALUES (2, 1, 2, 500);
 INSERT INTO TITEM VALUES (3, 3, 3, 1500);
 INSERT INTO TITEM VALUES (4, 4, 4, 1600);
 INSERT INTO TITEM VALUES (5, 1, 5, 500);
 INSERT INTO TITEM VALUES (6, 1, 6, 500);
 INSERT INTO TITEM VALUES (7, 2, 6, 500);
 INSERT INTO TITEM VALUES (8, 3, 7, 500);


--------------------------------------------------------------------------------------


Record e Collections - Script

    DECLARE
    --
    TYPE Rec_aluno IS RECORD
    ( cod_aluno NUMBER NOT NULL := 0,
    nome TALUNO.Nome%TYPE,
    cidade TALUNO.Cidade%TYPE );
    --
    Registro rec_aluno;
    BEGIN
    registro.cod_aluno := 50;
    registro.nome := 'Marcio Konrath';
    registro.cidade := 'Novo Hamburgo';
    ---
    Dbms_Output.Put_Line('Codigo: '||registro.cod_aluno);
    Dbms_Output.Put_Line(' Nome: '||registro.nome);
    Dbms_Output.Put_Line('Cidade: '||registro.cidade);
    ---
    END;

------

    DECLARE
    reg TAluno%ROWTYPE; --Record
    vcep VARCHAR(10) := '98300000';
    BEGIN
    SELECT COD_ALUNO, NOME, CIDADE
    INTO Reg.cod_aluno, Reg.nome, Reg.cidade
    FROM TALUNO
    WHERE COD_ALUNO = 1;
    vCep := '93500000';
    reg.cep := vCep;
    Dbms_Output.Put_Line('Codigo: ' ||reg.cod_aluno);
    Dbms_Output.Put_Line('Nome : ' ||reg.nome);
    Dbms_Output.Put_Line('Cidade: ' ||reg.cidade);
    Dbms_Output.Put_Line('Cep : ' ||reg.cep);
    END;

    --
    DECLARE
    TYPE T_ALUNO IS TABLE OF TALUNO.NOME%TYPE
    INDEX BY BINARY_INTEGER; --Matriz
    REGISTRO T_ALUNO; --Record
    BEGIN
    REGISTRO(1) := 'MARCIO';
    REGISTRO(2) := 'JOSE';
    REGISTRO(3) := 'PEDRO';
    --
    Dbms_Output.Put_Line('Nome 1: '||registro(1));
    Dbms_Output.Put_Line('Nome 2: '||registro(2));
    Dbms_Output.Put_Line('Nome 3: '||registro(3));
    END;

    --
    SELECT cod_aluno, NOME
    FROM tALUNO WHERE COD_ALUNO = 1;
    --

    --
    DECLARE
    TYPE nome_type IS TABLE OF taluno.nome%TYPE;
    nome_table nome_type := nome_type(); --Criando Instancia
    BEGIN
    nome_table.EXTEND; -- alocando uma nova linha
    nome_table(1) := 'Marcelo';
    nome_table.EXTEND; -- alocando uma nova linha
    nome_table(2) := 'Marcio';
    Dbms_Output.Put_Line('Nome 1: '||nome_table(1));
    Dbms_Output.Put_Line('Nome 2: '||nome_table(2));
    END;

--

    DECLARE
    TYPE tipo IS TABLE OF VARCHAR2(40) INDEX BY VARCHAR2(2);
    --
    uf_capital tipo;
    BEGIN
    uf_capital('RS') := 'PORTO ALEGRE';
    uf_capital('RJ') := 'RIO DE JANEIRO';
    uf_capital('PR') := 'CURITIBA';
    uf_capital('MT') := 'CUIABA';
    dbms_output.put_line(uf_capital('RS'));
    dbms_output.put_line(uf_capital('RJ'));
    dbms_output.put_line(uf_capital('PR'));
    dbms_output.put_line(uf_capital('MT'));
    END;

    -- VARRAY
    DECLARE
    TYPE nome_varray IS VARRAY(5) OF taluno.nome%TYPE;
    nome_vetor nome_varray := nome_varray();
    BEGIN
    nome_vetor.EXTEND;
    nome_vetor(1) := 'MasterTraining';
    Dbms_Output.Put_Line(nome_vetor(1));
    END;


------------------------------------------------------------------


Function Pipelined - Scripts

--Function CREATE OR REPLACE FUNCTION CONSULTA_PRECO(pCod_Curso NUMBER) RETURN NUMBER AS vValor NUMBER; BEGIN SELECT valor INTO vValor FROM TCurso WHERE cod_curso = pCod_Curso;

RETURN(vValor); END;

--Teste | Usando function DECLARE vCod NUMBER := &codigo; vValor NUMBER; BEGIN vValor := consulta_preco(vCod); Dbms_Output.Put_Line('Preco do curso: '||vValor); END;

--Function PIPELINED

--Conectado como System GRANT CREATE ANY TYPE TO MARCIO;

--Registro - Array DROP TYPE TABLE_REG_ALUNO;

CREATE OR REPLACE TYPE REG_ALUNO AS OBJECT ( CODIGO INTEGER, NOME VARCHAR2(30), CIDADE VARCHAR(30) );

--Matriz CREATE OR REPLACE TYPE TABLE_REG_ALUNO AS TABLE OF REG_ALUNO;

-- Array [0][1][2][3][4]

-- Matriz [0][1][2][3][4] [1][1][2][3][4] [2][][][][] --Function que retorna registros CREATE OR REPLACE FUNCTION GET_ALUNO(pCODIGO NUMBER) RETURN TABLE_REG_ALUNO PIPELINED IS outLista REG_ALUNO; CURSOR CSQL IS SELECT ALU.COD_ALUNO, ALU.NOME, ALU.CIDADE FROM TALUNO ALU WHERE ALU.COD_ALUNO = pCODIGO; REG CSQL%ROWTYPE; BEGIN OPEN CSQL; FETCH CSQL INTO REG; outLista := REG_ALUNO(REG.COD_ALUNO, REG.NOME, REG.CIDADE); PIPE ROW(outLista); --Escreve a linha CLOSE CSQL; RETURN; END;

--usando SELECT * FROM TABLE(GET_ALUNO(1));

--Usando SELECT ALU.*, CON.total FROM TABLE(GET_ALUNO(1)) ALU, TCONTRATO CON WHERE CON.COD_ALUNO = ALU.CODIGO

CREATE OR REPLACE FUNCTION GET_ALUNOS RETURN TABLE_REG_ALUNO PIPELINED IS outLista REG_ALUNO; CURSOR CSQL IS SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO; REG CSQL%ROWTYPE; BEGIN FOR REG IN CSQL LOOP ----------....... outLista := REG_ALUNO(REG.COD_ALUNO,REG.NOME,REG.CIDADE); PIPE ROW(outLista); END LOOP; ------........ RETURN; END;

--Usando SELECT * FROM TABLE(GET_ALUNOS);

CREATE OR REPLACE TYPE REG_TOTALALUNO AS OBJECT ( COD_ALUNO INTEGER, NOME VARCHAR2(30), TOTAL NUMERIC(8,2) );

--Matriz CREATE OR REPLACE TYPE TABLE_REG_TOTALALUNO AS TABLE OF REG_TOTALALUNO;

--Function que retorna registros CREATE OR REPLACE FUNCTION GET_TOTALALUNO(PCODIGO NUMBER) RETURN TABLE_REG_TOTALALUNO PIPELINED IS outLista REG_TOTALALUNO; CURSOR CSQL IS SELECT ALU.COD_ALUNO, ALU.NOME, Sum(CON.TOTAL) TOTAL FROM TCONTRATO CON, TALUNO ALU WHERE CON.COD_ALUNO = ALU.COD_ALUNO AND ALU.COD_ALUNO=PCODIGO GROUP BY ALU.COD_ALUNO, ALU.NOME; REG CSQL%ROWTYPE; BEGIN OPEN CSQL; FETCH CSQL INTO REG; outLista:=REG_TOTALALUNO(REG.COD_ALUNO, REG.NOME, REG.TOTAL); PIPE ROW(outLista); CLOSE CSQL; RETURN; END;

SELECT * FROM TABLE(GET_TOTALALUNO(1));

2) Criar uma FUNCTION que retorne Cod_Contrato, Data, NomeAluno, Total ( Usar FOR LOOP )

DROP TYPE TABLE_REG_LISTAALUNO; CREATE OR REPLACE TYPE REG_LISTAALUNO AS OBJECT ( DATA DATE, NOME VARCHAR(20), TOTAL NUMERIC(8,2) );

--Matriz CREATE OR REPLACE TYPE TABLE_REG_LISTAALUNO AS TABLE OF REG_LISTAALUNO;

CREATE OR REPLACE FUNCTION GET_LISTAALUNO RETURN TABLE_REG_LISTAALUNO PIPELINED IS outLista REG_LISTAALUNO; CURSOR CSQL IS SELECT Trunc(CON.DATA) DATA, ALU.NOME, Sum(CON.TOTAL) TOTAL FROM TALUNO ALU, TCONTRATO CON WHERE CON.COD_ALUNO = ALU.COD_ALUNO GROUP BY Trunc(CON.DATA), ALU.NOME; REG CSQL%ROWTYPE; BEGIN FOR REG IN CSQL LOOP ----------....... outLista := REG_LISTAALUNO(REG.DATA,REG.NOME, REG.TOTAL); PIPE ROW(outLista); END LOOP; ------........ RETURN; END;

SELECT * FROM TABLE(GET_LISTAALUNO);


-------------------------------------------------------------------------------------------


Bulk Collect

O uso do Bulk Collect é aplicado para a manipulação de grande massa de dados. Com seu uso correto, podemos ter vários tipos de ganhos.

Podemos ter: Aplicações mais rápidas, alocação dos dados na memória, sem a necessidade de refazer a busca no banco. Porem temos um risco também, pois se não aplicarmos corretamente as diretrizes na PGA(Program Global Area), podemos ter problemas na quantidade de dados carregados na memória.

Para estes problemas temos a claúsula LIMIT, que limita os dados que foram para a memória.

Exemplo:

    CREATE TABLE TPRODUTO (
      COD_PRODUTO NUMBER(5),
      DESCRICAO VARCHAR2(40),
      CONSTRAINT PRODUTO_PK PRIMARY KEY (COD_PRODUTO));

Inserindo os dados na tabela:

    BEGIN
      INSERT INTO TPRODUTO
      SELECT LEVEL, DBMS_RANDOM.STRING('A', 40) FROM DUAL CONNECT BY LEVEL <= 100;
      COMMIT;
    END;

--Vamos agora usar o Bulk Collect com limite de 50 registros. 
--Vamos colocar a cada loop apenas 50 registros na memória.

    DECLARE
      CURSOR CUR_PRODUTO IS
      SELECT COD_PRODUTO, DESCRICAO FROM TPRODUTO;
      TYPE TROW_PRODUTO IS TABLE OF CUR_PRODUTO%ROWTYPE INDEX BY PLS_INTEGER;
      ROW_PRODUTO TROW_PRODUTO;
    BEGIN
      OPEN CUR_PRODUTO;
      LOOP
        FETCH CUR_PRODUTO BULK COLLECT INTO ROW_PRODUTO LIMIT 50;
        EXIT WHEN ROW_PRODUTO.COUNT = 0;
        FOR I IN 1 .. ROW_PRODUTO.Count LOOP
          DBMS_OUTPUT.PUT_LINE('Código: ' || ROW_PRODUTO(I).COD_PRODUTO || ' Descrição: ' || ROW_PRODUTO(I).DESCRICAO);
        END LOOP;
      END LOOP;
      CLOSE CUR_PRODUTO;
    END;


---------------------------------------------------------------------------------------------------------



Comando Merge - Script

Scripts usados no video.

    SELECT * FROM TALUNO
    ORDER BY COD_ALUNO

    SELECT * FROM TCONTRATO

    CREATE SEQUENCE seq_con START WITH 50;

    --
    MERGE INTO TCONTRATO tcn
    USING (SELECT COD_ALUNO AS ALUNO
    FROM TALUNO)
    ON (tcn.COD_ALUNO = ALUNO )
    WHEN MATCHED THEN --Encontrou o registro
    UPDATE SET desconto = 44
    WHEN NOT MATCHED THEN --nao encontrou o registro
    INSERT(tcn.COD_CONTRATO, tcn.DATA, tcn.COD_ALUNO,
    tcn.desconto, tcn.total)
    VALUES( Seq_Con.NextVal, SYSDATE, ALUNO, 0, 666);


---------------------------------------------------------------------------------------


Oracle Text e Contains


Oracle Text

O Oracle Text é uma feature embutida no banco de dados que utiliza a linguagem SQL para indexar, pesquisar e analisar textos e documentos binários armazenados nas tabelas. Nas versões Oracle 11g essa feature é conhecida como Oracle Text. Esta tecnologia oferece uma solução completa para pesquisa de textos na qual a mesma permite filtrar e extrair textos de conteúdos de diferentes formatos de documentos. O Oracle Text suporta mais de 150 formatos de documentos, incluindo os mais populares como os documentos Microsoft Office, além de formatos de arquivo do Adobe PDF, arquivos HTML e XML. Neste artigo irei demonstrar como gravar um documento binário (.doc) no banco de dados Oracle 11g e o que fazer para poder realizar pesquisas no seu conteúdo. 

O arquivo que irei carregar para o banco de dados (teste.doc) possui o conteúdo "Marcio Konrath Curso de Oracle" para isto abra arquivo em branco do microsoft word e escreva o texto mencinado ou algum outro texto qualquer e salva na pasta C:\Temp com nome de "arquivo.doc"

Em seguida abra o CMD como administrador e conecte no SQLPLUS 

C:\set ORACLE_SID=curso

C:\>sqlplus sys/123 as sysdba

 

 

-- Criação de um diretório que indica a localização do documento

--Conectado como usuario system grant create any directory to marcio;

--Conectado como usuario normal create or replace directory arquivos as 'C:\Temp';

 

Agora conectado como usuário normal de desenvolvimento no SQL Developer vamos criar uma tabela

    create table teste (
      codigo number,
      nome varchar2(40),
      documento blob
    );

    create sequence seq_doc;

-- Criação de uma procedure para carregar o arquivo para o banco de dados

    create or replace procedure grava_arquivo (p_file in varchar(40))
    as
      v_bfile bfile;
      v_blob blob;
    begin
      insert into teste (codigo,nome,documento)
      values (seq_doc.nextval,p_file_name,empty_blob())
      return documento into v_blob;
      -- Informação de directory tem que ser maiusculo 
      v_bfile := bfilename('ARQUIVOS',p_file);
      dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);     
      dbms_lob.loadfromfile(v_blob,v_bfile,dbms_lob.getlength(v_bfile));
      dbms_lob.fileclose(v_bfile);
      commit;
    end;

-- Grava o arquivo para a tabela 

    execute grava_arquivo('arquivo.doc');

 

--Para testar se gravou o registro faça select na tabela

    Select * from teste;

e

    Select dbms_lob.getlength(documento) bytes from teste;

--Vamos criar índice que vai permitir pesquisar dentro deste arquivo grava na tabela

    create index ind_teste_doc on teste (documento) indextype is ctxsys.context parameters ('sync (on commit)');

--Para verificar se houve erro na criação do índice

    select * from ctx_user_index_errors;

--Podemos verificar que foram criados alguns índices adicionais usando o selects abaixo

    select table_name from user_tables;

    select index_name,table_name from user_indexes;

--Fazendo pesquisar no documento gravando na tabela

    select codigo, nome from teste where contains(documento, 'Marcio', 1) > 0;

    select codigo,nome from teste where contains(documento, 'curso', 1) > 0;


---------------------------------------------------------------------------------------------------


Pacote UTL_FILE
Oracle UTL_FILE

O pacote UTL_FILE é um conjunto de componentes que tem como função permitir o acesso ou geração de arquivos externos ao banco de dados. Um exemplo seria importarmos scripts em SQL ou PL/SQL para o nosso sistema.
O pacote é constituído de 18 componentes, são eles: Exceptions, Functions, Procedures e Types.

Para utilizarmos o pacote, teremos que interromper os serviços do banco de dados e modificar o arquivo initXE.ora (ORACLE 11G Express Edition), onde iremos acrescentar o parâmetro UTL_FILE_DIR, afim de determinar quais os diretórios do sistema está livre para o acesso.

Abra o CMD do windows ou terminar Linux e vamos informar ao banco de dados que podemos gravar e recuperar dados do sistema operacional, através dos seguintes passos:

COMANDOS UTL_FILE

Procedimentos da package UTL_FILE

FOPEN
abre um arquivo para entrada ou saída, criando um arquivo de saída caso o arquivo especificado não exista

IS_OPEN
indica se determinado arquivo está ou não aberto

FCLOSE
fecha um arquivo

FCLOSE_ALL
fecha todos os arquivos abertos

GET_LINE
lê uma linha de um arquivo aberto

PUT
escreve uma linha no arquivo. Não acrescenta automaticamente o caractere de fim de linha

PUT_LINE
escreve uma linha no arquivo, acrescentando automaticamente o caractere de fim de linha
NEW_LINE
inclui o caractere de fim de linha no arquivo, o que irá gerar uma nova linha em branco
FFLUSH
escreve, fisicamente, todas as pendências para um arquivo

Exceções package UTL_FILE

INVALID_PATH
diretório ou nome de arquivo inválido

INVALID_MODE
o parâmetro de modo de abertura é inválido

INVALID_FILEHANDLE
especificador de arquivo inválido

INVALID_OPERATION
o arquivo não pode ser aberto ou a operação é inválida

READ_ERROR
ocorreu um erro do sistema operacional durante a leitura de um arquivo

WRITE_ERROR
ocorreu um erro do sistema operacional durante a gravação de um arquivo

INTERNAL_ERROR
erro não especificado no PL/SQL

NO_DATA_FOUND
nesse caso, é disparada quando o fim do arquivo é encontrado em processamento de leitura seqüencial de um arquivo de texto

Exemplo para geração de arquivo texto:

CREATE OR REPLACE DIRECTORY DIRETORIO AS 'F:\Temp';

    DECLARE
     arquivo_saida UTL_File.File_Type;
     Cursor Cur_Linha is
     SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO; 
    BEGIN
     arquivo_saida := UTL_File.Fopen('DIRETORIO','Lista.txt','w');
     For Reg_Linha in Cur_linha Loop
     UTL_File.Put_Line(arquivo_saida, Reg_linha.COD_ALUNO||'-'||Reg_linha.NOME);
     UTL_File.Put_Line(arquivo_saida, Reg_linha.COD_ALUNO);
     End Loop;
     UTL_File.Fclose(arquivo_saida);
     Dbms_Output.Put_Line('Arquivo gerado com sucesso.');
    EXCEPTION
     WHEN UTL_FILE.INVALID_OPERATION THEN
     Dbms_Output.Put_Line('Operação inválida no arquivo.');
     UTL_File.Fclose(arquivo_saida);
     WHEN UTL_FILE.WRITE_ERROR THEN
     Dbms_Output.Put_Line('Erro de gravação no arquivo.');
     UTL_File.Fclose(arquivo_saida);
     WHEN UTL_FILE.INVALID_PATH THEN
     Dbms_Output.Put_Line('Diretório inválido.');
     UTL_File.Fclose(arquivo_saida);
     WHEN UTL_FILE.INVALID_MODE THEN
     Dbms_Output.Put_Line('Modo de acesso inválido.');
     UTL_File.Fclose(arquivo_saida);
     WHEN Others THEN
     Dbms_Output.Put_Line('Problemas na geração do arquivo.');
     UTL_File.Fclose(arquivo_saida);
    END;

Exemplo: Roteiro para leitura de arquivo texto:

    DECLARE
     arquivo UTL_File.File_Type;
     Linha Varchar2(100);
    BEGIN
     arquivo := UTL_File.Fopen('DIRETORIO','Lista.txt', 'r');
     Loop
     UTL_File.Get_Line(arquivo, Linha);
     Dbms_Output.Put_Line('Registro: '||linha);
     End Loop;
     UTL_File.Fclose(arquivo);
     Dbms_Output.Put_Line('Arquivo processado com sucesso.');
    EXCEPTION
     WHEN No_data_found THEN
     UTL_File.Fclose(arquivo);
     WHEN UTL_FILE.INVALID_PATH THEN
     Dbms_Output.Put_Line('Diretório inválido.');
     UTL_File.Fclose(arquivo);
     WHEN Others THEN
     Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
     UTL_File.Fclose(arquivo);
    END;

MAIS EXEMPLOS DE UTL_FILE

Rodar bloco anonimo conectado com seu usuario normal

    DECLARE
     VLINHA VARCHAR2(2000) := '';
     VARQUIVO UTL_FILE.FILE_TYPE;
    BEGIN
     VARQUIVO := UTL_FILE.FOPEN('DIRETORIO', 'Lista.TXT', 'w');
     FOR x in 1..8 LOOP
     VLINHA := 'LINHA ' || x;
     UTL_FILE.PUT_LINE(VARQUIVO, VLINHA);
     Dbms_Output.Put_Line('Registro: '||Vlinha);
     END LOOP;
     UTL_FILE.FCLOSE(VARQUIVO);
    END;

Confira o arquivo na pasta F:\temp


---------------------------------------------------------------------------------------------------



Manipulando XML

PL/SQL E XML

A XML (Extensible Markup Language) é uma linguagem de marcação de propósito geral. Ela permite compartilhar dados estruturados na Internet e pode ser usada para codificar dados e outros documentos. A XML apresenta as seguintes vantagens: 

? Pode ser lida por seres humanos e computadores e é armazenada como texto puro
? É independente de plataforma
? Suporta Unicode, o que significa que ela pode armazenar informações escritas em muitos idiomas
? Usa um formato autodocumentado que contém a estrutura do documento, nomes de elemento e valores de elemento Por causa dessas vantagens, a XML é muito usada para armazenamento e processamento de documentos, sendo aplicada por muitas organizações para o envio de dados entre seus sistemas de computador. Por exemplo, muitos fornecedores permitem que seus clientes enviem pedidos de compra como arquivos XML pela Internet.

GERANDO CÓDIGO XML A PARTIR DE DADOS RELACIONAIS

O banco de dados Oracle contém várias funções SQL que podem ser usadas para gerar código XML e, nesta seção, você vai ver como gerar código XML a partir de dados relacionais utilizando algumas dessas funções.

XMLELEMENT() A função XMLELEMENT() é usada para gerar elementos XML a partir de dados relacionais. Você fornece um nome para o elemento e a coluna que deseja recuperar para a função XMLELEMENT() e ela retorna os elementos como objetos XMLType. XMLType é um tipo interno do banco de dados Oracle utilizado para representar dados XML. Por padrão, um objeto XMLType armazena os dados XML como texto em um CLOB (Character Large Object). O exemplo a seguir se conecta no SQL Developer com usuário de desenvolvimento e usa objetos XMLType. 

CONNECT store/store_password 

    SELECT XMLELEMENT("cod_aluno", cod_aluno)
    AS aluno
    FROM taluno;

    ALUNO
    ----------------------------
    <cod_aluno>1</cod_aluno>
    <cod_aluno>2</cod_aluno>
    <cod_aluno>3</cod_aluno>
    <cod_aluno>4</cod_aluno>
    <cod_aluno>5</cod_aluno>
    Conforme você pode ver a partir desses resultados, XMLELEMENT ("cod_aluno", cod_aluno) retorna os valores de cod_aluno dentro de uma tag cod_aluno. Você pode usar o
    nome de tag que desejar, como mostrado no exemplo a seguir, que utiliza a tag "cod_alu":
    SELECT XMLELEMENT("cod_alu", cod_aluno)
    AS aluno
    FROM TAluno;

    ALUNO
    --------------------
    <cod_alu>1</cod_alu>
    <cod_alu>2</cod_alu>
    <cod_alu>3</cod_alu>
    <cod_alu>4</cod_alu>
    <cod_alu>5</cod_alu>

O exemplo a seguir obtém os valores de nome e cidade do aluno n° 2: 

    SELECT XMLELEMENT("nome", nome) || XMLELEMENT("cidade", cidade)
    AS alunos
    FROM taluno
    WHERE cod_aluno = 2;
    ALUNOS
    -----------------------------------------------------
    <nome>MARCIO</nome><cidade>NOVO HAMBURGO</cidade>

O exemplo a seguir incorpora duas chamadas de XMLELEMENT() dentro de uma chamada externa de XMLELEMENT(). Observe que os elementos cod_aluno e nome retornados estão contidos dentro de um elemento customer externo: 

    SELECT XMLELEMENT(
    "aluno",
    XMLELEMENT("cod_aluno", cod_aluno),
    XMLELEMENT("nome", nome)
    )
    AS alunos FROM TAluno
    WHERE cod_aluno IN (1, 2);
    ALUNOS
    ------------------------------
    <aluno>
    <cod_aluno>1</cod_aluno>
    <nome>PEDRO</nome>
    </aluno>
    <aluno>
    <cod_aluno>2</cod_aluno>
    <nome>MARCIO</nome>
    </aluno >

OBS

Algumas quebras de linhas e espaços foram adicionados no código XML retornado por essa consulta para torná-lo mais fácil de ler. O mesmo foi feito em alguns dos outros exemplos deste capítulo. Você pode recuperar dados relacionais normais, assim como código XML, conforme mostrado no exemplo a seguir, que recupera a coluna cod_aluno como um resultado relacional normal e as colunas nome e cidade concatenadas como elementos XML:

    SELECT cod_aluno, XMLELEMENT("aluno", nome) AS aluno
    FROM TAluno;
    COD_ALUNO ALUNO
    ----------- ----------------------------------
    1 <aluno>PEDRO</aluno>
    2 <aluno>MARCIO</aluno>

XMLFOREST()

Você usa XMLFOREST() para gerar uma “floresta” de elementos XML. XMLFOREST() concatena elementos XML sem que você precise usar o operador de concatenação || com várias chamadas de XMLELEMENT(). O exemplo a seguir usa XMLFOREST() para obter cod_aluno, nome e cidade dos alunos n° 1 e 2:

    SELECT XMLELEMENT(
    "aluno",
    XMLFOREST(
    cod_aluno AS "cod",
    nome AS "nome",
    cidade AS "dob"
    ) )
    AS aluno
    FROM aluno
    WHERE cod_aluno IN (1, 2);
    ALUNO
    -----------------------------
    <aluno>
    <id>1</id>
    <nome>PEDRO</nome>
    <cidade>PORTO ALEGRE</cidade>
    </aluno>
    <aluno>
    <id>2</id>
    <nome>MARCIO</nome>
    <cidade>NOVO HAMBURGO</cidade>
    </aluno>

A consulta a seguir coloca o nome do cliente dentro da tag de elemento aluno usado

XMLATTRIBUTES():

    SELECT XMLELEMENT(
    "aluno",
    XMLATTRIBUTES(nome AS "nome"),
    XMLFOREST(cidade AS "cidade", estado as “estado”)
    )
    AS xml_aluno
    FROM TAluno
    WHERE cod_aluno IN (1, 2);
    XML_ALUNO
    -------------------------------
    <aluno nome="PEDRO">
    <cidade>PORTO ALEGRE</cidade>
    <estado>RS</estado>
    </aluno>
    <aluno nome="MARCIO">
    <cidade>NOVO HAMBURGO</cidade>
    <estado>02/05/1968</estado>
    </aluno>


-----------------------------------------------------------------------------------------------------------------


Manipulando XML - Scripts

--XML

    SELECT XMLELEMENT("cod_aluno", cod_aluno) AS Aluno
    FROM taluno;

    SELECT XMLELEMENT("Nome", Nome) || XMLELEMENT("Cidade", cidade)
    AS Aluno
    FROM taluno;

    SELECT XMLELEMENT("DataContrato", TO_CHAR(data, 'MM/DD/YYYY'))||''
    AS Data_Contrato
    FROM tcontrato;

    SELECT XMLELEMENT("Aluno",
    XMLELEMENT("cod_aluno", cod_aluno),
    XMLELEMENT("nome", nome)) AS aluno
    FROM taluno;

    -------------------------------
    SELECT XMLELEMENT("Aluno",
    XMLATTRIBUTES(
    cod_aluno AS "cod_aluno",
    nome as "nome",
    cidade AS "cidade" ) )AS Aluno
    FROM taluno;

    -------------------------------
    SELECT XMLELEMENT("Aluno",
    XMLFOREST( cod_aluno AS "codigo",
    nome AS "nome",
    cidade as "cidade"))AS Aluno
    FROM TAluno;

    SELECT XMLELEMENT("Aluno",
    XMLFOREST(cod_aluno,
    nome,
    cidade))AS Aluno
    FROM taluno

    Select * from taluno

    SELECT XMLELEMENT("Aluno",
    XMLATTRIBUTES(cod_aluno as "cod_aluno"),
    XMLFOREST(nome AS "nome", cidade AS "cidade", cep AS "cep") 
    )AS aluno
    FROM TALUNO
    ------------------------
    SELECT XMLPARSE(CONTENT
    '<TAluno><nome>Márcio Konrath</nome></TAluno>'
    WELLFORMED
    ) AS ALUNO
    FROM dual;

--Criando arquivo XML a partir de tabela

--Primeiramente temos que configurar o Oracle para aceitar criar arquivos
--Abra o CMD como Administrador set ORACLE_SID=curso
-- SQLPLUS SYS/123 AS SYSDBA

--Fechar o banco de dados SHUTDOWN IMMEDIATE;
--Iniciar o banco de dos sem abrir STARTUP MOUNT;
--Alterar o parâmetro UTL_FILE_DIR: ALTER SYSTEM SET UTL_FILE_DIR = '*' SCOPE = SPFILE;

--Fechar novamente o banco SHUTDOWN IMMEDIATE;
--Abrir o banco STARTUP
--Verificar se o parâmetro foi alterado SHOW PARAMETER UTL_FILE_DIR
--Dar privilegio para qualquer usuário para trabalhar com UTL_FILE GRANT EXECUTE ON UTL_FILE TO PUBLIC;

--Conectar novamente ao usuário no SQL Developer

--Gerando arquivo xml

    Declare
      p_directory VARCHAR2(100) := 'D:\Temp';
      p_file_name VARCHAR2(50) := 'arquivo.xml';
      v_file UTL_FILE.FILE_TYPE;
      v_amount INTEGER:= 32767;
      v_xml_data XMLType;
      v_xml clob;
      v_char_buffer VARCHAR2(32767);
    BEGIN
      -- abre o arquivo para gravar o texto (até v_amount
      -- caracteres por vez)
      v_file:= UTL_FILE.FOPEN(P_DIRECTORY,p_file_name,'w', v_amount);
      -- grava a linha inicial em v_file
      UTL_FILE.PUT_LINE(v_file, '<?xml version="1.0"?>');
      -- recupera os alunos e os armazena em v_xml_data
      SELECT XMLELEMENT(
      "Aluno",
      XMLFOREST(
      cod_aluno AS "codigo",
      nome AS "nome"
      ))AS Aluno
      INTO v_xml_data
      from taluno where cod_aluno = 1; 
     
      -- obtém o valor da string de v_xml_data e o armazena em v_char_buffer
      v_char_buffer:= v_xml_data.GETSTRINGVAL();
      -- copia os caracteres de v_char_buffer no arquivo
      UTL_FILE.PUT(v_file, v_char_buffer);
      -- descarrega os dados restantes no arquivo
      UTL_FILE.FFLUSH(v_file);
      -- fecha o arquivo
      UTL_FILE.FCLOSE(v_file);
    end;

    --Lendo arquivo
    DECLARE
      arq_leitura UTL_File.File_Type;
      Linha Varchar2(250);
    BEGIN
      arq_leitura := UTL_File.Fopen('D:\Temp\','arquivo.xml', 'r');
      Dbms_Output.Put_Line('Processamento');
      Loop
        UTL_File.Get_Line(arq_leitura, Linha);
        DBMS_OUTPUT.PUT('Linha XML: '||Linha);
        exit;
      End Loop;
      UTL_File.Fclose(arq_leitura);
      Dbms_Output.Put_Line('Arquivo processado com sucesso.');
    EXCEPTION
      WHEN No_data_found THEN
        UTL_File.Fclose(arq_leitura);
        Commit;
      WHEN UTL_FILE.INVALID_PATH THEN
        Dbms_Output.Put_Line('Diretório inválido.');
        UTL_File.Fclose(arq_leitura);
      WHEN Others THEN
      Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
      UTL_File.Fclose(arq_leitura);
    END;


-----------------------------------------------------------------------------------------------


Otimização de Consulta

AJUSTE DE SQL

Uma das principais vantagens da linguagem SQL é que você não precisa dizer ao banco de dados exatamente como ele deve obter os dados solicitados. Basta executar uma consulta especificando as informações desejadas e o software de banco de dados descobre a melhor maneira de obtê-las. Às vezes, você pode melhorar o desempenho de suas instruções SQL “ajustando-as”. Nas seções a seguir, você verá dicas de ajuste que podem fazer suas consultas executarem mais rapidamente e técnicas de ajuste mais avançadas.

 

USE UMA CLÁUSULA WHERE PARA FILTRAR LINHAS

Muitos iniciantes recuperam todas as linhas de uma tabela quando só querem uma delas (ou algumas poucas). Isso é muito desperdício. Uma estratégia melhor é adicionar uma cláusula WHERE em uma consulta. Desse modo, você restringe as linhas recuperadas apenas àquelas realmente necessárias.

Por exemplo, digamos que você queira os detalhes dos clientes nº 1 e 2. A consulta a seguir recupera todas as linhas da tabela customers no esquema store (desperdício):

-- RUIM (recupera todas as linhas da tabela customers)

 

    SELECT * FROM TALUNO;

  

A próxima consulta adiciona uma cláusula WHERE ao exemplo anterior para obter apenas os

alunos nº 1 e 2:

 

-- BOM (usa uma cláusula WHERE para limitar as linhas recuperadas)

    SELECT *
    FROM TALUNO
    WHERE COD_ALUNO IN (1, 2);

 

USE JOINS DE TABELA EM VEZ DE VÁRIAS CONSULTAS

Se você precisa de informações de várias tabelas relacionadas, deve usar condições de join, em vez

de várias consultas. No exemplo inadequado a seguir, são usadas duas consultas para obter o nome

e o tipo do produto nº 1 (usar duas consultas é desperdício). A primeira consulta obtém os valores

de coluna nome e cod_aluno da tabela products para o produto nº 1. A segunda consulta

utiliza esse valor de cod_aluno para obter a coluna name da tabela TALUNO.

 

-- RUIM (duas consultas separadas, quando uma seria suficiente)

    SELECT nome, cod_aluno
    FROM taluno
    WHERE cod_aluno = 1;

 

Em vez de usar duas consultas, você deve escrever uma única consulta que utilize um join

entre as tabelas products e product_types. A consulta correta a seguir mostra isso:

-- BOM (uma única consulta com um join)

    SELECT CON.DATA, ALU.NOME, TOTAL
    FROM TCONTRATO CON, TALUNO ALU
    WHERE CON.COD_ALUNO = ALU.COD_ALUNO
    AND CON.COD_CONTRATO = 1;

 

Essa consulta resulta na recuperação do mesmo nome e tipo de produto do primeiro exemplo,

mas os resultados são obtidos com uma única consulta. Uma só consulta geralmente é mais

eficiente do que duas.

Você deve escolher a ordem de junção em sua consulta de modo a juntar menos linhas nas

tabelas posteriormente. 

 

USE REFERÊNCIAS DE COLUNA TOTALMENTE QUALIFICADAS AO FAZER JOINS

Sempre inclua apelidos de tabela em suas consultas e utilize o apelido de cada coluna (isso é conhecido

como “qualificar totalmente” suas referências de coluna). Desse modo, o banco de dados

não precisará procurar nas tabelas cada coluna utilizada em sua consulta.

 

-- RUIM (as colunas TOTAL não esta totalmente qualificada)

    SELECT CON.DATA, ALU.NOME
    FROM TCONTRATO CON, TALUNO ALU
    WHERE CON.COD_ALUNO = ALU.COD_ALUNO
    AND CON.COD_CONTRATO = 1;

 

USE EXPRESSÕES CASE EM VEZ DE VÁRIAS CONSULTAS

Use expressões CASE, em vez de várias consultas, quando precisar efetuar muitos cálculos nas

mesmas linhas em uma tabela. O exemplo inadequado a seguir usa várias consultas para contar o

número de produtos dentro de diversos intervalos de preço:

-- RUIM (três consultas separadas, quando uma única instrução CASE

funcionaria)

 

    SELECT COUNT(*) FROM TCURSO WHERE VALOR < 800;

 

    SELECT COUNT(*) FROM TCURSO WHERE VALOR BETWEEN 1000 AND 1500;

  

    SELECT COUNT(*)
    FROM TCURSO
    WHERE VALOR > 1200;

 

 

Em vez de usar três consultas, você deve escrever uma única que utilize expressões CASE. Isso

está mostrado no exemplo correto a seguir:

 

-- BOM (uma única consulta com uma expressão CASE)

    SELECT
    COUNT(CASE WHEN VALOR < 800 THEN 1 ELSE null END) baixo,
    COUNT(CASE WHEN VALOR BETWEEN 800 AND 1200 THEN 1 ELSE null END) medio,
    COUNT(CASE WHEN VALOR > 1500 THEN 1 ELSE null END) alto
    FROM TCURSO;

  

 

ADICIONE ÍNDICES NAS TABELAS

Ao procurar um tópico específico em um livro, você pode percorrer o livro inteiro ou utilizar o

índice para encontrar o local. Conceitualmente, um índice de uma tabela de banco de dados é

semelhante ao índice de um livro, exceto que os índices de banco de dados são usados para encontrar

linhas específicas em uma tabela. O inconveniente dos índices é que, quando uma linha é

adicionada na tabela, é necessário tempo adicional para atualizar o índice da nova linha.

Geralmente, você deve criar um índice em uma coluna quando está recuperando um pequeno

número de linhas de uma tabela que contenha muitas linhas. Uma boa regra geral é:

Crie um índice quando uma consulta recuperar <= 10% do total de linhas de uma tabela.

Isso significa que a coluna do índice deve conter uma ampla variedade de valores. Uma boa

candidata à indexação seria uma coluna contendo um valor exclusivo para cada linha (por exemplo,

um número de CPF). Uma candidata ruim para indexação seria uma coluna que contivesse

somente uma pequena variedade de valores (por exemplo, N, S, E, O ou 1, 2, 3, 4, 5, 6). Um banco

de dados Oracle cria um índice automaticamente para a chave primária de uma tabela e para as

colunas incluídas em uma restrição única.

Além disso, se o seu banco de dados é acessado por muitas consultas hierárquicas (isto é,

uma consulta contendo uma cláusula CONNECT BY), você deve adicionar índices nas colunas referenciadas

nas cláusulas START WITH e CONNECT BY

Por fim, para uma coluna que contenha uma pequena variedade de valores e seja usada

freqüentemente na cláusula WHERE de consultas, você deve considerar a adição de um índice de

bitmap nessa coluna. Os índices de bitmap são normalmente usados em ambientes de data warehouse,

que são bancos de dados contendo volumes de dados muito grandes. Os dados de um

data warehouse normalmente são lidos por muitas consultas, mas não são modificados por muitas

transações concorrentes.

Normalmente, o administrador do banco de dados é responsável pela criação de índices.

Entretanto, como desenvolvedor de aplicativos, você poderá fornecer informações para ele sobre

quais colunas são boas candidatas à indexação, pois talvez saiba mais sobre o aplicativo do que o

DBA.

 

USE WHERE EM VEZ DE HAVING

A cláusula WHERE é usada para filtrar linhas; a cláusula HAVING, para filtrar grupos de linhas. Como

a cláusula HAVING filtra grupos de linhas depois que elas foram agrupadas (o que leva algum tempo

para ser feito), quando possível, você deve primeiro filtrar as linhas usando uma cláusula WHERE.

Desse modo, você evita o tempo gasto para agrupar as linhas filtradas.

 

? Utiliza a cláusula GROUP BY para agrupar as linhas em blocos

? Utiliza a cláusula HAVING para filtrar os resultados retornados em funções de grupo

 

-- RUIM (usa HAVING em vez de WHERE)

    SELECT COD_ALUNO, AVG(TOTAL)
    FROM TCONTRATO
    GROUP BY COD_ALUNO
    HAVING COD_ALUNO IN (1, 2);

 

A consulta correta a seguir reescreve o exemplo anterior usando WHERE, em vez de HAVING,

para primeiro filtrar as linhas naquelas cujo valor de cod_aluno é 1 ou 2:

 

-- BOM (usa WHERE em vez de HAVING)

    SELECT COD_ALUNO, AVG(TOTAL)
    FROM TCONTRATO
    WHERE COD_ALUNO IN (1, 2)
    GROUP BY COD_ALUNO;

 

 

USE UNION ALL EM VEZ DE UNION

Você usa UNION ALL para obter todas as linhas recuperadas por duas consultas, incluindo as linhas

duplicadas; UNION é usado para obter todas as linhas não duplicadas recuperadas pelas consultas.

Como UNION remove as linhas duplicadas (o que leva algum tempo para ser feito), quando possível,

você deve usar UNION ALL.

A consulta inadequada a seguir usa UNION (ruim, porque UNION ALL funcionaria) para obter

as linhas das tabelas products e more_products. Observe que todas as linhas não duplicadas de

products e more_products são recuperadas:

-- RUIM (usa UNION em vez de UNION ALL)

    SELECT COD_ALUNO, NOME, CIDADE
    FROM TALUNO
     
    WHERE ESTADO = 'RS'
    UNION
    SELECT COD_ALUNO, NOME, CIDADE
    FROM COD_ALUNO = 1;

A consulta correta a seguir reescreve o exemplo anterior para usar UNION ALL. Observe que

todas as linhas de products e more_products são recuperadas, incluindo as duplicadas:

 

-- BOM (usa UNION ALL em vez de UNION)

    SELECT COD_ALUNO, NOME, CIDADE
    FROM TALUNO
     
    WHERE ESTADO = 'RS'
    UNION ALL
    SELECT COD_ALUNO, NOME, CIDADE
    FROM COD_ALUNO = 1;

USE EXISTS EM VEZ DE IN

Você usa IN para verificar se um valor está contido em uma lista. EXISTS é usado para verificar

a existência de linhas retornadas por uma subconsulta. EXISTS é diferente de IN: EXISTS apenas

verifica a existência de linhas, enquanto IN verifica os valores reais. Normalmente, EXISTS oferece

melhor desempenho do que IN com subconsultas. Portanto, quando possível, use EXISTS em vez

de IN.

Consulte a seção intitulada “Usando EXISTS e NOT EXISTS em uma subconsulta correlacionada”,

(um ponto importante a lembrar é que as subconsultas correlacionadas podem

trabalhar com valores nulos).

A consulta inadequada a seguir usa IN (ruim, porque EXISTS funcionaria) para recuperar os

produtos que foram comprados:

 

 

-- RUIM (usa IN em vez de EXISTS)

    SELECT COD_CURSO, NOME
    FROM TCURSO
    WHERE COD_CURSO IN
    (SELECT COD_CURSO
    FROM TITEM);

 

 

-- BOM (usa EXISTS em vez de IN)

    SELECT COD_CURSO, NOME
    FROM TCURSO cur
    WHERE EXISTS
    (SELECT 1
    FROM TITEM ite
    WHERE ite.COD_CURSO = cur.COD_CURSO);
    USE EXISTS EM VEZ DE DISTINCT

Você pode suprimir a exibição de linhas duplicadas usando DISTINCT. EXISTS é usado para verificar

a existência de linhas retornadas por uma subconsulta. Quando possível, use EXISTS em vez de

DISTINCT, pois DISTINCT classifica as linhas recuperadas antes de suprimir as linhas duplicadas.

A consulta inadequada a seguir usa DISTINCT (ruim, porque EXISTS funcionaria) para recuperar

os produtos que foram comprados:

 

-- RUIM (usa DISTINCT quando EXISTS funcionaria)

SELECT DISTINCT ITE.COD_CURSO, CUR.NOME

FROM TCURSO cur, TITEM ite

WHERE ITE.COD_CURSO = CUR.COD_CURSO;

 

A consulta correta a seguir reescreve o exemplo anterior usando EXISTS em vez de DISTINCT:

 

-- BOM (usa EXISTS em vez de DISTINCT)

    SELECT product_id, name
    FROM products outer
    WHERE EXISTS
    (SELECT 1
    FROM purchases inner
    WHERE inner.product_id = outer.product_id);

 

 

USE GROUPING SETS EM VEZ DE CUBE

Normalmente, a cláusula GROUPING SETS oferece melhor desempenho do que CUBE. Portanto,

quando possível, você deve usar GROUPING SETS em vez de CUBE. Isso foi abordado detalhadamente

na seção intitulada “Usando a cláusula GROUPING SETS”.

 

USE VARIÁVEIS DE BIND

O software de banco de dados Oracle coloca as instruções SQL em cache; uma instrução SQL colocada

no cache é reutilizada se uma instrução idêntica é enviada para o banco de dados. Quando

uma instrução SQL é reutilizada, o tempo de execução é reduzido. Entretanto, a instrução SQL

deve ser absolutamente idêntica para ser reutilizada. Isso significa que:

? Todos os caracteres na instrução SQL devem ser iguais

? Todas as letras na instrução SQL devem ter a mesma caixa

? Todos os espaços na instrução SQL devem ser iguais

Se você precisa fornecer valores de coluna diferentes em uma instrução, pode usar variáveis

de bind em vez de valores de coluna literais. Exemplos que esclarecem essas idéias são mostrados

a seguir.

 

Instruções SQL não idênticas

Nesta seção, você verá algumas instruções SQL não idênticas. As consultas não idênticas a seguir

recuperam os produtos nº 1 e 2:

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM products WHERE product_id = 2;

Essas consultas não são idênticas, pois o valor 1 é usado na primeira instrução, mas o valor 2

é usado na segunda. As consultas não idênticas têm espaços em posições diferentes:

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM products WHERE product_id = 1;

As consultas não idênticas a seguir usam uma caixa diferente para alguns dos caracteres:

select * from products where product_id = 1;

SELECT * FROM products WHERE product_id = 1;

Agora que você já viu algumas instruções não idênticas, vejamos instruções SQL idênticas

que utilizam variáveis de bind.

 

Instruções SQL idênticas que usam variáveis de bind

Você pode garantir que uma instrução seja idêntica utilizando variáveis de bind para representar

valores de coluna. Uma variável de bind é criada com o comando VARIABLE do SQL*Plus. Por

exemplo, o comando a seguir cria uma variável chamada v_product_id de tipo NUMBER:

VARIABLE v_product_id NUMBER

 

COMPARANDO O CUSTO DA EXECUÇÃO DE CONSULTAS

O software de banco de dados Oracle usa um subsistema conhecido como otimizador para gerar

o caminho mais eficiente para acessar os dados armazenados nas tabelas. O caminho gerado pelo

otimizador é conhecido como plano de execução. O Oracle Database 10g e as versões superiores

reúnem estatísticas sobre os dados de suas tabelas e índices automaticamente, para gerar o melhor

plano de execução (isso é conhecido como otimização baseada em custo).

A comparação dos planos de execução gerados pelo otimizador permite a você julgar o custo

relativo de uma instrução SQL em relação à outra. É possível usar os resultados para aprimorar

suas instruções SQL. Nesta seção, você vai aprender a ver e interpretar dois exemplos de planos de

execução.

 

Examinando planos de execução

O otimizador gera um plano de execução para uma instrução SQL. Você pode examinar o plano de

execução usando o comando EXPLAIN PLAN do SQL*Plus. O comando EXPLAIN PLAN preenche

uma tabela chamada plan_table com o plano de execução da instrução SQL (plan_table é freqüentemente

referida como “tabela de plano”). Você pode então examinar esse plano de execução

consultando a tabela de plano. A primeira coisa que você deve fazer é verificar se a tabela de plano

já existe no banco de dados.

 

Gerando um plano de execução

Uma vez que você tenha uma tabela de plano, pode usar o comando EXPLAIN PLAN para gerar um

plano de execução para uma instrução SQL. A sintaxe do comando EXPLAIN PLAN é:

EXPLAIN PLAN SET STATEMENT_ID = id_instrução FOR instrução_sql;

onde

? id_instrução é o nome que você deseja dar ao plano de execução. Pode ser qualquer

texto alfanumérico.

? instrução_sql é a instrução SQL para a qual você deseja gerar um plano de execução.

O exemplo a seguir gera o plano de execução para uma consulta que recupera todas as linhas

da tabela customers (observe que o valor de id_instrução é configurado como 'CUSTOMERS'):

EXPLAIN PLAN SET STATEMENT_ID = 'CUSTOMERS' FOR

SELECT customer_id, first_name, last_name FROM customers;

Explained

Depois que o comando terminar, você pode examinar o plano de execução armazenado na

tabela de plano. Você vai aprender a fazer isso a seguir.

NOTA

A consulta na instrução EXPLAIN PLAN não retorna linhas da tabela customers. A instrução

EXPLAIN PLAN simplesmente gera o plano de execução que seria usado se a consulta fosse

executada.

Consultando a tabela de plano

Para consultar a tabela de plano, fornecemos um script SQL*Plus chamado explain_plan.sql no

diretório SQL. O script solicita o valor de statement_id (id_instrução) e depois exibe o plano de

execução para essa instrução.

O script explain_plan.sql contém as seguintes instruções:

-- Exibe o plano de execução da statement_id especificada

    UNDEFINE v_statement_id;
    SELECT
    id ||
    DECODE(id, 0, '', LPAD(' ', 2*(level – 1))) || ' ' ||
    operation || ' ' ||
    options || ' ' ||
    object_name || ' ' ||
    object_type || ' ' ||
    DECODE(cost, NULL, '', 'Cost = ' || position)
    AS execution_plan
    FROM plan_table
    CONNECT BY PRIOR id = parent_id
    AND statement_id = '&&v_statement_id'
    START WITH id = 0
    AND statement_id = '&v_statement_id';

 

Um plano de execução é organizado em uma hierarquia de operações de banco de dados

semelhante a uma árvore; os detalhes dessas operações são armazenados na tabela de plano. A

operação com o valor de id igual a 0 é a raiz da hierarquia e todas as outras operações do plano

procedem dessa raiz. A consulta do script recupera os detalhes das operações, começando com a

operação raiz e, então, percorre a árvore a partir da raiz.

O exemplo a seguir mostra como executar o script explain_plan.sql para recuperar o plano

'CUSTOMERS' criado anteriormente:

SQL> @ c:\sql_book\sql\explain_plan.sql

Enter value for v_statement_id: CUSTOMERS

old 12: statement_id = '&&v_statement_id'

new 12: statement_id = 'CUSTOMERS'

old 14: statement_id = '&v_statement_id'

new 14: statement_id = 'CUSTOMERS'

EXECUTION_PLAN

----------------------------------------------

0 SELECT STATEMENT Cost = 3

1 TABLE ACCESS FULL CUSTOMERS TABLE Cost = 1

As operações mostradas na coluna EXECUTION_PLAN são executadas na seguinte ordem:

? A operação recuada mais à direita é executada primeiro, seguida de todas as operações

pai que estão acima dela.

? Para operações com o mesmo recuo, a operação mais acima é executada primeiro, seguida

de todas as operações pai que estão acima dela.

Cada operação envia seus resultados de volta no encadeamento até sua operação pai imediata

e, então, a operação pai é executada. Na coluna EXECUTION_PLAN, a ID da operação é mostrada

na extremidade esquerda. No exemplo de plano de execução, a operação 1 é executada primeiro,

com seus resultados sendo passados para a operação 0. O exemplo a seguir ilustra a ordem para

um exemplo mais complexo:

    0 SELECT STATEMENT Cost = 6
    1 MERGE JOIN Cost = 1
    2 TABLE ACCESS BY INDEX ROWID PRODUCT_TYPES TABLE Cost = 1
    3 INDEX FULL SCAN PRODUCT_TYPES_PK INDEX (UNIQUE) Cost = 1
    4 SORT JOIN Cost = 2
    5 TABLE ACCESS FULL PRODUCTS TABLE Cost = 1

A ordem em que as operações são executadas nesse exemplo é 3, 2, 5, 4, 1 e 0.

Agora que você já conhece a ordem na qual as operações são executadas, é hora de aprender

para o que elas fazem realmente.  O plano de execução da consulta 'CUSTOMERS' era:

0 SELECT STATEMENT Cost = 3

1 TABLE ACCESS FULL CUSTOMERS TABLE Cost = 1

A operação 1 é executada primeiro, com seus resultados sendo passados para a operação 0.

A operação 1 envolve uma varredura integral — indicada pela string TABLE ACCESS FULL — da

tabela customers. Este é o comando original usado para gerar a consulta 'CUSTOMERS':

    EXPLAIN PLAN SET STATEMENT_ID = 'CUSTOMERS' FOR
    SELECT customer_id, first_name, last_name FROM customers;

 

Uma varredura integral da tabela é realizada porque a instrução SELECT especifica que todas

as linhas da tabela customers devem ser recuperadas.

O custo total da consulta é de três unidades de trabalho, conforme indicado na parte referente

ao custo mostrada à direita da operação 0 no plano de execução (0 SELECT STATEMENT Cost =

3). Uma unidade de trabalho é a quantidade de processamento que o software precisa para realizar

determinada operação. Quanto mais alto o custo, mais trabalho o software do banco de dados precisa

realizar para concluir a instrução SQL.

NOTA

Se você estiver usando uma versão do banco de dados anterior ao Oracle Database 10g, a saída

do custo da instrução global poderá estar em branco. Isso ocorre porque as versões de banco de

dados anteriores não reúnem estatísticas de tabela automaticamente. Para reunir estatísticas, você

precisa usar o comando ANALYZE. Você vai aprender a fazer isso na seção “Reunindo estatísticas

de tabela”.

Planos de execução envolvendo joins de tabela

Os planos de execução para consultas com joins de tabelas são mais complexos. O exemplo a seguir

gera o plano de execução de uma consulta que junta as tabelas products e product_types:

    EXPLAIN PLAN SET STATEMENT_ID = 'PRODUCTS' FOR
    SELECT p.name, pt.name
    FROM products p, product_types pt
    WHERE p.product_type_id = pt.product_type_id;

O plano de execução dessa consulta está mostrado no exemplo a seguir:

@ c:\sql_book\sql\explain_plan.sql

Enter value for v_statement_id: PRODUCTS

EXECUTION_PLAN

----------------------------------------------------------------

    0 SELECT STATEMENT Cost = 6
    1 MERGE JOIN Cost = 1
    2 TABLE ACCESS BY INDEX ROWID PRODUCT_TYPES TABLE Cost = 1
    3 INDEX FULL SCAN PRODUCT_TYPES_PK INDEX (UNIQUE) Cost = 1
    4 SORT JOIN Cost = 2
    5 TABLE ACCESS FULL PRODUCTS TABLE Cost = 1

 

ID da operação Descrição

3 Varredura integral do índice product_types_pk (que é um índice exclusivo)

para obter os endereços das linhas na tabela product_types. Os

endereços estão na forma de valores de ROWID, os quais são passados para

a operação 2.

2 Acesso às linhas da tabela product_types usando a lista de valores de

ROWID passada da operação 3. As linhas são passadas para a operação 1.

5 Acesso às linhas da tabela products. As linhas são passadas para a operação

4.

4 Classificação das linhas passadas da operação 5. As linhas classificadas são

passadas para a operação 1.

1 Mesclagem das linhas passadas das operações 2 e 5. As linhas mescladas

são passadas para a operação 0.

0 Retorno das linhas da operação 1 para o usuário. O custo total da consulta

é de 6 unidades de trabalho.

Reunindo estatísticas de tabela

Se estiver usando uma versão do banco de dados anterior ao Oracle Database 10g (como a 9i),

você mesmo terá de reunir estatísticas de tabela usando o comando ANALYZE. Por padrão, se

nenhuma estatística estiver disponível, a otimização baseada em regra será utilizada. Normalmente,

a otimização baseada em regra não é tão boa quanto a otimização baseada em custo. Os

exemplos a seguir usam o comando ANALYZE para reunir estatísticas para as tabelas products e

product_types:

ANALYZE TABLE products COMPUTE STATISTICS;

ANALYZE TABLE product_types COMPUTE STATISTICS;

Uma vez reunidas as estatísticas, a otimização baseada em custo será usada em vez da otimização

baseada em regra.

Comparando planos de execução

Comparando o custo total mostrado no plano de execução para diferentes instruções SQL, você

pode determinar o valor do ajuste de seu código SQL. Nesta seção, você verá como comparar dois

planos de execução e a vantagem de usar EXISTS em vez de DISTINCT (uma dica dada anteriormente).

O exemplo a seguir gera um plano de execução para uma consulta que usa EXISTS:

    EXPLAIN PLAN SET STATEMENT_ID = 'EXISTS_QUERY' FOR
    SELECT product_id, name
    FROM products outer
    WHERE EXISTS
    (SELECT 1
    FROM purchases inner
    WHERE inner.product_id = outer.product_id);
    EXPLAIN PLAN SET STATEMENT_ID = 'DISTINCT_QUERY' FOR
    SELECT DISTINCT pr.product_id, pr.name
    FROM products pr, purchases pu
    WHERE pr.product_id = pu.product_id;

O plano de execução dessa consulta está mostrado no exemplo a seguir:

@ c:\sql_book\sql\explain_plan.sql

Enter value for v_statement_id: DISTINCT_QUERY

EXECUTION_PLAN

--------------------------------------------------------------

    0 SELECT STATEMENT Cost = 5
    1 HASH UNIQUE Cost = 1
    2 MERGE JOIN Cost = 1
    3 TABLE ACCESS BY INDEX ROWID PRODUCTS TABLE Cost = 1
    4 INDEX FULL SCAN PRODUCTS_PK INDEX (UNIQUE) Cost = 1
    5 SORT JOIN Cost = 2
    6 INDEX FULL SCAN PURCHASES_PK INDEX (UNIQUE) Cost = 1

O custo da consulta é de 5 unidades de trabalho. Essa consulta é mais dispendiosa do que a

anterior, que usou EXISTS (essa consulta tinha um custo de apenas 4 unidades de trabalho). Esses

resultados provam que é melhor usar EXISTS do que DISTINCT.

Referência Oracle DataBase 11G SQL


---------------------------------------------------------------------------------------------------------


Criação de Índices
Porque o índice é importante?

Índices (Index) são importantes pois diminuem processamento e I/O em disco. Quando usamos um comando SQL para retirar informações de uma tabela, na qual, a coluna da mesma não possui um índice, o Oracle faz um Acesso Total a Tabela para procurar o dado, ou seja, realiza-se um FULL TABLE SCAN degradando a performance do Banco de Dados Oracle. Com o índice isso não ocorre, pois com o índice isso apontará para a linha exata da tabela daquela coluna retirando o dado muito mais rápido.

Crie Índices quando:

Uma coluna contiver uma grande faixa de valores

Uma coluna contiver muitos valores nulos

Quando uma ou mais colunas forem usadas frequentemente em clausulas WHERE ou emJOINS

Se a tabela for muito grande e as consultas realizadas recuperarem menos de 5% dos registros.

NÃO Crie Índices quando:

As colunas não são usadas frequentemente como condição nas consultas

A tabela for pequena ou se os resultados das consultas forem maiores que 5-10% dos registros.

A tabela for atualizada com frequência

As colunas fizerem parte de uma expressão*

* Expressão é quando usado regra de filtro na clausula where, como por exemplo:

SELECT TABLE_NAME

FROM ALL_TABLES

WHERE TABLE_NAME||OWNER = 'DUALSYS'

Observe que na clausula de comparação as colunas TABLE_NAME e OWNER fazem uma expressão de comparação e por consequencia um índice não ajudaria em nada.

 

Outras coisas importantes de lembrar:

    ÍNDICES NÃO SÃO ALTERÁVEIS! (Para você alterar um índice você deve removê-lo e recriá-lo. )
    ÍNDICES ONERAM A PERFORMANCE DE INSERT / UPDATE  ( Não dá pra fazer milagres, se sua tabela tiver muitos índices as performances de alterações podem ser comprometidas )


-------------------------------------------------------------------------------------------------------------------------------------------------


Monitorando uso dos índices

Monitorando uso dos índices

Existem muitos bancos de dados em que índices estão criados mais não são utilizados. Por exemplo, ter criado um índice para um determinado procedimento, que é executado somente uma vez e após seu uso não é removido, ou até mesmo o Oracle perceber que leitura por scans completos pode ser mais vantajoso do que utilizar um determinado índice (isso acontece).

Criar índice em uma base, deve ser algo realmente estudado, pois podem ter impacto negativo sobre o desempenho das operações DML. Além de modificar o valor do bloco da data, também é necessário atualizar o bloco do índice.

Por esse motivo que devesse notar muito bem a utilização de um índice, caso não seja utilizado prejudica o desempenho do banco de dados.

Abaixo está um exemplo para descobrir se um índice está sendo ou não utilizado

--Criação de tabela de teste

create table teste (codigo number,  nome varchar2(40) );

  --Criação de indice create index ind_codigo on teste (codigo);

--Novo registro insert into teste values (1, 'MARCIO');

commit;

--Verificado se o índices já foi usado

select index_name, table_name, used from v$object_usage;

--Alterado índice

alter index ind_codigo monitoring usage;

 

--Select para usar o indice select * from teste where codigo=1;

 

--Verificado se o índices já foi usado novamente

select index_name, table_name, used from v$object_usage;

--Alterado índice para não ser monitorado

alter index ind_codigo nomonitoring usage;

Veja que a view v$OBJECT_USAGE, terá cada índice do seu esquema cujo uso está sendo monitorando, caso o índice não for usado, pode ser exclui-lo para melhorar performance de DML.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Estatísticas
Coletando estatísticas para o otimizador de queries do Oracle

  Para que o Oracle monte planos de execução otimizados, é necessário que as estatísticas dos objetos estejam sempre atualizadas. Para atualizar as estatísticas dos objetos, podemos usar os métodos abaixo:

 

     Comando ANALYZE:

          - Calcula estatísticas globais de tabelas, índices e clusters;

          - Permite coletar estatísticas exatas ou estimada em um número ou percentual de linhas;

          - Não é tão preciso ao calcular, por exemplo, a cardinalidade, ao envolver valores distintos;

           - Exemplo p/ coletar estatísticas exatas de uma tabela: 

               ANALYZE TABLE TALUNO COMPUTE STATISTICS;

 

     Package DBMS_UTILITY:

          - As procedures desta package diferem do comando ANALYZE apenas pela possibilidade de permitir coletar estatísticas de um schema ou do banco de dados completo;

          - Exemplo p/ coletar estatísticas de um schema todo:

               EXEC DBMS_UTILITY.ANALYZE_SCHEMA('CURSO','COMPUTE');

   

     Package DBMS_STATS:

          - Permite coletar estatísticas exatas ou estimadas de objetos individualmente (tabelas, índices, cluster etc), schemas, banco de dados completo e de sistema;

          - Permite execução paralela, transferência de estatísticas entre servidores e é mais preciso que os métodos anteriores;

          - Gera historicos que são extremamente úteis para otimizar queries que efetuam pesquisas em colunas que possuem valores dispersos;

          - É o método de coleta de estatísticas atualmente recomendado pela Oracle e por especialistas no assunto;

          - Exemplos:

              a) Para coletar estatísticas estimadas (5%) de uma tabela:

                 EXEC DBMS_STATS.GATHER_TABLE_STATS(

OWNNAME=>'OWNER', TABNAME=>'TALUNO', ESTIMATE_PERCENT=>5);  

 

              b) Para coletar estatísticas estimadas (30%) de um schema:

                 EXEC DBMS_STATS.GATHER_SCHEMA_STATS('OWNER', estimate_percent=> 30);

 

              c) Para coletar estatísticas de todo o banco de dados: 

               EXEC DBMS_STATS.GATHER_DATABASE_STATS;

  

              d) Para coletar estatísticas de sistema (DD): 

               EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;

Para coletar estatísticas de objetos:

  

        A partir do Oracle Database 10G, as estatísticas são coletadas automaticamente pelo Oracle, diariamente de 2ª à 6ª, em um horário compreendido geralmente entre 22h e 2h, e aos sábados começa às 6h e termina somente no Domingo, às 2h. É importante lembrar que ela só ocorre se o banco de dados estiver ocioso e somente nos objetos que tiveram mais que 10% de atualizações (inclui INSERT, UPDATE e DELETE). A partir do 11G, este valor de 10% é configurável.

           Pelo motivo dela ocorrer automaticamente, colete estatísticas somente quando você identificar alguma necessidade extra, como por exemplo, após uma carga de dados ou em banco de dados que trabalham 24X7 e que nunca ficam ociosos. Nestes casos, recomendo criar uma stored procedure contendo o código para coletar estatísticas de objetos do banco e criar em seguida um job para executar esta procedure periodicamente;

          Se o seu BD usa o CBO, evite coletar estatísticas através do comando ANALYZE TABLE e através da package DBMS_UTILITY.Se você fizer isso, suas estatísticas serão menos precisas e você não terá historicos;


-----------------------------------------------------------------------------------------------------------------------------------------------



Estatísticas - Scripts

--Analisa apenas uma tabela - executar como usuário normal ANALYZE TABLE TALUNO COMPUTE STATISTICS;

--Estatística de schema - SYSTEM EXEC DBMS_UTILITY.ANALYZE_SCHEMA('CURSO','COMPUTE');

--Estatística de banco inteiro (Pode ser demorado) - SYSTEM EXEC DBMS_STATS.GATHER_DATABASE_STATS;

--Bloco anonimo para ler estatísticas do banco de dados - SYSTEM 

    DECLARE
      libcac NUMBER(10, 2);
      rowcac NUMBER(10, 2);
      bufcac NUMBER(10, 2);
      redlog NUMBER(10, 2);
      spsize NUMBER;
      blkbuf NUMBER;
      logbuf NUMBER;
    BEGIN
      SELECT VALUE
      INTO redlog
      FROM v$sysstat
      WHERE name = 'redo log space requests';
    SELECT 100 * (SUM(pins) - SUM(reloads)) / SUM(pins)
      INTO libcac
      FROM v$librarycache;
     
      SELECT 100 * (SUM(gets) - SUM(getmisses)) / SUM(gets)
      INTO rowcac
      FROM v$rowcache;
    SELECT 100 * (cur.VALUE + con.VALUE - phys.VALUE) /(cur.VALUE + con.VALUE)
      INTO bufcac
      FROM v$sysstat cur, v$sysstat con, v$sysstat phys, 
      v$statname ncu, v$statname nco, v$statname nph
      WHERE cur.statistic# = ncu.statistic#
      AND ncu.name = 'db block gets'
      AND con.statistic# = nco.statistic#
      AND nco.name = 'consistent gets'
      AND phys.statistic# = nph.statistic#
      AND nph.name = 'physical reads';
      SELECT VALUE INTO spsize
      FROM v$parameter
      WHERE name = 'shared_pool_size';
      SELECT VALUE INTO blkbuf
      FROM v$parameter
      WHERE name = 'db_block_buffers';
      SELECT VALUE INTO logbuf FROM v$parameter WHERE name = 'log_buffer';
      DBMS_OUTPUT.put_line('> SGA CACHE STATISTICS');
      DBMS_OUTPUT.put_line('> ********************');
      DBMS_OUTPUT.put_line('> SQL Cache Hit rate = ' || libcac);
      DBMS_OUTPUT.put_line('> Dict Cache Hit rate = ' || rowcac);
      DBMS_OUTPUT.put_line('> Buffer Cache Hit rate = ' || bufcac);
      DBMS_OUTPUT.put_line('> Redo Log space requests = ' || redlog);
      DBMS_OUTPUT.put_line('> ');
      DBMS_OUTPUT.put_line('> INIT.ORA SETTING');
      DBMS_OUTPUT.put_line('> ****************');
      DBMS_OUTPUT.put_line('> Shared Pool Size = ' || spsize || ' Bytes');
      DBMS_OUTPUT.put_line('> DB Block Buffer = ' || blkbuf || ' Blocks');
      DBMS_OUTPUT.put_line('> Log Buffer = ' || logbuf || ' Bytes');
      DBMS_OUTPUT.put_line('> ');
      IF libcac < 99 THEN
        DBMS_OUTPUT.put_line('*** HINT: Library Cache muito baixo! Aumente Shared Pool Size.');
      END IF;
      IF rowcac < 85 THEN
        DBMS_OUTPUT.put_line('*** HINT: Row Cache muito baixo! Aumente Shared Pool Size.');
      END IF;
      IF bufcac < 90 THEN
        DBMS_OUTPUT.put_line('*** HINT: Buffer Cache muito baixo! Aumente DB Block Buffer value.');
      END IF;
      IF redlog > 100 THEN
        DBMS_OUTPUT.put_line('*** HINT: Valor de Log Buffer é muito baixo!');
      END IF;
     
    END;



----------------------------------------------------------------------------------------------------------------



Views Materializadas Utilizamos elas para fazermos cálculos, armazenamentos de dados e dar agilidade na troca de informações entre um banco de dados ou entre tabelas. Este recurso é muito utilizado em ambientes de Data Warehouse, que trabalha com uma enorme quantidade de informações. Pois com elas conseguimos melhorar a performance do sistema e trazer diversos benefícios ao Oracle.

As Views Materializadas são utilizadas para fazer atualizações, a própria Oracle garante que as atualizações são feitas com sucesso numa tabela destinatária após terem sido efetivadas nas tabelas originais. Isso nos dá mais tranquilidade na administração e no desenvolvimento.

Exemplo de como se faz uma Views Materializadas:

CREATE MATERIALIZED VIEW VM_ALUNO BUILD IMMEDIATE  REFRESH FAST ENABLE QUERY REWRITE  AS (SELECT * FROM TALUNO WHERE CIDADE=’NOVO HAMBURGO’) BUILD IMMEDIATE

A View Materializada deverá utilizar os dados imediatamente na query rewrite (Seu SELECT), desde modo os dados serão processados com mais agilidade.

Existe também outro método, chamado build deferred que significa que a view não terá nenhum tipo de dados a ser utilizada automaticamente, esse modo seria um processamento manual das informações, que será depois atualizado pelo Refresh, resumindo, que com essa opção o comando SELECT não será executado imediatamente.

REFRESH FAST

Esse método é para dizer que as modificações serão utilizadas somente pela View Materializada, para utilizar este recurso com segurança, sugiro criar uma View Materializada Log, para ter controle sobre as modificações que estão sendo feitas.

ENABLE QUERY REWRITE

Essa linha de comando é o que indica que o SELECT presente dentro da View Materializada será reescrita e atualizada para os novos valores passados pela VIEW. A query rewrite pode ter três níveis de integridade que vai desde o modo ENFORCED até o STALE_TOLERATED, que indicará ao banco de dados que tipo de confiança ele poderá ter nos dados. Sobre as integridades, falaremos na próxima coluna também, pois e um pouco mais delicado.

AS SELECT

Aqui será colocado seu SELECT, onde poderá fazer alguns cálculos ou visualizações de informações para outras tabelas, como no exemplo de SELECT a seguir.

    SELECT * FROM TALUNO WHERE cidade = ’NOVO HAMBURGO’

SELECTS que devemos utilizar dentro das Views Materializadas devem seguir um padrão delas, como, por exemplo, não utilizar cláusulas como UNION, UNION ALL, INTERSECT e MINUS. 



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------



View Materializada Scripts

--Conectado como system --Direito para criar view materializada GRANT CREATE ANY MATERIALIZED VIEW TO marcio;

--Criar log para view CREATE MATERIALIZED VIEW LOG ON taluno TABLESPACE tbs_dados

--Excluir View DROP MATERIALIZED VIEW V_MAT;

--Criar View 

    CREATE MATERIALIZED VIEW V_MAT
    TABLESPACE tbs_dados
    BUILD IMMEDIATE
    REFRESH FAST ON COMMIT AS
    (SELECT COD_ALUNO, NOME, CIDADE FROM TALUNO 
    WHERE CIDADE = 'NOVO HABURGO');

    INSERT INTO TALUNO (COD_ALUNO,NOME,CIDADE)
    VALUES(SEQ_ALUNO.NEXTVAL,'TESTE 2','NOVO HAMBURGO');

    SELECT * FROM TALUNO;

    SELECT * FROM V_MAT;



----------------------------------------------------------------------------------------------------------------



Hints de Pesquisa

CONHECENDO HINTS

Otimizador do Oracle é incrivelmente preciso na escolha do caminho de otimização correto e no uso de índices para milhares de registros no seu sistema, porem exise casos que é preciso mudar.  O ORACLE possui hints ou sugestões que você poderá usar para determinadas consultas, de modo que o otimizador seja desconsiderado, na esperança de conseguir melhor desempenho para determinada consulta.  Os hints modificam o caminho de execução quando um otimizador processa uma instrução específica. O parâmetro OPTIMIZER_MODE de init.ora pode ser usado para modificar todas as instruções no banco de dados para que sigam um caminho de execução específico, mas um hint para um caminho de execução diferente substitui qualquer coisa que esteja especificada no init.ora. Contudo, a otimização baseada em custo não será usada se as tabelas não tiverem sido analisadas.

Os hints podem ser muito úteis se soubermos quando e qual usar, mas eles podem ser maléficos se não forem utilizados na situação correta ou sem muito conhecimento de suas ações e consequências! Nas últimas versões do SGBD Oracle, um hint obsoleto pode gerar um plano de execução ruim, e consequentemente, impactar negativamente na performance da instrução SQL.

Veremos vários hints, como por exemplo: APPEND,PARALLEL e FIRST_ROWS, que são muito bons quando são utilizados nas situações adequadas! O hint APPEND, por exemplo, deve ser utilizado para otimizar cargas de dados via comando INSERT (através de carga direta) somente quando você tiver certeza de que outros usuários não estarão atualizando dados concorrentemente na tabela! Já o hint PARALLEL, só deve ser utilizado em consultas longas e quando houver recursos de processamento, memória e I/O disponíveis, ou seja, quando estes recursos, não estiverem sobrecarregados!


------------------------------------------------------------------------------------------------------------------------------------------------------------------


Hints de Pesquisa - Script

--Conectado como system --Visão dos hints select * from v$sql_hint

--Conectado como system grant select_catalog_role to marcio; grant select any dictionary to marcio;

-- first_rows: Para forçar o uso de índice de modo geral.  -- Faz com que o otimizador escolha um caminho que recupera N linhas primeiramente  -- e ja mostra enquanto processa o resto

    select * from taluno;

    create index ind_aluno_nome on taluno(nome);

    select /*+ first_rows(2) */ cod_aluno, nome from taluno

-- all_rows: Para forçar varredura completa na tabela.

    select /*+ all_rows (10) */ cod_aluno, nome
    from taluno;

    -- full: Para forçar um scan completo na tabela. 
    -- A hint full também pode causar resultados inesperados como varredura 
    -- na tabela em ordem diferente da ordem padrão.
     
    select /*+ full_rows (taluno) */ cod_aluno, nome
    from taluno
    where nome = 'MARCIO' ;

-- index: Força o uso de um índice. -- Nenhum índice é especificado.  -- O Oracle pesa todos os índices possíveis e escolhe um ou mais a serem usados.  -- Otimizador não fará um scan completo na tabela.

    select /*+ index */ cod_aluno, nome
    from taluno
    where nome = 'MARCIO' ;

---Exemplo do uso da hint index informando os índices que devem ser utilizados:

    select /*+ index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' ;

-- no_index: Evitar que um índice especificado seja usado pelo Oracle.

    select /*+ no_index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' ;

-- index_join : Permite mesclar índice em uma única tabela.  -- Permite acessar somente os índices da tabela, e não apenas um scan  -- com menos bloco no total, é mais rápido do que usar um índice que faz scan na tabela por rowid.

create index ind_aluno_cidade on taluno(cidade)

    select /*+ index_join (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

-- and_equal : Para acessar todos os índices que você especificar.  -- A hint and_equal faz com que o otimizador misture vários índices  -- para uma única tabela em vez de escolher qual é ao melhor.

    select /*+ and_equal (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

-- index_ffs: Força um scan completo do índice.  -- Este hint pode oferecer grandes ganhos de desempenho quando a tabela  -- também possuir muitas colunas.

    select /*+ index_ffs (taluno ind_aluno_nome) */ cod_aluno, nome
    from taluno
    where nome = 'MARCIO'



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


