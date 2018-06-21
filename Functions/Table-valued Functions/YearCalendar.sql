USE [Karthik]
GO

/****** Object:  UserDefinedFunction [dbo].[YearCalendar]    Script Date: 6/21/2018 7:17:05 PM ******/
/*** Usa
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[YearCalendar] (@Year AS varchar(4))
RETURNS @datetable TABLE (
  "Date" date,
  "DayofYear" int,
  "Week" int,
  "DayOfWeek" int,
  "Month" int,
  "DayofMonth" int
)
AS
BEGIN
  DECLARE @MinDate date = @Year + '0101',
          @MaxDate date = @Year + '1231';
  WITH DATES
  AS (SELECT TOP (DATEDIFF(DAY, @MinDate, @MaxDate) + 1)
    Date = DATEADD(DAY, ROW_NUMBER() OVER (ORDER BY a.object_id) - 1, @MinDate)
  FROM sys.all_objects a)
  INSERT INTO @datetable
    SELECT
      DATE AS Date,
      DATEPART(DAYOFYEAR, DATE),
      DATEPART(WEEK, DATE),
      DATEPART(WEEKDAY, DATE),
      DATEPART(MONTH, DATE),
      DATEPART(DAY, DATE)
    FROM DATES
  RETURN;
END

GO
