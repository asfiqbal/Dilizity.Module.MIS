/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_USER_NAME]    Script Date: 12/8/2016 4:33:37 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_USER_NAME]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_USER_NAME]    Script Date: 12/8/2016 4:33:37 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_USER_NAME]
(
	@LoginId as nvarchar(200)
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = NAME 
	from	SEC_USER
	WHERE  LOGIN_ID = @LoginId
	RETURN @Result
END



GO


