/* Zadanie 1 */
CREATE FUNCTION Sales.Wartosc_zamowienia(@orderid int)
RETURNS float
AS 
BEGIN
RETURN 
(
	SELECT  
	SUM(qty*unitprice)
	FROM Sales.OrderDetails 
	WHERE orderid = @orderid
)
END

SELECT [Sales].[Wartosc_zamowienia](10248) AS 'Wartoœæ Zamówienia'

/* Zadanie 2 */
CREATE FUNCTION Sales.Wybrane_zamowienia(@lowqty int, @highqty int)
RETURNS TABLE
AS
RETURN
(
	SELECT
	orderid AS 'Numer zamówienia',
	unitprice AS 'Cena produktu',
	qty AS 'Iloœæ'
	FROM Sales.OrderDetails
	WHERE qty BETWEEN @lowqty AND @highqty
)

SELECT * FROM [Sales].[Wybrane_zamowienia](5,12)

/* Zadanie 3 */
CREATE FUNCTION [dbo].[is_pesel](@pesel varchar(255))
RETURNS int
AS
BEGIN
DECLARE @wynik int
SET @wynik = 0
SET @wynik = (SELECT CASE
WHEN LEN(@pesel) != 11 THEN 0
WHEN ISNUMERIC(@pesel) = 0 THEN 0
WHEN SUBSTRING(@pesel, 3, 1) not in ('0', '1', '2', '3') THEN 0
WHEN @pesel='00000000000' THEN 0
WHEN @pesel='12345678910' THEN 0
WHEN @pesel='11111111116' THEN 0
WHEN @pesel='11111111123' THEN 0
WHEN 
	(
		(
			(CAST(SUBSTRING(@pesel, 1, 1) AS bigint) * 9)+
			(CAST(SUBSTRING(@pesel, 2, 1) AS bigint) * 7)+
			(CAST(SUBSTRING(@pesel, 3, 1) AS bigint) * 3)+
			(CAST(SUBSTRING(@pesel, 4, 1) AS bigint) * 1)+
			(CAST(SUBSTRING(@pesel, 5, 1) AS bigint) * 9)+
			(CAST(SUBSTRING(@pesel, 6, 1) AS bigint) * 7)+
			(CAST(SUBSTRING(@pesel, 7, 1) AS bigint) * 3)+
			(CAST(SUBSTRING(@pesel, 8, 1) AS bigint) * 1)+
			(CAST(SUBSTRING(@pesel, 9, 1) AS bigint) * 9)+
			(CAST(SUBSTRING(@pesel, 10, 1) AS bigint) * 7) 
		) % 10 = right(@pesel, 1) 
	) THEN 1
ELSE 0
END
)
RETURN(@wynik)
END

SELECT IIF([dbo].[is_pesel]('68082379779') = 1, 'Tak', 'Nie') AS 'Czy poprawny PESEL?'

/* Zadanie 4 */
CREATE FUNCTION [dbo].[pesel_plec](@pesel varchar(255))
RETURNS varchar(255)
AS
BEGIN
DECLARE @wynik varchar(255)
SET @wynik = NULL
SET @wynik = (SELECT CASE
WHEN [dbo].[is_pesel](@pesel) = 0 THEN 'Pesel niepoprawny'
WHEN CAST(SUBSTRING(@pesel,10,1) AS bigint)%2 = 0 THEN 'Kobieta'
ELSE 'Mê¿czyzna'
END
)
RETURN(@wynik)
END

SELECT [dbo].[pesel_plec]('68082379779') AS 'P³eæ'

/* Zadanie 5 */
CREATE FUNCTION [dbo].[get_date_from_pesel](@pesel varchar(255))
RETURNS date
AS
BEGIN
DECLARE @wynik date = NULL
DECLARE @dzien int
DECLARE @miesiac int
DECLARE @rok int
DECLARE @pomocna int
SET @pomocna = CAST(SUBSTRING(@pesel, 3, 1) AS int)
SET @dzien = CAST(SUBSTRING(@pesel, 5, 2) AS int)
SET @miesiac = (@pomocna % 2) * 10 + SUBSTRING(@pesel, 4, 1)
SET @rok = 1900 + CAST(SUBSTRING(@pesel, 1, 2) AS int)
SET @rok = (CASE 
	WHEN @pomocna >= 2 AND @pomocna <= 6 THEN @rok + @pomocna/2*100 
	WHEN @pomocna >= 8 THEN @rok - 100
	ELSE @rok
	END
)
SET @wynik = (CASE
	WHEN [dbo].[is_pesel](@pesel) = 0 THEN NULL
	ELSE DATEFROMPARTS(@rok,@miesiac,@dzien)
	END
)
RETURN (@wynik)
END

SELECT [dbo].[get_date_from_pesel]('68082379779') AS 'Data urodzenia'

/* Zadanie 6 */
CREATE FUNCTION [dbo].[get_wiek_from_pesel](@pesel varchar(255))
RETURNS int
AS
BEGIN
DECLARE @wynik int = NULL
DECLARE @data_urodzenia date = [dbo].[get_date_from_pesel](@pesel)
DECLARE @data_aktualna date = CONVERT(date,SYSDATETIME())
SET @wynik = (CASE
	WHEN [dbo].[is_pesel](@pesel) = 0 THEN NULL
	ELSE FLOOR(DATEDIFF(DAY, @data_urodzenia, @data_aktualna) / 365.25)
	END
)
RETURN (@wynik)
END

SELECT [dbo].[get_wiek_from_pesel]('68082379779') AS 'Wiek'