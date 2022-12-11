--DROP PROCEDURE public.pr_atualiza_sequence;

CREATE OR REPLACE FUNCTION public.fn_update_sequence (
	p_schema		text,
	p_name			text	)
/*
*	Função para atualizar o valor de qualquer sequence
*	Caso queira atualizar a sequence, por exemplo schema1.sq_human, entre com os parâmetros:
*	schema1, human.
*/
RETURNS INTEGER AS
$$
DECLARE
	v_sequence		text;
	v_table			text;
	v_id			text;
	v_max			BIGINT;
	v_codigo		INTEGER;
BEGIN
	v_codigo := 0;
	v_sequence	:= p_schema || '.'|| SUBSTRING(p_schema, 1, 2) || 'sq_' || p_name;
	v_table 	:= p_schema || '.'|| SUBSTRING(p_schema, 1, 2) || 'tb_' || p_name;
	v_id		:= 'id_' || p_name;
	
	EXECUTE format('SELECT MAX(' || v_id || ') FROM ' || v_table || ';')
	INTO v_max;
	
	EXECUTE format('SELECT setval(' || quote_literal(v_sequence) || ', ' || v_max || ');');
	
	RETURN v_codigo;
	
	EXCEPTION
		WHEN OTHERS THEN
		v_codigo:= 1 ;
		RETURN v_codigo;
		RAISE EXCEPTION 'Confira se as entradas da funcao de atualizar sequences estão corretas.
	Nomes gerados para a execução do código:
		tabela   - 	%;
		sequence - 	%', v_table, v_sequence;

END
$$
LANGUAGE plpgsql;
/*

GRANT ALL ON FUNCTION public.fn_update_sequence TO current_user;

CREATE TABLE dual();
--SELECT public.fn_update_sequence('schema1','tb1') FROM dual;

SELECT * FROM public.fn_update_sequence('schema1','tb1');

SELECT * FROM schema1.tb_tb1 ORDER BY id_tb1 DESC;

SELECT NEXTVAL('schema1.sq_tb1')

SELECT id_tb FROM schema2.tb2 ORDER BY id_tb DESC

GRANT ALL ON TABLE public.dual TO current_user
*/