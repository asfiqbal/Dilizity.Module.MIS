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



GO


