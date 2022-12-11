CREATE OR REPLACE TRIGGER XZVL01_Jogada
BEFORE
INSERT OR UPDATE OR DELETE
ON tb_jogada
FOR EACH ROW

DECLARE
    e_update_NA             EXCEPTION;
    e_delete_NA             EXCEPTION;
    e_movimento_invalido    EXCEPTION;
BEGIN
--LINHA 3
    IF(DELETING) THEN RAISE e_delete_NA;
    ELSIF(UPDATING) THEN RAISE e_update_NA;
    ELSE
        IF NEW.mov_vertical = 0 THEN RAISE e_movimento_invalido;
    END IF;
    
    EXCEPTION
        WHEN e_movimento_invalido THEN
            dbms_output.put_line('movimento invalido');
        WHEN e_update_NA    THEN
            dbms_output.put_line('nao pode atualizar');
        WHEN e_delete_NA    THEN
            dbms_output.put_line('nao pode deletar');
            
END;