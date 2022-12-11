TABLESPACE
    espaço de tamanho definido para armazenar tabelas, funçoes, etc.

RECORD COLLECTION
    manipular dados com conceitos de POO
    
    array ou matriz = object = record ou collection

CURSOR
    funciona como uma query em que vc pode pegar um dado por vez e ir armazenando em records ou collection
    
PIPE ROW
    EMPILHAR DADOS NUMA LISTA

Bulk Collect

    O uso do Bulk Collect é aplicado para a manipulação de grande massa de dados. Com seu uso correto,
  podemos ter vários tipos de ganhos.

    Podemos ter: Aplicações mais rápidas, alocação dos dados na memória, sem a necessidade de refazer
  a busca no banco. Porem temos um risco também, pois se não aplicarmos corretamente as diretrizes na
  PGA(Program Global Area), podemos ter problemas na quantidade de dados carregados na memória.

    Para estes problemas temos a claúsula LIMIT, que limita os dados que foram para a memória.



MERGE
    insere se n tem o dado, atualiza se já tem


TEXT e CONTAINS
    BFILE, BLOB
    importar/exportar de/para outros tipos de arquivos

UTL_FILE
    arquivo de entrada e saída

XML
    (Extensible Markup Language) é uma linguagem de marcação de propósito geral.
  Ela permite compartilhar dados estruturados na Internet e pode ser usada para
  codificar dados e outros documentos.
  
  TALVEZ SEJA BOM PARA PROGRAMAÇÃO WEB

    SHUTDOWN IMMEDIATE
    STARTUP MOUNT
    --reiniciando o banco
    
    GRANT EXECUTE ON utl_file TO PUBLIC;
    --qualquer usuario pode manipular


GARIMPANDO BITS
    usar EXISTS no lugar de DISTINCT


INDICE
    tem como monitorar para ver se está sendo usado ou não


ESTATÍSTICAS
    Para que o Oracle monte planos de execução otimizados, é necessário
  que as estatísticas dos objetos estejam sempre atualizadas. Para atualizar
  as estatísticas dos objetos, podemos usar os métodos abaixo:
    ANALYZE
    Package DBMS_UTILITY
    Package DBMS_STATS
    etc


MATERIALIZED VIEW
    uma view mais eficaz


HINTS DE PESQUISA /*+ hint */
    APPEND --inserir dados quando sabe que ngm está atualizando
    PARALLEL --consultas longas
    FIRST_ROWS