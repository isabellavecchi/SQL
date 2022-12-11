UTL FILE (read & right from file)

initcap -> Nome, Palavra, Primeira Maiuscula

InStr(campo, 'c') -> retorna a posicao da letra colocada entre parenteses 

LPad(campo, 5, '0') -> coloca '0's na esquerda até completar 5 chars

RPad(campo,5, '0') -> adiciona à esquerda, pode colocar outro tipo de char

SubStr(campo, 1, 3) -> a partir da posição 1, copia 3 chars

Trunc(DATA) -> se livra da hora

replace(campo, 'r', '$') -> substitui 'r' por '$'
replace(upper(campo), 'R', '$')

SELECT nome, SubStr(nome, 3, Length(nome)- 3) FROM TALUNO;

Trim(campo
0 -> tira os espaços em branco

NVL(campo, 0) -> se o campo for NULL substitui por '0'

NVL2(campo1, campo2, '0') -> Se o campo1 is null coloca '0', se n, coloca o valor do campo2

SELECT [

        ]
    FROM ĺocais de onde buscam
    WHERE SELECT [
                    sub-bloco
                 ]

    --> pensar na forma de construir os selects
        --são como sub-blocos nos programas, onde DECLARAMOS VARIÁVEIS!!

SELECT
FROM
WHERE (tb.campo1, tl.campo2) = SELECT (a.campo1, b.campo2)
                                FROM
                                WHERE
                                -- é válido
                                
                                
SUB-SELECT dentro do FROM!
      forca uma relacao que n existe entre tabelas selecionando
    dados como se fosse uma tabela
    
TIPOS DE DADOS
    B-FILE
    --ponteiro para um arquivo externo - outros tipos de doc (tipo até um word)

COMO COMENTAR EM TABELAS E COLUNAS
    COMMENT ON TABLE tb_table IS 'insira o comentario aqui';
    COMMENT ON COLUMN tb_table.coluna IS 'insira o comentario aqui';

DESABILITAR COLUNA
    ALTER TABLE tb_table SET UNUSED (coluna);

EXCLUIR COLUNAS DESABILITADAS
    ALTER TABLE tb_table DROP UNUSED COLUMNS;

TRUNCATE
    TRUNCATE TABLE tb_table;
    --exclui todos os dados da tablea
    --n tem commit e rollback
    
PARA VER AS VIEWS DO BD
    SELECT VIEW_NAME, TEXT
      FROM USER_VIEWS;

Dá para inserir dados numa view
ele insere indiretamente na tabela quando pedimos para inserir nela
uma forma de filtrar o que será inserido na tabela é acrescentando a
linha de código abaixo da cláusula de for
    WITH CHECK OPTION CONSTRAINT nome_da_constraint;
    
Para bloquear as ações de DML
    WITH READ ONLY;

JOIN (+)
    o (+) é colocado na coluna em que você deseja extrair resultados que n existem na outra

