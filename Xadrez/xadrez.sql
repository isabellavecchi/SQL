--BEGIN TRANSACTION;

/*
DROP TRIGGER XZVL01_Jogada;
DROP TABLE tb_resultado PURGE;
DROP TABLE tb_historico PURGE;
DROP TABLE tb_jogada PURGE;
DROP table tb_tabuleiro_posicao PURGE;
DROP table tb_partida PURGE;
DROP TABLE tb_jogador PURGE;
DROP TABLE tb_peca PURGE;
DROP SEQUENCE partida_seq;
DROP SEQUENCE jogada_seq;
DROP TABLE tb_validez_movimento PURGE;
*/

--Xadrez

SET SERVEROUTPUT ON;

--DROP SEQUENCE partida_seq
CREATE SEQUENCE partida_seq
    MINVALUE 1
    START WITH 1    --thing, idounou uaaai it dasenlivemerer ral rar iu truai
    INCREMENT BY 1;

--DROP SEQUENCE jogada_seq
CREATE SEQUENCE jogada_seq
    MINVALUE 1
    START WITH 1
    INCREMENT BY 1;

--DROP TABLE tb_peca;
CREATE TABLE tb_peca (
    id_peca         INTEGER,
    cor_peca        CHAR(1)         CHECK (cor_peca in (0, 1)),  -- 1)preta 0)branca
    nome            VARCHAR2(100),
    valor           INTEGER,
    flag_vida       CHAR(1)         CHECK (flag_vida in (0, 1)), -- 1)vivo 0)morto
        CONSTRAINT pk_tb_peca PRIMARY KEY (id_peca)
);

INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (1, 0, 'torre', 5, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (2, 0, 'cavalo', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (3, 0, 'bispo branco', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (4, 0, 'rei', 0, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (5, 0, 'rainha', 9, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (6, 0, 'bispo preto', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (7, 0, 'cavalo', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (8, 0, 'torre', 5, 1);
    
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (9, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (10, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (11, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (12, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (13, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (14, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (15, 0, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (16, 0, 'peao', 1, 1);
    
    
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (17, 1, 'torre', 5, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (18, 1, 'cavalo', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (19, 1, 'bispo branco', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (20, 1, 'rainha', 0, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (21, 1, 'rei', 9, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (22, 1, 'bispo preto', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (23, 1, 'cavalo', 3, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (24, 1, 'torre', 5, 1);
    
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (25, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (26, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (27, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (28, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (29, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (30, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (31, 1, 'peao', 1, 1);
INSERT INTO tb_peca (id_peca, cor_peca, nome, valor, flag_vida)
    VALUES (32, 1, 'peao', 1, 1);

--DROP TABLE tb_jogador;
CREATE TABLE tb_jogador (
    id_jogador      INTEGER,
    username        VARCHAR2(100)   UNIQUE NOT NULL,
    flag_pessoa     CHAR(1)         NOT NULL CHECK (flag_pessoa in (0,1)),   -- 1)pessoa 0)comp
        CONSTRAINT pk_tb_jogador PRIMARY KEY (id_jogador)
);

INSERT INTO tb_jogador (id_jogador, username, flag_pessoa)
    VALUES (1, 'isabellav', 1);
INSERT INTO tb_jogador (id_jogador, username, flag_pessoa)
    VALUES (2, 'mariaf', 1);
INSERT INTO tb_jogador (id_jogador, username, flag_pessoa)
    VALUES (3, 'flavioc', 1);
INSERT INTO tb_jogador (id_jogador, username, flag_pessoa)
    VALUES (4, 'comp', 0);


--DROP TABLE tb_partida;
CREATE TABLE tb_partida (
    id_partida      INTEGER,
    id_jogador_1    INTEGER,
    id_jogador_2    INTEGER,
    inicio          DATE        DEFAULT sysdate,        --duvida
    fim             DATE,
        CONSTRAINT pk_tb_partida PRIMARY KEY (id_partida),
        CONSTRAINT fk_tb_partida_jog_1
            FOREIGN KEY (id_jogador_1)
            REFERENCES tb_jogador (id_jogador),
        CONSTRAINT fk_tb_partida_jog_2
            FOREIGN KEY (id_jogador_2)
            REFERENCES tb_jogador (id_jogador)
);
    
    
--DROP table tb_tabuleiro_posicao;
CREATE TABLE tb_tabuleiro_posicao (
    id_partida      INTEGER,
    linha           INTEGER         CHECK (linha BETWEEN 1 AND 8),
    coluna          INTEGER         CHECK (coluna BETWEEN 1 AND 8),
    cor_da_casa     CHAR(1)         CHECK (cor_da_casa in (0,1)),  -- 1)preta 0)branca
    id_peca         INTEGER,
        CONSTRAINT pk_tb_posicao PRIMARY KEY (id_partida, linha, coluna),
        CONSTRAINT fk_tb_posicao_partida
            FOREIGN KEY (id_partida)
            REFERENCES tb_partida (id_partida),
        CONSTRAINT fk_tb_posicao_peca
            FOREIGN KEY (id_peca)
            REFERENCES tb_peca (id_peca)
);

--vetor
--CREATE OR REPLACE TYPE pecas_brancas IS VARRAY(16) of INTEGER;

--DROP FUNCTION fn_tabuleiro_inicial;

CREATE OR REPLACE PROCEDURE pr_tabuleiro_inicial(
    p_jog1     INTEGER,
    p_jog2     INTEGER)
IS
--    TYPE pecas brancas   IS VARRAY(16) of NUMERIC(7,3);
    partida         INTEGER;
    i               INTEGER;
    j               INTEGER;
    casa            CHAR(1);
    peca            INTEGER := 0;
BEGIN
    partida := partida_seq.NEXTVAL;
    
    INSERT INTO tb_partida (id_partida, id_jogador_1, id_jogador_2, inicio)
        VALUES(partida, p_jog1, p_jog2, SYSDATE);
        
    FOR i in 1 .. 8 LOOP
        FOR j in 1 .. 8 LOOP

            IF MOD((i + j), 2) = 0 THEN
                casa := '0'; --casa branca
            ELSE
                casa := '1'; --casa preta
            END IF;

            IF i <= 2 THEN
                peca := peca + 1; --vai de 1 a 16, já na ordem do tabuleiro que foi colocada na tabela
                INSERT INTO tb_tabuleiro_posicao (id_partida, linha, coluna, cor_da_casa, id_peca)
                    VALUES (partida, i, j, casa, peca);
            ELSIF (i > 2 AND i < 7)  THEN
                peca := 33; --o valor da ultima peca +1
                INSERT INTO tb_tabuleiro_posicao (id_partida, linha, coluna, cor_da_casa)
                    VALUES (partida, i, j, casa);
            ELSE
                peca := peca -1; --vai de 32 a 17, já na ordem do tabuleiro que foi colocada na tabela
                INSERT INTO tb_tabuleiro_posicao (id_partida, linha, coluna, cor_da_casa, id_peca)
                    VALUES (partida, i, j, casa, peca);
            END IF;
        END LOOP;
    END LOOP;

END;
/


BEGIN

    pr_tabuleiro_inicial(1, 2);
    pr_tabuleiro_inicial(2, 3);
END;
/

--DROP TABLE tb_jogada;
CREATE TABLE tb_jogada (
    id_jogada       INTEGER,
    id_partida      INTEGER     NOT NULL,
    id_jogador      INTEGER     NOT NULL,
    id_peca         INTEGER     NOT NULL,
    mov_horizontal  INTEGER     DEFAULT 0,
    mov_vertical    INTEGER     DEFAULT 0,
    inicio          DATE        DEFAULT sysdate,
    comeu           CHAR(1)     CHECK (comeu in (0,1)),     -- 1)true 0)false
    xeque           CHAR(1)     CHECK (xeque in (0,1,2)),   -- 0)nao 1)xeque 2)xeque-mate
        CONSTRAINT pk_tb_jogada PRIMARY KEY (id_jogada),
        CONSTRAINT fk_tb_jogada_partida
            FOREIGN KEY (id_partida)
            REFERENCES tb_partida (id_partida),
        CONSTRAINT fk_jogada_jog
            FOREIGN KEY (id_jogador)
            REFERENCES tb_jogador (id_jogador),
        CONSTRAINT fk_jogada_peca
            FOREIGN KEY (id_peca)
            REFERENCES tb_peca (id_peca)
);

--jogadas validas
--PEAO
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 1, 12, 0, 1);

/*UPDATE tb_tabuleiro_posicao
SET id_peca =   (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
WHERE linha = ( SELECT (tbo.linha + j.mov_vertical)
                  FROM  tb_tabuleiro_posicao tbo,
                        tb_jogada j
                  WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                        FROM tb_jogada jg)
                    AND tbo.id_jogada = j.id_jogada
              );
  */

UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 12
    WHERE id_partida = 1
      AND linha = 3
      AND coluna = 4;

--peao
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 2, 29, 0, -2);
    

UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 29
    WHERE id_partida = 1
      AND linha = 5
      AND coluna = 4;

--cavalo mov. valido
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 1, 2, 2, 1);
    

UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 2
    WHERE id_partida = 1
      AND linha = 2
      AND coluna = 4;

--peao da torre
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 2, 25, 0, -2);
    
UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 25
    WHERE id_partida = 1
      AND linha = 5
      AND coluna = 8;

--peao p/ rolar o fight
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 1, 13, 0, 2);
    
UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 13
    WHERE id_partida = 1
      AND linha = 4
      AND coluna = 5;


--torre mov. valido
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 2, 17, 0, -2);
    
UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 17
    WHERE id_partida = 1
      AND linha = 6
      AND coluna = 8;
      
--peao comendo peao      
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 1, 13, -1, 1);
    
UPDATE tb_tabuleiro_posicao
SET id_peca = NULL
WHERE id_peca = (    SELECT j.id_peca
                        FROM tb_jogada j
                        WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                FROM tb_jogada jg)
                )
    AND id_partida = (  SELECT j.id_partida
                          FROM tb_jogada j
                          WHERE j.id_jogada = (SELECT MAX(jg.id_jogada)
                                                 FROM tb_jogada jg)
                     );

UPDATE tb_tabuleiro_posicao
    SET id_peca = 13
    WHERE id_partida = 1
      AND linha = 5
      AND coluna = 4;


   
--jogadas invalidas    
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 1, 12, 120, 120);
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 2, 29, 240, 241);

INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 2, 17, -3, -2);  --torre mov.invalido

INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 3, 23, -3, -4);  --cavalo mov. invalido
    
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 2, 7, -2, 2);  --cavalo mov. invalido


INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 2, 11, -3, -4);  --peao mov. invalido


--jogada com peca n definida
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 2, 3, 2, 2);  --BISPO

/*    
--validas_restante    
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 1, 2, 2, 1);
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 1, 2, 28, 0, -1);

INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 3, 29, 0, -2);
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 2, 2, 2, 1);
INSERT INTO tb_jogada (id_jogada, id_partida, id_jogador, id_peca, mov_horizontal, mov_vertical)
    VALUES (jogada_seq.NEXTVAL, 2, 3, 28, 0, -1);
*/

CREATE TABLE tb_historico (
    id_jogada               INTEGER,
    id_partida              INTEGER,
    linha_old               INTEGER,
    coluna_old              INTEGER,
    linha_new               INTEGER,
    coluna_new              INTEGER,
        CONSTRAINT pk_tb_hstr_jogada PRIMARY KEY (id_jogada),
        CONSTRAINT fk_tb_hstr_jogada
            FOREIGN KEY (id_jogada)
            REFERENCES tb_jogada (id_jogada),
        CONSTRAINT fk_tb_hstr_posicao_old
            FOREIGN KEY (id_partida, linha_old, coluna_old)
            REFERENCES tb_tabuleiro_posicao (id_partida, linha, coluna),
        CONSTRAINT fk_tb_hstr_posicao_new
            FOREIGN KEY (id_partida, linha_new, coluna_new)
            REFERENCES tb_tabuleiro_posicao (id_partida, linha, coluna)
);


--DROP TABLE tb_resultado;
CREATE TABLE tb_resultado (
    id_jogador      INTEGER     NOT NULL,
    id_partida      INTEGER     NOT NULL,
    resultado       CHAR(1)     CHECK (resultado in (0, 1, 2)), -- 0)derrota 1)empate 2)vitoria
        CONSTRAINT pk_tb_resultado PRIMARY KEY (id_jogador, id_partida)
);
/*
--DROP TABLE tb_validez_movimento;
CREATE TABLE tb_validez_movimento (
    validez         VARCHAR2(32)    CHECK (validez in ('valido', 'invalido'))   NOT NULL
);

INSERT INTO tb_validez_movimento
    VALUES ('valido');
INSERT INTO tb_validez_movimento
    VALUES ('invalido');
*/


--CREATE INDEX idx_partida_jogada_cor
--  ON tb_historico (id_jogada);

CREATE OR REPLACE VIEW vw_jogada AS
    --selecionando as jogadas em que a posicao final eh possivel
    SELECT  tpo.id_partida    partida,
            j.id_jogada         jogada,
            tpo.id_peca           peca,
            tpo.linha           linha_anterior,
            tpo.coluna          coluna_anterior,
            j.mov_vertical      mov_vertical,
            j.mov_horizontal    mov_horizontal,
            (CASE
            --OUTRAS PECAS
            WHEN p.nome NOT IN ('cavalo', 'torre', 'peao')
              THEN 'peca n definida'
            
            --PEAO BRANCO
            
            WHEN p.nome = 'peao' AND p.cor_peca = 0
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
                      THEN 'valido'
            
             --PEAO PRETO
            WHEN p.nome = 'peao' AND p.cor_peca = 1
                AND(
                        (mov_vertical = -2 AND mov_horizontal = 0
                        AND tpn.id_peca IS NULL
                        AND tpo.linha = 7
                        AND (SELECT tpd.id_peca FROM tb_tabuleiro_posicao tpd
                                WHERE tpd.linha = (tpo.linha - 1)
                                    AND tpd.coluna = tpo.coluna
                                    AND tpd.id_partida = tpn.id_partida) IS NULL)
                      OR (mov_vertical = -1 AND mov_horizontal = 0
                            AND tpn.id_peca IS NULL)
                        
                        OR (mov_vertical = -1 AND mov_horizontal IN (-1, 1)
                            AND tpn.id_peca IS NOT NULL
                            AND p.cor_peca != (SELECT p2.cor_peca
                                                FROM tb_peca p2
                                                WHERE p2.id_peca = tpn.id_peca))
                        )
              THEN 'valido'
            
            --se a casa destino estiver ocupada e for uma peca da mesma cor, o movimento será inválido
            --(separado do peao pois este possui regra própria neste caso)
            WHEN tpn.id_peca IS NOT NULL
                AND p.cor_peca = (SELECT p2.cor_peca FROM tb_peca p2 WHERE p2.id_peca = tpn.id_peca)
              THEN 'invalido'

            --CAVALO
            WHEN p.nome = 'cavalo'
                AND (j.mov_vertical IN (-1, 1) AND j.mov_horizontal IN (-2, 2)
                  OR j.mov_vertical IN (-2, 2) AND j.mov_horizontal IN (-1, 1))
              THEN 'valido'

            --TORRE
            WHEN p.nome = 'torre'
              THEN
              (CASE
                    WHEN mov_vertical > 0 AND mov_horizontal = 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.linha > tpo.linha AND tpd.linha < tpn.linha)
                                        AND tpd.coluna = tpo.coluna
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                      
                    WHEN mov_vertical < 0 AND mov_horizontal = 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.linha > tpn.linha AND tpd.linha < tpo.linha)
                                        AND tpd.coluna = tpo.coluna
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                      
                    WHEN mov_vertical = 0 AND mov_horizontal > 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.coluna > tpo.coluna AND tpd.coluna < tpn.coluna)
                                        AND tpd.linha = tpo.linha
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                      
                    WHEN mov_vertical = 0 AND mov_horizontal < 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.coluna > tpn.coluna AND tpd.coluna < tpo.coluna)
                                        AND tpd.linha = tpo.linha
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                    
                    ELSE 'invalido'
              END)
              
            ELSE 'invalido'
            
            END) AS validez
    FROM    tb_jogada j,
            tb_tabuleiro_posicao tpo,
            tb_tabuleiro_posicao tpn,
            tb_peca p
    WHERE   j.id_partida = tpo.id_partida
        AND j.id_partida = tpn.id_partida
        AND j.id_peca = tpo.id_peca
        AND tpn.linha = tpo.linha + j.mov_vertical
        AND tpn.coluna = tpo.coluna + j.mov_horizontal
        AND p.id_peca = tpo.id_peca;

SELECT * FROM vw_jogada;

CREATE OR REPLACE VIEW vw_jogadas_possiveis AS
    SELECT
        tpo.id_partida      partida,
        j.id_jogada         jogada,
        tpo.id_peca         id_peca,
        tpo.linha           linha_atual,
        tpo.coluna          coluna_atual,
        j.mov_vertical      mov_vertical,
        j.mov_horizontal    mov_horizontal,
        (CASE
            --OUTRAS PECAS
            WHEN p.nome NOT IN ('cavalo', 'torre', 'peao')
              THEN 'peca n definida'
            
            --PEAO BRANCO
            
            WHEN p.nome = 'peao' AND p.cor_peca = 0
                AND(
                        (mov_vertical = 2 AND mov_horizontal = 0
                        AND tpn.id_peca IS NULL
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
                      THEN 'valido'
            
             --PEAO PRETO
            WHEN p.nome = 'peao' AND p.cor_peca = 1
                AND(
                        (mov_vertical = -2 AND mov_horizontal = 0
                        AND tpn.id_peca IS NULL
                        AND (SELECT tpd.id_peca FROM tb_tabuleiro_posicao tpd
                                WHERE tpd.linha = (tpo.linha - 1)
                                    AND tpd.coluna = tpo.coluna
                                    AND tpd.id_partida = tpn.id_partida) IS NULL)
                      OR (mov_vertical = -1 AND mov_horizontal = 0
                            AND tpn.id_peca IS NULL)
                        
                        OR (mov_vertical = -1 AND mov_horizontal IN (-1, 1)
                            AND tpn.id_peca IS NOT NULL
                            AND p.cor_peca != (SELECT p2.cor_peca
                                                FROM tb_peca p2
                                                WHERE p2.id_peca = tpn.id_peca))
                        )
              THEN 'valido'
            
            --se a casa destino estiver ocupada e for uma peca da mesma cor, o movimento será inválido
            --(separado do peao pois este possui regra própria neste caso)
            WHEN tpn.id_peca IS NOT NULL
                AND p.cor_peca = (SELECT p2.cor_peca FROM tb_peca p2 WHERE p2.id_peca = tpn.id_peca)
              THEN 'invalido'

            --CAVALO
            WHEN p.nome = 'cavalo'
                AND (j.mov_vertical IN (-1, 1) AND j.mov_horizontal IN (-2, 2)
                  OR j.mov_vertical IN (-2, 2) AND j.mov_horizontal IN (-1, 1))
              THEN 'valido'

            --TORRE
            WHEN p.nome = 'torre'
              THEN
              (CASE
                    WHEN mov_vertical > 0 AND mov_horizontal = 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.linha > tpo.linha AND tpd.linha < tpn.linha)
                                        AND tpd.coluna = tpo.coluna
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                      
                    WHEN mov_vertical < 0 AND mov_horizontal = 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.linha > tpn.linha AND tpd.linha < tpo.linha)
                                        AND tpd.coluna = tpo.coluna
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                      
                    WHEN mov_vertical = 0 AND mov_horizontal > 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.coluna > tpo.coluna AND tpd.coluna < tpn.coluna)
                                        AND tpd.linha = tpo.linha
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                      
                    WHEN mov_vertical = 0 AND mov_horizontal < 0
                        AND NOT EXISTS (
                                    SELECT 'X'
                                      FROM tb_tabuleiro_posicao tpd
                                      WHERE tpd.id_peca IS NOT NULL
                                        AND (tpd.coluna > tpn.coluna AND tpd.coluna < tpo.coluna)
                                        AND tpd.linha = tpo.linha
                                        AND tpd.id_partida = tpn.id_partida
                                    )
                      THEN 'valido'
                    
                    ELSE 'invalido'
              END)
              
            ELSE 'invalido'

        END) Validez
      FROM
        tb_jogadas_possiveis j,
        tb_tabuleiro_posicao tpo,   --old
        tb_tabuleiro_posicao tpn,   --new
        tb_peca p
      WHERE
        p.id_peca = tpo.id_peca AND
        tpo.id_partida = tpn.id_partida AND
        tpn.linha = tpo.linha + j.mov_vertical AND
        tpn.coluna = tpo.coluna + j.mov_horizontal; /*AND
        (tpo.linha + j.mov_vertical BETWEEN 1 AND 8) AND
        (tpo.coluna + j.mov_horizontal BETWEEN 1 AND 8);*/
        
SELECT * FROM vw_jogadas_possiveis
    WHERE partida = 1
        AND mov_horizontal = 0
        AND id_peca = &id_peca  --input
        AND validez IS NOT NULL;

SELECT * FROM vw_jogadas_possiveis
    WHERE partida = 1
        AND id_peca = 13
        AND validez IS NOT NULL;

  
  
  
ROLLBACK;   --COMMIT;
