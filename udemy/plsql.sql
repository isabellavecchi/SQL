PARA REFERENCIAR VARIAVEIS HOST -- que n é plsql
    :varhost := vexmp * 2.5;

UTILIZANDO O TIPO DE OUTRO DADO
    Ex.: de um dado de uma coluna de uma tabela específica
    
    DECLARE
        v_ex TB_TABLE.v_ex2%TYPE;


SET SERVEROUTPUT ON;
   
    BEGIN
        dbms_output.enable;
        Dbms_Output.Put_Line(Round(5.5));
    END;
    --o Round() arredonda conforme o padrão matemático

DECLARANDO VARIAVEL GLOBAL
    VARIABLE v_var TYPE --sem ';'

plsql não suporta DDL e DCL (definicao e controle)
    create, drop                                                                            ----------------------*******DÚVIDA
    não suporta mesmo
    pode colocar sql embutido, e o oracle faz uma adaptação
    tem que executar de forma dinâmica (EXECUTE IMMEDIATE)
    
INPUT
    &nome_var

SELECT nseioque FROM DUAL
    maneira de pegar coisas aleatórias que n estão em tabelas,
  como sequencias ou coisas que acabaram de ser criadas e quero
  ver.


vtexto := SQL%ROWCOUNT;
    retorna a qtde de registros afetados pelo comando sql



RECORD
    similar a uma linha de tabela, mas é uma variável
    
    DECLARE nome_record_type IS RECORD
        (igual á declaração de uma tabela);
    
    instancia_record    nome_record_type;
*obs.: o bom do record é que se o select retornar vazio n dá erro


DECLARANDO UMA VARIÁVEL PARA ARMAZENAR AS INFORMAÇÕES DE UMA LINHA DE UMA TABELA
    cliente_record      tclientes%ROWTYPE;


COLLECTION
    - Associative index-by Array     --pega os dados de uma tabela, cada elemento é um registro
    - Nested Table          --POO por tabelas criadas; usa EXTEND para abrir um registro que irá receber dados
    - Varrays               --vetor normal, também utiliza extend
        para criar a partir de uma tabela vc usa IS TABLE OF tb_table


FOR UPDATE OF column_name NOWAIT;
    enquanto o programa estiver rodando, esta linha n pode ser alterada
FOR UPDATE;
    bloqueia a linha toda

WHERE CURRENT OF registro;
    a cada vez que passa pelo registro durante a ação do bd, ele fica bloqueado
  para alterações


CURSOR
    ou usa um for ou open fetch & close

PRAGMA EXCEPTION_INIT                                                                     ----------------------*******DÚVIDA
    serve para criar nomes de exceções para serem tratadas
    
    código?

    *SQLCODE
        imprime o último erro
    
    posso declarar uma excessão no DECLARE
PROCEDURE
    na hora de declarar os tipos das variáveis dos parâmetros, n coloca tamanho

FUNCTIONS E PROCEDURES podem ter parâmetros IN e OUT

PACKAGE
    funciona como uma classe
    serve para agrupar objetos
    o que é declarado na especificação se torna público
    o que é declarado no body se torna privado, local

Raise_Application_Error (cod, 'msg')
    exception



GROUP BY
    -RANK
        ordena, repete a posição de valores repetidos, mas pula a posição seguinte do repetido (ex.: 1o, 1o, 3o)
      -DENSE_RANK
        valores repetidos recebem a mesma enumeração/ordenação, e o próximo a poisção seguinte (ex.: 1o, 1o, 2o)

    -RATIO_TO_REPORT
        calcula o percentual/proporção de um valor em relação a um conjunto de 
      valores
    -LAG E LEAD
        permite comparação entre duas linhas de um mesmo conjunto de dados
        LAG - anterior
        LEAD - posterior
    --GROUPING
        total geral (1)
    --GROUPING_ID
        subtotal    (1)
            --nos dois casos 0 é linha simples
    GROUPING SETS
        mostra só subtotais


DATABASE LINK
    conectar-se a uma base de dados de outra máquina
    
    CREATE DATABASE LINK db_link
    CONNECT TO usuario IDENTIFIED BY "senha"
    USING "tns_nome"
    
    SELECT * FROM tb_table@db_link

MULTI TABLE INSERT
    -INSERT --incondicional
        insere todas as linhas em todas as tabelas
    -ALL INSERT --condicional
        When --todos são verificados
            pode ter ELSE
        podem ser utilizadas várias cláusulas INTO com uma condição WHEN
    -FIRST INSERT --condicional
        verifica cada WHEN na ordem e insere somente o primeiro INTO que retornar TRUE
            pode ter ELSE
    *se o SELECT retornar vãrios registros, ele irá compilar o código para cada um

MERGE
    pega dados de uma tabela e insere em outra
    UPDATE caso o dado já exista na outra (WHEN MATCHED), INSERT quando n existe (WHEN NOT MATCHED)
    * legal para atualizar tabelas dependente de outras

SQL DINÂMICO
    INSERT UPDATE E DELETE
        -EXECUTE IMMEDIATE
            não executa o commit mesmo se for uma ação de commit automática?                    ---------------------**dúvida
            é necessário que o usuário tenha recebido os GRANTS de DDL de forma explícita, n pode ser atraés de ROLE
            *colocar ponto e vírgula no final do que mandou executar
    SQL SELECT
        -OPEN-FOR
        -FETCH
        -CLOSE