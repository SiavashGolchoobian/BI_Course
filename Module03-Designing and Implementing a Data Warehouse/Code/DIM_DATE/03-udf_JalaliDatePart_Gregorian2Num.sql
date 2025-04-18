
CREATE FUNCTION [GNR].[udf_JalaliDatePart_Gregorian2Num] (@GregorianDate DATETIME , @DatePart CHAR)
RETURNS INT
WITH SCHEMABINDING
AS
BEGIN
  Declare @TmpY int, @Leap int
  Declare @Sh_Y int , @Sh_M int , @Sh_D int, @Result INT
  DECLARE @Sh_Q INT, @Sh_H INT
  
  SET @GregorianDate=CAST(@GregorianDate AS DATE)

  IF @GregorianDate IS NULL
	RETURN 0

  --Declare @Result int
  SET @Result = CONVERT(INT, CONVERT(FLOAT,@GregorianDate))

  IF @Result <= 78
  BEGIN
    Set @Sh_Y = 1278
    Set @Sh_M = (@Result + 10) / 30 + 10 
    SET @Sh_D = (@Result + 10) % 30 + 1
  END
  ELSE
  BEGIN
    Set @Result = @Result - 78
    Set @Sh_Y = 1279
    WHILE 1 = 1 
    BEGIN
      SET @TmpY = @Sh_Y + 11
      SET @TmpY = @TmpY - ( @TmpY / 33) * 33
      IF  (@TmpY <> 32) AND ( (@TmpY / 4) * 4 = @TmpY )
        SET @Leap = 1
      ELSE
        SET @Leap = 0

      IF @Result <= (365+@Leap)
        BREAK

      SET @Result = @Result -  (365+@Leap)
      SET @Sh_Y = @Sh_Y + 1
    END

    IF @Result <= 31*6
    BEGIN
      SET @Sh_M = (@Result-1) / 31 + 1
      SET @Sh_D = (@Result-1) % 31 + 1
    END
    ELSE
    BEGIN
      SET @Sh_M = ((@Result-1) - 31*6) / 30 + 7
      SET @Sh_D = ((@Result-1) - 31*6) % 30 + 1
    END
  END

  --Aditional calculation
	SET @Sh_Q=CASE 
				WHEN @Sh_M>0 AND @Sh_M<=3 THEN 1 
				WHEN @Sh_M>3 AND @Sh_M<=6 THEN 2
				WHEN @Sh_M>6 AND @Sh_M<=9 THEN 3
				ELSE 4 
				END
	SET @Sh_H=CASE WHEN @Sh_M<=6 THEN 1 ELSE 2 END

  RETURN
    CASE UPPER(@DatePart)
      WHEN 'Y' THEN @Sh_Y
      WHEN 'M' THEN @Sh_M
      WHEN 'D' THEN @Sh_D
	  WHEN 'Q' THEN @Sh_Q
	  WHEN 'H' THEN @Sh_H
	  ELSE  0
    END
END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تابع محاسبه قسمتهای زمانی تاریخ جلالی بر اساس تاریخ گرگورین اعلام شده', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'FUNCTION', @level1name = N'udf_JalaliDatePart_Gregorian2Num';

