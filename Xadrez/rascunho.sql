o   inserir o execute immediate na fucao de preencher tabuleiro
-   organizar os blocos de execução como PROCEDURE
-   implementar cursor no xadrez com record
-   organizar os códigos em packages
x   DROP TABLE tb_table PURGE;
-   limpar a table recyclebin
-   estudar rowjjid

MANEIRA MAIS F�?CIL DE MIGRAÇÃO
    escrever os scripts em um e passar para outro

DÚVIDAS
    colection pega a table inteira, ou apenas uma column?
    o cursor na collection funciona como um record?


------------------------------------------------------------------


select round((sum(bytes)/1048576/1024),2) from v$datafile; 

select
"Reserved_Space(MB)", "Reserved_Space(MB)" - "Free_Space(MB)" "Used_Space(MB)","Free_Space(MB)"
from(
select
(select sum(bytes/(1014*1024)) from dba_data_files) "Reserved_Space(MB)",
(select sum(bytes/(1024*1024)) from dba_free_space) "Free_Space(MB)"
from dual
);


CREATE TABLESPACE tbs_xadrez
DATAFILE '/u01/app/oracle/oradata/tbs_xadrez.dbf'
    SIZE 250M
AUTOEXTEND ON NEXT 100M MAXSIZE 350M
DEFAULT STORAGE
    (INITIAL 512K NEXT 256K
    MINEXTENTS 1
    MAXEXTENTS unlimited
    PCTINCREASE 0)
ONLINE;

CREATE OR REPLACE PROCEDURE pr_tabuleiro_inicial
AS
--    TYPE pecas brancas   IS VARRAY(16) of NUMERIC(7,3);
    v_tp    tb_tabuleiro_posicao%ROWTYPE;
    i       INTEGER;
    j       INTEGER;
    peca    INTEGER := 1;
BEGIN
    SELECT partida_seq.CURRVAL
    INTO v_tp.id_partida
    FROM DUAL;
    
    FOR i in 1 .. 8 LOOP
        FOR j in 1 .. 8 LOOP
            
            v_tp.linha := i;
            v_tp.coluna := j;
            
            IF MOD((v_tp.linha + v_tp.coluna), 2) = 0 THEN
                v_tp.cor_da_casa := '0'; --casa branca
            ELSE
                v_tp.cor_da_casa := '1'; --casa preta
            END IF;
            
            IF v_tp.linha <= 2 THEN
                peca := peca + 1; --vai de 1 a 16, já na ordem do tabuleiro que foi colocada na tabela
                v_tp.id_peca := peca;
                INSERT INTO tb_tabuleiro_posicao (id_partida, linha, coluna, cor_da_casa, id_peca)
                    VALUES (v_tp.id_partida, v_tp.linha, v_tp.coluna, v_tp.cor_da_casa, v_tp.id_peca);
            ELSIF (i > 2 AND i < 7)  THEN
                peca := 33; --o valor da ultima peca +1
                INSERT INTO tb_tabuleiro_posicao (id_partida, linha, coluna, cor_da_casa)
                    VALUES (v_tp.id_partida, v_tp.linha, v_tp.coluna, v_tp.cor_da_casa);
            ELSE
                peca := peca -1; --vai de 32 a 17, já na ordem do tabuleiro que foi colocada na tabela
                INSERT INTO tb_tabuleiro_posicao (id_partida, linha, coluna, cor_da_casa, id_peca)
                    VALUES (partida, i, j, casa, peca);
            END IF;
        END LOOP;
    END LOOP;
END;
/


CREATE OR REPLACE TRIGGER XZVL01_Jogada
BEFORE
INSERT OR UPDATE OR DELETE
ON tb_jogada
FOR EACH ROW
WHEN (p.nome = 'peao' AND p.cor_peca = 0
                AND(
                        (mov_vertical = 2 AND mov_horizontal = 0
                        AND tpn.id_peca IS NULL
                        AND tpo.linha = 2
                        AND (SELECT tpd.id_peca FROM tb_tabuleiro_posicao tpd
                                WHERE tpd.linha = (tpo.linha + 1)
                                    AND tpd.coluna = tpo.coluna
                                    AND tpd.id_partida = tpn.id_partida) IS NULL)
                      
                      OR (mov_vertical = 1 AND mov_horizontal = 0
                        AND tpn.id_peca IS NULL)
                      
                      OR (mov_vertical = 1 AND mov_horizontal IN (-1, 1)
                        AND tpn.id_peca IS NOT NULL
                        AND p.cor_peca != (SELECT p2.cor_peca
                                            FROM tb_peca p2
                                            WHERE p2.id_peca = tpn.id_peca))
                    )
   )
BEGIN
--LINHA 3
    IF(DELETING) THEN
        RAISE_APPLICATION_ERROR(-20002, 'NAO PODE REMOVER');
    ELSE(UPDATING) THEN
        RAISE_APPLICATION_ERROR(-20003, 'NAO PODE ALTERAR');
    --ELSE
        
    END IF;
END;