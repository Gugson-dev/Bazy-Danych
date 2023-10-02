-- ZADANIA 1-8

USE master;
DROP DATABASE IF EXISTS wypozyczalnia_aut;
CREATE DATABASE wypozyczalnia_aut;
USE wypozyczalnia_aut;

CREATE TABLE U¿ytkownik (Uzytkownik_ID int PRIMARY KEY IDENTITY(1,1),
login VARCHAR(255) NOT NULL,
haslo VARCHAR(32) NOT NULL,
adresEmail VARCHAR(255) NOT NULL CHECK (adresEmail LIKE '%@%.%'),
kierowca_ID INT NOT NULL);

CREATE TABLE Kierowca(Kierowca_ID int PRIMARY KEY IDENTITY (1,1),
imie VARCHAR(155) NOT NULL,
nazwisko VARCHAR(155) NOT NULL,
ulica VARCHAR(20) NOT NULL,
nrBudynku VARCHAR(10) NOT NULL,
kodPocztowy NVARCHAR(6) NOT NULL CHECK(kodPocztowy LIKE '__-___'),
miasto VARCHAR(60) NOT NULL,
telefon NVARCHAR(9) NOT NULL CHECK(LEN(telefon)=9));

CREATE TABLE Wypo¿yczalnia (Wypozyczalnia_ID int PRIMARY KEY IDENTITY(1,1),
pasa¿erowie INT NULL DEFAULT(0),
od_kiedy DATE NOT NULL,
do_kiedy DATE NOT NULL,
pojazd_id INT NOT NULL);

CREATE TABLE Pojazd (Pojazd_ID int PRIMARY KEY IDENTITY(1,1),
marka_pojazdu VARCHAR(155) NOT NULL,
model_pojazdu VARCHAR(155) NOT NULL,
numer_rejestracyjny VARCHAR(45) NOT NULL,
rok_produkcji INT NULL DEFAULT(NULL));

CREATE TABLE Rezerwacja (Rezerwacja_ID int PRIMARY KEY IDENTITY(1,1),
wypozyczalnia_ID INT NOT NULL,
uzytkownik_ID INT NOT NULL,
kierowca_ID INT NULL,
pojazd_ID INT NULL,
od_kiedy DATE NULL,
do_kiedy DATE NULL,
odczyt_licznika INT NULL DEFAULT(NULL));

ALTER TABLE U¿ytkownik 
ADD FOREIGN KEY (kierowca_ID) REFERENCES Kierowca(Kierowca_ID);

ALTER TABLE Wypo¿yczalnia 
ADD FOREIGN KEY (pojazd_id) REFERENCES Pojazd(Pojazd_ID);

ALTER TABLE Rezerwacja 
ADD FOREIGN KEY (wypozyczalnia_ID) REFERENCES Wypo¿yczalnia(Wypozyczalnia_ID);

ALTER TABLE Rezerwacja 
ADD FOREIGN KEY (uzytkownik_ID) REFERENCES U¿ytkownik(Uzytkownik_ID);

ALTER TABLE Rezerwacja 
ADD FOREIGN KEY (pojazd_ID) REFERENCES Pojazd(Pojazd_ID);

ALTER TABLE Rezerwacja 
ADD FOREIGN KEY (kierowca_ID) REFERENCES Kierowca(Kierowca_ID);

INSERT INTO dbo.Kierowca (imie, nazwisko, ulica, nrBudynku, kodPocztowy, miasto, telefon)
VALUES
(N'Marcin',N'Nowak',N'Malinowa',  N'7a', '85-799', N'Bydgoszcz', 533445676),
(N'Kazimierz',N'Malinowski',N'Wojska Polskiego',  N'122', '83-200',  N'Starogard Gdañski',634526737),
(N'Karol',N'Kamiñski', N'Pomorska',  N'13', '83-000',  N'Gdañsk',552537677),
(N'Jan',N'Jankowski',N'Gdañska', N'123a/2', '82-987', N'Gdynia',737635344),
(N'Antoni',N'Bieliñski',N'Hallera', N'56', '87-899', N'Sopot', 725678664),
(N'Mateusz',N'Kowalski',N'Fordoñska', N'54', '85-789', N'Bydgoszcz', 552111231),
(N'Patryk',N'¯eliñski',N'Staffa',  N'76', '83-210', N'Gdañsk',645789565),
(N'Zygmunt',N'Wiœniewski',N'Aleje Grunwaldzkie', N'765', '83-213', N'Gdañsk', 513624604),
(N'Dominik',N'Kowalczyk',N'Brzozowa', N'12', '82-222', N'Gdañsk',525666778),
(N'Marian',N'Adamczyk',N'Wrzosowa', N'987/2a', '83-333', N'Gdynia',878555434);

INSERT INTO dbo.Pojazd(marka_pojazdu, model_pojazdu, numer_rejestracyjny, rok_produkcji)
VALUES
(N'Volksvagen', N'Golf', N'GDA123A', 2016),
(N'Fiat', N'500', N'GDA45A', 2019),
(N'Toyota', N'Yaris', N'GD876HF', 2020),
(N'Kia', N'Ceed Sportswagon', N'GDHHU^', 2019),
(N'Seat', N'Leon', N'GDAA344', 2018),
(N'Nissan', N'Qashqai', N'GD6654F', 2016),
(N'Opel', N'Insignia', N'GD8765KK', 2019),
(N'Kia', N'Sportage', N'GD5H6G', 2021),
(N'Mazda', N' 6 Tourer', N'GD75575', 2020),
(N'Opel', N'Insignia Sports Tourer', N'GD68GJK', 2021);

INSERT INTO dbo.U¿ytkownik (login, haslo, adresEmail, kierowca_ID)
VALUES
(N'm.nowak', 'hd^$^&*v', N'm.nowak@gmail.com',1),
(N'k.kaminski', 'BV%&*N&HBN', N'k.kaminski@wp.pl',3),
(N'j.jankowski', '(*&^VVGVUU', N'j.jankowskik@gmail.com',4),
(N'd.kowalczyk', 'NO&NMIBY', N'd.kowalczyk@gmail.com',9),
(N'm.kowalski', 'JBH%V56v6', N'm.kowalski@gmail.com',6),
(N'p.zelinski', 'LKMG&RVXE#', N'p.zelinski@o2.pl',7),
(N'a.bielinski', 'H%^V^&VN&', N'a.bielinski@onet.eu',5),
(N'z.wisniewski', 'KHV^$%$MN', N'z.wisniewski@gmail.com',8),
(N'k.malinowski', 'hgh6%hgv6', N'kmalina@gmail.com',2),
(N'm.adamczyk', ')(&(djdkeTY', N'm.adamczyk@gmail.com',10);


INSERT INTO dbo.Wypo¿yczalnia (pasa¿erowie, od_kiedy, do_kiedy, pojazd_id)
VALUES
(2, '20211224', '20211228', 2),
(1, '20211222', '20211223', 3),
(3, '20211222', '20211223', 1),
(0, '20211223', '20211225', 4),
(1, '20211227', '20211230', 7),
(2, '20211230', '20211231', 8),
(2, '20211230', '20220128', 10),
(1, '20211223', '20220103', 6),
(1, '20211227', '20220202', 5),
(3, '20211229', '20220106', 9);

INSERT INTO dbo.Rezerwacja (wypozyczalnia_ID, uzytkownik_ID, kierowca_ID, pojazd_ID, od_kiedy,do_kiedy, odczyt_licznika)
VALUES
(1, 2, 3, 1,'20211222', '20211223', 150876),
(2, 4, 9, 2, '20211224', '20211228', 100678),
(3, 5, 6, 3, '20211222', '20211223', 90765),
(4, 1,1, 4, '20211223', '20211225',56789),
(5, 7, 5, 5, '20211227', '20220202', 36000),
(6, 10, 10, 10, '20211230', '20220128', 64578),
(7, 9, 2, 6, '20211223', '20220103', 112098),
(8, 3, 4, 4, '20211223', '20211225',78543),
(9, 6, 7, 7, '20211227', '20211230', 200679),
(10, 8, 8, 9, '20211229', '20220106',92732);

CREATE NONCLUSTERED INDEX ncidx_lname
ON Kierowca (Nazwisko);

CREATE NONCLUSTERED INDEX ncidx_marka
ON Pojazd (marka_pojazdu);

CREATE NONCLUSTERED INDEX ncidx_uid
ON U¿ytkownik (Uzytkownik_ID);

--ZADANIE 9

Create view przejazd as select tb1.Rezerwacja_ID,tb2.imie,tb3.numer_rejestracyjny,tb4.pasa¿erowie from Rezerwacja AS tb1 JOIN Kierowca as tb2 ON tb2.Kierowca_ID = tb1.kierowca_ID JOIN Pojazd AS tb3 ON tb3.Pojazd_ID = tb1.pojazd_ID JOIN Wypo¿yczalnia AS tb4 ON 
tb4.Wypozyczalnia_ID = tb1.wypozyczalnia_ID;

--ZADANIE 10

Create view ilosc_rezerwacji AS Select Kierowca_ID, COUNT(*) AS 'Ilosc rezerwacji' FROM Rezerwacja GROUP BY Kierowca_ID;

--ZADANIE 12

CREATE FUNCTION [dbo].[roznica_dni](@date1 date,@date2 date)
RETURNS int
AS 
BEGIN
RETURN 
(
	SELECT  
	DATEDIFF(d,@date1,@date2)
)
END

--ZADANIE 13

CREATE FUNCTION dbo.ilosc_pasazerow(@min int, @max int)
RETURNS TABLE
AS
RETURN
(
	SELECT
	Wypozyczalnia_ID AS 'Numer wypo¿yczenia',
	pojazd_id AS 'Numer pojazdu',
	pasa¿erowie AS 'Iloœæ pasa¿erów'
	FROM Wypo¿yczalnia
	WHERE pasa¿erowie BETWEEN @min AND @max
)

--ZADANIE 14

CREATE VIEW bez_pasazerow AS SELECT * FROM dbo.ilosc_pasazerow(0,0)

--ZADANIE 15

DROP PROCEDURE IF EXISTS [dbo].[dodaj_kierowce]
GO
CREATE PROCEDURE [dbo].[dodaj_kierowce] 
	@imie AS VARCHAR(155),
	@nazwisko AS VARCHAR(155),
	@ulica AS VARCHAR(20),
	@nrBudynku AS VARCHAR(10),
	@kodPocztowy AS NVARCHAR(255),
	@miasto AS VARCHAR(60),
	@telefon AS NVARCHAR(255)
AS
BEGIN
	DECLARE 
		@blad nvarchar(255),
		@jaki nvarchar(255);
	BEGIN TRY
    IF NOT(@kodPocztowy LIKE '__-___') 
		BEGIN
			SET @blad = 'Podany kod pocztowy: ' 
				+ CAST(@kodPocztowy AS varchar(255)) + ' jest niepoprawny. Przyk³adowy kod pocztowy: 85-472.';
        THROW 50000, @blad, 0;
    END;
	IF NOT(LEN(@telefon)=9) 
		BEGIN
			IF (LEN(@telefon)>9) SET @jaki = 'd³ugi';
			IF (LEN(@telefon)<9) SET @jaki = 'krótki';
			SET @blad = 'Podany numer telefonu: ' 
				+ CAST(@telefon AS varchar(255)) + ' jest za ' + @jaki + '. Wymagana d³ugoœc: 9.';
        THROW 50000, @blad, 0;
    END;
	IF EXISTS(SELECT 1 FROM dbo.Kierowca
		WHERE telefon = @telefon)
		BEGIN
			SET @blad = 'Kierowca z podanym numerem telefonu: ' 
				+ @telefon + ' ju¿ istnieje. Proszê podaæ inny.';
		THROW 50000, @blad, 0;
	END;
	INSERT INTO dbo.Kierowca (imie, nazwisko, ulica, nrBudynku, kodPocztowy, miasto, telefon)
	VALUES (@imie, @nazwisko, @ulica, @nrBudynku, @kodPocztowy, @miasto, @telefon)
	END TRY
	BEGIN CATCH
		THROW;
	END CATCH;
END;
GO

-- Przyk³adowe wywo³anie procedury z b³êdem w kodzie pocztowym i telefonie
EXEC dbo.dodaj_kierowce
@imie = 'Jan',
@nazwisko = 'Kowalski',
@ulica = 'Kowalewska',
@nrBudynku = '15a',
@kodPocztowy = '123-345',
@miasto = 'Jankowo',
@telefon = '12345678910'