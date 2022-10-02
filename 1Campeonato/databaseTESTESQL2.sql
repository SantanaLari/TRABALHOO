CREATE DATABASE av_teste2
use av_teste2

CREATE TABLE times
(
CodigoTime	INT				NOT NULL,
NomeTime	VARCHAR(50)		NOT NULL,
Cidade		VARCHAR(50)		NOT NULL,
Estadio		VARCHAR(50)		NOT NULL
PRIMARY KEY(CodigoTime)
)

CREATE TABLE grupos
(
Grupo		CHAR(1)		NOT NULL, 
CodigoTime	INT			NOT NULL,
PRIMARY KEY(Grupo, CodigoTime),
FOREIGN KEY(CodigoTime) REFERENCES times(CodigoTime)
)

CREATE TABLE jogos
(
CodigoTimeA		INT		NOT NULL,
CodigoTimeB		INT		NOT NULL,
GolsTimeA		INT		NULL,
GolsTimeB		INT		NULL,
Data			DATE	NULL
PRIMARY KEY(CodigoTimeA, CodigoTimeB)
)

INSERT INTO times VALUES
(1, 'Corinthians', 'S�o Paulo', 'Neo Qu�mica Arena'),
(2, 'Palmeiras', 'S�o Paulo', 'Allanz Parque'),
(3, 'Santos', 'Santos', 'Vila Belmiro'),
(4, 'S�o Paulo', 'S�o Paulo', 'Morumbi'),
(5, 'Botafogo-SP', 'Ribeir�o Preto', 'Santa Cruz'),
(6, 'Ferrovi�ria', 'Araraquara', 'Fonte Luminosa'),
(7, 'Guarani', 'Campinas', 'Brinco de Ouro'),
(8, 'Inter de Limeira', 'Limeira', 'Limeir�o'),
(9, 'Ituano', 'Itu', 'Novelli J�nior'),
(10, 'Mirassol', 'Mirassol', 'Jos� Maria de Campos Maia'),
(11, 'Novorizontino', 'Novo Horizonte', 'Jorge Ismael de Biasi'),
(12, 'Ponte Preta', 'Campinas', 'Mois�s Lucarelli'),
(13, 'Red Bull Bragantino', 'Bragan�a Paulista', 'Nabi Abi Chedid'),
(14, 'Santo Andr�', 'Santo Andr�', 'Bruno Jos� Daniel'),
(15, 'S�o Bento', 'Sorocaba', 'Walter Ribeiro'),
(16, 'S�o Caetano', 'S�o Caetano do Sul', 'Anacletto Campanella')

/******************************************** GERAR GRUPOS ****************************/
CREATE PROCEDURE p_geraGrupos_1 --Times (5 a 10) - A ou B; Times (11 a 16) - C ou D
AS								--PARES: RAND = 1 - A ou C; RAND = 2 - B ou D 						
DECLARE @grupo char(1),			--IMPARES: RAND = 1 - B ou D; RAND = 2 - A ou C
		@time INT,
		@rand1 INT

SET @time = 5
	WHILE (@time <= 10) --A e B
	BEGIN
		IF(@time % 2 = 0)
		BEGIN
			SET @grupo = 'A'
		END
		ELSE
		BEGIN
			SET @grupo = 'B'
		END
		INSERT INTO grupos VALUES
		(@grupo, @time)
		SET @time = @time + 1
	END

	WHILE (@time <= 16) --C e D
	BEGIN
		IF(@time % 2 = 0)
		BEGIN
			SET @grupo = 'C'
		END
		ELSE
		BEGIN
			SET @grupo = 'D'
		END
		INSERT INTO grupos VALUES
		(@grupo, @time)
		SET @time = @time + 1
	END
---------------------------------------------------------------------------------------------------------
CREATE PROCEDURE p_geraGrupos_2 --Times (5 a 10) - C ou D; Times (11 a 16) - A ou B
AS								--PARES: RAND = 1 - A ou C; RAND = 2 - B ou D 						
DECLARE @grupo char(1),			--IMPARES: RAND = 1 - B ou D; RAND = 2 - A ou C
		@time INT,
		@rand1 INT

SET @time = 5
	WHILE (@time <= 10) --C e D
	BEGIN
		IF(@time % 2 = 0)
		BEGIN
			SET @grupo = 'C'
		END
		ELSE
		BEGIN
			SET @grupo = 'D'
		END
		INSERT INTO grupos VALUES
		(@grupo, @time)
		SET @time = @time + 1
	END

	WHILE (@time <= 16) --A e B
	BEGIN
		IF(@time % 2 = 0)
		BEGIN
			SET @grupo = 'A'
		END
		ELSE
		BEGIN
			SET @grupo = 'B'
		END
		INSERT INTO grupos VALUES
		(@grupo, @time)
		SET @time = @time + 1
	END

/****************************************************** GERAR PARTIDAS ********************************/
CREATE PROCEDURE p_partidas
AS
	DECLARE @timeA INT,
			@timeB INT,
			@cont INT,
			@cont1 INT,
			@dataQuarta DATE,
			@dataDomingo DATE,
			@data DATE
SET @cont = 5
SET @cont1 = 5	
SET @dataQuarta = '23/02/2022'
SET @dataDomingo = '27/02/2022'

--CABE�AS
	INSERT INTO jogos VALUES
	(1,2,NULL,NULL,'23/02/2022'),
	(1,3,NULL,NULL,'27/02/2022'),
	(1,4,NULL,NULL,'27/02/2022'),
	(2,3,NULL,NULL,'23/02/2022'),
	(2,4,NULL,NULL,'27/02/2022'),
	(3,4,NULL,NULL,'23/02/2022')

--RESTO 1
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 1
		IF (@cont = 12 or @cont = 14 or @cont = 16)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 5
--RESTO 2
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 2
		IF (@cont = 11 or @cont = 13 or @cont = 15)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 5
--RESTO 3
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 3
		IF (@cont = 6 or @cont = 8 or @cont = 10)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 5
--RESTO 4
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 4
		IF (@cont = 5 or @cont = 7 or @cont = 9)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 6

--RESTO 5
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 5
		IF (@cont = 7 or @cont = 9)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 7

--RESTO 6
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 6
		IF (@cont = 8 or @cont = 10)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 8

--RESTO 7
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 7
		IF (@cont = 9)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 9
--RESTO 8
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 8
		IF (@cont = 10)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END
	
SET @cont = 10
--RESTO 9
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 9
		SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
		SET @cont = @cont + 1
	END
	
SET @cont = 11
--RESTO 11
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 10
		SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
		SET @cont = @cont + 1
	END

SET @cont = 12
--RESTO 12
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 11
		SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
		SET @cont = @cont + 1
	END

SET @cont = 13
--RESTO 13
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 12
		SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
		SET @cont = @cont + 1
	END

--------------------------------------------------TERMINAR------------------------------------------
CREATE PROCEDURE p_partidas2
AS
DECLARE @timeA INT,
			@timeB INT,
			@cont INT,
			@dataQuarta DATE,
			@dataDomingo DATE,
			@data DATE
SET @cont = 5
SET @dataQuarta = '23/02/2022'
SET @dataDomingo = '27/02/2022'

--CABE�AS
	INSERT INTO jogos VALUES
	(1,2,NULL,NULL,'23/02/2022'),
	(1,3,NULL,NULL,'27/02/2022'),
	(1,4,NULL,NULL,'27/02/2022'),
	(2,3,NULL,NULL,'23/02/2022'),
	(2,4,NULL,NULL,'27/02/2022'),
	(3,4,NULL,NULL,'23/02/2022')

--RESTO 1
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 1
		IF (@cont = 6 or @cont = 8 or @cont = 10)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 5
--RESTO 2
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 2
		IF (@cont = 5 or @cont = 7 or @cont = 9)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 5
--RESTO 2
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 3
		IF (@cont = 12 or @cont = 14 or @cont = 16)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

SET @cont = 5
--RESTO 3
	WHILE @cont <= 16 
	BEGIN
		SET @timeA = 4
		IF (@cont = 11 or @cont = 13 or @cont = 15)
		BEGIN
			SET @cont = @cont + 1
		END
		ELSE
		BEGIN
			SET @timeB = @cont
			INSERT INTO jogos VALUES
			(@timeA, @timeB, NULL, NULL, NULL)
			SET @cont = @cont + 1
		END
	END

/*************************************************** PROCEDURE QUE VAI SER CHAMADA ******************/
CREATE PROCEDURE p_geraGrupo
AS
DECLARE @grupo char(1),
		@time INT,
		@rand INT
SET @rand = (RAND() * 2) + 1
SET @time = 0

		WHILE (@time < 4)
		BEGIN
			IF (@time = 0)
			BEGIN
				SET @grupo = 'A'
			END
			ELSE
				IF (@time = 1)
				BEGIN
					SET @grupo = 'B'
				END
				ELSE
					IF (@time = 2)
					BEGIN
						SET @grupo = 'C'
					END
					ELSE
						IF (@time = 3)
						BEGIN
							SET @grupo = 'D'
						END
			SET @time = @time + 1
			INSERT INTO grupos VALUES
			(@grupo, @time)
		END

		IF @rand = 1
		BEGIN
			EXEC p_geraGrupos_1
			EXEC p_partidas2
			PRINT 'ESCOLHIDO 1'
		END
		ELSE
		IF @rand = 2
		BEGIN
			EXEC p_geraGrupos_2
			EXEC p_partidas
		END

EXEC p_geraGrupo


SELECT * FROM grupos
SELECT * FROM jogos

DELETE grupos
DELETE jogos

