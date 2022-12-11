--DROP tb2 schema1.fn_registration;

CREATE OR REPLACE tb2 schema1.fn_registration (
	--nm_directory	text,
	nm_file			text,
	vl_location		schema1.permanent_tb1.id_location%TYPE)
RETURNS INTEGER AS
$$
DECLARE
	r			RECORD;
	filename	text;
	v1_string	VARCHAR(100);
	v2_string	VARCHAR(200);
	v3_int		INTEGER := 0;
	v4_string	VARCHAR(100);
	
	v_error_file text:='/path/to/'|| CURRENT_DATE || '-log_file.csv';
	
	--PASTA COM OS DOCUMENTOS (TANTO DE ENTRADA QUANTO DE SAÍDA):
	--	mkdir -p /path/to/docs
	--	chown postgres:postgres /path/to/docs
BEGIN
	--################ ATUALIZANDO SEQUENCES #################
	--TRUNCATE A TABELA "TEMPORÁRIA"
	v3_int := (	SELECT	a.* + b.* + c.* + d.* + e.*
					FROM	public.fn_update_sequence('schema1','tb1') a,
							public.fn_update_sequence('schema1','tb1_type') b,
							public.fn_update_sequence('schema1','tb2') c,
							public.fn_update_sequence('schema1','tb3') d,
							public.fn_update_sequence('schema1','tb3_type') e);
	IF v3_int <> 0 THEN
		v4_string := 'Problema em ' || v3_int || ' sequence(s)';
		EXECUTE format('COPY (SELECT ' || quote_literal(v4_string) || ' AS "ERROR_MSG") TO ' || quote_literal(v_error_file) || ' DELIMITER '';'' CSV HEADER;');
		RETURN 1;
	END IF;
	
	--#########################################################################

	--################ CRIANDO TABELA TEMPORÁRIA PARA RECEBER DADOS ###########
	CREATE TEMPORARY TABLE tb_temp (
		tx_tb1					VARCHAR(200),
		fl_tb1_status			CHAR(1),
		date_something					VARCHAR(100),
		
		id_tb1_type				BIGINT,
		tx_tb1_type				VARCHAR(200),
		ds_tb1_type				VARCHAR(200),
		fl_tb1_type_status		CHAR(1),
		
		id_tb2					BIGINT,
		nm_tb2					VARCHAR(200),
		ds_tb2					VARCHAR(60),
		fl_tb2_status			CHAR(1),
		
		id_tb3				BIGINT,
		nm_tb3				VARCHAR(200),
		ds_tb3				VARCHAR(60),
		fl_tb3_status			CHAR(1),
		
		id_tb3_type			BIGINT,
		nm_tb3_type			VARCHAR(200),
		ds_tb3_type			VARCHAR(60),
		fl_tb3_type_status	CHAR(1)
		);
		
		EXECUTE format('COPY tb_temp FROM '|| quote_literal(nm_file) ||' DELIMITER '';'' CSV HEADER;');
		
		--#########################################################################
		
		--Adicionando Coluna de logs
		ALTER TABLE tb_temp ADD COLUMN log_de_erro VARCHAR(200);
		
		--##########	INSERE DADOS NO BANCO	###########
		FOR a IN SELECT * FROM tb_temp
		LOOP
		
			--Função que transforma o nome em username
			v1_string := (SELECT schema1.fn_createUsername(a.tx_tb1));
				--funcao que cria o username, a partir do nome, automaticamente de acordo com o padr'ao da empresa
			IF v1_string LIKE '' THEN
				v3_int := 1;
				UPDATE tb_temp
				   SET log_de_erro = 'username invalido'
				 WHERE tx_tb1 = a.tx_tb1;
			END IF;
			v2_string := v1_string || '@email.br';
			
			--v3_int = 0 -> SUCESSO
			--v3_int != 0 -> FALHA
			IF v3_int = 0 THEN
				INSERT INTO schema1.permanent_tb1(
					id_tb1,
					id_tb1_type,
					id_tb2,
					num_username,
					tx_tb1,
					date_something,
					id_location,
					fl_status,
					dt_started_from)
				VALUES (
					nextval('schema1.sq_tb1'),
					a.id_tb1_type,
					a.id_tb2,
					v1_string,
					a.tx_tb1,
					TO_DATE(a.date_something,'YYYY-MM-DD'),
					vl_location,
					a.fl_tb1_status,
					CURRENT_DATE);
				END IF;
			
				IF v3_int = 0 THEN
					--deletar a linha que deu sucesso em tudo ou deixar o log de erro nulo e vida que segue
				END IF
			
		END LOOP;
		EXECUTE format('COPY (SELECT * FROM tb_temp ~~~NULLS LAST~~~ ) TO ' || quote_literal(v_error_file) || ' DELIMITER '';'' CSV HEADER;');
				
		RETURN 0;
		
		EXCEPTION
			WHEN bad_copy_file_format THEN
				EXECUTE format('COPY (SELECT ' || quote_literal(SQLERRM) || ' AS "ERROR_MSG") TO ' || quote_literal(v_error_file) || ' DELIMITER '';'' CSV HEADER;');
				RETURN 2;
			WHEN sqlstate '22007' THEN
				EXECUTE format('COPY (SELECT ' || quote_literal(SQLERRM) || ' AS "ERROR_MSG") TO ' || quote_literal(v_error_file) || ' DELIMITER '';'' CSV HEADER;');
				RETURN 2;
			WHEN OTHERS THEN
				EXECUTE format('COPY (SELECT ' || quote_literal(SQLERRM) || ' AS "ERROR_MSG") TO ' || quote_literal(v_error_file) || ' DELIMITER '';'' CSV HEADER;');
				RETURN 3;
END
$$
LANGUAGE plpgsql;