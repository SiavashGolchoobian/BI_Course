---------------------------------روش استخراج آخرین ورژن در سطح کل دیتابیس
SELECT min_active_rowversion() AS CurrentRowversion		--SELECT CONVERT(Varchar(50),min_active_rowversion(),1) AS CurrentRowversion
SELECT @@DBTS AS CurrentRowversion
---------------------------------مثال: ساخت جدولی با فیلد ورژن و بررسی تغییرات آن
CREATE TABLE tblA (Id INT PRIMARY KEY IDENTITY,NameValue NVARCHAR(max),RowVer ROWVERSION NOT NULL)
INSERT INTO [dbo].[tblA] ([NameValue]) VALUES (N'A')
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM [dbo].[tblA]
UPDATE [dbo].[tblA] SET [NameValue]=N'B'
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM [dbo].[tblA]
INSERT INTO [dbo].[tblA] ([NameValue]) VALUES (N'A')
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM [dbo].[tblA]
UPDATE [dbo].[tblA] SET [NameValue]=N'C' WHERE id=2
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM [dbo].[tblA]
---------------------------------ساخت جدولی چهت همگام سازی با جدول اول
CREATE TABLE tblB (Id INT PRIMARY KEY,NameValue NVARCHAR(max),RowVer BINARY(8) NOT NULL)
UPDATE [dbo].[tblA] SET [NameValue]=N'A' WHERE id=1
---------------------------------بررسی مقادیر دو جدول پیش از همگام سازی
--Data in tblB before update
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblA
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblB
---------------------------------همگام سازی دو جدول با استفاده از دستور مرج و مقدار ورژن
DECLARE @lastChange AS BINARY(8)
SET @lastChange=(SELECT MAX([RowVer]) FROM tblB)

--Updating data in tblB table, merging by tblA table
MERGE tblB AS target
USING (SELECT Id, NameValue, RowVer FROM dbo.tblA AS o WHERE o.[RowVer] > ISNULL(@lastChange,0)) AS source 
ON target.Id = source.Id
WHEN MATCHED AND ISNULL(target.NameValue,N'')<>ISNULL(source.NameValue,N'')
	THEN UPDATE SET target.NameValue = source.NameValue, target.[RowVer]=source.[RowVer]
WHEN NOT MATCHED 
	THEN INSERT (Id, NameValue, [RowVer])
	VALUES(source.Id, source.NameValue, source.[RowVer])
;
---------------------------------بررسی مقادیر دو جدول پس از همگام سازی
--Data in tblB before update
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblA
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblB
---------------------------------تغییر مجدد جدول اول
UPDATE [dbo].[tblA] SET [NameValue]=N'A' WHERE id=1
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblA
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblB
---------------------------------همگام سازی مجدد دو جدول با استفاده از دستور مرج و مقدار ورژن
GO
DECLARE @lastChange AS BINARY(8)
SET @lastChange=(SELECT MAX([RowVer]) FROM tblB)

--Updating data in tblB table, merging by tblA table
MERGE tblB AS target
USING (SELECT Id, NameValue, RowVer FROM dbo.tblA AS o WHERE o.[RowVer] > ISNULL(@lastChange,0)) AS source 
ON target.Id = source.Id
WHEN MATCHED AND ISNULL(target.NameValue,N'')<>ISNULL(source.NameValue,N'')
	THEN UPDATE SET target.NameValue = source.NameValue, target.[RowVer]=source.[RowVer]
WHEN NOT MATCHED 
	THEN INSERT (Id, NameValue, [RowVer])
	VALUES(source.Id, source.NameValue, source.[RowVer])
;
---------------------------------بررسی مقادیر دو جدول پس از همگام سازی
--Data in tblB before update
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblA
SELECT *,CAST(RowVer AS BIGINT) AS VerNo FROM tblB