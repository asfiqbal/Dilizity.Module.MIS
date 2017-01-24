/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_DELETED_ROLE_NAME]]    Script Date: 12/8/2016 4:40:34 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_DELETED_ROLE_NAME]
GO

/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_DELETED_ROLE_NAME]]    Script Date: 12/8/2016 4:40:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_DELETED_ROLE_NAME]
(
	@ContextId as varchar(10)
)
RETURNS nvarchar(400)
AS
BEGIN
	DECLARE @Result as nvarchar(400)
	
	select @Result = ROLE_NAME 
	from	SEC_ROLE
	WHERE  ROLE_ID = @ContextId
	RETURN @Result
END



GO


