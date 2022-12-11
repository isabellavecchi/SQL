CREATE OR REPLACE VIEW isabellav.vw_jogadas_possiveis AS
    SELECT  tpo.id_partida    partida,
            j.id_jogada         jogada,
            --j.id_jogador       jogador,
            tpo.id_peca           peca,
            tpo.linha           linha_anterior,
            tpo.coluna          coluna_anterior,
            j.mov_vertical      mov_vertical,
            j.mov_horizontal    mov_horizontal,
            --tpn.linha           linha_atual,
            --tpn.coluna          coluna_atual
            (CASE peca
              WHEN tpo.id_peca IN   --PEAO
                    (SELECT p.id_peca
                      FROM tb_peca p
                      WHERE p.nome = 'peao')    THEN
                (CASE peao_branco
                  WHEN (SELECT p.cor_peca
                          FROM tb_peca p
                          WHERE p.id_peca = tpo.id_peca) = 0      THEN
                    (CASE mov1 WHEN (tpn.id_peca IS NULL   --exceçao do peao
                        AND j.mov_vertical = 1
                        AND j.mov_horizontal = 0)   THEN 'valido'
                        END)
                    (CASE mov2 WHEN /*(NOT EXISTS (
                      SELECT tpd.id_peca
                      FROM tb_tabuleiro_posicao tpd
                      WHERE tpd.id_partida = tpo.id_partida
                        AND tpd.linha IN (3, 4)
                        AND tpd.coluna = tpo.coluna)
                    AND*/( j.mov_vertical = 2
                    AND j.mov_horizontal = 0)   THEN 'valido'
                    END)
                    (CASE comeu WHEN (tpn.id_peca IS NOT NULL
                    AND (p.cor_peca != (SELECT p.cor_peca
                                          FROM tb_peca p
                                          WHERE p.id_peca = tpn.id_peca))
                    AND j.mov_vertical = 1
                    AND j.mov_horizontal IN (1, -1))    THEN 'valido'
                    END)
                  END)
                (CASE peao_preto WHEN p.cor_peca = 1    THEN
                    (CASE mov1 WHEN (tpn.id_peca IS NULL   --exceçao do peao
                        AND j.mov_vertical = -1
                        AND j.mov_horizontal = 0)   THEN 'valido'
                        END)
                    (CASE mov2 WHEN (j.mov_vertical = -2
                         AND j.mov_horizontal = 0)
                         /*AND (NOT EXISTS (
                            SELECT tpd.id_peca
                              FROM tb_tabuleiro_posicao tpd
                              WHERE tpd.id_partida = tpo.id_partida
                                AND tpd.linha IN (5, 6)
                                AND tpd.coluna = tpo.coluna) IN NULL))*/  THEN 'valido'
                        END)
                    (CASE comeu WHEN (tpn.id_peca IS NOT NULL
                        AND ((SELECT p.cor_peca
                              FROM tb_peca p
                              WHERE p.id_peca = tpo.id_peca)
                            != (SELECT p.cor_peca
                                  FROM tb_peca p
                                  WHERE p.id_peca = tpn.id_peca))
                        AND j.mov_vertical = -1
                        AND j.mov_horizontal IN (1, -1))    THEN 'valido'
                        END)
                    END)
                END)
              
              WHEN NOT EXISTS (
                    SELECT  tpn.linha, tpn.coluna
                      FROM  tb_peca p1,
                            tb_peca p2
                      WHERE tpn.id_peca IS NULL
                            OR p1.id_peca = tpo.id_peca
                            AND p2.id_peca = tpn.id_peca
                            AND p1.cor_peca != p2.cor_peca)
                THEN 'invalido'
              
              WHEN tpo.id_peca IN
                    (SELECT p.id_peca
                      FROM tb_peca p
                      WHERE p.nome NOT IN ('cavalo', 'torre', 'peao'))
                THEN 'peca n definida'
              WHEN tpo.id_peca IN
                    (SELECT p.id_peca
                      FROM tb_peca p
                      WHERE p.nome = 'cavalo')
                AND (j.mov_vertical IN (-1, 1) AND j.mov_horizontal IN (-2, 2)
                  OR j.mov_vertical IN (-2, 2) AND j.mov_horizontal IN (-1, 1))
                THEN 'valido'
              WHEN tpo.id_peca IN
                    (SELECT p.id_peca
                      FROM tb_peca p
                      WHERE p.nome = 'torre')
                AND (
                     (j.mov_vertical = 0 AND j.mov_horizontal != 0
                     *//*AND NOT EXISTS (
                      SELECT tpd.id_peca
                        FROM tb_tabuleiro_posicao tpd
                        WHERE tpd.id_partida = tpo.id_partida
                          AND tpd.linha = tpo.linha
                          AND tpd.coluna IN BETWEEN tpo.coluna AND tpn.coluna
                     )*//*)
                     OR (j.mov_vertical != 0 AND j.mov_horizontal = 0
                     /*AND NOT EXISTS (
                      SELECT tpd.id_peca
                        FROM tb_tabuleiro_posicao tpd
                        WHERE tpd.linha IN BETWEEN tpo.linha AND tpn.linha
                          AND tpd.coluna = tpo.coluna
                     )*//*)
                    )
                THEN 'valido'
              */
              ELSE 'erro'
            END) AS validez
    FROM    tb_jogadas_possiveis j,
            tb_tabuleiro_posicao tpo,
            tb_tabuleiro_posicao tpn,
            tb_peca p
            --tb_validez_movimento vm
    WHERE   p.id_peca = tpo.id_peca
        AND tpn.id_partida = tpo.id_partida
        AND tpn.linha = tpo.linha + j.mov_vertical
        AND tpn.coluna = tpo.coluna + j.mov_horizontal
        AND tpo.linha + j.mov_vertical BETWEEN 1 AND 8
        AND tpo.coluna + j.mov_horizontal BETWEEN 1 AND 8;
        --AND j.id_jogada = 1
    
SELECT *
  FROM vw_jogadas_possiveis
  WHERE peca = 27
          