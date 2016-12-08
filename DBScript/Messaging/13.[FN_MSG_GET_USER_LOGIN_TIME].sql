USE [ReportMIS]
GO

/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_USER_LOGIN_TIME]]    Script Date: 12/8/2016 4:40:59 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_USER_LOGIN_TIME]
GO

/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_USER_LOGIN_TIME]]    Script Date: 12/8/2016 4:40:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_USER_LOGIN_TIME]
(
	@LoginId as nvarchar(200)
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATEPART(HOUR, LAST_LOGIN_DATETIME)-12 as varchar)+ ':' + cast(DATEPART(MINUTE, LAST_LOGIN_DATETIME) as varchar)+':'+cast(DATEPART(SECOND, LAST_LOGIN_DATETIME) as varchar)+
    (CASE WHEN DATEPART(HOUR, GETDATE()) > 12 THEN ' PM'
        ELSE ' AM'
    END)
	from	SEC_USER
	WHERE  LOGIN_ID = @LoginId
	RETURN @Result
END
GO

