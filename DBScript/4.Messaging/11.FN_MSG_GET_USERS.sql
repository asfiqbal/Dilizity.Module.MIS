IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USERS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
DROP FUNCTION [FN_MSG_GET_USERS]
GO

/****** Object:  UserDefinedFunction [FN_MSG_GET_USERS]    Script Date: 2/14/2017 9:28:54 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[FN_MSG_GET_USERS]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE FUNCTION [FN_MSG_GET_USERS]
(
	@CONTEXTID INT
)
RETURNS 
@OUTTABLE TABLE 
(
	LOGIN_ID VARCHAR(200)
)
AS
BEGIN
	
	INSERT INTO @OUTTABLE(LOGIN_ID)
	SELECT LOGIN_ID
	FROM   SEC_USER
	WHERE  IS_DELETED = 0
	
	RETURN 
END
' 
END

GO