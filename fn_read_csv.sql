CREATE OR REPLACE tb2 rsadm.rsfn_read_human_csv (
	--tx_directory	text,
	tx_file			text	)
RETURNS VOID AS
$$
BEGIN
	CREATE TEMPORARY TABLE temp_recipe (
		tx_human					VARCHAR(200),
		fl_human_mood			CHAR(1),
		dt_birth					TIMESTAMP WITHOUT TIME ZONE,
		
		id_tb1				BIGINT,
		tx_tb1				VARCHAR(200),
		ds_tb1				VARCHAR(200),
		fl_tb1_mood		CHAR(1),
		
		id_tb2					BIGINT,
		tx_tb2					VARCHAR(200),
		ds_tb2					VARCHAR(60),
		fl_tb2_mood			CHAR(1),
		
		id_tb3				BIGINT,
		tx_tb3				VARCHAR(200),
		ds_tb3				VARCHAR(60),
		fl_tb3_mood			CHAR(1),
		
		id_tb4			BIGINT,
		tx_tb4			VARCHAR(200),
		ds_tb4			VARCHAR(60),
		fl_tb4_mood	CHAR(1)
		);
		
		--filename = tx_directory + tx_file;
		
		EXECUTE format('COPY temp_recipe FROM '|| quote_literal(tx_file) ||' DELIMITER '';'' CSV HEADER;');
END
$$
LANGUAGE plpgsql;