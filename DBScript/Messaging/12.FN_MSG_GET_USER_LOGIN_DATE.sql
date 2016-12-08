/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_USER_LOGIN_DATE]    Script Date: 12/8/2016 4:39:54 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_USER_LOGIN_DATE]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_USER_LOGIN_DATE]    Script Date: 12/8/2016 4:39:54 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_USER_LOGIN_DATE]
(
	@LoginId as nvarchar(200)
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATENAME(dw, LAST_LOGIN_DATETIME) as varchar(3)) + ', ' +  CONVERT(VARCHAR(11),LAST_LOGIN_DATETIME,106)
	from	SEC_USER
	WHERE  LOGIN_ID = @LoginId
	RETURN @Result
END






GO


