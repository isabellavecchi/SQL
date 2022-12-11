-- Caso tenhas estas tabelas criadas de outro curso como o SQL ou PL/SQL n�o precisa executar novamente


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

O uso do Bulk Collect � aplicado para a manipula��o de grande massa de dados. Com seu uso correto, podemos ter v�rios tipos de ganhos.

Podemos ter: Aplica��es mais r�pidas, aloca��o dos dados na mem�ria, sem a necessidade de refazer a busca no banco. Porem temos um risco tamb�m, pois se n�o aplicarmos corretamente as diretrizes na PGA(Program Global Area), podemos ter problemas na quantidade de dados carregados na mem�ria.

Para estes problemas temos a cla�sula LIMIT, que limita os dados que foram para a mem�ria.

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
--Vamos colocar a cada loop apenas 50 registros na mem�ria.

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
          DBMS_OUTPUT.PUT_LINE('C�digo: ' || ROW_PRODUTO(I).COD_PRODUTO || ' Descri��o: ' || ROW_PRODUTO(I).DESCRICAO);
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

O Oracle Text � uma feature embutida no banco de dados que utiliza a linguagem SQL para indexar, pesquisar e analisar textos e documentos bin�rios armazenados nas tabelas. Nas vers�es Oracle 11g essa feature � conhecida como Oracle Text. Esta tecnologia oferece uma solu��o completa para pesquisa de textos na qual a mesma permite filtrar e extrair textos de conte�dos de diferentes formatos de documentos. O Oracle Text suporta mais de 150 formatos de documentos, incluindo os mais populares como os documentos Microsoft Office, al�m de formatos de arquivo do Adobe PDF, arquivos HTML e XML. Neste artigo irei demonstrar como gravar um documento bin�rio (.doc) no banco de dados Oracle 11g e o que fazer para poder realizar pesquisas no seu conte�do. 

O arquivo que irei carregar para o banco de dados (teste.doc) possui o conte�do "Marcio Konrath Curso de Oracle" para isto abra arquivo em branco do microsoft word e escreva o texto mencinado ou algum outro texto qualquer e salva na pasta C:\Temp com nome de "arquivo.doc"

Em seguida abra o CMD como administrador e conecte no SQLPLUS 

C:\set ORACLE_SID=curso

C:\>sqlplus sys/123 as sysdba

 

 

-- Cria��o de um diret�rio que indica a localiza��o do documento

--Conectado como usuario system grant create any directory to marcio;

--Conectado como usuario normal create or replace directory arquivos as 'C:\Temp';

 

Agora conectado como usu�rio normal de desenvolvimento no SQL Developer vamos criar uma tabela

    create table teste (
      codigo number,
      nome varchar2(40),
      documento blob
    );

    create sequence seq_doc;

-- Cria��o de uma procedure para carregar o arquivo para o banco de dados

    create or replace procedure grava_arquivo (p_file in varchar(40))
    as
      v_bfile bfile;
      v_blob blob;
    begin
      insert into teste (codigo,nome,documento)
      values (seq_doc.nextval,p_file_name,empty_blob())
      return documento into v_blob;
      -- Informa��o de directory tem que ser maiusculo 
      v_bfile := bfilename('ARQUIVOS',p_file);
      dbms_lob.fileopen(v_bfile, dbms_lob.file_readonly);     
      dbms_lob.loadfromfile(v_blob,v_bfile,dbms_lob.getlength(v_bfile));
      dbms_lob.fileclose(v_bfile);
      commit;
    end;

-- Grava o arquivo para a tabela 

    execute grava_arquivo('arquivo.doc');

 

--Para testar se gravou o registro fa�a select na tabela

    Select * from teste;

e

    Select dbms_lob.getlength(documento) bytes from teste;

--Vamos criar �ndice que vai permitir pesquisar dentro deste arquivo grava na tabela

    create index ind_teste_doc on teste (documento) indextype is ctxsys.context parameters ('sync (on commit)');

--Para verificar se houve erro na cria��o do �ndice

    select * from ctx_user_index_errors;

--Podemos verificar que foram criados alguns �ndices adicionais usando o selects abaixo

    select table_name from user_tables;

    select index_name,table_name from user_indexes;

--Fazendo pesquisar no documento gravando na tabela

    select codigo, nome from teste where contains(documento, 'Marcio', 1) > 0;

    select codigo,nome from teste where contains(documento, 'curso', 1) > 0;


---------------------------------------------------------------------------------------------------


Pacote UTL_FILE
Oracle UTL_FILE

O pacote UTL_FILE � um conjunto de componentes que tem como fun��o permitir o acesso ou gera��o de arquivos externos ao banco de dados. Um exemplo seria importarmos scripts em SQL ou PL/SQL para o nosso sistema.
O pacote � constitu�do de 18 componentes, s�o eles: Exceptions, Functions, Procedures e Types.

Para utilizarmos o pacote, teremos que interromper os servi�os do banco de dados e modificar o arquivo initXE.ora (ORACLE 11G Express Edition), onde iremos acrescentar o par�metro UTL_FILE_DIR, afim de determinar quais os diret�rios do sistema est� livre para o acesso.

Abra o CMD do windows ou terminar Linux e vamos informar ao banco de dados que podemos gravar e recuperar dados do sistema operacional, atrav�s dos seguintes passos:

COMANDOS UTL_FILE

Procedimentos da package UTL_FILE

FOPEN
abre um arquivo para entrada ou sa�da, criando um arquivo de sa�da caso o arquivo especificado n�o exista

IS_OPEN
indica se determinado arquivo est� ou n�o aberto

FCLOSE
fecha um arquivo

FCLOSE_ALL
fecha todos os arquivos abertos

GET_LINE
l� uma linha de um arquivo aberto

PUT
escreve uma linha no arquivo. N�o acrescenta automaticamente o caractere de fim de linha

PUT_LINE
escreve uma linha no arquivo, acrescentando automaticamente o caractere de fim de linha
NEW_LINE
inclui o caractere de fim de linha no arquivo, o que ir� gerar uma nova linha em branco
FFLUSH
escreve, fisicamente, todas as pend�ncias para um arquivo

Exce��es package UTL_FILE

INVALID_PATH
diret�rio ou nome de arquivo inv�lido

INVALID_MODE
o par�metro de modo de abertura � inv�lido

INVALID_FILEHANDLE
especificador de arquivo inv�lido

INVALID_OPERATION
o arquivo n�o pode ser aberto ou a opera��o � inv�lida

READ_ERROR
ocorreu um erro do sistema operacional durante a leitura de um arquivo

WRITE_ERROR
ocorreu um erro do sistema operacional durante a grava��o de um arquivo

INTERNAL_ERROR
erro n�o especificado no PL/SQL

NO_DATA_FOUND
nesse caso, � disparada quando o fim do arquivo � encontrado em processamento de leitura seq�encial de um arquivo de texto

Exemplo para gera��o de arquivo texto:

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
     Dbms_Output.Put_Line('Opera��o inv�lida no arquivo.');
     UTL_File.Fclose(arquivo_saida);
     WHEN UTL_FILE.WRITE_ERROR THEN
     Dbms_Output.Put_Line('Erro de grava��o no arquivo.');
     UTL_File.Fclose(arquivo_saida);
     WHEN UTL_FILE.INVALID_PATH THEN
     Dbms_Output.Put_Line('Diret�rio inv�lido.');
     UTL_File.Fclose(arquivo_saida);
     WHEN UTL_FILE.INVALID_MODE THEN
     Dbms_Output.Put_Line('Modo de acesso inv�lido.');
     UTL_File.Fclose(arquivo_saida);
     WHEN Others THEN
     Dbms_Output.Put_Line('Problemas na gera��o do arquivo.');
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
     Dbms_Output.Put_Line('Diret�rio inv�lido.');
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

A XML (Extensible Markup Language) � uma linguagem de marca��o de prop�sito geral. Ela permite compartilhar dados estruturados na Internet e pode ser usada para codificar dados e outros documentos. A XML apresenta as seguintes vantagens: 

? Pode ser lida por seres humanos e computadores e � armazenada como texto puro
? � independente de plataforma
? Suporta Unicode, o que significa que ela pode armazenar informa��es escritas em muitos idiomas
? Usa um formato autodocumentado que cont�m a estrutura do documento, nomes de elemento e valores de elemento Por causa dessas vantagens, a XML � muito usada para armazenamento e processamento de documentos, sendo aplicada por muitas organiza��es para o envio de dados entre seus sistemas de computador. Por exemplo, muitos fornecedores permitem que seus clientes enviem pedidos de compra como arquivos XML pela Internet.

GERANDO C�DIGO XML A PARTIR DE DADOS RELACIONAIS

O banco de dados Oracle cont�m v�rias fun��es SQL que podem ser usadas para gerar c�digo XML e, nesta se��o, voc� vai ver como gerar c�digo XML a partir de dados relacionais utilizando algumas dessas fun��es.

XMLELEMENT() A fun��o XMLELEMENT() � usada para gerar elementos XML a partir de dados relacionais. Voc� fornece um nome para o elemento e a coluna que deseja recuperar para a fun��o XMLELEMENT() e ela retorna os elementos como objetos XMLType. XMLType � um tipo interno do banco de dados Oracle utilizado para representar dados XML. Por padr�o, um objeto XMLType armazena os dados XML como texto em um CLOB (Character Large Object). O exemplo a seguir se conecta no SQL Developer com usu�rio de desenvolvimento e usa objetos XMLType. 

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
    Conforme voc� pode ver a partir desses resultados, XMLELEMENT ("cod_aluno", cod_aluno) retorna os valores de cod_aluno dentro de uma tag cod_aluno. Voc� pode usar o
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

O exemplo a seguir obt�m os valores de nome e cidade do aluno n� 2: 

    SELECT XMLELEMENT("nome", nome) || XMLELEMENT("cidade", cidade)
    AS alunos
    FROM taluno
    WHERE cod_aluno = 2;
    ALUNOS
    -----------------------------------------------------
    <nome>MARCIO</nome><cidade>NOVO HAMBURGO</cidade>

O exemplo a seguir incorpora duas chamadas de XMLELEMENT() dentro de uma chamada externa de XMLELEMENT(). Observe que os elementos cod_aluno e nome retornados est�o contidos dentro de um elemento customer externo: 

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

Algumas quebras de linhas e espa�os foram adicionados no c�digo XML retornado por essa consulta para torn�-lo mais f�cil de ler. O mesmo foi feito em alguns dos outros exemplos deste cap�tulo. Voc� pode recuperar dados relacionais normais, assim como c�digo XML, conforme mostrado no exemplo a seguir, que recupera a coluna cod_aluno como um resultado relacional normal e as colunas nome e cidade concatenadas como elementos XML:

    SELECT cod_aluno, XMLELEMENT("aluno", nome) AS aluno
    FROM TAluno;
    COD_ALUNO ALUNO
    ----------- ----------------------------------
    1 <aluno>PEDRO</aluno>
    2 <aluno>MARCIO</aluno>

XMLFOREST()

Voc� usa XMLFOREST() para gerar uma �floresta� de elementos XML. XMLFOREST() concatena elementos XML sem que voc� precise usar o operador de concatena��o || com v�rias chamadas de XMLELEMENT(). O exemplo a seguir usa XMLFOREST() para obter cod_aluno, nome e cidade dos alunos n� 1 e 2:

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
    XMLFOREST(cidade AS "cidade", estado as �estado�)
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
    '<TAluno><nome>M�rcio Konrath</nome></TAluno>'
    WELLFORMED
    ) AS ALUNO
    FROM dual;

--Criando arquivo XML a partir de tabela

--Primeiramente temos que configurar o Oracle para aceitar criar arquivos
--Abra o CMD como Administrador set ORACLE_SID=curso
-- SQLPLUS SYS/123 AS SYSDBA

--Fechar o banco de dados SHUTDOWN IMMEDIATE;
--Iniciar o banco de dos sem abrir STARTUP MOUNT;
--Alterar o par�metro UTL_FILE_DIR: ALTER SYSTEM SET UTL_FILE_DIR = '*' SCOPE = SPFILE;

--Fechar novamente o banco SHUTDOWN IMMEDIATE;
--Abrir o banco STARTUP
--Verificar se o par�metro foi alterado SHOW PARAMETER UTL_FILE_DIR
--Dar privilegio para qualquer usu�rio para trabalhar com UTL_FILE GRANT EXECUTE ON UTL_FILE TO PUBLIC;

--Conectar novamente ao usu�rio no SQL Developer

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
      -- abre o arquivo para gravar o texto (at� v_amount
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
     
      -- obt�m o valor da string de v_xml_data e o armazena em v_char_buffer
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
        Dbms_Output.Put_Line('Diret�rio inv�lido.');
        UTL_File.Fclose(arq_leitura);
      WHEN Others THEN
      Dbms_Output.Put_Line ('Problemas na leitura do arquivo.');
      UTL_File.Fclose(arq_leitura);
    END;


-----------------------------------------------------------------------------------------------


Otimiza��o de Consulta

AJUSTE DE SQL

Uma das principais vantagens da linguagem SQL � que voc� n�o precisa dizer ao banco de dados exatamente como ele deve obter os dados solicitados. Basta executar uma consulta especificando as informa��es desejadas e o software de banco de dados descobre a melhor maneira de obt�-las. �s vezes, voc� pode melhorar o desempenho de suas instru��es SQL �ajustando-as�. Nas se��es a seguir, voc� ver� dicas de ajuste que podem fazer suas consultas executarem mais rapidamente e t�cnicas de ajuste mais avan�adas.

 

USE UMA CL�USULA WHERE PARA FILTRAR LINHAS

Muitos iniciantes recuperam todas as linhas de uma tabela quando s� querem uma delas (ou algumas poucas). Isso � muito desperd�cio. Uma estrat�gia melhor � adicionar uma cl�usula WHERE em uma consulta. Desse modo, voc� restringe as linhas recuperadas apenas �quelas realmente necess�rias.

Por exemplo, digamos que voc� queira os detalhes dos clientes n� 1 e 2. A consulta a seguir recupera todas as linhas da tabela customers no esquema store (desperd�cio):

-- RUIM (recupera todas as linhas da tabela customers)

 

    SELECT * FROM TALUNO;

  

A pr�xima consulta adiciona uma cl�usula WHERE ao exemplo anterior para obter apenas os

alunos n� 1 e 2:

 

-- BOM (usa uma cl�usula WHERE para limitar as linhas recuperadas)

    SELECT *
    FROM TALUNO
    WHERE COD_ALUNO IN (1, 2);

 

USE JOINS DE TABELA EM VEZ DE V�RIAS CONSULTAS

Se voc� precisa de informa��es de v�rias tabelas relacionadas, deve usar condi��es de join, em vez

de v�rias consultas. No exemplo inadequado a seguir, s�o usadas duas consultas para obter o nome

e o tipo do produto n� 1 (usar duas consultas � desperd�cio). A primeira consulta obt�m os valores

de coluna nome e cod_aluno da tabela products para o produto n� 1. A segunda consulta

utiliza esse valor de cod_aluno para obter a coluna name da tabela TALUNO.

 

-- RUIM (duas consultas separadas, quando uma seria suficiente)

    SELECT nome, cod_aluno
    FROM taluno
    WHERE cod_aluno = 1;

 

Em vez de usar duas consultas, voc� deve escrever uma �nica consulta que utilize um join

entre as tabelas products e product_types. A consulta correta a seguir mostra isso:

-- BOM (uma �nica consulta com um join)

    SELECT CON.DATA, ALU.NOME, TOTAL
    FROM TCONTRATO CON, TALUNO ALU
    WHERE CON.COD_ALUNO = ALU.COD_ALUNO
    AND CON.COD_CONTRATO = 1;

 

Essa consulta resulta na recupera��o do mesmo nome e tipo de produto do primeiro exemplo,

mas os resultados s�o obtidos com uma �nica consulta. Uma s� consulta geralmente � mais

eficiente do que duas.

Voc� deve escolher a ordem de jun��o em sua consulta de modo a juntar menos linhas nas

tabelas posteriormente. 

 

USE REFER�NCIAS DE COLUNA TOTALMENTE QUALIFICADAS AO FAZER JOINS

Sempre inclua apelidos de tabela em suas consultas e utilize o apelido de cada coluna (isso � conhecido

como �qualificar totalmente� suas refer�ncias de coluna). Desse modo, o banco de dados

n�o precisar� procurar nas tabelas cada coluna utilizada em sua consulta.

 

-- RUIM (as colunas TOTAL n�o esta totalmente qualificada)

    SELECT CON.DATA, ALU.NOME
    FROM TCONTRATO CON, TALUNO ALU
    WHERE CON.COD_ALUNO = ALU.COD_ALUNO
    AND CON.COD_CONTRATO = 1;

 

USE EXPRESS�ES CASE EM VEZ DE V�RIAS CONSULTAS

Use express�es CASE, em vez de v�rias consultas, quando precisar efetuar muitos c�lculos nas

mesmas linhas em uma tabela. O exemplo inadequado a seguir usa v�rias consultas para contar o

n�mero de produtos dentro de diversos intervalos de pre�o:

-- RUIM (tr�s consultas separadas, quando uma �nica instru��o CASE

funcionaria)

 

    SELECT COUNT(*) FROM TCURSO WHERE VALOR < 800;

 

    SELECT COUNT(*) FROM TCURSO WHERE VALOR BETWEEN 1000 AND 1500;

  

    SELECT COUNT(*)
    FROM TCURSO
    WHERE VALOR > 1200;

 

 

Em vez de usar tr�s consultas, voc� deve escrever uma �nica que utilize express�es CASE. Isso

est� mostrado no exemplo correto a seguir:

 

-- BOM (uma �nica consulta com uma express�o CASE)

    SELECT
    COUNT(CASE WHEN VALOR < 800 THEN 1 ELSE null END) baixo,
    COUNT(CASE WHEN VALOR BETWEEN 800 AND 1200 THEN 1 ELSE null END) medio,
    COUNT(CASE WHEN VALOR > 1500 THEN 1 ELSE null END) alto
    FROM TCURSO;

  

 

ADICIONE �NDICES NAS TABELAS

Ao procurar um t�pico espec�fico em um livro, voc� pode percorrer o livro inteiro ou utilizar o

�ndice para encontrar o local. Conceitualmente, um �ndice de uma tabela de banco de dados �

semelhante ao �ndice de um livro, exceto que os �ndices de banco de dados s�o usados para encontrar

linhas espec�ficas em uma tabela. O inconveniente dos �ndices � que, quando uma linha �

adicionada na tabela, � necess�rio tempo adicional para atualizar o �ndice da nova linha.

Geralmente, voc� deve criar um �ndice em uma coluna quando est� recuperando um pequeno

n�mero de linhas de uma tabela que contenha muitas linhas. Uma boa regra geral �:

Crie um �ndice quando uma consulta recuperar <= 10% do total de linhas de uma tabela.

Isso significa que a coluna do �ndice deve conter uma ampla variedade de valores. Uma boa

candidata � indexa��o seria uma coluna contendo um valor exclusivo para cada linha (por exemplo,

um n�mero de CPF). Uma candidata ruim para indexa��o seria uma coluna que contivesse

somente uma pequena variedade de valores (por exemplo, N, S, E, O ou 1, 2, 3, 4, 5, 6). Um banco

de dados Oracle cria um �ndice automaticamente para a chave prim�ria de uma tabela e para as

colunas inclu�das em uma restri��o �nica.

Al�m disso, se o seu banco de dados � acessado por muitas consultas hier�rquicas (isto �,

uma consulta contendo uma cl�usula CONNECT BY), voc� deve adicionar �ndices nas colunas referenciadas

nas cl�usulas START WITH e CONNECT BY

Por fim, para uma coluna que contenha uma pequena variedade de valores e seja usada

freq�entemente na cl�usula WHERE de consultas, voc� deve considerar a adi��o de um �ndice de

bitmap nessa coluna. Os �ndices de bitmap s�o normalmente usados em ambientes de data warehouse,

que s�o bancos de dados contendo volumes de dados muito grandes. Os dados de um

data warehouse normalmente s�o lidos por muitas consultas, mas n�o s�o modificados por muitas

transa��es concorrentes.

Normalmente, o administrador do banco de dados � respons�vel pela cria��o de �ndices.

Entretanto, como desenvolvedor de aplicativos, voc� poder� fornecer informa��es para ele sobre

quais colunas s�o boas candidatas � indexa��o, pois talvez saiba mais sobre o aplicativo do que o

DBA.

 

USE WHERE EM VEZ DE HAVING

A cl�usula WHERE � usada para filtrar linhas; a cl�usula HAVING, para filtrar grupos de linhas. Como

a cl�usula HAVING filtra grupos de linhas depois que elas foram agrupadas (o que leva algum tempo

para ser feito), quando poss�vel, voc� deve primeiro filtrar as linhas usando uma cl�usula WHERE.

Desse modo, voc� evita o tempo gasto para agrupar as linhas filtradas.

 

? Utiliza a cl�usula GROUP BY para agrupar as linhas em blocos

? Utiliza a cl�usula HAVING para filtrar os resultados retornados em fun��es de grupo

 

-- RUIM (usa HAVING em vez de WHERE)

    SELECT COD_ALUNO, AVG(TOTAL)
    FROM TCONTRATO
    GROUP BY COD_ALUNO
    HAVING COD_ALUNO IN (1, 2);

 

A consulta correta a seguir reescreve o exemplo anterior usando WHERE, em vez de HAVING,

para primeiro filtrar as linhas naquelas cujo valor de cod_aluno � 1 ou 2:

 

-- BOM (usa WHERE em vez de HAVING)

    SELECT COD_ALUNO, AVG(TOTAL)
    FROM TCONTRATO
    WHERE COD_ALUNO IN (1, 2)
    GROUP BY COD_ALUNO;

 

 

USE UNION ALL EM VEZ DE UNION

Voc� usa UNION ALL para obter todas as linhas recuperadas por duas consultas, incluindo as linhas

duplicadas; UNION � usado para obter todas as linhas n�o duplicadas recuperadas pelas consultas.

Como UNION remove as linhas duplicadas (o que leva algum tempo para ser feito), quando poss�vel,

voc� deve usar UNION ALL.

A consulta inadequada a seguir usa UNION (ruim, porque UNION ALL funcionaria) para obter

as linhas das tabelas products e more_products. Observe que todas as linhas n�o duplicadas de

products e more_products s�o recuperadas:

-- RUIM (usa UNION em vez de UNION ALL)

    SELECT COD_ALUNO, NOME, CIDADE
    FROM TALUNO
     
    WHERE ESTADO = 'RS'
    UNION
    SELECT COD_ALUNO, NOME, CIDADE
    FROM COD_ALUNO = 1;

A consulta correta a seguir reescreve o exemplo anterior para usar UNION ALL. Observe que

todas as linhas de products e more_products s�o recuperadas, incluindo as duplicadas:

 

-- BOM (usa UNION ALL em vez de UNION)

    SELECT COD_ALUNO, NOME, CIDADE
    FROM TALUNO
     
    WHERE ESTADO = 'RS'
    UNION ALL
    SELECT COD_ALUNO, NOME, CIDADE
    FROM COD_ALUNO = 1;

USE EXISTS EM VEZ DE IN

Voc� usa IN para verificar se um valor est� contido em uma lista. EXISTS � usado para verificar

a exist�ncia de linhas retornadas por uma subconsulta. EXISTS � diferente de IN: EXISTS apenas

verifica a exist�ncia de linhas, enquanto IN verifica os valores reais. Normalmente, EXISTS oferece

melhor desempenho do que IN com subconsultas. Portanto, quando poss�vel, use EXISTS em vez

de IN.

Consulte a se��o intitulada �Usando EXISTS e NOT EXISTS em uma subconsulta correlacionada�,

(um ponto importante a lembrar � que as subconsultas correlacionadas podem

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

Voc� pode suprimir a exibi��o de linhas duplicadas usando DISTINCT. EXISTS � usado para verificar

a exist�ncia de linhas retornadas por uma subconsulta. Quando poss�vel, use EXISTS em vez de

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

Normalmente, a cl�usula GROUPING SETS oferece melhor desempenho do que CUBE. Portanto,

quando poss�vel, voc� deve usar GROUPING SETS em vez de CUBE. Isso foi abordado detalhadamente

na se��o intitulada �Usando a cl�usula GROUPING SETS�.

 

USE VARI�VEIS DE BIND

O software de banco de dados Oracle coloca as instru��es SQL em cache; uma instru��o SQL colocada

no cache � reutilizada se uma instru��o id�ntica � enviada para o banco de dados. Quando

uma instru��o SQL � reutilizada, o tempo de execu��o � reduzido. Entretanto, a instru��o SQL

deve ser absolutamente id�ntica para ser reutilizada. Isso significa que:

? Todos os caracteres na instru��o SQL devem ser iguais

? Todas as letras na instru��o SQL devem ter a mesma caixa

? Todos os espa�os na instru��o SQL devem ser iguais

Se voc� precisa fornecer valores de coluna diferentes em uma instru��o, pode usar vari�veis

de bind em vez de valores de coluna literais. Exemplos que esclarecem essas id�ias s�o mostrados

a seguir.

 

Instru��es SQL n�o id�nticas

Nesta se��o, voc� ver� algumas instru��es SQL n�o id�nticas. As consultas n�o id�nticas a seguir

recuperam os produtos n� 1 e 2:

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM products WHERE product_id = 2;

Essas consultas n�o s�o id�nticas, pois o valor 1 � usado na primeira instru��o, mas o valor 2

� usado na segunda. As consultas n�o id�nticas t�m espa�os em posi��es diferentes:

SELECT * FROM products WHERE product_id = 1;

SELECT * FROM products WHERE product_id = 1;

As consultas n�o id�nticas a seguir usam uma caixa diferente para alguns dos caracteres:

select * from products where product_id = 1;

SELECT * FROM products WHERE product_id = 1;

Agora que voc� j� viu algumas instru��es n�o id�nticas, vejamos instru��es SQL id�nticas

que utilizam vari�veis de bind.

 

Instru��es SQL id�nticas que usam vari�veis de bind

Voc� pode garantir que uma instru��o seja id�ntica utilizando vari�veis de bind para representar

valores de coluna. Uma vari�vel de bind � criada com o comando VARIABLE do SQL*Plus. Por

exemplo, o comando a seguir cria uma vari�vel chamada v_product_id de tipo NUMBER:

VARIABLE v_product_id NUMBER

 

COMPARANDO O CUSTO DA EXECU��O DE CONSULTAS

O software de banco de dados Oracle usa um subsistema conhecido como otimizador para gerar

o caminho mais eficiente para acessar os dados armazenados nas tabelas. O caminho gerado pelo

otimizador � conhecido como plano de execu��o. O Oracle Database 10g e as vers�es superiores

re�nem estat�sticas sobre os dados de suas tabelas e �ndices automaticamente, para gerar o melhor

plano de execu��o (isso � conhecido como otimiza��o baseada em custo).

A compara��o dos planos de execu��o gerados pelo otimizador permite a voc� julgar o custo

relativo de uma instru��o SQL em rela��o � outra. � poss�vel usar os resultados para aprimorar

suas instru��es SQL. Nesta se��o, voc� vai aprender a ver e interpretar dois exemplos de planos de

execu��o.

 

Examinando planos de execu��o

O otimizador gera um plano de execu��o para uma instru��o SQL. Voc� pode examinar o plano de

execu��o usando o comando EXPLAIN PLAN do SQL*Plus. O comando EXPLAIN PLAN preenche

uma tabela chamada plan_table com o plano de execu��o da instru��o SQL (plan_table � freq�entemente

referida como �tabela de plano�). Voc� pode ent�o examinar esse plano de execu��o

consultando a tabela de plano. A primeira coisa que voc� deve fazer � verificar se a tabela de plano

j� existe no banco de dados.

 

Gerando um plano de execu��o

Uma vez que voc� tenha uma tabela de plano, pode usar o comando EXPLAIN PLAN para gerar um

plano de execu��o para uma instru��o SQL. A sintaxe do comando EXPLAIN PLAN �:

EXPLAIN PLAN SET STATEMENT_ID = id_instru��o FOR instru��o_sql;

onde

? id_instru��o � o nome que voc� deseja dar ao plano de execu��o. Pode ser qualquer

texto alfanum�rico.

? instru��o_sql � a instru��o SQL para a qual voc� deseja gerar um plano de execu��o.

O exemplo a seguir gera o plano de execu��o para uma consulta que recupera todas as linhas

da tabela customers (observe que o valor de id_instru��o � configurado como 'CUSTOMERS'):

EXPLAIN PLAN SET STATEMENT_ID = 'CUSTOMERS' FOR

SELECT customer_id, first_name, last_name FROM customers;

Explained

Depois que o comando terminar, voc� pode examinar o plano de execu��o armazenado na

tabela de plano. Voc� vai aprender a fazer isso a seguir.

NOTA

A consulta na instru��o EXPLAIN PLAN n�o retorna linhas da tabela customers. A instru��o

EXPLAIN PLAN simplesmente gera o plano de execu��o que seria usado se a consulta fosse

executada.

Consultando a tabela de plano

Para consultar a tabela de plano, fornecemos um script SQL*Plus chamado explain_plan.sql no

diret�rio SQL. O script solicita o valor de statement_id (id_instru��o) e depois exibe o plano de

execu��o para essa instru��o.

O script explain_plan.sql cont�m as seguintes instru��es:

-- Exibe o plano de execu��o da statement_id especificada

    UNDEFINE v_statement_id;
    SELECT
    id ||
    DECODE(id, 0, '', LPAD(' ', 2*(level � 1))) || ' ' ||
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

 

Um plano de execu��o � organizado em uma hierarquia de opera��es de banco de dados

semelhante a uma �rvore; os detalhes dessas opera��es s�o armazenados na tabela de plano. A

opera��o com o valor de id igual a 0 � a raiz da hierarquia e todas as outras opera��es do plano

procedem dessa raiz. A consulta do script recupera os detalhes das opera��es, come�ando com a

opera��o raiz e, ent�o, percorre a �rvore a partir da raiz.

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

As opera��es mostradas na coluna EXECUTION_PLAN s�o executadas na seguinte ordem:

? A opera��o recuada mais � direita � executada primeiro, seguida de todas as opera��es

pai que est�o acima dela.

? Para opera��es com o mesmo recuo, a opera��o mais acima � executada primeiro, seguida

de todas as opera��es pai que est�o acima dela.

Cada opera��o envia seus resultados de volta no encadeamento at� sua opera��o pai imediata

e, ent�o, a opera��o pai � executada. Na coluna EXECUTION_PLAN, a ID da opera��o � mostrada

na extremidade esquerda. No exemplo de plano de execu��o, a opera��o 1 � executada primeiro,

com seus resultados sendo passados para a opera��o 0. O exemplo a seguir ilustra a ordem para

um exemplo mais complexo:

    0 SELECT STATEMENT Cost = 6
    1 MERGE JOIN Cost = 1
    2 TABLE ACCESS BY INDEX ROWID PRODUCT_TYPES TABLE Cost = 1
    3 INDEX FULL SCAN PRODUCT_TYPES_PK INDEX (UNIQUE) Cost = 1
    4 SORT JOIN Cost = 2
    5 TABLE ACCESS FULL PRODUCTS TABLE Cost = 1

A ordem em que as opera��es s�o executadas nesse exemplo � 3, 2, 5, 4, 1 e 0.

Agora que voc� j� conhece a ordem na qual as opera��es s�o executadas, � hora de aprender

para o que elas fazem realmente.  O plano de execu��o da consulta 'CUSTOMERS' era:

0 SELECT STATEMENT Cost = 3

1 TABLE ACCESS FULL CUSTOMERS TABLE Cost = 1

A opera��o 1 � executada primeiro, com seus resultados sendo passados para a opera��o 0.

A opera��o 1 envolve uma varredura integral � indicada pela string TABLE ACCESS FULL � da

tabela customers. Este � o comando original usado para gerar a consulta 'CUSTOMERS':

    EXPLAIN PLAN SET STATEMENT_ID = 'CUSTOMERS' FOR
    SELECT customer_id, first_name, last_name FROM customers;

 

Uma varredura integral da tabela � realizada porque a instru��o SELECT especifica que todas

as linhas da tabela customers devem ser recuperadas.

O custo total da consulta � de tr�s unidades de trabalho, conforme indicado na parte referente

ao custo mostrada � direita da opera��o 0 no plano de execu��o (0 SELECT STATEMENT Cost =

3). Uma unidade de trabalho � a quantidade de processamento que o software precisa para realizar

determinada opera��o. Quanto mais alto o custo, mais trabalho o software do banco de dados precisa

realizar para concluir a instru��o SQL.

NOTA

Se voc� estiver usando uma vers�o do banco de dados anterior ao Oracle Database 10g, a sa�da

do custo da instru��o global poder� estar em branco. Isso ocorre porque as vers�es de banco de

dados anteriores n�o re�nem estat�sticas de tabela automaticamente. Para reunir estat�sticas, voc�

precisa usar o comando ANALYZE. Voc� vai aprender a fazer isso na se��o �Reunindo estat�sticas

de tabela�.

Planos de execu��o envolvendo joins de tabela

Os planos de execu��o para consultas com joins de tabelas s�o mais complexos. O exemplo a seguir

gera o plano de execu��o de uma consulta que junta as tabelas products e product_types:

    EXPLAIN PLAN SET STATEMENT_ID = 'PRODUCTS' FOR
    SELECT p.name, pt.name
    FROM products p, product_types pt
    WHERE p.product_type_id = pt.product_type_id;

O plano de execu��o dessa consulta est� mostrado no exemplo a seguir:

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

 

ID da opera��o Descri��o

3 Varredura integral do �ndice product_types_pk (que � um �ndice exclusivo)

para obter os endere�os das linhas na tabela product_types. Os

endere�os est�o na forma de valores de ROWID, os quais s�o passados para

a opera��o 2.

2 Acesso �s linhas da tabela product_types usando a lista de valores de

ROWID passada da opera��o 3. As linhas s�o passadas para a opera��o 1.

5 Acesso �s linhas da tabela products. As linhas s�o passadas para a opera��o

4.

4 Classifica��o das linhas passadas da opera��o 5. As linhas classificadas s�o

passadas para a opera��o 1.

1 Mesclagem das linhas passadas das opera��es 2 e 5. As linhas mescladas

s�o passadas para a opera��o 0.

0 Retorno das linhas da opera��o 1 para o usu�rio. O custo total da consulta

� de 6 unidades de trabalho.

Reunindo estat�sticas de tabela

Se estiver usando uma vers�o do banco de dados anterior ao Oracle Database 10g (como a 9i),

voc� mesmo ter� de reunir estat�sticas de tabela usando o comando ANALYZE. Por padr�o, se

nenhuma estat�stica estiver dispon�vel, a otimiza��o baseada em regra ser� utilizada. Normalmente,

a otimiza��o baseada em regra n�o � t�o boa quanto a otimiza��o baseada em custo. Os

exemplos a seguir usam o comando ANALYZE para reunir estat�sticas para as tabelas products e

product_types:

ANALYZE TABLE products COMPUTE STATISTICS;

ANALYZE TABLE product_types COMPUTE STATISTICS;

Uma vez reunidas as estat�sticas, a otimiza��o baseada em custo ser� usada em vez da otimiza��o

baseada em regra.

Comparando planos de execu��o

Comparando o custo total mostrado no plano de execu��o para diferentes instru��es SQL, voc�

pode determinar o valor do ajuste de seu c�digo SQL. Nesta se��o, voc� ver� como comparar dois

planos de execu��o e a vantagem de usar EXISTS em vez de DISTINCT (uma dica dada anteriormente).

O exemplo a seguir gera um plano de execu��o para uma consulta que usa EXISTS:

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

O plano de execu��o dessa consulta est� mostrado no exemplo a seguir:

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

O custo da consulta � de 5 unidades de trabalho. Essa consulta � mais dispendiosa do que a

anterior, que usou EXISTS (essa consulta tinha um custo de apenas 4 unidades de trabalho). Esses

resultados provam que � melhor usar EXISTS do que DISTINCT.

Refer�ncia Oracle DataBase 11G SQL


---------------------------------------------------------------------------------------------------------


Cria��o de �ndices
Porque o �ndice � importante?

�ndices (Index) s�o importantes pois diminuem processamento e I/O em disco. Quando usamos um comando SQL para retirar informa��es de uma tabela, na qual, a coluna da mesma n�o possui um �ndice, o Oracle faz um Acesso Total a Tabela para procurar o dado, ou seja, realiza-se um FULL TABLE SCAN degradando a performance do Banco de Dados Oracle. Com o �ndice isso n�o ocorre, pois com o �ndice isso apontar� para a linha exata da tabela daquela coluna retirando o dado muito mais r�pido.

Crie �ndices quando:

Uma coluna contiver uma grande faixa de valores

Uma coluna contiver muitos valores nulos

Quando uma ou mais colunas forem usadas frequentemente em clausulas WHERE ou emJOINS

Se a tabela for muito grande e as consultas realizadas recuperarem menos de 5% dos registros.

N�O Crie �ndices quando:

As colunas n�o s�o usadas frequentemente como condi��o nas consultas

A tabela for pequena ou se os resultados das consultas forem maiores que 5-10% dos registros.

A tabela for atualizada com frequ�ncia

As colunas fizerem parte de uma express�o*

* Express�o � quando usado regra de filtro na clausula where, como por exemplo:

SELECT TABLE_NAME

FROM ALL_TABLES

WHERE TABLE_NAME||OWNER = 'DUALSYS'

Observe que na clausula de compara��o as colunas TABLE_NAME e OWNER fazem uma express�o de compara��o e por consequencia um �ndice n�o ajudaria em nada.

 

Outras coisas importantes de lembrar:

    �NDICES N�O S�O ALTER�VEIS! (Para voc� alterar um �ndice voc� deve remov�-lo e recri�-lo. )
    �NDICES ONERAM A PERFORMANCE DE INSERT / UPDATE  ( N�o d� pra fazer milagres, se sua tabela tiver muitos �ndices as performances de altera��es podem ser comprometidas )


-------------------------------------------------------------------------------------------------------------------------------------------------


Monitorando uso dos �ndices

Monitorando uso dos �ndices

Existem muitos bancos de dados em que �ndices est�o criados mais n�o s�o utilizados. Por exemplo, ter criado um �ndice para um determinado procedimento, que � executado somente uma vez e ap�s seu uso n�o � removido, ou at� mesmo o Oracle perceber que leitura por scans completos pode ser mais vantajoso do que utilizar um determinado �ndice (isso acontece).

Criar �ndice em uma base, deve ser algo realmente estudado, pois podem ter impacto negativo sobre o desempenho das opera��es DML. Al�m de modificar o valor do bloco da data, tamb�m � necess�rio atualizar o bloco do �ndice.

Por esse motivo que devesse notar muito bem a utiliza��o de um �ndice, caso n�o seja utilizado prejudica o desempenho do banco de dados.

Abaixo est� um exemplo para descobrir se um �ndice est� sendo ou n�o utilizado

--Cria��o de tabela de teste

create table teste (codigo number,  nome varchar2(40) );

  --Cria��o de indice create index ind_codigo on teste (codigo);

--Novo registro insert into teste values (1, 'MARCIO');

commit;

--Verificado se o �ndices j� foi usado

select index_name, table_name, used from v$object_usage;

--Alterado �ndice

alter index ind_codigo monitoring usage;

 

--Select para usar o indice select * from teste where codigo=1;

 

--Verificado se o �ndices j� foi usado novamente

select index_name, table_name, used from v$object_usage;

--Alterado �ndice para n�o ser monitorado

alter index ind_codigo nomonitoring usage;

Veja que a view v$OBJECT_USAGE, ter� cada �ndice do seu esquema cujo uso est� sendo monitorando, caso o �ndice n�o for usado, pode ser exclui-lo para melhorar performance de DML.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------


Estat�sticas
Coletando estat�sticas para o otimizador de queries do Oracle

  Para que o Oracle monte planos de execu��o otimizados, � necess�rio que as estat�sticas dos objetos estejam sempre atualizadas. Para atualizar as estat�sticas dos objetos, podemos usar os m�todos abaixo:

 

     Comando ANALYZE:

          - Calcula estat�sticas globais de tabelas, �ndices e clusters;

          - Permite coletar estat�sticas exatas ou estimada em um n�mero ou percentual de linhas;

          - N�o � t�o preciso ao calcular, por exemplo, a cardinalidade, ao envolver valores distintos;

           - Exemplo p/ coletar estat�sticas exatas de uma tabela: 

               ANALYZE TABLE TALUNO COMPUTE STATISTICS;

 

     Package DBMS_UTILITY:

          - As procedures desta package diferem do comando ANALYZE apenas pela possibilidade de permitir coletar estat�sticas de um schema ou do banco de dados completo;

          - Exemplo p/ coletar estat�sticas de um schema todo:

               EXEC DBMS_UTILITY.ANALYZE_SCHEMA('CURSO','COMPUTE');

   

     Package DBMS_STATS:

          - Permite coletar estat�sticas exatas ou estimadas de objetos individualmente (tabelas, �ndices, cluster etc), schemas, banco de dados completo e de sistema;

          - Permite execu��o paralela, transfer�ncia de estat�sticas entre servidores e � mais preciso que os m�todos anteriores;

          - Gera historicos que s�o extremamente �teis para otimizar queries que efetuam pesquisas em colunas que possuem valores dispersos;

          - � o m�todo de coleta de estat�sticas atualmente recomendado pela Oracle e por especialistas no assunto;

          - Exemplos:

              a) Para coletar estat�sticas estimadas (5%) de uma tabela:

                 EXEC DBMS_STATS.GATHER_TABLE_STATS(

OWNNAME=>'OWNER', TABNAME=>'TALUNO', ESTIMATE_PERCENT=>5);  

 

              b) Para coletar estat�sticas estimadas (30%) de um schema:

                 EXEC DBMS_STATS.GATHER_SCHEMA_STATS('OWNER', estimate_percent=> 30);

 

              c) Para coletar estat�sticas de todo o banco de dados: 

               EXEC DBMS_STATS.GATHER_DATABASE_STATS;

  

              d) Para coletar estat�sticas de sistema (DD): 

               EXEC DBMS_STATS.GATHER_DICTIONARY_STATS;

Para coletar estat�sticas de objetos:

  

        A partir do Oracle Database 10G, as estat�sticas s�o coletadas automaticamente pelo Oracle, diariamente de 2� � 6�, em um hor�rio compreendido geralmente entre 22h e 2h, e aos s�bados come�a �s 6h e termina somente no Domingo, �s 2h. � importante lembrar que ela s� ocorre se o banco de dados estiver ocioso e somente nos objetos que tiveram mais que 10% de atualiza��es (inclui INSERT, UPDATE e DELETE). A partir do 11G, este valor de 10% � configur�vel.

           Pelo motivo dela ocorrer automaticamente, colete estat�sticas somente quando voc� identificar alguma necessidade extra, como por exemplo, ap�s uma carga de dados ou em banco de dados que trabalham 24X7 e que nunca ficam ociosos. Nestes casos, recomendo criar uma stored procedure contendo o c�digo para coletar estat�sticas de objetos do banco e criar em seguida um job para executar esta procedure periodicamente;

          Se o seu BD usa o CBO, evite coletar estat�sticas atrav�s do comando ANALYZE TABLE e atrav�s da package DBMS_UTILITY.Se voc� fizer isso, suas estat�sticas ser�o menos precisas e voc� n�o ter� historicos;


-----------------------------------------------------------------------------------------------------------------------------------------------



Estat�sticas - Scripts

--Analisa apenas uma tabela - executar como usu�rio normal ANALYZE TABLE TALUNO COMPUTE STATISTICS;

--Estat�stica de schema - SYSTEM EXEC DBMS_UTILITY.ANALYZE_SCHEMA('CURSO','COMPUTE');

--Estat�stica de banco inteiro (Pode ser demorado) - SYSTEM EXEC DBMS_STATS.GATHER_DATABASE_STATS;

--Bloco anonimo para ler estat�sticas do banco de dados - SYSTEM 

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
        DBMS_OUTPUT.put_line('*** HINT: Valor de Log Buffer � muito baixo!');
      END IF;
     
    END;



----------------------------------------------------------------------------------------------------------------



Views Materializadas Utilizamos elas para fazermos c�lculos, armazenamentos de dados e dar agilidade na troca de informa��es entre um banco de dados ou entre tabelas. Este recurso � muito utilizado em ambientes de Data Warehouse, que trabalha com uma enorme quantidade de informa��es. Pois com elas conseguimos melhorar a performance do sistema e trazer diversos benef�cios ao Oracle.

As Views Materializadas s�o utilizadas para fazer atualiza��es, a pr�pria Oracle garante que as atualiza��es s�o feitas com sucesso numa tabela destinat�ria ap�s terem sido efetivadas nas tabelas originais. Isso nos d� mais tranquilidade na administra��o e no desenvolvimento.

Exemplo de como se faz uma Views Materializadas:

CREATE MATERIALIZED VIEW VM_ALUNO BUILD IMMEDIATE  REFRESH FAST ENABLE QUERY REWRITE  AS (SELECT * FROM TALUNO WHERE CIDADE=�NOVO HAMBURGO�) BUILD IMMEDIATE

A View Materializada dever� utilizar os dados imediatamente na query rewrite (Seu SELECT), desde modo os dados ser�o processados com mais agilidade.

Existe tamb�m outro m�todo, chamado build deferred que significa que a view n�o ter� nenhum tipo de dados a ser utilizada automaticamente, esse modo seria um processamento manual das informa��es, que ser� depois atualizado pelo Refresh, resumindo, que com essa op��o o comando SELECT n�o ser� executado imediatamente.

REFRESH FAST

Esse m�todo � para dizer que as modifica��es ser�o utilizadas somente pela View Materializada, para utilizar este recurso com seguran�a, sugiro criar uma View Materializada Log, para ter controle sobre as modifica��es que est�o sendo feitas.

ENABLE QUERY REWRITE

Essa linha de comando � o que indica que o SELECT presente dentro da View Materializada ser� reescrita e atualizada para os novos valores passados pela VIEW. A query rewrite pode ter tr�s n�veis de integridade que vai desde o modo ENFORCED at� o STALE_TOLERATED, que indicar� ao banco de dados que tipo de confian�a ele poder� ter nos dados. Sobre as integridades, falaremos na pr�xima coluna tamb�m, pois e um pouco mais delicado.

AS SELECT

Aqui ser� colocado seu SELECT, onde poder� fazer alguns c�lculos ou visualiza��es de informa��es para outras tabelas, como no exemplo de SELECT a seguir.

    SELECT * FROM TALUNO WHERE cidade = �NOVO HAMBURGO�

SELECTS que devemos utilizar dentro das Views Materializadas devem seguir um padr�o delas, como, por exemplo, n�o utilizar cl�usulas como UNION, UNION ALL, INTERSECT e MINUS. 



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

Otimizador do Oracle � incrivelmente preciso na escolha do caminho de otimiza��o correto e no uso de �ndices para milhares de registros no seu sistema, porem exise casos que � preciso mudar.  O ORACLE possui hints ou sugest�es que voc� poder� usar para determinadas consultas, de modo que o otimizador seja desconsiderado, na esperan�a de conseguir melhor desempenho para determinada consulta.  Os hints modificam o caminho de execu��o quando um otimizador processa uma instru��o espec�fica. O par�metro OPTIMIZER_MODE de init.ora pode ser usado para modificar todas as instru��es no banco de dados para que sigam um caminho de execu��o espec�fico, mas um hint para um caminho de execu��o diferente substitui qualquer coisa que esteja especificada no init.ora. Contudo, a otimiza��o baseada em custo n�o ser� usada se as tabelas n�o tiverem sido analisadas.

Os hints podem ser muito �teis se soubermos quando e qual usar, mas eles podem ser mal�ficos se n�o forem utilizados na situa��o correta ou sem muito conhecimento de suas a��es e consequ�ncias! Nas �ltimas vers�es do SGBD Oracle, um hint obsoleto pode gerar um plano de execu��o ruim, e consequentemente, impactar negativamente na performance da instru��o SQL.

Veremos v�rios hints, como por exemplo: APPEND,PARALLEL e FIRST_ROWS, que s�o muito bons quando s�o utilizados nas situa��es adequadas! O hint APPEND, por exemplo, deve ser utilizado para otimizar cargas de dados via comando INSERT (atrav�s de carga direta) somente quando voc� tiver certeza de que outros usu�rios n�o estar�o atualizando dados concorrentemente na tabela! J� o hint PARALLEL, s� deve ser utilizado em consultas longas e quando houver recursos de processamento, mem�ria e I/O dispon�veis, ou seja, quando estes recursos, n�o estiverem sobrecarregados!


------------------------------------------------------------------------------------------------------------------------------------------------------------------


Hints de Pesquisa - Script

--Conectado como system --Vis�o dos hints select * from v$sql_hint

--Conectado como system grant select_catalog_role to marcio; grant select any dictionary to marcio;

-- first_rows: Para for�ar o uso de �ndice de modo geral.  -- Faz com que o otimizador escolha um caminho que recupera N linhas primeiramente  -- e ja mostra enquanto processa o resto

    select * from taluno;

    create index ind_aluno_nome on taluno(nome);

    select /*+ first_rows(2) */ cod_aluno, nome from taluno

-- all_rows: Para for�ar varredura completa na tabela.

    select /*+ all_rows (10) */ cod_aluno, nome
    from taluno;

    -- full: Para for�ar um scan completo na tabela. 
    -- A hint full tamb�m pode causar resultados inesperados como varredura 
    -- na tabela em ordem diferente da ordem padr�o.
     
    select /*+ full_rows (taluno) */ cod_aluno, nome
    from taluno
    where nome = 'MARCIO' ;

-- index: For�a o uso de um �ndice. -- Nenhum �ndice � especificado.  -- O Oracle pesa todos os �ndices poss�veis e escolhe um ou mais a serem usados.  -- Otimizador n�o far� um scan completo na tabela.

    select /*+ index */ cod_aluno, nome
    from taluno
    where nome = 'MARCIO' ;

---Exemplo do uso da hint index informando os �ndices que devem ser utilizados:

    select /*+ index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' ;

-- no_index: Evitar que um �ndice especificado seja usado pelo Oracle.

    select /*+ no_index (taluno ind_aluno_nome) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' ;

-- index_join : Permite mesclar �ndice em uma �nica tabela.  -- Permite acessar somente os �ndices da tabela, e n�o apenas um scan  -- com menos bloco no total, � mais r�pido do que usar um �ndice que faz scan na tabela por rowid.

create index ind_aluno_cidade on taluno(cidade)

    select /*+ index_join (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

-- and_equal : Para acessar todos os �ndices que voc� especificar.  -- A hint and_equal faz com que o otimizador misture v�rios �ndices  -- para uma �nica tabela em vez de escolher qual � ao melhor.

    select /*+ and_equal (taluno ind_aluno_nome, ind_aluno_cidade) */ cod_aluno, nome, cidade
    from taluno
    where nome = 'MARCIO' AND cidade = 'NOVO HAMBURGO';

-- index_ffs: For�a um scan completo do �ndice.  -- Este hint pode oferecer grandes ganhos de desempenho quando a tabela  -- tamb�m possuir muitas colunas.

    select /*+ index_ffs (taluno ind_aluno_nome) */ cod_aluno, nome
    from taluno
    where nome = 'MARCIO'



---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


