USE [Karthik]
GO

/****** Object:  UserDefinedFunction [dbo].[GetAge]    Script Date: 6/21/2018 7:13:37 PM ******/
/*** Usage => select [dbo].[GetAge]('DD-MM-YYY') ***/

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[GetAge] (@dateOfBirth AS datetime)
RETURNS varchar(40)
BEGIN
  DECLARE @today datetime = GETDATE()
  DECLARE @days int = DAY(@dateOfBirth) - DAY(@today)
  DECLARE @months int = MONTH(@dateOfBirth) - MONTH(@today)
  DECLARE @years int = DATEDIFF(YEAR, @dateOfBirth, @today) - CASE
    WHEN @months > 0 OR
      (@months = 0 AND
      @days > 0) THEN 1
    ELSE 0
  END
  SET @dateOfBirth = DATEADD(YEAR, @years, @dateOfBirth)
  SET @months = DATEDIFF(MONTH, @dateOfBirth, @today) - CASE
    WHEN @days > 0 THEN 1
    ELSE 0
  END
  SET @dateOfBirth = DATEADD(MONTH, @months, @dateOfBirth)
  SET @days = DATEDIFF(DAY, @dateOfBirth, @today)
  RETURN concat(@years, ' years, ', @months, ' months, and ', @days, ' days.')
END


GO
