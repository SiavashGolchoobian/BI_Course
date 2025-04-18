

CREATE FUNCTION [GNR].[udf_FirstDayOfJalaliYear_Jalali2Jalali] (@JalaliDate VARCHAR(10) , @Delimiter VARCHAR(1))
RETURNS VARCHAR(10)
WITH SCHEMABINDING
AS
BEGIN
	RETURN 
		LEFT(@JalaliDate,5)+'01' + @Delimiter + '01'
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع محاسبه اولین روز سال جلالی به صورت تاریخ جلالی بر اساس تاریخ جلالی اعلام شده', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_FirstDayOfJalaliYear_Jalali2Jalali';

