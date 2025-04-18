/*
INSERT INTO [GNR].[DIM_Dates] SELECT * FROM [AfterSalse].GNR.DIM_Dates
*/

OR

/*
DECLARE @myCurrentLastDate DATE
DECLARE @myFromDate DATE
DECLARE @myToDate DATE

SET @myCurrentLastDate = (SELECT MAX(GregorianDate) FROM [GNR].[DIM_Dates] WHERE GregorianDate NOT IN ('9997-12-30'))

IF @myCurrentLastDate IS NOT NULL
BEGIN
	SET @myFromDate = DATEADD(DAY,1,@myCurrentLastDate)
	SET @myToDate = DATEADD(YEAR,1,@myFromDate)
END
ELSE
BEGIN
	SET @myFromDate = '1921-03-23'	--1300/01/03
	SET @myToDate = '2046-03-20'	--1424/12/30
END

BEGIN TRY
	EXECUTE [GNR].[usp_DIM_Date_Fill] '1900-01-01','1900-01-01',0
END TRY
BEGIN CATCH
	Print 'Already Exist'
END CATCH

BEGIN TRY
	EXECUTE [GNR].[usp_DIM_Date_Fill] '9997-12-30','9997-12-30',0
END TRY
BEGIN CATCH
	Print 'Already Exist'
END CATCH

EXECUTE [GNR].[usp_DIM_Date_Fill] @myFromDate,@myToDate,0
*/