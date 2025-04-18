
CREATE FUNCTION [GNR].[udf_JalaliToGregorianDate] (@JalaliDate VARCHAR(10),@Delimiter VARCHAR(1)='/') 
RETURNS DATETIME
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @myDelimiterPosition_Y INT,@myDelimiterPosition_M INT
	DECLARE @Sh_Y INT, @Sh_M INT, @Sh_D INT	
	--DECLARE @epbase INT, @epyear INT, @mdays INT, @persian_jdn INT, @i INT, @j INT, @l INT, @n INT
	DECLARE @I INT, @Leap INT, @D_of_Y INT, @TmpY INT
	DECLARE @Result DATETIME

	SET @JalaliDate=LTRIM(RTRIM(@JalaliDate))
	
	IF (@Delimiter IS NULL OR LEN(@Delimiter)=0) AND LEN(@JalaliDate)=8
	BEGIN
		SET @Delimiter='/'
		SET @JalaliDate=LEFT(@JalaliDate,4)+@Delimiter+SUBSTRING(@JalaliDate,5,2)+@Delimiter+RIGHT(@JalaliDate,2)
	END
	ELSE IF (@Delimiter IS NULL OR LEN(@Delimiter)=0) AND LEN(@JalaliDate)=6
	BEGIN
		SET @Delimiter='/'
		SET @JalaliDate=LEFT(@JalaliDate,2)+@Delimiter+SUBSTRING(@JalaliDate,3,2)+@Delimiter+RIGHT(@JalaliDate,2)
	END


	--Jalali Format Control
	IF	[GNR].[udf_JalaliDateValidation](@JalaliDate,@Delimiter)=0
		RETURN NULL

	SET @myDelimiterPosition_Y=CHARINDEX(@Delimiter,@JalaliDate)
	SET @myDelimiterPosition_M=CHARINDEX(@Delimiter,@JalaliDate,@myDelimiterPosition_Y+1)
	SET @Sh_Y=CAST(SUBSTRING(@JalaliDate,1,@myDelimiterPosition_Y-1) AS INT)
	SET @Sh_M=CAST(SUBSTRING(@JalaliDate,@myDelimiterPosition_Y+1,@myDelimiterPosition_M-@myDelimiterPosition_Y-1) AS INT)
	SET @Sh_D=CAST(SUBSTRING(@JalaliDate,@myDelimiterPosition_M+1,LEN(@JalaliDate)-@myDelimiterPosition_M) AS INT)

	IF @Sh_Y < 100
		SET @Sh_Y = @Sh_Y + 1300

 --   IF ( @Sh_Y >= 0 )
	--	SET @epbase = @Sh_Y - 474
	--ELSE
	--	SET @epbase = @Sh_Y - 473

	--SET @epyear = 474 + (@epbase % 2820)
 --   IF (@Sh_M <= 7 )
	--	SET @mdays = ((@Sh_M) - 1) * 31
 --   Else
	--	SET @mdays = ((@Sh_M) - 1) * 30 + 6
		
	--SET @persian_jdn =(@Sh_D)  + @mdays + CAST((((@epyear * 682) - 110) / 2816) as int)  + (@epyear - 1) * 365  +  CAST((@epbase / 2820)  as int ) * 1029983  + (1948321 - 1)
 --   IF (@persian_jdn > 2299160)
	--BEGIN
	--	SET @l = @persian_jdn + 68569
 --       SET @n = CAST(((4 * @l) / 146097) as int)
 --       SET @l = @l -  CAST(((146097 * @n + 3) / 4) as int)
 --       SET @i =  CAST(((4000 * (@l + 1)) / 1461001) as int)
 --       SET @l = @l - CAST( ((1461 * @i) / 4) as int) + 31
 --       SET @j =  CAST(((80 * @l) / 2447) as int)
 --       SET @Sh_D = @l - CAST( ((2447 * @j) / 80) as int)
 --       SET @l =  CAST((@j / 11) as int)
 --       SET @Sh_M = @j + 2 - 12 * @l
 --       SET @Sh_Y = 100 * (@n - 49) + @i + @l
	--END
	--SET @Result = DATETIMEFROMPARTS(@Sh_Y,@Sh_M,@Sh_D,0,0,0,0)

	IF @Sh_M >= 7
		SET @D_of_Y = 31 * 6 + (@Sh_M-7) * 30 + @Sh_D
	ELSE
		SET @D_of_Y = (@Sh_M-1) * 31 + @Sh_D

	IF @Sh_Y = 1278
	BEGIN
		SET @Result = @D_of_Y-(31*6 + 3*30+11)
	END
	ELSE
	BEGIN
		SET @Result = 365 - (31*6 + 3*30+11) + 1
		SET @I = 1279
		WHILE @I < @Sh_Y
		BEGIN
			SET @TmpY = @I + 11
			SET @TmpY = @TmpY - ( @TmpY / 33) * 33
			IF (@TmpY <> 32) AND ( (@TmpY / 4) * 4 = @TmpY )
				SET @Leap = 1
			ELSE
				SET @Leap = 0

			--IF [GNR].[udf_JalaliLeapYear](@I)=1
			--	SET @Leap = 1
			--ELSE
			--	SET @Leap = 0

			IF @Leap = 1
				SET @Result = @Result + 366
			ELSE
				SET @Result = @Result + 365

			SET @I = @I + 1
		END
		SET @Result = @Result + @D_of_Y - 1 
	END
	RETURN @Result
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع تبدیل تاریخ جلالی به تاریخ گرگورین', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_JalaliToGregorianDate';

