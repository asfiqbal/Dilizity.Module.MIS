IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USER_NAME]
GO

/****** Object:  UserDefinedFunction [FN_MSG_GET_USER_NAME]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USER_NAME]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'

CREATE FUNCTION [FN_MSG_GET_USER_NAME]
(
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select	@Result = NAME 
	from	OF_OPERATIONS O
			INNER JOIN SEC_USER U ON O.CREATED_BY = U.LOGIN_ID
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END



' 
END

GO
