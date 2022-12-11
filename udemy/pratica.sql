TABLESPACE
    espa�o de tamanho definido para armazenar tabelas, fun�oes, etc.

RECORD COLLECTION
    manipular dados com conceitos de POO
    
    array ou matriz = object = record ou collection

CURSOR
    funciona como uma query em que vc pode pegar um dado por vez e ir armazenando em records ou collection
    
PIPE ROW
    EMPILHAR DADOS NUMA LISTA

Bulk Collect

    O uso do Bulk Collect � aplicado para a manipula��o de grande massa de dados. Com seu uso correto,
  podemos ter v�rios tipos de ganhos.

    Podemos ter: Aplica��es mais r�pidas, aloca��o dos dados na mem�ria, sem a necessidade de refazer
  a busca no banco. Porem temos um risco tamb�m, pois se n�o aplicarmos corretamente as diretrizes na
  PGA(Program Global Area), podemos ter problemas na quantidade de dados carregados na mem�ria.

    Para estes problemas temos a cla�sula LIMIT, que limita os dados que foram para a mem�ria.



MERGE
    insere se n tem o dado, atualiza se j� tem


TEXT e CONTAINS
    BFILE, BLOB
    importar/exportar de/para outros tipos de arquivos

UTL_FILE
    arquivo de entrada e sa�da

XML
    (Extensible Markup Language) � uma linguagem de marca��o de prop�sito geral.
  Ela permite compartilhar dados estruturados na Internet e pode ser usada para
  codificar dados e outros documentos.
  
  TALVEZ SEJA BOM PARA PROGRAMA��O WEB

    SHUTDOWN IMMEDIATE
    STARTUP MOUNT
    --reiniciando o banco
    
    GRANT EXECUTE ON utl_file TO PUBLIC;
    --qualquer usuario pode manipular


GARIMPANDO BITS
    usar EXISTS no lugar de DISTINCT


INDICE
    tem como monitorar para ver se est� sendo usado ou n�o


ESTAT�STICAS
    Para que o Oracle monte planos de execu��o otimizados, � necess�rio
  que as estat�sticas dos objetos estejam sempre atualizadas. Para atualizar
  as estat�sticas dos objetos, podemos usar os m�todos abaixo:
    ANALYZE
    Package DBMS_UTILITY
    Package DBMS_STATS
    etc


MATERIALIZED VIEW
    uma view mais eficaz


HINTS DE PESQUISA /*+ hint */
    APPEND --inserir dados quando sabe que ngm est� atualizando
    PARALLEL --consultas longas
    FIRST_ROWS