/* Zadanie 1 */
SELECT 
	[Product].[ProductNumber] as 'Numer produktu', 
	COUNT([SalesOrderDetail].[SalesOrderDetailID]) AS 'Liczba sprzeda¿y',
	ROW_NUMBER() OVER (ORDER BY COUNT([SalesOrderDetail].[SalesOrderDetailID]) DESC) AS 'Najwiêksza sprzeda¿ wg. Pozycji', 
	DENSE_RANK() OVER (ORDER BY COUNT([SalesOrderDetail].[SalesOrderDetailID]) DESC) AS 'Najwiêksza sprzeda¿ wg. Iloœci'
	FROM [SalesLT].[SalesOrderDetail]
	JOIN [SalesLT].[Product] ON [Product].[ProductID] = [SalesOrderDetail].[ProductID] 
	GROUP BY [Product].[ProductNumber]
	ORDER BY COUNT([SalesOrderDetail].[SalesOrderDetailID]) DESC

/* Zadanie 2 */
SELECT 
	YEAR([DueDate]) AS 'Rok',
	MONTH([DueDate]) AS 'Miesi¹c', 
	DAY([DueDate]) AS 'Dzieñ',
	SUM ([TotalDue]) OVER (PARTITION BY DAY([DueDate])) AS 'Sprzeda¿ na Dzieñ',
	SUM ([TotalDue]) OVER (PARTITION BY MONTH([DueDate])) AS 'Sprzeda¿ na Miesi¹c',
	SUM ([TotalDue]) OVER (PARTITION BY YEAR([DueDate])) AS 'Sprzeda¿ na Rok',
	SUM ([TotalDue]) OVER () AS 'Sprzeda¿ ca³oœciowa' 
	FROM [SalesLT].[SalesOrderHeader]

/* Zadanie 3 */
SELECT 
	[SalesOrderID] AS 'ID Zamówienia', 
	[TotalDue] AS 'Ca³kowita wartoœæ',    
	[TotalDue] - LAG ([TotalDue]) OVER (ORDER BY [SalesOrderID]) AS 'Ró¿nica wartoœci pomiêdzy dwoma zamówieniami'
	FROM [SalesLT].[SalesOrderHeader]