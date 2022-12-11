CREATE OR REPLACE PROCEDURE TESTE_PROCEDURE (
    p_entrada   IN      NUMBER, --P_PARAMETRO
    p_saida     OUT     NUMBER,
    p_misto     IN OUT  NUMBER
)
IS
    v_teste1     NUMBER := 5;   --v_variavel
BEGIN
    dbms_output.put_line('Recebi: ' || p_entrada);
    dbms_output.put_line('Recebi também: ' || p_misto);
    p_saida := 1;
    p_misto := 2;
EXCEPTION
    WHEN OTHERS THEN
            dbms_output.put_line('ERRO: ' || SQLERRM);
END teste_procedure;

