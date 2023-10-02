SELECT [Name] AS 'Produkty sprzedane Jeffrey'
	FROM [SalesLT].[Product] 
	INNER JOIN [SalesLT].[SalesOrderDetail] ON [SalesLT].[Product].[ProductID] = [SalesLT].[SalesOrderDetail].[ProductID]
	INNER JOIN [SalesLT].[SalesOrderHeader] ON [SalesLT].[SalesOrderDetail].[SalesOrderID] = [SalesLT].[SalesOrderHeader].[SalesOrderID]
	INNER JOIN [SalesLT].[Customer] ON [SalesLT].[SalesOrderHeader].[CustomerID] = [SalesLT].[Customer].[CustomerID]
	WHERE [FirstName] = 'Jeffrey' ORDER BY [Name]

SELECT ([FirstName] + ' ' + [LastName]) AS 'Nigdy nic nie kupili' 
	FROM [SalesLT].[Customer]
	FULL JOIN [SalesLT].[SalesOrderHeader] ON [SalesLT].[Customer].[CustomerID] = [SalesLT].[SalesOrderHeader].[CustomerID]
	WHERE [SalesLT].[SalesOrderHeader].[CustomerID] IS NULL

SELECT [SalesOrderID] AS 'Numer zamówienia', [Freight] AS 'Wysokoœæ op³aty', IIF([Freight]>100, 'High', 'Low') AS 'Skala kosztownoœci' 
	FROM [SalesLT].[SalesOrderHeader]