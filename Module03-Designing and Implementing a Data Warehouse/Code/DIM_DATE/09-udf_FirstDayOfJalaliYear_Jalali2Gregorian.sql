




CREATE FUNCTION [GNR].[udf_FirstDayOfJalaliYear_Jalali2Gregorian] (@JalaliDate VARCHAR(10) , @Delimiter VARCHAR(1))
RETURNS DATETIME
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @myJalaliDate VARCHAR(10)
	SET @myJalaliDate=[GNR].[udf_FirstDayOfJalaliYear_Jalali2Jalali](@JalaliDate,@Delimiter)
	RETURN 
		[GNR].[udf_JalaliToGregorianDate](@myJalaliDate,@Delimiter)
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع محاسبه اولین روز سال جلالی به صورت تاریخ گرگورین بر اساس تاریخ جلالی اعلام شده', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_FirstDayOfJalaliYear_Jalali2Gregorian';

