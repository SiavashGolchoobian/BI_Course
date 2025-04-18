/*
=============
=============ساخت دیتابیس Dev_STG جهت انتقال اطلاعات فروش دیتابیس AdventureWorks 2019
=============
*/
use [master]
GO
CREATE DATABASE [Dev_STG]
 CONTAINMENT = NONE
 ON  
 PRIMARY 
	( NAME = N'Dev_STG', FILENAME = N'/var/opt/mssql/data/Dev_STG.mdf' , SIZE = 8MB , FILEGROWTH = 8MB ), 
 FILEGROUP [Extract] 
	( NAME = N'Extract01', FILENAME = N'/var/opt/mssql/data/Extract01.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ),
	( NAME = N'Extract02', FILENAME = N'/var/opt/mssql/data/Extract02.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ), 
 FILEGROUP [Transform] 
	( NAME = N'Transform01', FILENAME = N'/var/opt/mssql/data/Transform01.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ),
	( NAME = N'Transform02', FILENAME = N'/var/opt/mssql/data/Transform02.ndf' , SIZE = 64MB , FILEGROWTH = 64MB )
 LOG ON 
	( NAME = N'Dev_STG_log', FILENAME = N'/var/opt/mssql/log/Dev_STG_log.ldf' , SIZE = 1024MB , FILEGROWTH = 1024MB )
 COLLATE Persian_100_CI_AI
GO
ALTER DATABASE [Dev_STG] MODIFY FILEGROUP [Extract] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_STG] MODIFY FILEGROUP [Transform] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_STG] MODIFY FILEGROUP [PRIMARY] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_STG] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [Dev_STG] SET RECOVERY SIMPLE 
GO
USE [Dev_STG]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'Extract') ALTER DATABASE [Dev_STG] MODIFY FILEGROUP [Extract] DEFAULT
GO
/*
=============
=============ساخت جدول اسکیماها
=============
*/
USE [Dev_STG]
GO
CREATE SCHEMA [EXTRACT]
GO
CREATE SCHEMA [TRANSFORM]
GO
/*
=============
=============ساخت جدول واکشی محصولات
=============
*/
CREATE TABLE [Extract].[SLE_DIM_Product01] (
    [Id] int identity PRIMARY KEY,
	[ProductID] int,
    [Name] nvarchar(255),
    [ProductNumber] nvarchar(50),
    [ModifiedDate] datetime,
    [rowguid] uniqueidentifier
) ON [Extract] WITH (DATA_COMPRESSION=PAGE)