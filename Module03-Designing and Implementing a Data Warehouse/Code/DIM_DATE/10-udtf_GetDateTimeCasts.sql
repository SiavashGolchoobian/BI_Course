﻿


-- =============================================
-- Author:		<Golchoobin>
-- Create date: <8/5/2016>
-- Description:	<Retrive timeflags>
-- =============================================
CREATE FUNCTION [GNR].[udtf_GetDateTimeCasts] (@date DATETIME)
RETURNS 
@Answer TABLE 
(
	flag_name NVARCHAR(50), 
	flag_value NVARCHAR(255)
)
WITH SCHEMABINDING
--Variable Names are:
--GR_DATE_NUM
--GR_DATE
--JL_DATE
--GR_YEAR_NUM
--JL_YEAR_NUM
--GR_MONTH_NUM
--JL_MONTH_NUM
--GR_MONTH_NAME
--JL_MONTH_NAME
--GR_DAYOFMONTH_NUM
--JL_DAYOFMONTH_NUM
--GR_DAYOFYEAR_NUM
--JL_DAYOFYEAR_NUM
--GR_WEEKOFYEAR_NUM
--JL_WEEKOFYEAR_NUM
--GR_DAYOFWEEK_NUM
--JL_DAYOFWEEK_NUM
--GR_DAYOFWEEK_NAME
--JL_DAYOFWEEK_NAME
--GR_QUARTER_NUM
--JL_QUARTER_NUM
--GR_QUARTER_NAME
--JL_QUARTER_NAME
--GR_HALF_NUM
--JL_HALF_NUM
--GR_HALF_NAME
--JL_HALF_NAME
--ISLEAPYEAR
--TIME_FULL
--TIME_HHMMSS
--TIME_HHMM
--HOUR
--MINUTE
--SECOND

AS
BEGIN
	DECLARE @Time AS TIME
	DECLARE @Date_Gregorian AS DATE
	DECLARE @Date_Jalali AS VARCHAR(10)
	DECLARE @StartYear_JalaliToGregorian AS DATE
	DECLARE @StringValue NVARCHAR(255)
	
	SET @Date_Gregorian=CAST(@date as date)
	SET @Date_Jalali=GNR.udf_GregorianToJalaliDate(@date,'/')
	SET @Time=CAST(@date AS TIME)
	SET @StartYear_JalaliToGregorian=[GNR].[udf_FirstDayOfJalaliYear_Jalali2Gregorian](@Date_Jalali,'/')

	--تاریخ مبلادی به عدد
	SET @StringValue=LTRIM(RTRIM(CAST(CONVERT(VARCHAR(10),@Date_Gregorian ,112) AS int)))
	IF NOT @StringValue IS NULL
		INSERT INTO @Answer
		        ( flag_name, flag_value )
		VALUES  ( '{%GR_DATE_NUM%}', @StringValue)

	--تاریخ میلادی
	IF NOT @Date_Gregorian IS NULL
		BEGIN
			SET @StringValue=CAST(DATEPART(YEAR,@Date_Gregorian) AS NVARCHAR(20))
			IF DATEPART(MONTH,@Date_Gregorian)<10
				BEGIN
					SET @StringValue=@StringValue + '/0' + CAST(DATEPART(month,@Date_Gregorian) AS NVARCHAR(255))
				END
				ELSE
				BEGIN
					SET @StringValue=@StringValue + '/' + CAST(DATEPART(MONTH,@Date_Gregorian) AS NVARCHAR(255))
				END
			IF DATEPART(DAY,@Date_Gregorian)<10
				BEGIN
					SET @StringValue=@StringValue + '/0' + CAST(DATEPART(DAY,@Date_Gregorian) AS NVARCHAR(255))
				END
				ELSE
				BEGIN
					SET @StringValue=@StringValue + '/' + CAST(DATEPART(DAY,@Date_Gregorian) AS NVARCHAR(255))
				END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_DATE%}', @StringValue)
		END

	--تاریخ شمسی
	SET @StringValue=LTRIM(RTRIM(CAST(@Date_Jalali AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		INSERT INTO @Answer
		        ( flag_name, flag_value )
		VALUES  ( '{%JL_DATE%}', @StringValue)

	--سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(year,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		INSERT INTO @Answer
		        ( flag_name, flag_value )
		VALUES  ( '{%GR_YEAR_NUM%}', @StringValue)

	--سال شمسی
	SET @StringValue=LTRIM(RTRIM(LEFT(@Date_Jalali,4)))
	IF NOT @StringValue IS NULL
		INSERT INTO @Answer
		        ( flag_name, flag_value )
		VALUES  ( '{%JL_YEAR_NUM%}', @StringValue)
	
	--شماره ماه میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(month,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_MONTH_NUM%}', @StringValue)
		END

	--شماره ماه شمسی
	SET @StringValue=LTRIM(RTRIM(SUBSTRING(@Date_Jalali,6,2)))
	IF NOT @StringValue IS NULL
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_MONTH_NUM%}', @StringValue)

	--نام ماه میلادی
	SET @StringValue=LTRIM(RTRIM(DATENAME(month,@Date_Gregorian)))
	IF NOT @StringValue IS NULL
		INSERT INTO @Answer
		        ( flag_name, flag_value )
		VALUES  ( '{%GR_MONTH_NAME%}', @StringValue)

	--نام ماه شمسی
	SET @StringValue=LTRIM(RTRIM(SUBSTRING(@Date_Jalali,6,2)))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE @StringValue
								WHEN '01' THEN N'فروردين'
								WHEN '02' THEN N'ارديبهشت'
								WHEN '03' THEN N'خرداد'
								WHEN '04' THEN N'تير'
								WHEN '05' THEN N'مرداد'
								WHEN '06' THEN N'شهريور'
								WHEN '07' THEN N'مهر'
								WHEN '08' THEN N'آبان'
								WHEN '09' THEN N'آذر'
								WHEN '10' THEN N'دي'
								WHEN '11' THEN N'بهمن'
								WHEN '12' THEN N'اسفند'
								ELSE @StringValue
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_MONTH_NAME%}', @StringValue)
		END

	--شماره روز در ماه میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(DAY,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_DAYOFMONTH_NUM%}', @StringValue)
		END

	--شماره روز در ماه شمسی
	SET @StringValue=LTRIM(RTRIM(RIGHT(@Date_Jalali,2)))
	IF NOT @StringValue IS NULL
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_DAYOFMONTH_NUM%}', @StringValue)

	--شماره روز در سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(DAYOFYEAR,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_DAYOFYEAR_NUM%}', @StringValue)
		END

	--شماره روز در سال شمسی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEDIFF(DAY,@StartYear_JalaliToGregorian,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_DAYOFYEAR_NUM%}', @StringValue)
		END

	--شماره هفته در سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(WEEK,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_WEEKOFYEAR_NUM%}', @StringValue)
		END

	--شماره هفته در سال شمسی
	
	SET @StringValue=ISNULL(LTRIM(RTRIM(CAST(
									ABS(CEILING((((DATEPART(WEEKDAY,@StartYear_JalaliToGregorian) -1 + 1) % 7) + DATEDIFF(DAY,@StartYear_JalaliToGregorian,@Date_Gregorian) + 1)/-7.01))
									+ 1 AS NVARCHAR(255)))),'0')
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_WEEKOFYEAR_NUM%}', @StringValue)
		END

	--شماره روز در هفته میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(WEEKDAY,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_DAYOFWEEK_NUM%}', @StringValue)
		END

	--شماره روز در هفته شمسی
	SET @StringValue=LTRIM(RTRIM(CAST(DATENAME(WEEKDAY,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE @StringValue
								When 'Saturday' Then '01'
								When 'Sunday' Then '02'
								When 'Monday' Then '03'
								When 'Tuesday' Then '04'
								When 'Wednesday' Then '05'
								When 'Thursday' Then '06'
								Else '07'
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_DAYOFWEEK_NUM%}', @StringValue)
		END

	--نام روز در هفته میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATENAME(WEEKDAY,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_DAYOFWEEK_NAME%}', @StringValue)
		END

	--نام روز در هفته شمسی
	SET @StringValue=LTRIM(RTRIM(CAST(DATENAME(WEEKDAY,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE @StringValue
								When 'Saturday' Then N'شنبه'
								When 'Sunday' Then N'یکشنبه'
								When 'Monday' Then N'دوشنبه'
								When 'Tuesday' Then N'سه شنبه'
								When 'Wednesday' Then N'چهارشنبه'
								When 'Thursday' Then N'پنجشنبه'
								Else N'جمعه'
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_DAYOFWEEK_NAME%}', @StringValue)
		END

	--شماره فصل در سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(quarter,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_QUARTER_NUM%}', @StringValue)
		END

	--شماره فصل در سال شمسی
	SET @StringValue=LTRIM(RTRIM(SUBSTRING(@Date_Jalali,6,2)))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE 
								When @StringValue IN ('01','02','03') Then '01'
								When @StringValue IN ('04','05','06') Then '02'
								When @StringValue IN ('07','08','09') Then '03'
								Else '04'
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_QUARTER_NUM%}', @StringValue)
		END

	--نام فصل در سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATENAME(quarter,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN 'Q'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_QUARTER_NAME%}', @StringValue)
		END

	--نام فصل در سال شمسی
	SET @StringValue=LTRIM(RTRIM(SUBSTRING(@Date_Jalali,6,2)))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE 
								When @StringValue IN ('01','02','03') Then N'بهار'
								When @StringValue IN ('04','05','06') Then N'تابستان'
								When @StringValue IN ('07','08','09') Then N'پاييز'
								Else N'زمستان'
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_QUARTER_NAME%}', @StringValue)
		END

	--شماره نیمه در سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(quarter,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE WHEN @StringValue IN ('1','2') THEN N'1' ELSE N'2' END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_HALF_NUM%}', @StringValue)
		END

	--شماره نیمه در سال شمسی
	SET @StringValue=LTRIM(RTRIM(SUBSTRING(@Date_Jalali,6,2)))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE 
								When @StringValue IN ('01','02','03','04','05','06') Then N'1'
								Else N'2'
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_HALF_NUM%}', @StringValue)
		END

	--نام نیمه در سال میلادی
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(quarter,@Date_Gregorian) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE WHEN @StringValue IN ('1','2') THEN N'First Half' ELSE N'Second Half' END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%GR_HALF_NAME%}', @StringValue)
		END

	--نام نیمه در سال شمسی
	SET @StringValue=LTRIM(RTRIM(SUBSTRING(@Date_Jalali,6,2)))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue = CASE 
								When @StringValue IN ('01','02','03','04','05','06') Then N'نیمه اول سال'
								Else N'نیمه دوم سال'
							 END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%JL_HALF_NAME%}', @StringValue)
		END
	--سال کبیسه
	SELECT @StringValue=CAST(GNR.udf_IsJalaliLeapYear(CAST(LEFT(@Date_Jalali,4) AS INT)) AS NVARCHAR(255))
	IF NOT @StringValue IS NULL
		BEGIN
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%ISLEAPYEAR%}', @StringValue)
		END

	--زمان کامل
	SET @StringValue=LTRIM(RTRIM(CAST(@Time AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%TIME_FULL%}', @StringValue)
		END

	--زمان ساعت دقیقه ثانیه
	SET @StringValue=LTRIM(RTRIM(LEFT(CAST(@Time AS NVARCHAR(255)),8)))
	IF NOT @StringValue IS NULL
		BEGIN
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%TIME_HHMMSS%}', @StringValue)
		END

	--زمان ساعت دقیقه
	SET @StringValue=LTRIM(RTRIM(LEFT(CAST(@Time AS NVARCHAR(255)),5)))
	IF NOT @StringValue IS NULL
		BEGIN
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%TIME_HHMM%}', @StringValue)
		END

	--زمان ساعت
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(HOUR,@Time) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%HOUR%}', @StringValue)
		END

	--زمان دقیقه
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(MINUTE,@Time) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%MINUTE%}', @StringValue)
		END

	--زمان ثانیه
	SET @StringValue=LTRIM(RTRIM(CAST(DATEPART(SECOND,@Time) AS NVARCHAR(255))))
	IF NOT @StringValue IS NULL
		BEGIN
			SET @StringValue=CASE LEN(@StringValue) WHEN 1 THEN '0'+@StringValue ELSE @StringValue END
			INSERT INTO @Answer
					( flag_name, flag_value )
			VALUES  ( '{%SECOND%}', @StringValue)
		END
	RETURN
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع تولید رکوردست حاوی فرمت های مختلف یک زمان مشخص', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udtf_GetDateTimeCasts';

