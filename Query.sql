USE master;
GO

IF EXISTS(SELECT * FROM sys.databases WHERE name = 'TrainStation')
BEGIN
	DROP DATABASE TrainStation
END;
GO

CREATE DATABASE TrainStation;
GO

USE TrainStation;
GO

/****** Object:  Table dbo.CarriageTypes ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'CarriageTypes' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.CarriageTypes;
GO

CREATE TABLE dbo.CarriageTypes
(
	CarriageTypeID INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(20) NOT NULL,
	PRIMARY KEY(CarriageTypeID)
) 
GO 

/****** Object:  Table dbo.Carriages ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Carriages' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Carriages;
GO

CREATE TABLE dbo.Carriages
(
	CarriageID INT IDENTITY(1,1) NOT NULL,
	TrainID INT NULL,
	Number INT NOT NULL,
	CarriageTypeID INT NOT NULL,
	PRIMARY KEY (CarriageID),
	CONSTRAINT FK_CarriageType FOREIGN KEY (CarriageTypeID)
	REFERENCES dbo.CarriageTypes(CarriageTypeID) 
);
GO 

/****** Object:  Table dbo.TrainTypes ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'TrainTypes' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.TrainTypes;
GO

CREATE TABLE dbo.TrainTypes
(
	TrainTypeID INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	PRIMARY KEY (TrainTypeID),
);
GO 

/****** Object:  Table dbo.Trains ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Trains' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Trains;
GO

CREATE TABLE dbo.Trains
(
	TrainID INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(100) NOT NULL,
	Number INT NOT NULL,
	TrainTypeID INT NOT NULL,
	PRIMARY KEY (TrainID),
	CONSTRAINT FK_TrainTypes FOREIGN KEY (TrainTypeID)
	REFERENCES dbo.TrainTypes(TrainTypeID) 
);
GO 

/****** Object:  Table dbo.Stations ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Stations' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Stations;
GO

CREATE TABLE dbo.Stations
(
	StationID INT IDENTITY(1,1) NOT NULL,
	Name VARCHAR(30) NOT NULL,
	PRIMARY KEY (StationID)
);
GO 

/****** Object:  Table dbo.Routes ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Routes' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Routes;
GO

CREATE TABLE dbo.Routes
(
	RouteID int IDENTITY(1,1) NOT NULL,
	TrainID int NULL,
	Name nchar(50) NULL,
	PRIMARY KEY (RouteID),
	CONSTRAINT FK_Trains FOREIGN KEY (TrainID)
	REFERENCES dbo.Trains(TrainID)
);
GO 

/****** Object:  Table dbo.Points ******/
IF EXISTS
( 
	SELECT TOP(1) 1 
	FROM INFORMATION_SCHEMA.TABLES 
	WHERE TABLE_NAME = N'Points' AND TABLE_SCHEMA = 'dbo' 
) 
DROP TABLE dbo.Points;
GO

CREATE TABLE dbo.Points
(
	PointID INT IDENTITY(1,1) NOT NULL,
	RouteID INT NOT NULL,
	ArrivalTime DATETIME NOT NULL,
	ArrivalStationID INT NOT NULL,
	DepartureTime DATETIME NOT NULL,
	DepartureStationID [int] NOT NULL,
	PRIMARY KEY (PointID),
	CONSTRAINT FK_Routes FOREIGN KEY (RouteID)
	REFERENCES dbo.Routes(RouteID),
	CONSTRAINT FK_StationsArrival FOREIGN KEY (ArrivalStationID)
	REFERENCES dbo.Stations(StationID),
	CONSTRAINT FK_StationsDeparture FOREIGN KEY (DepartureStationID)
	REFERENCES dbo.Stations(StationID)
);
GO 

--Добавим данные
INSERT INTO TrainStation.dbo.TrainTypes(Name)
VALUES ('Скорый'), ('Скоростной'), ('Пассажирский'), ('Пригородный');
GO

INSERT INTO TrainStation.dbo.CarriageTypes(Name)
VALUES ('Сидячий'), ('Плацкартный'), ('Купейный'), ('СВ');
GO