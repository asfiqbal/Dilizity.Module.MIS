IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_PASSWORD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USER_PASSWORD]
GO

/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_PASSWORD]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_PASSWORD]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_USER_PASSWORD]
(
	@UserId as INT
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = PASSWORD
	from	SEC_USER U
	WHERE	U.USER_ID = @UserId
	RETURN @Result
END

' 
END

GO

