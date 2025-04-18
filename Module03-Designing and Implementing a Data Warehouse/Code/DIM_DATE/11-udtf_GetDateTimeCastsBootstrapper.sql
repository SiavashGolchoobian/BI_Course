
-- =============================================
-- Author:		<Siavash Golchoobian>
-- Create date: <8/6/2016>
-- Description:	<Get list of casted date times>
-- =============================================
CREATE FUNCTION [GNR].[udtf_GetDateTimeCastsBootstrapper] (@StartDate DATE,@EndDate DATE)
RETURNS 
@myDimDate TABLE 
(
		[GregorianDateKey] [INT] NOT NULL,
		[GregorianDate] [DATE] NOT NULL,
		[GregorianYear] [INT] NOT NULL,
		[GregorianYearHalf] [INT] NOT NULL,
		[GregorianYearQuarter] [INT] NOT NULL,
		[GregorianYearWeek] [INT] NOT NULL,
		[GregorianYearMonth] [INT] NOT NULL,
		[GregorianYearMonthDay] [INT] NOT NULL,
		[GregorianQuarter] [INT] NOT NULL,
		[GregorianQuarterName] [NVARCHAR](50) NOT NULL,
		[GregorianHalf] [INT] NOT NULL,
		[GregorianHalfName] [NVARCHAR](50) NOT NULL,
		[GregorianMonth] [INT] NOT NULL,
		[GregorianMonthName] [NVARCHAR](50) NOT NULL,
		[GregorianDay] [INT] NOT NULL,
		[GregorianWeek] [INT] NOT NULL,
		[GregorianWeekDay] [INT] NOT NULL,
		[GregorianWeekDayName] [NVARCHAR](50) NOT NULL,
		[JalaliDate] [NCHAR](10) NOT NULL,
		[JalaliYear] [INT] NOT NULL,
		[JalaliYearHalf] [INT] NOT NULL,
		[JalaliYearQuarter] [INT] NOT NULL,
		[JalaliYearWeek] [INT] NOT NULL,
		[JalaliYearMonth] [INT] NOT NULL,
		[JalaliYearMonthDay] [INT] NOT NULL,
		[JalaliQuarter] [INT] NOT NULL,
		[JalaliQuarterName] [NVARCHAR](50) NOT NULL,
		[JalaliHalf] [INT] NOT NULL,
		[JalaliHalfName] [NVARCHAR](50) NOT NULL,
		[JalaliMonth] [INT] NOT NULL,
		[JalaliMonthName] [NVARCHAR](50) NOT NULL,
		[JalaliDay] [INT] NOT NULL,
		[JalaliWeek] [INT] NOT NULL,
		[JalaliWeekDay] [INT] NOT NULL,
		[JalaliWeekDayName] [NVARCHAR](50) NOT NULL,
		[PeriodCode] SMALLINT NOT NULL,
		[PeriodNameEn] NVARCHAR(50) NOT NULL,
		[PeriodNameFa] NVARCHAR(50) NOT NULL
)
WITH SCHEMABINDING
AS
BEGIN
	
	--Add Records
	DECLARE @Today DATE
	DECLARE @GregorianDateKey INT
	DECLARE @GregorianDate DATE
	DECLARE @GregorianYear INT
	DECLARE @GregorianYearHalf int
	DECLARE @GregorianYearQuarter int
	DECLARE @GregorianYearWeek int
	DECLARE @GregorianYearMonth int
	DECLARE @GregorianYearMonthDay int
	DECLARE @GregorianHalf INT
	DECLARE @GregorianHalfName nvarchar(50)
	DECLARE @GregorianQuarter INT
	DECLARE @GregorianQuarterName nvarchar(50)
	DECLARE @GregorianMonth INT
	DECLARE @GregorianMonthName nvarchar(50)
	DECLARE @GregorianDay INT
	DECLARE @GregorianWeek INT
	DECLARE @GregorianWeekDay INT
	DECLARE @GregorianWeekDayName nvarchar(50)
	DECLARE @JalaliDate nchar(10)
	DECLARE @JalaliYear int
	DECLARE @JalaliYearHalf int
	DECLARE @JalaliYearQuarter int
	DECLARE @JalaliYearWeek int
	DECLARE @JalaliYearMonth int
	DECLARE @JalaliYearMonthDay int
	DECLARE @JalaliQuarter int
	DECLARE @JalaliQuarterName nvarchar(50)
	DECLARE @JalaliHalf int
	DECLARE @JalaliHalfName nvarchar(50)
	DECLARE @JalaliMonth int
	DECLARE @JalaliMonthName nvarchar(50)
	DECLARE @JalaliDay int
	DECLARE @JalaliWeek INT
	DECLARE @JalaliWeekDay INT
	DECLARE @JalaliWeekDayName nvarchar(50)
	DECLARE @PeriodCode SMALLINT
	DECLARE @PeriodNameEn NVARCHAR(50)
	DECLARE @PeriodNameFa NVARCHAR(50)

	SET @Today=CAST(GETDATE() AS DATE)
	SET @GregorianDate=@StartDate
	
	WHILE @GregorianDate<=@EndDate
	BEGIN
		--SELECT @GregorianDate=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name=''
		SELECT @GregorianDateKey=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_DATE_NUM%}'
		SELECT @GregorianYear=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_YEAR_NUM%}'
		SELECT @GregorianYearHalf=CAST(@GregorianYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_HALF_NUM%}'
		SELECT @GregorianYearQuarter=CAST(@GregorianYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_QUARTER_NUM%}'
		SELECT @GregorianYearWeek=CAST(@GregorianYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_WEEKOFYEAR_NUM%}'
		SELECT @GregorianYearMonth=CAST(@GregorianYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_MONTH_NUM%}'
		SELECT @GregorianYearMonthDay=CAST(@GregorianYearMonth as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_DAYOFMONTH_NUM%}'
		SELECT @GregorianQuarter=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_QUARTER_NUM%}'
		SELECT @GregorianQuarterName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_QUARTER_NAME%}'
		SELECT @GregorianHalf=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_HALF_NUM%}'
		SELECT @GregorianHalfName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_HALF_NAME%}'
		SELECT @GregorianMonth=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_MONTH_NUM%}'
		SELECT @GregorianMonthName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_MONTH_NAME%}'
		SELECT @GregorianDay=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_DAYOFMONTH_NUM%}'
		SELECT @GregorianWeek=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_WEEKOFYEAR_NUM%}'
		SELECT @GregorianWeekDay=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_DAYOFWEEK_NUM%}'
		SELECT @GregorianWeekDayName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%GR_DAYOFWEEK_NAME%}'
		SELECT @JalaliDate=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_DATE%}'
		SELECT @JalaliYear=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_YEAR_NUM%}'
		SELECT @JalaliYearHalf=CAST(@JalaliYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_HALF_NUM%}'
		SELECT @JalaliYearQuarter=CAST(@JalaliYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_QUARTER_NUM%}'
		SELECT @JalaliYearWeek=CAST(@JalaliYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_WEEKOFYEAR_NUM%}'
		SELECT @JalaliYearMonth=CAST(@JalaliYear as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_MONTH_NUM%}'
		SELECT @JalaliYearMonthDay=CAST(@JalaliYearMonth as nvarchar(20)) + flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_DAYOFMONTH_NUM%}'
		SELECT @JalaliQuarter=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_QUARTER_NUM%}'
		SELECT @JalaliQuarterName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_QUARTER_NAME%}'
		SELECT @JalaliHalf=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_HALF_NUM%}'
		SELECT @JalaliHalfName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_HALF_NAME%}'
		SELECT @JalaliMonth=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_MONTH_NUM%}'
		SELECT @JalaliMonthName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_MONTH_NAME%}'
		SELECT @JalaliDay=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_DAYOFMONTH_NUM%}'
		SELECT @JalaliWeek=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_WEEKOFYEAR_NUM%}'
		SELECT @JalaliWeekDay=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_DAYOFWEEK_NUM%}'
		SELECT @JalaliWeekDayName=flag_value from [GNR].[udtf_GetDateTimeCasts](@GregorianDate) where flag_name='{%JL_DAYOFWEEK_NAME%}'
		SET @PeriodCode =	CASE 
								WHEN @GregorianDate < @Today THEN -1
								WHEN @GregorianDate = @Today THEN 0
								ELSE 1
							END
		SET @PeriodNameEn =	CASE @PeriodCode
								WHEN -1 THEN N'Past'
								WHEN  0 THEN N'Present'
								ELSE N'Future'
							END
		SET @PeriodNameFa =	CASE @PeriodCode
								WHEN -1 THEN N'گذشته'
								WHEN  0 THEN N'روزجاری'
								ELSE N'آینده'
							END

		INSERT INTO @myDimDate
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
			VALUES
			(
			@GregorianDateKey
			,@GregorianDate	
			,@GregorianYear
			,@GregorianYearHalf
			,@GregorianYearQuarter
			,@GregorianYearWeek
			,@GregorianYearMonth
			,@GregorianYearMonthDay
			,@GregorianQuarter
			,@GregorianQuarterName
			,@GregorianHalf
			,@GregorianHalfName
			,@GregorianMonth
			,@GregorianMonthName
			,@GregorianDay
			,@GregorianWeek
			,@GregorianWeekDay
			,@GregorianWeekDayName 
			,@JalaliDate
			,@JalaliYear
			,@JalaliYearHalf
			,@JalaliYearQuarter
			,@JalaliYearWeek
			,@JalaliYearMonth
			,@JalaliYearMonthDay
			,@JalaliQuarter
			,@JalaliQuarterName
			,@JalaliHalf
			,@JalaliHalfName
			,@JalaliMonth
			,@JalaliMonthName
			,@JalaliDay
			,@JalaliWeek
			,@JalaliWeekDay
			,@JalaliWeekDayName
			,@PeriodCode
			,@PeriodNameEn
			,@PeriodNameFa
			)
	
		--PRINT	CAST(@GregorianDate AS NCHAR(10)) + ',' + @GregorianYear + ',' + @GregorianMonth + ',' + @GregorianDay
		--		 + ',' + @ShamsiDate + ',' + @ShamsiYear + ',' + @ShamsiMonth + ',' + @ShamsiDay + ',' + CAST(@GregorianQuarterOfYear AS NCHAR(1))
		--		 + ',' + CAST(@ShamsiQuarterOfYear AS NCHAR(1))
			 
		SET @GregorianDate=DATEADD(DAY,1,@GregorianDate)
	END
	
	RETURN
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع تولید رکوردست حاوی فرمت های مختلف تاریخ های موجود در یک رنج زمانی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udtf_GetDateTimeCastsBootstrapper';

