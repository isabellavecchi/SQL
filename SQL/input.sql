DECLARE
    v_valor_input   CHAR(1) := '&INPUT';
    v_valor_out     NUMBER;
BEGIN
    SELECT COUNT (1)
      INTO v_valor_out
      FROM DUAL
      WHERE dummy = 'X'
    
    dbms_output.put_line(v_valor_out);
END;

DECLARE
    v_valor_input   CHAR(1) := '&"Entre com o ca==valor do input"';
    v_valor_out     NUMBER;
BEGIN    
    dbms_output.put_line(v_valor_out);
END;
