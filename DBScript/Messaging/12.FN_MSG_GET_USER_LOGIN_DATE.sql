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
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATENAME(dw, LAST_LOGIN_DATETIME) as varchar(3)) + ', ' +  CONVERT(VARCHAR(11),LAST_LOGIN_DATETIME,106)
	from	OF_OPERATIONS O
			INNER JOIN SEC_USER U ON O.CREATED_BY = U.LOGIN_ID
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END






GO


