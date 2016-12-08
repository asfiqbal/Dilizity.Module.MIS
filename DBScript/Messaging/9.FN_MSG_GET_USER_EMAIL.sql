/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_USER_EMAIL]    Script Date: 12/8/2016 4:40:34 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_USER_EMAIL]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_USER_EMAIL]    Script Date: 12/8/2016 4:40:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_USER_EMAIL]
(
	@LoginId as nvarchar(200)
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = EMAIL 
	from	SEC_USER
	WHERE  LOGIN_ID = @LoginId
	RETURN @Result
END



GO


