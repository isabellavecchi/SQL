CREATE OR REPLACE VIEW vw_jogada AS
    --selecionando as jogadas em que a posicao final eh possivel
    SELECT  --j.id_partida    partida,
            j.id_jogada         jogada,
            --j.id_jogador       jogador,
            j.id_peca           peca,
            tpo.linha           linha_anterior,
            tpo.coluna          coluna_anterior,
            j.mov_vertical      mov_vertical,
            j.mov_horizontal    mov_horizontal,
            --tpn.linha           linha_atual,
            --tpn.coluna          coluna_atual
            vm.validez          validez
    FROM    tb_jogada j,
            tb_tabuleiro_posicao tpo,
            tb_tabuleiro_posicao tpn,
            tb_validez_movimento vm
    WHERE   j.id_partida = tpo.id_partida
        AND j.id_partida = tpn.id_partida
        AND j.id_peca = tpo.id_peca
        --AND j.id_jogada = 1 (20)
        AND NOT ( NOT EXISTS (  --todas as condicoes de existencia satisfeitas
            SELECT  tpn.linha, tpn.coluna
              FROM  tb_tabuleiro_posicao tpn,
                    tb_tabuleiro_posicao tpo,
                    tb_peca p1,
                    tb_peca p2
              WHERE tpn.linha = tpo.linha + j.mov_vertical
                AND tpn.coluna = tpo.coluna + j.mov_horizontal
                AND (tpn.id_peca IS NULL
                    OR p1.id_peca = tpo.id_peca
                    AND p2.id_peca = tpn.id_peca
                    AND p1.cor_peca != p2.cor_peca)
                ))
                --selecionando as jogadas pelos movimentos das peças
                --cavalo
                AND (j.id_peca IN
                                (SELECT p.id_peca
                                  FROM tb_peca p
                                  WHERE p.nome = 'cavalo')
                    AND (   vm.validez = 'valido' --(40)
                            AND mov_vertical IN (-1, 1) AND mov_horizontal IN (-2, 2)
                            OR mov_vertical IN (-2, 2) AND mov_horizontal IN (-1, 1)    
                        OR( vm.validez = 'invalido'
                            AND NOT ( mov_vertical IN (-1, 1) AND mov_horizontal IN (-2, 2)
                            OR mov_vertical IN (-2, 2) AND mov_horizontal IN (-1, 1))   )
                    ) )
                --torre
                AND (j.id_peca IN
                                (SELECT p.id_peca
                                  FROM tb_peca p
                                  WHERE p.nome = 'torre')
                    AND (   vm.validez = 'valido'
                            AND ((mov_vertical = 0 AND mov_horizontal != 0)
                                OR (mov_vertical != 0 AND mov_horizontal = 0))    )
                    --ver caminho do movimento
                    OR  (   vm.validez = 'invalido'
                            AND ((mov_vertical = 0 AND mov_horizontal = 0)
                                OR (mov_vertical != 0 AND mov_horizontal != 0))    )
                    )
                --peao
                AND (j.id_peca IN
                                (SELECT p.id_peca
                                  FROM tb_peca p
                                  WHERE p.nome = 'peao')
                    AND (   vm.validez = 'valido'
                        AND ((  tpn.id_peca IS NULL)    --exceçao do peao
                                AND j.mov_vertical = 1
                                AND j.mov_horizontal = 0
                            OR( tpo.linha = 2 --(70)
                                AND tpn.id_peca IS NULL
                                AND j.mov_vertical = 2
                                AND j.mov_horizontal = 0)
                            OR( EXISTS (
                                    SELECT  p2.id_peca
                                      FROM  tb_tabuleiro_posicao tpn,
                                            tb_tabuleiro_posicao tpo,
                                            tb_peca p1,
                                            tb_peca p2
                                      WHERE tpn.linha = tpo.linha + j.mov_vertical
                                        AND tpn.coluna = tpo.coluna + j.mov_horizontal
                                        AND p1.id_peca = tpo.id_peca
                                            AND p2.id_peca = tpn.id_peca
                                            AND p1.cor_peca != p2.cor_peca)
                            )
                                AND mov_vertical = 1
                                AND mov_horizontal IN (1, -1))
                        )
            )
UNION
    --selecionando as jogadas invalidadas pela posicao final
    SELECT  --j.id_partida    partida,
            j.id_jogada         jogada,
            --j.id_jogador       jogador,
            j.id_peca           peca,
            tpo.linha           linha_anterior,
            tpo.coluna          coluna_anterior,
            j.mov_vertical      mov_vertical,
            j.mov_horizontal    mov_horizontal,
            --tpn.linha           linha_atual,
            --tpn.coluna          coluna_atual,
            vm.validez
    FROM    tb_jogada j,
            tb_tabuleiro_posicao tpo,
            tb_tabuleiro_posicao tpn,
            tb_validez_movimento vm
    WHERE   vm.validez = 'invalido'
        AND j.id_partida = tpo.id_partida
        AND j.id_partida = tpn.id_partida
        AND j.id_peca = tpo.id_peca
        --AND j.id_jogada = 16
        AND NOT EXISTS (
            SELECT  tpn.linha, tpn.coluna
              FROM  tb_tabuleiro_posicao tpn,
                    tb_tabuleiro_posicao tpo,
                    tb_peca p1,
                    tb_peca p2
              WHERE tpn.linha = tpo.linha + j.mov_vertical
                AND tpn.coluna = tpo.coluna + j.mov_horizontal
                AND (tpn.id_peca IS NULL
                    OR p1.id_peca = tpo.id_peca
                    AND p2.id_peca = tpn.id_peca
                    AND p1.cor_peca != p2.cor_peca)
                );

SELECT *
  FROM vw_jogada;
