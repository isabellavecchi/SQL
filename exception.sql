--VARIÁVEIS EXCEPTION  

/*
* 1. Declare uma variável do tipo EXCEPTION
* 2. Raise the exception    (aviso pro compilador que ela existe)
* 3. Handle the exception   (trato o que deve ser feito
*/

DECLARE
    v_dividendo     NUMBER := 24;
    v_divisor       NUMBER := 0;
    v_resultado     NUMBER;
    ex_divZero      EXCEPTION;
BEGIN
    IF v_divisor = 0 THEN
        RAISE ex_divZero;
    END IF;
    
    v_resultado := v_dividendo/v_divisor;
    DBMS_OUTPUT.PUT_LINE('Resultado = ' || v_resultado);
    EXCEPTION WHEN ex_divZero THEN
        dbms_output.put_line ('ERROR');
END;


SET SERVEROUTPUT ON;


--USER-DEFINE EXCEPTION
    --RAISE_APPLICATION_ERROR

--comando para aparecer uma mensagem na janela de pop-up
ACCEPT var_age NUMBER PROMPT 'What is your AGE?';
DECLARE
    age     NUMBER := &var_age;
BEGIN
    IF age < 18 THEN
        RAISE_APPLICATION_ERROR(-20008, 'PROIBIDO PARA MENORES');
    END IF;
    
        DBMS_OUTPUT.put_line('vc pode');
        
        EXCEPTION WHEN OTHERS THEN
            DBMS_OUTPUT.put_line(SQLERRM);
END;


--PRAGMA EXCEPTION_INIT
--podemos associar uma exception a um número nativo do Oracle
--podendo inclusive manipular a exception
DECLARE
    ex_age  EXCEPTION;
    age     NUMBER  := 17;
    PRAGMA EXCEPTION_INIT(ex_age, -20008);
    --PRAGMA EXCEPTION_INIT(exception_name, error_number);
BEGIN
    IF age < 18 THEN
        RAISE_APPLICATION_ERROR(-20008, 'MENOR');
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Que que cê quer beber?');
    
    EXCEPTION WHEN ex_age THEN
            DBMS_OUTPUT.PUT_LINE(SQLERRM);

END;