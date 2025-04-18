

-- =============================================
-- Author:		<Siavash Golchoobian>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [GNR].[usp_DIM_Date_Fill]  (@StartDate date,@EndDate date,@Recreate bit=0)
AS
BEGIN
	SET NOCOUNT ON;
	--SET @StartDate='2000/01/01'
	--SET @EndDate='2030/01/01'
	--SET @StartDate='9999-12-29'
	--SET @EndDate='9999-12-29'
	--SET @StartDate='1900-01-01'
	--SET @EndDate='1900-01-01'

	--Recreate Table
	IF @Recreate=1
	BEGIN
		Drop Table IF EXISTS [GNR].[DIM_Dates]
	CREATE TABLE [GNR].[DIM_Dates](
	[GregorianDateKey] [int] NOT NULL,
	[GregorianDate] [date] NOT NULL,
	[GregorianYear] [int] NOT NULL,
	[GregorianYearHalf] [int] NOT NULL,
	[GregorianYearQuarter] [int] NOT NULL,
	[GregorianYearWeek] [int] NOT NULL,
	[GregorianYearMonth] [int] NOT NULL,
	[GregorianYearMonthDay] [int] NOT NULL,
	[GregorianQuarter] [int] NOT NULL,
	[GregorianQuarterName] [nvarchar](50) NOT NULL,
	[GregorianHalf] [int] NOT NULL,
	[GregorianHalfName] [nvarchar](50) NOT NULL,
	[GregorianMonth] [int] NOT NULL,
	[GregorianMonthName] [nvarchar](50) NOT NULL,
	[GregorianDay] [int] NOT NULL,
	[GregorianWeek] [int] NOT NULL,
	[GregorianWeekDay] [int] NOT NULL,
	[GregorianWeekDayName] [nvarchar](50) NOT NULL,
	[JalaliDate] [nchar](10) NOT NULL,
	[JalaliYear] [int] NOT NULL,
	[JalaliYearHalf] [int] NOT NULL,
	[JalaliYearQuarter] [int] NOT NULL,
	[JalaliYearWeek] [int] NOT NULL,
	[JalaliYearMonth] [int] NOT NULL,
	[JalaliYearMonthDay] [int] NOT NULL,
	[JalaliQuarter] [int] NOT NULL,
	[JalaliQuarterName] [nvarchar](50) NOT NULL,
	[JalaliHalf] [int] NOT NULL,
	[JalaliHalfName] [nvarchar](50) NOT NULL,
	[JalaliMonth] [int] NOT NULL,
	[JalaliMonthName] [nvarchar](50) NOT NULL,
	[JalaliDay] [int] NOT NULL,
	[JalaliWeek] [int] NOT NULL,
	[JalaliWeekDay] [int] NOT NULL,
	[JalaliWeekDayName] [nvarchar](50) NOT NULL,
	[PeriodCode] SMALLINT NOT NULL,
	[PeriodNameEn] NVARCHAR(50) NOT NULL,
	[PeriodNameFa] NVARCHAR(50) NOT NULL
	 CONSTRAINT [PK_GNR_DIM_Dates] PRIMARY KEY CLUSTERED 
	(
		[GregorianDateKey] ASC
	)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 100) ON [Dim]
	) ON [Dim]
	END

	INSERT INTO [GNR].[DIM_Dates]
		(
		GregorianDateKey
		,GregorianDate
		,GregorianYear
		,GregorianYearHalf
		,GregorianYearQuarter
		,GregorianYearWeek
		,GregorianYearMonth
		,GregorianYearMonthDay
		,GregorianQuarter
		,GregorianQuarterName
		,GregorianHalf
		,GregorianHalfName
		,GregorianMonth
		,GregorianMonthName
		,GregorianDay
		,GregorianWeek
		,GregorianWeekDay
		,GregorianWeekDayName
		,JalaliDate
		,JalaliYear
		,JalaliYearHalf
		,JalaliYearQuarter
		,JalaliYearWeek
		,JalaliYearMonth
		,JalaliYearMonthDay
		,JalaliQuarter
		,JalaliQuarterName
		,JalaliHalf
		,JalaliHalfName
		,JalaliMonth
		,JalaliMonthName
		,JalaliDay
		,JalaliWeek
		,JalaliWeekDay
		,JalaliWeekDayName
		,PeriodCode
		,PeriodNameEn
		,PeriodNameFa
		)
	SELECT
		GregorianDateKey
		,GregorianDate
		,GregorianYear
		,GregorianYearHalf
		,GregorianYearQuarter
		,GregorianYearWeek
		,GregorianYearMonth
		,GregorianYearMonthDay
		,GregorianQuarter
		,GregorianQuarterName
		,GregorianHalf
		,GregorianHalfName
		,GregorianMonth
		,GregorianMonthName
		,GregorianDay
		,GregorianWeek
		,GregorianWeekDay
		,GregorianWeekDayName
		,JalaliDate
		,JalaliYear
		,JalaliYearHalf
		,JalaliYearQuarter
		,JalaliYearWeek
		,JalaliYearMonth
		,JalaliYearMonthDay
		,JalaliQuarter
		,JalaliQuarterName
		,JalaliHalf
		,JalaliHalfName
		,JalaliMonth
		,JalaliMonthName
		,JalaliDay
		,JalaliWeek
		,JalaliWeekDay
		,JalaliWeekDayName
		,PeriodCode
		,PeriodNameEn
		,PeriodCode
	FROM
		[GNR].[udtf_GetDateTimeCastsBootstrapper](@StartDate,@EndDate)
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'پرکردن DIM_Dates', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'PROCEDURE', @level1name = N'usp_DIM_Date_Fill';

