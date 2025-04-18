CREATE SCHEMA GNR
GO
CREATE TABLE [GNR].[DIM_Dates] (
    [GregorianDateKey]      INT           NOT NULL,
    [GregorianDate]         DATE          NOT NULL,
    [GregorianYearMonthDay] INT           NOT NULL,
    [JalaliDate]            NCHAR (10)    NOT NULL,
    [JalaliYearMonthDay]    INT           NOT NULL,
    [GregorianYear]         INT           NOT NULL,
    [GregorianYearHalf]     INT           NOT NULL,
    [GregorianYearQuarter]  INT           NOT NULL,
    [GregorianYearWeek]     INT           NOT NULL,
    [GregorianYearMonth]    INT           NOT NULL,
    [GregorianQuarter]      INT           NOT NULL,
    [GregorianHalf]         INT           NOT NULL,
    [GregorianMonth]        INT           NOT NULL,
    [GregorianDay]          INT           NOT NULL,
    [GregorianWeek]         INT           NOT NULL,
    [GregorianWeekDay]      INT           NOT NULL,
    [JalaliYear]            INT           NOT NULL,
    [JalaliYearHalf]        INT           NOT NULL,
    [JalaliYearQuarter]     INT           NOT NULL,
    [JalaliYearWeek]        INT           NOT NULL,
    [JalaliYearMonth]       INT           NOT NULL,
    [JalaliQuarter]         INT           NOT NULL,
    [JalaliHalf]            INT           NOT NULL,
    [JalaliMonth]           INT           NOT NULL,
    [JalaliDay]             INT           NOT NULL,
    [JalaliWeek]            INT           NOT NULL,
    [JalaliWeekDay]         INT           NOT NULL,
    [GregorianQuarterName]  NVARCHAR (50) NOT NULL,
    [GregorianHalfName]     NVARCHAR (50) NOT NULL,
    [GregorianMonthName]    NVARCHAR (50) NOT NULL,
    [GregorianWeekDayName]  NVARCHAR (50) NOT NULL,
    [JalaliQuarterName]     NVARCHAR (50) NOT NULL,
    [JalaliHalfName]        NVARCHAR (50) NOT NULL,
    [JalaliMonthName]       NVARCHAR (50) NOT NULL,
    [JalaliWeekDayName]     NVARCHAR (50) NOT NULL,
    [PeriodCode]            SMALLINT      CONSTRAINT [DF_GNR_DIM_Dates_PeriodCode] DEFAULT ((0)) NOT NULL,
    [PeriodNameEn]          NVARCHAR (50) CONSTRAINT [DF_GNR_DIM_Dates_PeriodNameEn] DEFAULT (N'Present') NOT NULL,
    [PeriodNameFa]          NVARCHAR (50) CONSTRAINT [DF_GNR_DIM_Dates_PeriodNameFa] DEFAULT (N'روزجاری') NOT NULL,
    CONSTRAINT [PK_GNR_DIM_Dates] PRIMARY KEY CLUSTERED ([GregorianDateKey] ASC) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Dates_JalaliYearMonthDay]
    ON [GNR].[DIM_Dates]([JalaliYearMonthDay] ASC) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
    
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Dates_GregorianYearMonthDay]
    ON [GNR].[DIM_Dates]([GregorianYearMonthDay] ASC) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)
    
GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Dates_GregorianDate] 
    ON [GNR].[DIM_Dates]([GregorianDate] ASC) INCLUDE (JalaliDate) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)

GO
CREATE UNIQUE NONCLUSTERED INDEX [UNQIX_GNR_DIM_Dates_JalaliDate]
    ON [GNR].[DIM_Dates]([JalaliDate] ASC) INCLUDE ([GregorianDate]) WITH (FILLFACTOR = 100, PAD_INDEX = ON, DATA_COMPRESSION = PAGE)

GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان روز هفته به جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliWeekDayName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliMonthName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان نیمه سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliHalfName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان فصل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliQuarterName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان روز هفته به میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianWeekDayName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianMonthName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان نیمه سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianHalfName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'عنوان فصل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianQuarterName';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در هفته جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliWeekDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره هفته در سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliWeek';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliMonth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره نیمه سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliHalf';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره فصل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliQuarter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و ماه جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliYearMonth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و هفته جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliYearWeek';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و فصل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliYearQuarter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و نیمه سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliYearHalf';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'سال جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliYear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در هفته میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianWeekDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره هفته در سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianWeek';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره روز در ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianMonth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره نیمه سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianHalf';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره فصل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianQuarter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و ماه میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianYearMonth';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و هفته میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianYearWeek';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و فصل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianYearQuarter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال و نیمه سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianYearHalf';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'سال میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianYear';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال، ماه و روز جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliYearMonthDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تاریخ کامل جلالی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'JalaliDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شماره سال، ماه و روز میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianYearMonthDay';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تاریخ کامل میلادی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'شناسه تاریخ', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'GregorianDateKey';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'تقویم', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates';


GO
EXECUTE sp_addextendedproperty @name = N'LoadTypeScript', @value = N'EXECUTE [GNR].[usp_DIM_Date_Fill] ''1900-01-01'',''1900-01-01'',0
GO
EXECUTE [GNR].[usp_DIM_Date_Fill] ''9997-12-30'',''9997-12-30'',0
GO
EXECUTE [GNR].[usp_DIM_Date_Fill] ''1921-03-21'',''2027-03-20'',0
GO', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates';


GO
EXECUTE sp_addextendedproperty @name = N'LoadType', @value = N'Static', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'دوره زمانی به فارسی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'PeriodNameFa';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'دوره زمانی به انگلیسی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'PeriodNameEn';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'کد دوره زمانی', @level0type = N'SCHEMA', @level0name = N'GNR', @level1type = N'TABLE', @level1name = N'DIM_Dates', @level2type = N'COLUMN', @level2name = N'PeriodCode';

