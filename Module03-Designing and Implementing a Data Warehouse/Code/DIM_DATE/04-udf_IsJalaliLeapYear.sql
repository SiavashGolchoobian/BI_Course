

CREATE FUNCTION [GNR].[udf_IsJalaliLeapYear] (@JalaliYear INT)
RETURNS BIT
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @myAlpha DECIMAL(4,3)
	DECLARE @myBeta INT
	DECLARE @myLeapDays0 DECIMAL(19,5)
	DECLARE @myLeapDays1 DECIMAL(19,5)
	DECLARE @myFrac0 INT
	DECLARE @myFrac1 INT
	DECLARE @Result BIT

	SET @myAlpha=0.025
	SET @myBeta=266

	SET @myLeapDays0 = ((@JalaliYear + 38) % 2820)*0.24219 + @myAlpha	--# 0.24219 ~ extra days of one year
    SET @myLeapDays1 = ((@JalaliYear + 39) % 2820)*0.24219 + @myAlpha	--# 38 days is the difference of epoch to 2820-year cycle

    SET @myFrac0 = CAST((@myLeapDays0 - CAST(@myLeapDays0 AS INT))*1000 AS INT)
	SET @myFrac1 = CAST((@myLeapDays1 - CAST(@myLeapDays1 AS INT))*1000 AS INT)

	RETURN CASE WHEN @myFrac0 <= @myBeta AND @myFrac1 > @myBeta THEN 1 ELSE 0 END
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع تشخیص سال کبیسه بر اساس تقویم جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_IsJalaliLeapYear';

