/* Zadanie 1 */
SELECT [OrderDate] AS 'Data zamówienia', [CustomerID] AS 'ID klienta', MAX([Freight]) AS 'Najwy¿sza oplata za przesylke' 
	FROM [SalesLT].[SalesOrderHeader]
	GROUP BY [OrderDate], [CustomerID]

/* Zadanie 2 */
SELECT [Product].[Name] AS 'Nazwa produktu', COUNT([SalesOrderDetail].[ProductID]) AS 'Liczba sprzeda¿y' 
	FROM [SalesLT].[Product] 
	JOIN [SalesLT].[SalesOrderDetail] ON [Product].[ProductID]=[SalesOrderDetail].[ProductID]
	GROUP BY [Product].[Name] 
	HAVING COUNT([Product].[Name])>3

/* Zadanie 3 */
CREATE TABLE ##Sprzedaz 
	(
	[ID klienta] INT NOT NULL,
	Miesi¹c INT NOT NULL,
	Wartoœæ MONEY NOT NULL
	);
GO

INSERT INTO ##Sprzedaz
	SELECT [CustomerID], DATEPART(MONTH, [OrderDate]), [TotalDue]
	FROM [SalesLT].[SalesOrderHeader];
GO

/* Coœ nie dzia³a³o z lokaln¹ tabel¹ tymczasow¹ wiêc stworzy³em globaln¹ */

SELECT * FROM ##Sprzedaz
	PIVOT (SUM(Wartoœæ) FOR [Miesi¹c] IN([1], [2], [3], [4], [5], [6], [7], [8], [9], [10], [11], [12])) AS pivocik
