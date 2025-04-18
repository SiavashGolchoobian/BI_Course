
CREATE FUNCTION [GNR].[udf_GregorianToJalaliDate](@GregorianDate DATETIME,@Delimiter VARCHAR(1)='/') 
RETURNS VARCHAR(10)
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @SolarDate CHAR(10)
	DECLARE @Day CHAR(2)
	DECLARE @Mon CHAR(2)
	DECLARE @Year CHAR(4)
	DECLARE @SDay INT
	DECLARE @SMon INT
	DECLARE @SYear INT

	SET @SYear = GNR.[udf_JalaliDatePart_Gregorian2Num](@GregorianDate, 'Y')
	SET @SMon = GNR.[udf_JalaliDatePart_Gregorian2Num](@GregorianDate, 'M')
	SET @SDay = GNR.[udf_JalaliDatePart_Gregorian2Num](@GregorianDate, 'D')

	SET @Year = CONVERT(CHAR(4),@SYear)

	IF @SMon <= 9
		SET @Mon = '0'+CONVERT(CHAR(1),@SMon)
	ELSE
		SET @Mon = CONVERT(CHAR(2),@SMon)

	IF @SDay <= 9
		SET @Day = '0'+CONVERT(CHAR(1),@SDay)
	ELSE
		SET @Day = CONVERT(CHAR(2),@SDay)

	SET @SolarDate = @Year+@Delimiter+@Mon+@Delimiter+@Day

	RETURN @SolarDate
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع تبدیل تاریخ گرگورین به تاریخ جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_GregorianToJalaliDate';

