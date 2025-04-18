

CREATE FUNCTION [GNR].[udf_JalaliDateValidation] (@JalaliDate VARCHAR(10) , @Delimiter VARCHAR(1))
RETURNS BIT
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @myDelimiterPosition_Y INT,@myDelimiterPosition_M INT
	DECLARE @Sh_Y INT, @Sh_M INT, @Sh_D INT	
	DECLARE @Result BIT

    SET @Result=1

	IF	(
		PATINDEX('[0-9][0-9][' + @Delimiter + '][0-9][' + @Delimiter + '][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][' + @Delimiter + '][0-9][' + @Delimiter + '][0-9][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][' + @Delimiter + '][0-9][0-9][' + @Delimiter + '][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][' + @Delimiter + '][0-9][0-9][' + @Delimiter + '][0-9][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][0-9][0-9][' + @Delimiter + '][0-9][' + @Delimiter + '][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][0-9][0-9][' + @Delimiter + '][0-9][' + @Delimiter + '][0-9][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][0-9][0-9][' + @Delimiter + '][0-9][0-9][' + @Delimiter + '][0-9]',@JalaliDate)+
		PATINDEX('[0-9][0-9][0-9][0-9][' + @Delimiter + '][0-9][0-9][' + @Delimiter + '][0-9][0-9]',@JalaliDate)
		)=0
		SET @Result=0

	IF @Result=1
	BEGIN
		SET @myDelimiterPosition_Y=CHARINDEX(@Delimiter,@JalaliDate)
		SET @myDelimiterPosition_M=CHARINDEX(@Delimiter,@JalaliDate,@myDelimiterPosition_Y+1)
		SET @Sh_Y=CAST(SUBSTRING(@JalaliDate,1,@myDelimiterPosition_Y-1) AS INT)
		SET @Sh_M=CAST(SUBSTRING(@JalaliDate,@myDelimiterPosition_Y+1,@myDelimiterPosition_M-@myDelimiterPosition_Y-1) AS INT)
		SET @Sh_D=CAST(SUBSTRING(@JalaliDate,@myDelimiterPosition_M+1,LEN(@JalaliDate)-@myDelimiterPosition_M) AS INT)
		IF @Sh_Y < 100 SET @Sh_Y = @Sh_Y + 1300
		
		IF @Sh_Y < 1200 SET @Result=0
		IF @Sh_M < 1 OR @Sh_M > 12 SET @Result=0
		IF @Sh_D < 1 OR @Sh_D > 31 SET @Result=0
		IF @Sh_M <= 6 AND @Sh_D > 31 SET @Result=0
		IF @Sh_M > 6 AND @Sh_M <= 11 AND @Sh_D > 30 SET @Result=0
		IF @Sh_M = 12 AND @Sh_D > 30 SET @Result=0
		IF @Sh_M = 12 AND @Sh_D>29 AND [GNR].[udf_IsJalaliLeapYear] (@Sh_Y)=0 SET @Result=0
	END

	RETURN @Result
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع اعتبار سنجی فرمت و اعداد تاریخ جلالی اعلام شده', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_JalaliDateValidation';

