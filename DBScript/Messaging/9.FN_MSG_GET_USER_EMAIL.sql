/****** Object:  UserDefinedFunction [dbo].[get_Global_State]    Script Date: 11/17/2016 4:50:52 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_USER_EMAIL]
GO

CREATE FUNCTION [FN_MSG_GET_USER_EMAIL]
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



