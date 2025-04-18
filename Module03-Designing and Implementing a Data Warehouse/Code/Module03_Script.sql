/*
=============
=============ساخت دیتابیس Dev_DWH جهت انتقال اطلاعات فروش دیتابیس AdventureWorks 2019
=============
*/
use [master]
GO
CREATE DATABASE [Dev_DWH]
 CONTAINMENT = NONE
 ON  
 PRIMARY 
	( NAME = N'Dev_DWH', FILENAME = N'/var/opt/mssql/data/Dev_DWH.mdf' , SIZE = 8MB , FILEGROWTH = 8MB ), 
 FILEGROUP [Config] 
	( NAME = N'Config01', FILENAME = N'/var/opt/mssql/data/Config01.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ), 
 FILEGROUP [Dim] 
	( NAME = N'Dim01', FILENAME = N'/var/opt/mssql/data/Dim01.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ),
	( NAME = N'Dim02', FILENAME = N'/var/opt/mssql/data/Dim02.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ), 
 FILEGROUP [Fact] 
	( NAME = N'Fact01', FILENAME = N'/var/opt/mssql/data/Fact01.ndf' , SIZE = 64MB , FILEGROWTH = 64MB ),
	( NAME = N'Fact02', FILENAME = N'/var/opt/mssql/data/Fact02.ndf' , SIZE = 64MB , FILEGROWTH = 64MB )
 LOG ON 
	( NAME = N'Dev_DWH_log', FILENAME = N'/var/opt/mssql/log/Dev_DWH_log.ldf' , SIZE = 1024MB , FILEGROWTH = 1024MB )
 COLLATE Persian_100_CI_AI
GO
ALTER DATABASE [Dev_DWH] MODIFY FILEGROUP [Config] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_DWH] MODIFY FILEGROUP [Dim] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_DWH] MODIFY FILEGROUP [Fact] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_DWH] MODIFY FILEGROUP [PRIMARY] AUTOGROW_ALL_FILES
GO
ALTER DATABASE [Dev_DWH] SET COMPATIBILITY_LEVEL = 150
GO
ALTER DATABASE [Dev_DWH] SET RECOVERY SIMPLE 
GO
USE [Dev_DWH]
GO
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'Fact') ALTER DATABASE [Dev_DWH] MODIFY FILEGROUP [Fact] DEFAULT
GO
/*
=============
=============ساخت جدول اسکیماها
=============
*/
USE [Dev_DWH]
GO
CREATE SCHEMA SLE
GO
CREATE SCHEMA GNR
GO
CREATE SCHEMA AUD
GO
CREATE SCHEMA CFG
GO
/*
=============
=============ساخت جدول DIM_DATE
=============
*/
USE [Dev_DWH]
GO
CREATE TABLE [GNR].[DIM_Date] (
    [GregorianDateKey]      INT           NOT NULL,
    [GregorianDate]         DATE          NOT NULL,
    [GregorianYearMonthDay] INT           NOT NULL,
    [JalaliDate]            NCHAR (10)    NOT NULL,
    [JalaliYearMonthDay]    INT           NOT NULL,
    [GregorianYear]         INT           NOT NULL,
    [GregorianYearHalf]     INT           NOT NULL,
    [GregorianYearQuarter]  INT           NOT NULL,
    [GregorianYearWeek]     INT           NOT NULL,
    [GregorianYearMonth]    INT           NOT NULL,
    [GregorianQuarter]      INT           NOT NULL,
    [GregorianHalf]         INT           NOT NULL,
    [GregorianMonth]        INT           NOT NULL,
    [GregorianDay]          INT           NOT NULL,
    [GregorianWeek]         INT           NOT NULL,
    [GregorianWeekDay]      INT           NOT NULL,
    [JalaliYear]            INT           NOT NULL,
    [JalaliYearHalf]        INT           NOT NULL,
    [JalaliYearQuarter]     INT           NOT NULL,
    [JalaliYearWeek]        INT           NOT NULL,
    [JalaliYearMonth]       INT           NOT NULL,
    [JalaliQuarter]         INT           NOT NULL,
    [JalaliHalf]            INT           NOT NULL,
    [JalaliMonth]           INT           NOT NULL,
    [JalaliDay]             INT           NOT NULL,
    [JalaliWeek]            INT           NOT NULL,
    [JalaliWeekDay]         INT           NOT NULL,
    [GregorianQuarterName]  NVARCHAR (50) NOT NULL,
    [GregorianHalfName]     NVARCHAR (50) NOT NULL,
    [GregorianMonthName]    NVARCHAR (50) NOT NULL,
    [GregorianWeekDayName]  NVARCHAR (50) NOT NULL,
    [JalaliQuarterName]     NVARCHAR (50) NOT NULL,
    [JalaliHalfName]        NVARCHAR (50) NOT NULL,
    [JalaliMonthName]       NVARCHAR (50) NOT NULL,
    [JalaliWeekDayName]     NVARCHAR (50) NOT NULL,
    [PeriodCode]            SMALLINT      CONSTRAINT [DF_GNR_DIM_Date_PeriodCode] DEFAULT ((0)) NOT NULL,
    [PeriodNameEn]          NVARCHAR (50) CONSTRAINT [DF_GNR_DIM_Date_PeriodNameEn] DEFAULT (N'Present') NOT NULL,
    [PeriodNameFa]          NVARCHAR (50) CONSTRAINT [DF_GNR_DIM_Date_PeriodNameFa] DEFAULT (N'روزجاری') NOT NULL,
    CONSTRAINT [PK_GNR_DIM_Date] PRIMARY KEY CLUSTERED ([GregorianDateKey] ASC) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE) ON [DIM]
) ON [DIM];
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Date_JalaliYearMonthDay]
    ON [GNR].[DIM_Date]([JalaliYearMonthDay] ASC) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Date_GregorianYearMonthDay]
    ON [GNR].[DIM_Date]([GregorianYearMonthDay] ASC) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Date_GregorianDate] 
    ON [GNR].[DIM_Date]([GregorianDate] ASC) INCLUDE (JalaliDate) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Date_JalaliDate]
    ON [GNR].[DIM_Date]([JalaliDate] ASC) INCLUDE ([GregorianDate]) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان روز هفته به جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliWeekDayName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliMonthName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان نیمه سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliHalfName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان فصل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliQuarterName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان روز هفته به میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianWeekDayName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianMonthName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان نیمه سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianHalfName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان فصل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianQuarterName';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در هفته جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliWeekDay';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره هفته در سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliWeek';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliDay';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliMonth';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره نیمه سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliHalf';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره فصل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliQuarter';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliYearMonth';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و هفته جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliYearWeek';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و فصل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliYearQuarter';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و نیمه سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliYearHalf';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliYear';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در هفته میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianWeekDay';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره هفته در سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianWeek';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianDay';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianMonth';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره نیمه سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianHalf';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره فصل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianQuarter';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianYearMonth';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و هفته میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianYearWeek';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و فصل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianYearQuarter';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و نیمه سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianYearHalf';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianYear';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال، ماه و روز جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliYearMonthDay';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تاریخ کامل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'JalaliDate';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال، ماه و روز میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianYearMonthDay';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تاریخ کامل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianDate';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شناسه تاریخ', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'GregorianDateKey';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تقویم', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date';
GO
EXECUTE sp_addextendedproperty @name = N'LoadTypeScript', @value = N'EXECUTE [GNR].[usp_DIM_Date_Fill] ''1900-01-01'',''1900-01-01'',0
GO
EXECUTE [GNR].[usp_DIM_Date_Fill] ''9997-12-30'',''9997-12-30'',0
GO
EXECUTE [GNR].[usp_DIM_Date_Fill] ''1921-03-21'',''2027-03-20'',0
GO', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date';
GO
EXECUTE sp_addextendedproperty @name = N'LoadType', @value = N'Static', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'دوره زمانی به فارسی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'PeriodNameFa';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'دوره زمانی به انگلیسی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'PeriodNameEn';
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'کد دوره زمانی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Date', @level2type = N'COLUMN', @level2name = N'PeriodCode';
GO
/*
=============
=============ساخت جدول محصول
=============
*/
CREATE TABLE [SLE].[DIM_Product] (
	[ProductKey] INT Identity NOT NULL,
	[BKProductNumber] nvarchar(25) NOT NULL,
	[ProductName] nvarchar(50) NOT NULL,
	[AuditProductId] int
) ON [DIM]
GO
CREATE UNIQUE CLUSTERED INDEX [PK_ProductKey] ON [SLE].[DIM_Product]
([ProductKey] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Dim]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQ_ProductKey] ON [SLE].[DIM_Product]
([BKProductNumber] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Dim]
GO
/*
=============
=============ساخت جدول مشتری
=============
*/
CREATE TABLE [SLE].[DIM_Customer] (
	[CustomerKey] INT Identity NOT NULL,
	[BKAccountNumber] nvarchar(10) NOT NULL,
	[FirstName] nvarchar(50) NOT NULL,
	[LastName] nvarchar(50) NOT NULL,
	[AuditCustomerId] int
) ON [DIM]
GO
CREATE UNIQUE CLUSTERED INDEX [PK_CustomerKey] ON [SLE].[DIM_Customer]
([CustomerKey] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Dim]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQ_BKAccountNumber] ON [SLE].[DIM_Customer]
([BKAccountNumber] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Dim]
GO
/*
=============
=============ساخت جدول مکان/منطقه
=============
*/
CREATE TABLE [SLE].[DIM_Territory] (
	[TerritoryKey] INT Identity NOT NULL,
	[BKTerritoryName] nvarchar(50) NOT NULL,
	[AuditTerritoryId] int
) ON [DIM]
GO
CREATE UNIQUE CLUSTERED INDEX [PK_TerritoryKey] ON [SLE].[DIM_Territory]
([TerritoryKey] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Dim]
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQ_BKTerritoryName] ON [SLE].[DIM_Territory]
([BKTerritoryName] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [Dim]
GO
/*
=============
=============ساخت جدول تراکنش های فروش
=============
*/
CREATE TABLE [SLE].[FACT_Sales] (
	[SalesKey] BIGINT Identity NOT NULL,
	[ProductKey] int NOT NULL,
	[CustomerKey] int NOT NULL,
	[TerritoryKey] int NOT NULL,
	[OrderDateKey] int NOT NULL,
	[Quantity] int NULL,
	[UnitPrice] money NULL,
	[Discount] money NULL,
	[Total] money NULL,
	[AuditSalesOrderId] int,
	[AuditSalesOrderDetailId] int
) ON [FACT]
GO
CREATE UNIQUE CLUSTERED INDEX [PK_SalesKey] ON [SLE].[FACT_Sales] 
([SalesKey] ASC)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = ON, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [FACT]
GO
/*
=============
=============ساخت جدول ثبت وقایع
=============
*/
CREATE TABLE [AUD].[Events] (
	[Id] BIGINT Identity NOT NULL,
	[Source] NVARCHAR(256) NOT NULL,
	[Type] NVARCHAR(20) NOT NULL,
	[Description] NVARCHAR(4000) NOT NULL,
	[InsertDate] DATETIME DEFAULT(GETDATE())
) ON [Config] WITH (DATA_COMPRESSION=PAGE)
GO
