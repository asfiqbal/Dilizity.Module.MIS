/****** Object:  UserDefinedFunction [dbo].[get_Global_State]    Script Date: 11/17/2016 4:50:52 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_USER_NAME]
GO

CREATE FUNCTION [FN_MSG_GET_USER_NAME]
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



