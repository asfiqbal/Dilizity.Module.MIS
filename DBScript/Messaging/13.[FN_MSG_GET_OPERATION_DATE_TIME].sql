/****** Object:  UserDefinedFunction [dbo].[[FN_MSG_GET_OPERATION_DATETIME]]    Script Date: 12/8/2016 4:40:59 PM ******/
DROP FUNCTION [dbo].[FN_MSG_GET_OPERATION_DATETIME]
GO

/****** Object:  UserDefinedFunction [dbo].[FN_MSG_GET_OPERATION_DATE_TIME]    Script Date: 12/8/2016 4:40:59 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE FUNCTION [dbo].[FN_MSG_GET_OPERATION_DATETIME]
(
	@OperationId as INT
)
RETURNS nvarchar(200)
AS
BEGIN
	DECLARE @Result as nvarchar(200)
	
	select @Result = cast(DATEPART(HOUR, UPDATED_ON)-12 as varchar)+ ':' + cast(DATEPART(MINUTE, UPDATED_ON) as varchar)+':'+cast(DATEPART(SECOND, UPDATED_ON) as varchar)+
    (CASE WHEN DATEPART(HOUR, UPDATED_ON) > 12 THEN ' PM'
        ELSE ' AM'
    END)
	from	OF_OPERATIONS O
	WHERE	O.OPERATION_ID = @OperationId
	RETURN @Result
END
GO

