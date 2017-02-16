IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_ROLE_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_ROLE_NAME]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_ROLE_NAME]    Script Date: 12/8/2016 4:40:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_ROLE_NAME]
(
	@RoleId as int
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = ROLE_NAME 
	from	SEC_ROLE
	WHERE  ROLE_ID = @RoleId
	RETURN @Result
END



GO


