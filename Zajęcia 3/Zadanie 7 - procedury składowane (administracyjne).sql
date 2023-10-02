DROP PROCEDURE IF EXISTS [dbo].[zrob_kopie];
GO
CREATE PROCEDURE [dbo].[zrob_kopie] 
  @databasetype AS NVARCHAR(30)
AS
BEGIN;
DECLARE 
	@databasename AS NVARCHAR(128), 
	@timecomponent AS NVARCHAR(50),
	@sqlcommand AS NVARCHAR(1000);
IF @databasetype NOT IN ('User', 'System')
	BEGIN;
		THROW 50000, 'Nazw¹ bazy danych (@databasename) mo¿e byæ tylko: "System" i "User"', 0;
		RETURN;
	END;
IF @databasetype = 'System'
	SET @databasename = 
		(
			SELECT MIN(name) 
			FROM sys.databases 
			WHERE name IN ('master', 'model', 'msdb')
		);
ELSE
	SET @databasename = 
		(
			SELECT MIN(name) 
			FROM sys.databases 
			WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb')
		);
WHILE @databasename IS NOT NULL
	BEGIN;
		SET @timecomponent = 
			REPLACE
			(
				REPLACE
				(
					REPLACE
					(	
						CONVERT
						(
							NVARCHAR, GETDATE(), 120
						),
						' ', '_'
					), 
					':', ''
				), 
				'-', ''
			);
		SET @sqlcommand = 
			'BACKUP DATABASE ' + @databasename + ' TO DISK = ' + 
			'C:\Backups\' + @databasename + '_' + @timecomponent + '.bak';
	PRINT @sqlcommand;
	IF @databasetype = 'System'
		SET @databasename = 
			(
				SELECT MIN(name) 
				FROM sys.databases 
				WHERE name IN ('master', 'model', 'msdb') AND name > @databasename
			);
	ELSE
		SET @databasename = 
			(
				SELECT MIN(name) 
				FROM sys.databases 
				WHERE name NOT IN ('master', 'model', 'msdb', 'tempdb') AND name > @databasename
			);
	END;
	RETURN;
END;

EXEC dbo.zrob_kopie;
GO

EXEC dbo.zrob_kopie 'User';
GO

EXEC dbo.zrob_kopie 'System';
GO

EXEC dbo.zrob_kopie 'Unknown'