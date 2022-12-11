        --TABLES

--DROP TABLE tb_Viagem;
CREATE TABLE tb_Viagem (
    Localizacao         INTEGER         CONSTRAINT pk_location  PRIMARY KEY,
    Longitude           NUMERIC(12,7)   CONSTRAINT nn_longitude NOT NULL,
    Latitude            NUMERIC(12,7)   CONSTRAINT nn_latitude  NOT NULL,
    Arrived             TIMESTAMP       CONSTRAINT un_arrival   UNIQUE,
    GallonsArrival      NUMERIC(8,4),
    Departed            TIMESTAMP       CONSTRAINT un_departure UNIQUE,
    GallonsDeparture    NUMERIC(8,4)
);

--DROP TABLE tb_miles_per_gallon;
CREATE TABLE tb_miles_per_gallon (
    Id_                 INTEGER         CONSTRAINT pk_id    PRIMARY KEY,
    Origin              INTEGER     references tb_Viagem(Localizacao),
    Destination         INTEGER     references tb_Viagem(Localizacao),
    Miles               NUMERIC(9,4),
    Gallons             NUMERIC(8,4),
    Miles_per_Gallon    NUMERIC(8,4)   
);


SET DEFINE OFF
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (1, -75.948486, 41.054502, NULL, NULL, to_timestamp('7.16.19 7:33', 'MM.DD.YY HH24:MI'), 16);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (2, -80.837402, 41.112469, to_timestamp('7.16.19 13:02', 'MM.DD.YY HH24:MI'), 68, to_timestamp('7.16.19 13:48', 'MM.DD.YY HH24:MI'), 16);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (3, -82.122803, 41.393294, to_timestamp('7.16.19 15:10', 'MM.DD.YY HH24:MI'), 137, to_timestamp('7.16.19 15:17', 'MM.DD.YY HH24:MI'), 137);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (4, -85.03418, 41.697526, to_timestamp('7.16.19 17:38', 'MM.DD.YY HH24:MI'), 86, to_timestamp('7.16.19 19:09', 'MM.DD.YY HH24:MI'), 86);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (5, -87.297363, 41.574361, to_timestamp('7.16.19 21:40', 'MM.DD.YY HH24:MI'), 41, to_timestamp('7.17.19 7:46', 'MM.DD.YY HH24:MI'), 16);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (6, -89.187012, 41.368564, to_timestamp('7.17.19 9:22', 'MM.DD.YY HH24:MI'), 13, to_timestamp('7.17.19 9:46', 'MM.DD.YY HH24:MI'), 13);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (7, -91.647949, 41.672912, to_timestamp('7.17.19 12:28', 'MM.DD.YY HH24:MI'), 82, to_timestamp('7.17.19 13:06', 'MM.DD.YY HH24:MI'), 82);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (8, -93.614502, 41.607228, to_timestamp('7.17.19 14:41', 'MM.DD.YY HH24:MI'), 49, to_timestamp('7.17.19 14:46', 'MM.DD.YY HH24:MI'), 16);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (9, -95.910645, 41.483891, to_timestamp('7.17.19 16:57', 'MM.DD.YY HH24:MI'), 122, to_timestamp('7.17.19 17:53', 'MM.DD.YY HH24:MI'), 122);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (10, -96.405029, 42.463993, to_timestamp('7.17.19 19:01', 'MM.DD.YY HH24:MI'), 97, to_timestamp('7.17.19 19:14', 'MM.DD.YY HH24:MI'), 97);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (11, -98.448486, 42.317939, to_timestamp('7.17.19 21:05', 'MM.DD.YY HH24:MI'), 63, to_timestamp('7.18.19 8:35', 'MM.DD.YY HH24:MI'), 16);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (12, -100.788574, 42.892064, to_timestamp('7.18.19 10:51', 'MM.DD.YY HH24:MI'), 116, to_timestamp('7.18.19 12:39', 'MM.DD.YY HH24:MI'), 116);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (13, -105.13916, 42.666281, to_timestamp('7.18.19 16:38', 'MM.DD.YY HH24:MI'), 45, to_timestamp('7.18.19 18:03', 'MM.DD.YY HH24:MI'), 16);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (14, -108.083496, 43.245203, to_timestamp('7.18.19 20:27', 'MM.DD.YY HH24:MI'), 109, to_timestamp('7.19.19 8:14', 'MM.DD.YY HH24:MI'), 109);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (15, -108.050537, 44.465151, to_timestamp('7.19.19 10:07', 'MM.DD.YY HH24:MI'), 8, to_timestamp('7.19.19 10:27', 'MM.DD.YY HH24:MI'), 8);
INSERT INTO TB_VIAGEM (LOCALIZACAO, LONGITUDE, LATITUDE, ARRIVED, GALLONSARRIVAL, DEPARTED, GALLONSDEPARTURE) 
VALUES (16, -110.269775, 44.504341, to_timestamp('7.19.19 12:49', 'MM.DD.YY HH24:MI'), 42, NULL, NULL);
-- Import Data into table TB_VIAGEM from file Data_Enginner_Challenge_Dataset.xlsx . Task successful and sent to worksheet.



--Função para consertar os dados referentes aos Galões de gasolina
--utilizando vetor para simplificar.

--DROP TYPE escultor;
CREATE OR REPLACE TYPE escultor IS VARRAY(15) of NUMERIC(7,3);

CREATE OR REPLACE FUNCTION fn_escultor
RETURN VARCHAR
AS
    TYPE escultor   IS VARRAY(15) of NUMERIC(7,3);
    galao_chegada   escultor;
    galao_saida     escultor;
    i               INTEGER;
BEGIN
    galao_chegada := escultor(6.8, 13.7, 8.6, 4.1, 13, 8.2, 4.9, 12.2, 9.7, 6.3, 11.6, 4.5, 10.9, 8, 4.2);
    galao_saida := escultor(16, 16, 13.7, 8.6, 16, 13, 8.2, 16, 12.2, 9.7, 16, 11.6, 16, 10.9, 8);
    
    FOR i in 1 .. 15 LOOP
        UPDATE tb_Viagem
        SET GallonsArrival = galao_chegada(i)
        WHERE localizacao = i + 1;     --utilizei 'i + 1' para n precisar de 2 laços
        
        UPDATE tb_Viagem
        SET GallonsDeparture = galao_saida(i)
        WHERE localizacao = i;
    END LOOP;
    RETURN 'Dados dos galões consertados com sucesso!';
END;
/


--DESAFIO 2

--Função que insere os dados na tabela tb_miles_per_gallon

--DROP FUNCTION fn_desafio2;
CREATE OR REPLACE FUNCTION fn_desafio2
    RETURN VARCHAR
    AS
        contador    INTEGER;
        indice1     INTEGER;
        indice2     INTEGER;
        indice      INTEGER := 0;
        milhas      NUMERIC(9,4)    DEFAULT 0;
        galoes      NUMERIC(8,4)    DEFAULT 0;        
    BEGIN
        --Programação para caber em tabela com qualquer tamanho
        SELECT COUNT(Localizacao)
        INTO contador
        FROM tb_Viagem;
        
        FOR indice1 IN 1 .. contador LOOP
            FOR indice2 IN (indice1 + 1)..contador LOOP
                
                indice := indice + 1; --pk_Id_
                
                --funções que calculam as milhas e os galões entre as duas localizacoes do instante do FOR
                milhas := fn_miles(indice1, indice2);
                galoes := fn_galoes_utilizados(indice1, indice2);
                
                --após calculados, são inseridos todos os dados na tabela
                INSERT INTO tb_miles_per_gallon
                VALUES (indice, indice1, indice2, milhas, galoes, milhas/galoes);
                
            END LOOP;
        END LOOP;
        
        RETURN 'Tabela construída com sucesso!';
    END;
    /


--função para calcular a distância em Milhas entre um ponto geográfico e outro
CREATE OR REPLACE FUNCTION fn_miles (
    loc1     INTEGER,
    loc2     INTEGER
)
    RETURN NUMBER
    AS
        lon1        NUMERIC(15,7);
        lon2        NUMERIC(15,7);
        lat1        NUMERIC(15,7);
        lat2        NUMERIC(15,7);
        
        milhas      NUMERIC(9,4)    DEFAULT 0;
    BEGIN
        SELECT longitude, latitude
        INTO lon1, lat1
        FROM tb_Viagem
        WHERE localizacao = loc1;
        
        SELECT longitude, latitude
        INTO lon2, lat2
        FROM tb_Viagem
        WHERE localizacao = loc2;
        
        --cálculo da distância em milhas
        --1 grau de latitude = 69 milhas
        --1 grau de longitude = 54.6 milhas
            --este grau é medido a partir da diferença entre uma coordenada e outra
       
        --milhas := (((lon1 - lon2)*59)**2 + ((lat1 - lat2)*54.6)**2)**(1/2);       --comentado pois deu erro, n entendi
        lon1 := (lon1 - lon2) * 54.6;                                                                          --o por que
        lat1 := (lat1 - lat2) * 69;
        milhas := (lon1**2 + lat1**2)**(1/2);   --Teorema de Pitágoras
        
        RETURN milhas;
    END;
    /
    
    
--Função recursiva para descobrir quantos galões foram utilizados de uma localização à outra
CREATE OR REPLACE FUNCTION fn_galoes_utilizados (
    loc1        INTEGER,
    loc2        INTEGER
)
RETURN NUMERIC
AS
    g_saida     NUMERIC(8,4);
    g_chegada   NUMERIC(8,4);
    aux         INTEGER;
    
    galoes  NUMERIC(8,4)    DEFAULT 0;
BEGIN
    
    SELECT gallonsDeparture
    INTO g_saida
    FROM tb_Viagem
    WHERE localizacao = loc1;
    
    SELECT gallonsArrival
    INTO g_chegada
    FROM tb_Viagem
    WHERE localizacao = loc2;
    
    aux := loc1;
    IF aux+1 = loc2 THEN    --caso tenha chegado num trecho de localizações CONSECUTIVAS, termina a recursividade
        galoes := galoes + g_saida - g_chegada;
    ELSE
        aux := aux + 1;     --avança 1 localização em relação a loc1
        
        SELECT gallonsArrival
        INTO g_chegada
        FROM tb_Viagem
        WHERE localizacao = aux;
        --é preciso mudar a variável g_chegada, para que a conta do trecho seja somada
        
        galoes := galoes + g_saida - g_chegada + fn_galoes_utilizados(aux, loc2);
    END IF;
    
    RETURN galoes;

END;
/


--Função para buscar e mostrar automaticamente em qual segmento da viagem foi obtida a maior velocidade
CREATE OR REPLACE FUNCTION fn_vel_max
RETURN NUMERIC
AS
    loc1        INTEGER;
    loc2        INTEGER;
    vel_max     NUMERIC(8,4);
BEGIN
    SELECT Origin, Destination, Miles_per_Gallon
    INTO loc1, loc2, vel_max
    FROM tb_miles_per_gallon
    WHERE Miles_per_Gallon = ( SELECT MIN(Miles_per_Gallon)
                                FROM tb_miles_per_gallon  );
                                
    --foi selecionada a Miles_per_gallon mínima, pois quanto menos milhas Jim e Pam
    --fizeram por galão, mais afundaram o pé no acelerador!
    
    --printando a resposta na tela de maneira organizada
    dbms_output.enable;
    dbms_output.put_line('O trajeto de maior velocidade foi o de '||loc1||' para '||loc2||'.');
    dbms_output.put_line('Miles/Gallon: '||vel_max||'.');

    
    RETURN vel_max;
END;
/


SET SERVEROUTPUT ON;

--código automático para a execução das funções
DECLARE
    Saida       VARCHAR(64);
    resposta    NUMERIC(8,4);
BEGIN
    Saida := fn_escultor;
    Saida := fn_desafio2;
    --armazenando o resultado final numa variável
    resposta := fn_vel_max;    
END;
/

SELECT * FROM tb_Viagem;
SELECT * FROM tb_miles_per_gallon;

--QUERY DA RESPOSTA
SELECT Origin, Destination, Miles_per_Gallon
FROM tb_miles_per_gallon
WHERE Miles_per_Gallon = ( SELECT MIN(Miles_per_Gallon)
                            FROM tb_miles_per_gallon  );