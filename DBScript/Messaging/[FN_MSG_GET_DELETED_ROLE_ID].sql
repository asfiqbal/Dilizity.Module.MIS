/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_DELETED_ROLE_ID]]    Script Date: 12/8/2016 4:40:34 PM ******/
DROP FUNCTION [dbo].FN_MSG_GET_DELETED_ROLE_ID
GO

/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_DELETED_ROLE_ID]]    Script Date: 12/8/2016 4:40:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].FN_MSG_GET_DELETED_ROLE_ID
(
	@ContextId as varchar(10)
)
RETURNS nvarchar(400)
AS
BEGIN

	RETURN @ContextId
END



GO


